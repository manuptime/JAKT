
from io import BytesIO

import boto
from boto.elastictranscoder.layer1 import ElasticTranscoderConnection

import gzip
from  datetime import datetime
from datetime import timedelta
from email.utils import formatdate
import time
import mimetypes


from aws import AWS_ACCESS_KEY_ID, AWS_ACCESS_KEY_SECRET


BUCKET_NAME = "public-unlockable"
CF_DISTRIBUTION_ID = 'E3VQ8C5VWYA8A'

def get_rfc_time():
    dt = datetime.now() + timedelta(days=365)
    timestamp = time.mktime(dt.timetuple())
    return formatdate(timestamp, usegmt=True)

def gzip_file(source_buffer):
    target_buffer = BytesIO()
    gzipped_content = gzip.GzipFile(fileobj=target_buffer, mode='w', mtime=0)
    gzipped_content.write(source_buffer.read())
    gzipped_content.close()
    return BytesIO(target_buffer.getvalue())

def move_file_to_s3(path, file, bucket_name=BUCKET_NAME, zip=True):
    conn = boto.connect_s3(AWS_ACCESS_KEY_ID, AWS_ACCESS_KEY_SECRET)
    bucket = conn.get_bucket(bucket_name)
    key = bucket.get_key(path) or bucket.new_key(path)
    mimetype, encoding = mimetypes.guess_type(path)
    key.set_metadata("Content-Type", mimetype)
    key.set_metadata("Expires", get_rfc_time())

    if zip:
        minified_file = gzip_file(file)
        key.set_metadata("Content-Encoding", "gzip")
        key.set_contents_from_string(minified_file.getvalue())
    else:
        key.set_contents_from_string(file.read())


    key.make_public()
    return key
    #invalidate_cf_asset(path)



def invalidate_cf_asset(path_to_invalidate):
    cf_conn = boto.connect_cloudfront(AWS_ACCESS_KEY_ID, \
                                      AWS_ACCESS_KEY_SECRET)
    cf_conn.create_invalidation_request(CF_DISTRIBUTION_ID, \
                                        [path_to_invalidate])


ENCODING_PIPELINE = '1367789075072-9351b2'
ENCODING_BUCKET = 'unlockable-transcode-dev'

def encode_video(key):

    conn = boto.connect_s3(AWS_ACCESS_KEY_ID, AWS_ACCESS_KEY_SECRET)
    #copy movie to transcoding bucket
    source_bucket = conn.get_bucket(ENCODING_BUCKET)
    dest_bucket = conn.get_bucket(BUCKET_NAME)

    source_key = source_bucket.get_key(key)
    dest_key = dest_bucket.get_key(key)
    output_file, extension = key.key.rsplit('.', 1)
    input_dict = {
        "Key":unicode(key.key),
        "FrameRate":"auto",
        "Resolution":"auto",
        "AspectRatio":"auto",
        "Interlaced":"auto",
        "Container":"auto",
        }
    mp4_dict = {
        "Key": output_file + ".mp4",
        "ThumbnailPattern":"",
        "Rotate":"auto",
        "PresetId":"1375737314274-nbtv6e", #640x360 web
        }

    webm_dict = {
        "Key": output_file + ".webm",
        "ThumbnailPattern":"",
        "Rotate":"auto",
        "PresetId":"1375737334693-51g7ri" #webm 640x360
        }



    elastic_connection = ElasticTranscoderConnection(aws_access_key_id=AWS_ACCESS_KEY_ID,
                                                     aws_secret_access_key=AWS_ACCESS_KEY_SECRET)

    elastic_connection.create_job(ENCODING_PIPELINE, input_dict, mp4_dict)
    elastic_connection.create_job(ENCODING_PIPELINE, input_dict, webm_dict)
