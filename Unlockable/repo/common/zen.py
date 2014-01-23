from zencoder import Zencoder
zen = Zencoder('e35198ebcc9f94bdef1ae6be300969b7')

def get_outputs(bucket, filename):
    outputs = [
        {
          "url": "s3://%s/%s.mp4" % (bucket, filename),
          "h264_profile": "high",
          "public": True,

        },
        {
          "url": "s3://%s/%s.webm" %(bucket, filename),
          "public": True,
        },
        {
          "url": "s3://%s/%s.ogg" % (bucket, filename),
          "public": True,
        },
    ]

def convert_video(video_path, input_bucket, output_bucket):
    input_url = "s3://%s/%s" % (input_bucket, video_path)
    filename = video_path.rsplit('.', 1)
    outputs = get_outputs(output_bucket, filename)
    zen.job.create(input_url, outputs=outputs)
