# How to use:
# ------------
# ./create_stack.sh default dagster-network app_network.yaml app_network_parameters.json
#
aws cloudformation create-stack \
--profile=$1 \
--stack-name $2 \
--template-body file://$3 \
--parameters file://$3 \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=us-east-2
