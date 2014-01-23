#Taken from ecl_tools
from datetime import datetime
from datetime import timedelta
from hashlib import md5
from io import BytesIO
import json
import mimetypes
import os
import time
import argparse


from email.utils import formatdate
from fabric import colors
import boto
import cssmin
import gzip
#import jsmin

from ecl_tools.progress import SnakeIndicator
from boto.s3.connection import OrdinaryCallingFormat

AWS_KEY = "AKIAJCPC7VUW7OBBSVCQ"
AWS_SECRET = "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"
DISTRIBUTION = 'E3VQ8C5VWYA8A'

HEADERS = {
    'Access-Control-Allow-Origin': '*'
    }




def sync_media_to_s3(bucket_name, aws_access_key_id=None, \
        aws_access_key_secret=None, headers=None, cf_distribution_id=None, \
        folder="media/"):
    """
    Syncs all static files in a specified media directory to Amazon S3.

    :param bucket_name: the name of the S3 bucket to sync files to
    :param aws_access_key_id: the access key id with access to the specified bucket
    :param aws_access_key_secret: the access key secret with access to the
    specified bucket.
    :param headers: extra headers to pass to the S3 keys
    """
    print(colors.yellow("Syncing media to %s" % bucket_name))

    conn = boto.connect_s3(aws_access_key_id, aws_access_key_secret,
            calling_format=OrdinaryCallingFormat())
    bucket = conn.get_bucket(bucket_name)
    checksum_key = bucket.get_key("checksums")
    if checksum_key:
        checksums = json.loads(checksum_key.get_contents_as_string())
    else:
        checksum_key = bucket.new_key("checksums")
        checksums = {}

    def gzip_file(source_buffer):
        target_buffer = BytesIO()
        gzipped_content = gzip.GzipFile(fileobj=target_buffer, mode='w', mtime=0)
        gzipped_content.write(source_buffer.getvalue())
        gzipped_content.close()
        return BytesIO(target_buffer.getvalue())

    def upload_file(filename, remote_key):
        key = bucket.get_key(remote_key) or bucket.new_key(remote_key)
        mimetype, encoding = mimetypes.guess_type(remote_key)
        if not mimetype:
            return False

        key.set_metadata("Content-Type", mimetype)

        dt = datetime.now() + timedelta(days=365)
        timestamp = time.mktime(dt.timetuple())
        rfc822_time = formatdate(timestamp, usegmt=True)

        if mimetype == 'text/css':
            minify = lambda k: BytesIO(cssmin.cssmin(k.getvalue()))
            gzipify = gzip_file
            key.set_metadata("Content-Encoding", "gzip")
        elif mimetype == 'application/javascript':
            #minify = lambda k: BytesIO(jsmin.jsmin(k.getvalue())) # build process should handle that
            minify = lambda k: k # we're already built
            gzipify = gzip_file
            key.set_metadata("Content-Encoding", "gzip")
        else:
            minify = lambda k: k
            gzipify = lambda k: k
            key.set_metadata("Content-Type", mimetype)

        with open(filename) as fp:
            fb = BytesIO()
            fb.write(fp.read())

            minified_file = minify(fb)
            gzipped_file = gzipify(minified_file)
            computed_md5 = md5(gzipped_file.getvalue()).hexdigest()
            existing_md5 = checksums.get(remote_key, None)

            if computed_md5 != existing_md5:
                key.set_metadata("Expires", rfc822_time)
                key.set_contents_from_string(gzipped_file.getvalue(),
                        headers=headers)
                key.make_public()
                checksums[remote_key] = computed_md5
                return True
            return False

    indicator = SnakeIndicator("%s", "%d files skipped, %d files updated")
    num_updated = 0
    paths_to_invalidate = []

    for root, dirs, filenames in os.walk(folder):
        for filename in filenames:
            relpath = os.path.relpath(root, build_dir)
            if  relpath == ".":
                remote_key = "%s" % filename
            else:
                remote_key = "%s" % os.path.join(relpath, filename)
            filepath = "%s/%s" % (root, filename)

            paths_to_invalidate.append(remote_key)
            updated = upload_file(filepath, remote_key)
            if updated:
                num_updated += 1

            indicator.write(remote_key, indicator.index-num_updated, num_updated)
            indicator.animate()

    if cf_distribution_id:
        cf_conn = boto.connect_cloudfront(aws_access_key_id, \
                aws_access_key_secret)
        #cf_conn.create_invalidation_request(cf_distribution_id, \
                #paths_to_invalidate)

    indicator.flush()

    checksum_key.set_contents_from_string(json.dumps(checksums))
    cors = boto.s3.cors.CORSConfiguration()
    cors.add_rule(['GET'], ['*'], 'all', max_age_seconds=36000)
    bucket.set_cors(cors)
    return True

import os.path
file_dir = os.path.dirname(os.path.abspath(__file__))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="upload client to an s3 bucket")
    parser.add_argument("--bucket", dest="bucket", type=str, help="the bucket to upload to")
    parser.set_defaults(bucket="unlockable-dev")
    args = parser.parse_args()
    build_dir = os.path.join(file_dir, "..", 'webapp-build')
    sync_media_to_s3(args.bucket, aws_access_key_id=AWS_KEY, \
        aws_access_key_secret=AWS_SECRET, headers=HEADERS, cf_distribution_id=DISTRIBUTION, \
        folder=build_dir)
