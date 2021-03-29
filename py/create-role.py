import boto3
import json

# Create IAM client
iam = boto3.client('iam')

path='/'
role_name='lambda-basic-execution'
description='Lambda Basic Execution'

trust_policy={
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}

tags=[
    {
        'Key': 'Environment',
        'Value': 'dev'
    }
]

try:
    response = iam.create_role(
        Path=path,
        RoleName=role_name,
        AssumeRolePolicyDocument=json.dumps(trust_policy),
        Description=description,
        MaxSessionDuration=3600,
        Tags=tags
    )

    print(response)
except Exception as e:
    print(e)
