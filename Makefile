
# Lambda Config
AWS_REGION=us-west-2
TF_BACKEND_BUCKET_NAME=tfbe
BUCKET_NAME=some-random-bucket-name
LAMBDA_VERSION=v1.0.0
LAMBDA_NAME=my-cool-lambda
ARTIFACT_NAME=${LAMBDA_NAME}.zip

deploy: init-bucket zip-artifact deploy-artifact clean-local

# Makes sure bucket exists
init-bucket:
	echo "using AWS_PROFILE=${AWS_PROFILE}"
	- aws s3api create-bucket --bucket=${BUCKET_NAME} --profile=${AWS_PROFILE} --create-bucket-configuration LocationConstraint=${AWS_REGION}

zip-artifact:
	zip ${ARTIFACT_NAME} main.js

deploy-artifact:
	echo "using AWS_PROFILE=${AWS_PROFILE}"
	aws s3 cp ${ARTIFACT_NAME} s3://${BUCKET_NAME}/${LAMBDA_VERSION}/${ARTIFACT_NAME} --profile=${AWS_PROFILE}

clean-local:
	rm ${ARTIFACT_NAME}


#***# Terraform #***#

## Create Backend Remove in AWS S3
create-tf-backend-remote:
	aws s3api create-bucket --bucket=${TF_BACKEND_BUCKET_NAME} --profile=${AWS_PROFILE} --create-bucket-configuration LocationConstraint=${AWS_REGION}

tf-apply:
	terraform apply -var="lambda_name=${LAMBDA_NAME}" -var="app_version=${LAMBDA_VERSION}" -var="aws_profile=${AWS_PROFILE}" -var="bucket_name=${BUCKET_NAME}"

tf-plan:
	terraform plan -var="lambda_name=${LAMBDA_NAME}" -var="app_version=${LAMBDA_VERSION}" -var="aws_profile=${AWS_PROFILE}" -var="bucket_name=${BUCKET_NAME}"

tf-refresh:
	terraform refresh -var="lambda_name=${LAMBDA_NAME}" -var="app_version=${LAMBDA_VERSION}" -var="aws_profile=${AWS_PROFILE}" -var="bucket_name=${BUCKET_NAME}"

tf-destroy:
	terraform destroy -var="lambda_name=${LAMBDA_NAME}" -var="app_version=${LAMBDA_VERSION}" -var="aws_profile=${AWS_PROFILE}" -var="bucket_name=${BUCKET_NAME}"