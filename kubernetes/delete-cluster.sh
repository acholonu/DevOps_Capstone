aws sts get-caller-identity
aws eks --region us-east-2 update-kubeconfig --name dagster-eks
kubectl delete all -l app=dagster
eksctl delete cluster --name=dagster-eks