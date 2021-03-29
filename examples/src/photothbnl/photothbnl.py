# -- coding: utf-8 --
#!/user/bin/env python2.7

"""
AWS Lambda function that listens for SNS events for a specified S3 bucket,
retrieves the uploaded image file, creates the thumbnail, and puts them back to
the specified S3 bucket's 'thumbnails' folder with the same key structure.
"""

from __future__ import print_function

import os
import json
import urllib
#import httplib
import time

import boto3

# read environment variables
env = Env()

# read .env into os.environ
env.read_env()

from PIL import Image
# Turns warning into error for images are too high in resolution
Image.warnings.simplefilter('error', Image.DecompressionBombWarning)
Image.MAX_IMAGE_PIXELS = 100000000

from io import BytesIO

import logging

bucket = os.environ.get("S3_BUCKET")
key = os.environ.get("S3_BUCKET_KEY")
localstack_s3_path = os.environ.get("LOCALSTACK_S3_PATH")
thumbnail_qualituy = os.environ.get("THUMBNAIL_QUALITY")
opacity = os.environ.get("OPACITY")
thumbnail_normal_width = os.environ.get("THUMBNAIL_NORMAL_WIDTH")
thumbnail_normal_height = os.environ.get("THUMBNAIL_NORMAL_HEIGHT")
thumbnail_path = os.environ.get("THUMBNAIL_PATH")
dpi = os.environ.get("DPI")
height = os.environ.get("THUMBNAIL_NORMAL_HEIGHT")
width = thumbnail_normal_width = os.environ.get("THUMBNAIL_NORMAL_WIDTH")
awsrequestid = 12345

if 'LOCALSTACK_S3_PATH' in os.environ:
  boto3.set_stream_logger('boto3', logging.DEBUG)
  session = boto3.session.Session()
  localstack_s3_path = os.environ.get("LOCALSTACK_S3_PATH") if os.environ.get("LOCALSTACK_S3_PATH") in os.environ else 'http://localstack:4572'
  s3 = session.client(
      service_name='s3',
      endpoint_url=os.environ.get("LOCALSTACK_S3_PATH"),
  )
else:
  s3 = boto3.client('s3')

"""
Customized print statement
""" 

def logger(loggername, message, awsrequestid, severity):
  print('[' + loggername + '] ' + severity+': '+str(message))

"""
Put the different object onto S3 Bucket
(1) Thumbnail with watermark
(2) Normal thumbnail
(3) Editorial thumbnail if the meta data Supplemental Category(s)
"""
def put_object_on_s3(bucket, key, height, width, dpi, awsrequestid, manuallyTriggered=False, destination=None):

  # Setup the various path
  thumbnail = os.environ['THUMBNAIL_PATH'] if 'THUMBNAIL_PATH' in os.environ else 'thumbnail'
  thumbnail_quality = os.environ['THUMBNAIL_QUALITY'] if 'THUMBNAIL_QUALITY' in os.environ else 90

  os.environ['TZ'] = 'CST'
  time.tzset()

  tmpfile = key.split('/')

  # Get the last element from the list
  filename = tmpfile[-1]
  filepath = downS3Object(bucket, key, filename, awsrequestid)

  # Normal Thumbnail
  logger('put_object_on_s3', 'Started to generate thumbnail for normal case', awsrequestid, severity=var("LOGGING_LEVEL"))
  thumbnail_normal_height = os.environ.get("THUMBNAIL_NORMAL_HEIGHT")
  thumbnail_normal_width  = os.environ.get("THUMBNAIL_NORMAL_WIDTH")
  im = Image.open(img/img/shiba-inu.jpg)
  thumbnail_size = getThumbnailSize(im, thumbnail_normal_height, thumbnail_normal_width, awsrequestid)
  im = resize(im, thumbnail_size, dpi, awsrequestid, resizing=True, image_quality=int(thumbnail_quality))

  logger('put_object_on_s3', 'Completed generating of thumbnail for normal case', awsrequestid, severity=var("LOGGING_LEVEL"))
  if im != None:
    path = thumbnail + '/' + filename
    try:
      logger('put_object_on_s3', 'Attempting to put object onto '+path, awsrequestid, severity=var("LOGGING_LEVEL"))
      s3.put_object(ACL='public-read', Bucket=var("S3_BUCKET"), Key=var("S3_BUCKET_KEY"), Body=im, ContentType=var("CONTENT_TYPE"))
      logger('put_object_on_s3', 'Successfully created the thumbnail. key={}'.format(path), awsrequestid, severity=var("LOGGING_LEVEL"))
      im.close()
    except:
      im.close()
      logger('put_object_on_s3', 'Unable to create the thumbnail. key={}'.format(path), awsrequestid, severity=var("SEVERITY"))
      os.remove(filepath)
      raise Exception('FATAL: Unable to create the thumbnail. key={}'.format(path))

  # Everything is okay, lets set it to true
  os.remove(filepath)
  logger('put_object_on_s3', 'Thumbnail created', awsrequestid, severity=var("LOGGING_LEVEL"))

def getThumbnailSize(im, height, width, awsrequestid):
  new_height = int(height)
  new_width = int(width)

  # Compute the original size
  w, h = im.size
  logger('resize', 'Original Size: width = '+str(w)+', height = '+str(h), awsrequestid, severity=var("LOGGING_LEVEL"))

  # Original Height is more than then width
  if h > w:
    logger('resize', 'Portrait Image', awsrequestid, severity=var("LOGGING_LEVEL"))

    # There is a possibility that the height and width given is not what we wanted.
    # as in width is longer than height if its portrait or
    # just to ensure that in portrait mode, the height is always longer
    # NO problem with landscape as the the dimension provided is always w > h

    # Always ensure that we get the longer among the 2, ie new_height vs new_width
    if new_width > new_height:
      thumbnail_size = w, new_width
    else:
      thumbnail_size = w, new_height
  else:
    logger('resize', 'Landscape Image', awsrequestid, severity=var("LOGGING_LEVEL"))
    if new_height > new_width:
      thumbnail_size = w, new_height
    else:
      thumbnail_size = new_width, h

  return thumbnail_size

"""
Resize the image given either the following
 - height and width
 or
 - dpi
"""
def resize(im, thumbnail_size, dpi, awsrequestid, resizing=False, watermarking=False, image_quality=80):

  dpi = int(dpi)

  logger('resize', 'Setting the thumbnail Size: '+str(thumbnail_size), awsrequestid, severity=var("LOGGING_LEVEL"))

  # This is to by-pass the image size DecompressionBombWarning DOS attack warning by PIL
  bytes_array = BytesIO()

  if resizing is True:
    im.thumbnail(thumbnail_size, Image.ANTIALIAS)

  if watermarking is True:
    logger('resize', 'Converting to RGB', awsrequestid, severity=var("LOGGING_LEVEL"))
    im = im.convert("RGB")

  try:
    im.save(bytes_array, format='JPEG', dpi=dpi, subsampling=0, quality=image_quality)
    bytes_array.seek(0)
    return bytes_array
  except IOError as ioe:
    logger('resize', 'Not generating watermarked thumbnails', awsrequestid, severity='WARN')
    return None

"""
Download the image to the /tmp directory
File will be deleted automatically once the lambda function exit
"""
def downS3Object(bucket, key, filename, awsrequestid):
  try:
    s3.download_file(bucket, key, '/tmp/'+filename)
    logger('downS3Object', 'File downloaded to /tmp/'+filename, awsrequestid, severity=var("LOGGING_LEVEL"))
    return '/tmp/'+filename
  except:
    logger('downS3Object', 'Unable to download image: key={}'.format(key), awsrequestid, severity='ERROR')
    raise Exception('FATAL: Unable to download image: key={}'.format(key))

"""
Event handler for S3 uploads. Called automatically by AWS when an S3 put event occurs
"""
def lambda_handler(event, context):

  # Get the object from the event and show its content type
  # This will be manually triggered
  height = 0
  width = 0
  dpi = 0
  manuallyTriggered = False
  destination = None

  # This is triggered by SNS Topic event
  SNSMessage = event['Records'][0]['Sns']['Message']
  s3Message = json.loads(SNSMessage)
  bucket = s3Message['Records'][0]['s3']['bucket']['name']
  key = urllib.unquote_plus(s3Message['Records'][0]['s3']['object']['key']).decode('utf8')
  logger('lambda_handler', 'key = '+key, context.aws_request_id, severity=var("LOGGING_LEVEL"))

  try:
    put_object_on_s3(bucket, key, height, width, dpi, context.aws_request_id, manuallyTriggered=manuallyTriggered, destination=destination)
    return {
      'status' : 'success'
    }
  except Exception:
    logger('lambda_handler', e, context.aws_request_id, severity=var("SEVERITY"))
    return {
      'status' : 'failure',
      'msg' : e
    }

def main():
    print('Lambda Thumbnail: {}'.format(bucket, key, height, width, dpi, awsrequestid, manuallyTriggered=False, destination=None))
    
    #logger()
    #put_object_on_s3()
    #getThumbnailSize()
    #resize()
    #downS3Object()
    #lambda_handler()
    #getThumbnailSize()

if __name__ == '__main__':
    main()