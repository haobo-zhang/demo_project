



# demo_project

以Kmean为出发，进行粗略基因型分型脚本HapClass

## 版本日志

1. 20230907第一次提交

```mermaid
graph LR
	A[原始数据]
	B[进行迭代计算优化]
	C[预估聚类中心数]
	D[基因分型结果]
	A-->B-->C-->D
```

## 环境配置和软件安装

利用vcftool软件进行vcf数据的切割（给大佬磕头）

需要R包pheatmap;getopt;stringr



## 操作介绍

本脚本进行轻代码化处理

```sh
##将自己原始vcf文件放在目录下
sh go.sh [原始vcf] [染色体] [起始位置] [终止位置]
#结果在rusult文件夹中
```

