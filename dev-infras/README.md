# 集群配置

- [集群安装](./cluster/README.md)
- [命名空间](./namespaces/README.md)
- [cert-manger 安装与配置](./cert-manager/README.md)
- [rancher 安装](./rancher/README.md)
- [节点本地存储声明与使用](storage/README.md)
- [gitlab 的安装](./gitlab/README.md)
- [docker registry](docker-registry/README.md)
- [sonatype-nexus](sonatype-nexus/README.md)

# 命名

yourdomain - 你的主域名，譬如 google.com
yourbiz - 你的业务简短名，譬如 k8s

# 安装的 Chart 的版本

| NAME              | NAMESPACE     | REVISION | UPDATED    |                           | STATUS   | CHART                 | APP VERSION |
| ----------------- | ------------- | -------- | ---------- | ------------------------- | -------- | --------------------- | ----------- |
| cert-manager      | cert-manager  | 1        | 2020-01-04 | 11:46:12.920596 +0800 CST | deployed | cert-manager-v0.12.0  | v0.12.0     |
| docker-registry   | yourbiz-infra | 2        | 2020-01-08 | 18:31:13.957634 +0800 CST | deployed | docker-registry-1.9.1 | 2.7.1       |
| rancher           | cattle-system | 3        | 2020-01-08 | 17:47:55.089866 +0800 CST | deployed | rancher-2.3.4-rc8     | v2.3.4-rc8  |
| sonatype-nexus    | yourbiz-infra | 7        | 2020-01-08 | 19:42:21.157519 +0800 CST | deployed | sonatype-nexus-1.21.3 | 3.20.1-01   |
| yourdomain-gitlab | yourbiz-infra | 2        | 2020-01-08 | 12:54:48.212919 +0800 CST | deployed | gitlab-ce-0.1.0       | 12.0.9-ce.0 |
