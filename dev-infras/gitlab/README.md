```sh
# 初始化存储，PV & PVC
kubectl apply -f yourdomain-gitlab/gitlab-data.yaml
kubectl apply -f yourdomain-gitlab/gitlab-etc.yaml
kubectl apply -f yourdomain-gitlab/gitlab-postgresql.yaml

# 初次安装
helm -n yourbiz-infra install yourdomain-gitlab ./gitlab-ce -f yourdomain-gitlab/values.yaml

# 后续更新
helm -n yourbiz-infra install yourdomain-gitlab ./gitlab-ce -f yourdomain-gitlab/values.yaml
```
