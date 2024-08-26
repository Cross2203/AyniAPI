import boto3
from django.conf import settings

s3 = boto3.client(
    's3',
    aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
    aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
    region_name=settings.AWS_S3_REGION_NAME
)

def get_s3_file_url(object_name, folder_name, expiration=3600):
    object_key = f"{folder_name}/{object_name}"
    try:
        url = s3.generate_presigned_url(
            ClientMethod='get_object',
            Params={
                'Bucket': settings.AWS_STORAGE_BUCKET_NAME,
                'Key': object_key
            },
            ExpiresIn=expiration
        )
        return url
    except Exception as e:
        print(f"Error al generar la URL prefirmada: {e}")
        return None