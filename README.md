# Terraform EKS

## Role-based access control (RBAC)

1. Create service account

  `kubectl create serviceaccount tiller --namespace kube-system`

2. Create cluster role binding

  ```
  kubectl create clusterrolebinding tiller-cluster-rule \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller
  ```

3. Init helm with service account

  `helm init --service-account tiller`

## Security

This command will start Tiller with both strong authentication over gRPC,
and a service account to which RBAC policies have been applied

```
helm init \
--tiller-tls \
--tiller-tls-verify \
--tiller-tls-cert=cert.pem \
--tiller-tls-key=key.pem \
--tls-ca-cert=ca.pem \
--service-account=accountname
```
