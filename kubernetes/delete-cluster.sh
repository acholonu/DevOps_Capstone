aws sts get-caller-identity # returns the ARN of the IAM user or role.
aws eks --region us-east-2 update-kubeconfig --name dagster-eks --profile capstone
kubectl get svc
kubectl delete all -l app=dagster --namespace=production
eksctl delete cluster --name=dagster-eks --profile capstone