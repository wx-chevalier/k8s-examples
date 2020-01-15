```sh
# 初始化所需的 PV
kubectl apply -f sonatype-nexus-pv.yaml

# 安装
helm install --namespace yourbiz-infra sonatype-nexus -f values.yaml stable/sonatype-nexus

# 更新
helm upgrade --namespace yourbiz-infra sonatype-nexus -f values.yaml stable/sonatype-nexus
```

用户

| 用户名                 | 密码                   |
| ---------------------- | ---------------------- |
| `admin`                | `YOUR-ADMIN-PASSWORD`  |
| `yourbiz-snapshot-pub` | `yourbiz-snapshot-pub` |
| `yourbiz-release-pub`  | `yourbiz-release-pub`  |
| `yourbiz-read`         | `yourbiz-read`         |
