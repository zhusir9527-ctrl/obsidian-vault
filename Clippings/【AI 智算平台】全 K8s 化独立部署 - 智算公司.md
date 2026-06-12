---
title: "【AI 智算平台】全 K8s 化独立部署 - 智算公司"
source: "https://cwiki.yunify.com/pages/viewpage.action?pageId=205173272"
author:
published:
created: 2026-06-10
description:
tags:
  - "clippings"
---
[Skip to end of metadata](#page-metadata-end) [Go to start of metadata](#page-metadata-start)

## 一、完整部署：

1. 平台服务使用 3 Master（裸机）和多个 GPU 算力节点（裸机）来部署，安装 K8s + KSE + 智算平台 + 智算公共服务，通过 kube-vip服务实现 K8s Master 高可用。（同时也支持单节点，单节点配置请看cluster.yaml配置）
	1. 包括 3 台 CPU 物理节点，作为智算平台管理节点（即 K8s Master），部署智算平台服务（包括 KSE 服务），以及部署智算公共服务：Account、WebService、Billing、HaProxy、Nginx、Boss、Product 等。
		2. 配置 3 台 CPU 物理节点 与 所有 GPU 物理机之间的网络联通，以及从 3 台 物理节点到所有其他 node 的 root用户ssh 免密钥 （服务依赖，使用密码方式会导致节点信息采集失败）登陆。
2. 所有裸机加入同一管理网络、包括外接的第三方文件存储，也接入管理网络
	1. 计算节点之间有独立计算、存储网路，独立配置，此网络不需要与管理节点相连
3. GPU 服务器需要访问公网场景时：
	1. K8s Master 节点，设置 VIP，该 VIP 作为网关 IP。
		2. 配置所有节点的网关为该 VIP。
		3. 3 个 Master 绑定公网 IP，从而实现所有节点，以及内部 Pod 均可以访问公网来下载软件。

![](https://cwiki.yunify.com/download/attachments/205173272/AI%20%E6%99%BA%E7%AE%97%E5%B9%B3%E5%8F%B0-Page-16.png?version=2&modificationDate=1775281327462&api=v2)

确认组网

1. 管理网络（25G/10G/100G）
2. 计算网络，根据客户需求进行配置，非必选，一般h100 系列需要，4090 不需要
3. 存储网络，超高计算效率集群需要，非别选，一般不需要，计入计算高性能网络即可

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-12-29_16-47-12.png?version=1&modificationDate=1766998032656&api=v2)

## 二、前置条件：

生产环境主域名：例如 core.com，【严重声明！！！】智算用的是企业云的域名，企业云不支持改域名，所以智算不支持改域名！！

- 智算镜像仓库域名【可选】, 如：（默认 ）
- 智算 API 服务域名【必选】，如：ai. + 主域名
- 智算管理 KSE 控制台域名【可选】，如：kse. + 主域名 （如果没有域名可使用master节点IP：30880 如：10.23.0.2:30880）
- 智算用户端 console 域名【必选】，如 console. + 主域名
- 智算公共服务管理端 Boss 域名【必选】，如 boss. + 主域名
- 文档域名【必选】，如 docs. + 主域名
- 智算公共服务 API 服务域名【必选】，调用 boss 和产品中心接口使用，如 api. + 主域名
- 智算公共服务 前端配置中心域名【必选】 cadmin. + 主域名

POC 或非正式环境，遇到无法搞定域名的情况下，根据将来的真实域名，模拟一些假域名，使用 host 配置 ip 映射来部署，将来真实域名到了可以直接配置转发，所以

- POC 环境可以不用申请真实域名，通过配置 /etc/hosts 来实现测试
- 模拟的域名需要跟将来正式环境的域名保持一致

## 2\. 确认可用网段

**默认是 docker 的 172.17.0.0 和 calico 的 10.233，如该地址已经被使用，那么该网络不可用，严格确认客户分配给智算平台的网段**

**默认是 docker 的 172.17.0.0 和 calico 的 10.233，如该地址已经被使用，那么该网络不可用，严格确认客户分配给智算平台的网段**

**默认是 docker 的 172.17.0.0 和 calico 的 10.233，如该地址已经被使用，那么该网络不可用，严格确认客户分配给智算平台的网段**

## 3\. 确认第三方存储正确联通

- 第三方存储管理网卡接入管理网络
- 存储服务器如有规划的独立存储网卡，同客户的网络架构图确认
	- 独立的存储网络，则配置连接独立存储网络，并可访问通过
		- 无独立的存储网络，接入高速计算网络
- 计算节点通过client进行挂载此文件系统，这个posix client 对系统和内核版本的要求，非常严格
- 智算平台安装完成后，系统会自动创建maasfile/model/public 作为公共存储目录
- 查看 [对接第三方文件存储](https://cwiki.yunify.com/pages/viewpage.action?pageId=224902632) 的步骤
- 同客户索要第三方存储的访问URL、用户名和密码

## 4\. 再次确认需要OS、内核版本，当前支持ubuntu、qilin

## 5\. 确认显卡驱动、CUDA的版本

交付确认版本，下载安装包，批量安装找叶栓

推荐驱动：

<table><colgroup><col> <col> <col></colgroup><thead><tr><th><p>驱动版本</p></th><th colspan="1"><p>推荐原因</p></th><th><p>驱动下载</p></th></tr></thead><tbody><tr><td>570.195.03</td><td colspan="1">目前客户多是570版本的驱动，并且没有隐藏问题</td><td>wget --header="Referer: <a href="https://www.nvidia.com/">https://www.nvidia.com/</a> " <a href="https://cn.download.nvidia.com/XFree86/Linux-x86_64/570.195.03/NVIDIA-Linux-x86_64-570.195.03.run">https://cn.download.nvidia.com/XFree86/Linux-x86_64/570.195.03/NVIDIA-Linux-x86_64-570.195.03.run</a></td></tr></tbody></table>

不可用驱动：

| 驱动版本 | 不可用原因 |
| --- | --- |
| 550.90.12 | 该驱动版本有bug，会导致vgpu的监控采集不到 |

## 三、智算平台部署

## 0\. 机器上架

QAI K8S集群环境节点要求:

1. \[非强制性\] 系统版本 == Ubuntu 22.04.1,[Kylin V10 SP3](https://ins.qingcloud.com/repos/isos/deprecated/Kylin-Server-V10-SP3-qingcloud-aarch64-AutoInstall-20240913.iso) （未使用指定系统版本及其他版本需要自行解决依赖问题，会有某些命令缺失、版本过低等问题）
2. \[强制性\] 内核版本 == \[暂无\]，同第三方存储要求的内核版本核对，如果要使用longhorn，内核系统版本不可为5.15.0-94-generic
3. \[强制性\] 节点名称, 禁止手动修改节点名称(hostname)，部署的脚本会自动修改， host：下种的name 即节点名称例如，（name: master1）
4. \[强制性\] **管理节点要求（3 台 CPU 物理节点）**
	1. 硬件: >=32c 128G
		2. 系统盘 \* 2 = raid1, 容量 > 480G （操作系统安装的盘），要求SATA/NVME SSD，HDD不可以（平台会挂、会长时间无响应、应用负载长时间创建不出来）
		3. 数据盘 \* 2, 容量 > 1T （如日志，镜像等），要求SATA/NVME SSD，HDD不可以
5. \[强制性\] **计算节点要求**
	1. 硬件：根据显卡效率，配置CPU和内存，一般情况1:4，或者1:8，具体以客户的服务器配置为主
		2. 系统盘 \* 2 = raid1, 容量 > 480G （操作系统安装的盘），要求SATA/NVME SSD，HDD不可以
		3. 数据盘 \* 2, 单盘容量 > 3T ，分两个区，要求SATA/NVME SSD，HDD不可以
		1. 分区1：为容器实例的系统盘、关机保存的镜像、镜像预热的盘
				2. 分区2：临时存储数据的盘，如无共享的文件存储集群，可使用此盘
6. \[强制性\] **网络**:
	1. 所有节点 DNS 验证正常，（这个其实主要是环境主机的 dns 服务需要正常，比如配置为 8.8.8.8 或者 114.114.114.114 。 防止配置一个不通的 dns 地址， 这样会导致部署后 k8s 网络访问有问题。）
		2. 如有其他网络，所有节点独立的计算网络、存储网络已经实施接入

## 1\. 下载部署包

注意：离线包大小 52G，解压后 150G左右, 安装系统依赖还需要空间，整体安装部署目录空间 > 200G

下载地址：(账号密码使用公司ftp提供账号密码)

```java
x86: https://ins.qingcloud.com/repos/coreshub/aicp-installer-amd64-v2.27.2.tar.gz
```

参考项目信息模板，联系 [向乐](https://cwiki.yunify.com/display/~levenxiang) 确认参数：

具体信息，在 wiki 上做好登记，售前 POC 在这登记 [项目售前测试](https://cwiki.yunify.com/pages/viewpage.action?pageId=200212040) ，实施正式交付在这登记 [项目交付](https://cwiki.yunify.com/pages/viewpage.action?pageId=184658256) ，再次确认该项目可以进场实施

```bash
客户名称：
负责销售：
负责售前：
 
1. 域名准备
主域名：例如 coreshub.cn
智算镜像仓库域名【可选】：  dockerhub.aicp.local
智算 API 服务域名【必选】，jupyter和推理服务使用： ai. + 主域名
智算管理 KSE 域名【可选】： kse. + 主域名
智算用户端 console 域名【必选】：  console. + 主域名
智算公共服务管理端 Boss 域名【必选】：  boss. + 主域名
文档域名【必选】：  docs. + 主域名 
智算公共服务 API 服务域名【必选】：  api. + 主域名
智算公共服务 前端配置中心域名【必选】：  cadmin. + 主域名
 
部署类型： 纯私有化容器poc部署
部署架构： 3（Master+Worker）融合部署
服务器数量：3台
服务器类型：物理机
服务器配置：
    CPU：Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz*2
    内存：192GB 
    系统盘：480Gb ssd raid1
    数据盘：30Tb SATA raid1
    磁盘数量：2块
    网卡： 2，bond4 GE
    显卡：1*T4
    操作系统：Ubuntu 22.04.5
是否支持远程：支持
服务器是否支持公网：不支持
对象存储：无
并行文件存储：无
网络架构图：图片
```

解压部署包

```bash
cd/opt# 不限制目录，需保障空间充足（空间200G+）
tar-xzvf aicp-installer.tar.gz
```

安装文件如下:

```java
aicp-installer
├── aicp-cluster.tar.gz // 由 kk 工具生成的集群安装包  
├── scripts // 其他相关部署脚本  
    ├── nccl-test/ // nccl 测试
├── kk // kubekey 集群安装工具  
├── charts // 业务 chart 包  
├── common  // aicp 业务包
├── conf // 配置文件目录  
    ├── cluster-x86.yaml // k8s 集群部署x86内置配置文件, 参考 kk 工具
    ├── cluster-ascend.yaml // k8s 集群部署arm内置配置文件, 参考 kk 工具
```

## 2\. 修改 AICP-INSTALLER 配置

### 1）修改 cluster.yaml 配置(下面配置仅供属性参考解读， 严禁使用下面配置， 部署包已经集成相应配置文件，请根据实际情况填写)

cluster配置存放于 conf目录下(请根据架构进行选择修改 )

- cluster-x86.yaml
- cluster-ascend.yaml

注意：请根据实际情况修改配置

1. **hostsname：禁止手动手改hostname**
2. **节点配置： 有几个节点hosts 就在spec.hosts和spec.roleGroups填写几个节点的内容信息， 如果是单节点则在spec.hosts 和 spec.roleGroups填写一个节点 内容信息即可。**
3. **hosts配置： 如果节点为arm， 须在 下面节点 参数中添加 arch: arm64, 默认为填写是 amd64 。 gpuType只有(nvidia、ascend）两个值，如果节点带有卡则需要填写上。label标签中如果是管理节点则需要加上 [node-role.kubernetes.io/master](http://node-role.kubernetes.io/master): ""，则是计算节点就需要加上aicp.group/role: worker，如果既是管理节点和计算节点都需要加上（单节点需要注意）。**
4. **单节点配置：labels中需要同时加上 [node-role.kubernetes.io/master](http://node-role.kubernetes.io/master): ""和 aicp.group/role: worker 标签；修改kubernetes.maxPods pod数量大小值180+。harbor仓库地址端口不能为443**
5. **其他配置需要根据实际情况修改 spec.system 下的依赖安装。 如果使用高可用模式必须将spec.controlPlaneEndpoint.internalLoadbalancer 改成kube-vip，address 必须填写高可用地址**
6. **目前证书配置只支持通配符 证书 例：\*.coreshub.cn**

```yml
# nonk8s
apiVersion:kubekey.kubesphere.io/v1alpha2
kind:Cluster
metadata:
  name:sample
spec:
  aicp:### aicp 业务配置
    domainConfig:### 域名相关配置
      domain:core.com  ### 主域名
      protocol:http ### 请求协议
      ai:ai  ### ai服务域名
      api:api ### 公共APi服务域名
      cadmin:cadmin ### 配置中心服务域名
      boss:boss ### boss服务域名
      console:console ### console 服务域名
      docs:docs ### 文档服务域名
      certPaths:###证书路径 
        General:### 固定
          keyFile:xxxxx.key ### 私钥路径
          certFile:xxxx.pem ### 证书路径
    zone:core ### 区域名称
    hami:true### 开启 GPU 虚拟化
    network:false### nvidia network operator 的安装，在有 IB 网卡的情况下设置 true
    billing:true### 计费 
  hosts:
    -{name:master1,address:10.23.0.2,internalAddress:10.23.0.2,user:ubuntu,password:Zhu88jie!,labels:{istio.ingress.gateway:enabled,node-role.kubernetes.io/master:""},dockerRootDisk:/dev/vdc,dockerOverlaySize:50G,zfsDataDisk:[/dev/vdd]}
    -{name:master2,address:10.23.0.3,internalAddress:10.23.0.3,user:ubuntu,password:Zhu88jie!,labels:{istio.ingress.gateway:enabled,node-role.kubernetes.io/master:""},dockerRootDisk:/dev/vdc,dockerOverlaySize:50G,zfsDataDisk:[/dev/vdd]}
    -{name:master3,address:10.23.0.4,internalAddress:10.23.0.4,user:ubuntu,password:Zhu88jie!,labels:{istio.ingress.gateway:enabled,node-role.kubernetes.io/master:""},dockerRootDisk:/dev/vdc,dockerOverlaySize:50G,zfsDataDisk:[/dev/vdd]}
    -{name:gpu001,address:10.23.0.5,internalAddress:10.23.0.5,user:ubuntu,password:Zhu88jie!,labels:{aicp.group/role:worker},dockerRootDisk:/dev/vdc,dockerOverlaySize:50G,zfsDataDisk:[/dev/vdd],gpuType:nvidia}
    -{name:gpu002,address:10.23.0.6,internalAddress:10.23.0.6,user:ubuntu,password:Zhu88jie!,labels:{aicp.group/role:worker},dockerRootDisk:/dev/vdc,dockerOverlaySize:50G,zfsDataDisk:[/dev/vdd],gpuType:nvidia}
  roleGroups:
    etcd:
      -master1
      -master2
      -master3
    control-plane:
      -master1
      -master2
      -master3
    worker:
      -master1
      -master2
      -master3
      -gpu001
      -gpu002
    registry:
      -master2
  controlPlaneEndpoint:
    ## Internal loadbalancer for apiservers
    internalLoadbalancer:haproxy   ### 集群运行模式 haproxy / kube-vip （负载均衡和高可用）， 可选：设置成 kube-vip k8s 集群 3 个 master 节点会是高可用模式。但是address 地址不可为空
    domain:lb.kubesphere.local
    address:""###  vip地址 ， 设置kube-vip后必填
    port:6443
  kubernetes:
    version:v1.27.16
    clusterName:cluster.local
    autoRenewCerts:true
    containerManager:docker
  etcd:
    type:kubekey
  network:
    plugin:calico
    kubePodsCIDR:10.233.64.0/18
    kubeServiceCIDR:10.233.0.0/18
    ## multus support. https://github.com/k8snetworkplumbingwg/multus-cni
    multusCNI:
      enabled:false
  registry:
    type:harbor
    auths:
      "dockerhub.aicp.local:8443":
        username:admin
        password:Harbor12345
        skipTLSVerify:true### 使用默认域名， 或者自签名的 harbor地址，须填写这个
        plainHTTP:false### 如果harbor域名的 http  须为 true，如果是使用自kk 部署的harbor不要改成true
    privateRegistry:"dockerhub.aicp.local:8443/aicp-common"
    # bridgeIP: 172.17.0.1/16  ### docker 网卡默认网段，部署前须确认是否和网络网段有冲突
    namespaceOverride:""
    registryMirrors:[]
    insecureRegistries:[]
  addons:[]
  dns:
    ### 如果集群里面有额外的 hosts域名请求（指没有解析到公网，或者自建dns服务的域名，通过解析hosts方式来访问的）， 在下面参数添加上。 默认内置3个   
    dnsEtcHosts:| 
      10.23.0.3 dockerhub.aicp.local
      10.23.0.2 ai.core.com
      10.23.0.2 api.core.com
  system:
    # The ntp servers of chrony.
    ntpServers:
      -master1 # Set the node name in \`hosts\` as ntp server if no public ntp servers access.
    timezone:"Asia/Shanghai"
    preDebs:
      -zfsutils-linux
      -dpkg-dev
      -make
      -sshpass
      -libdpkg-perl
      -bzip2
      -lto-disabled-list
      -libalgorithm-merge-perl
      -flex
      -libc6-dev
      -make
      -gcc
      -libopenmpi-dev
      -pigz
      -nvidia-driver-550-open
      -nvidia-container-toolkit
    postDebs:
      -cuda-toolkit-12-4
      -cuda-drivers-550
      -libnccl2=2.22.3-1+cuda12.5
      -libnccl-dev=2.22.3-1+cuda12.5
      # 如果 ls -l /dev/nvidia-nvswitch* | grep -E 'nvidia-nvswitch[0-9]' 输出有nvidia-switch0~N的设备，则需要安装
      # - nvidia-fabricmanager-550
    AfterPrePkgs:
      -name:install NLNX
        bash:|
          #!/bin/bash
          #tar -zxvf /tmp/kubekey/MLNX_OFED_LINUX-5.8-3.0.7.0-ubuntu22.04-x86_64.tgz;
          #cd MLNX_OFED_LINUX-5.8-3.0.7.0-ubuntu22.04-x86_64;
          #./mlnxofedinstall --all --force;
          #/etc/init.d/openibd restart;
 
          cat > /etc/rc.local.pci << 'EOF'
          #!/bin/bash
          pci_devices=$(lspci | awk '{print $1}')
          for device in $pci_devices
          do
            if lspci -vvv -s $device | grep ACSCtl | grep -q 'SrcValid+'
            then
              setpci -s $device ECAP_ACS+6.w=0
            fi
          done
          EOF
 
          cat > /etc/rc.local << 'EOF'
          #!/bin/bash
          modprobe nvidia_peermem
          sysctl -w net.ipv4.conf.all.arp_ignore=1
          sysctl -w net.ipv4.conf.all.arp_announce=2
          if [-f /etc/rc.local.ib ]; then
            /etc/rc.local.ib;
          fi
          if [-f /etc/rc.local.pci ]; then
            /etc/rc.local.pci;
          fi
          exit0
          EOF
 
          cat > /etc/systemd/system/nvidia-persistenced.service << 'EOF'
          [Unit]
          Description=NVIDIA Persistence Daemon
          Wants=syslog.target
 
          [Service]
          Type=forking
          ExecStart=/usr/bin/nvidia-persistenced
          ExecStopPost=/bin/rm -rf /var/run/nvidia-persistenced
 
          [Install]
          WantedBy=multi-user.target
          EOF
 
          systemctl daemon-reload;
          systemctl enable nvidia-persistenced --now;
 
          chmod +x /etc/rc.local*;
          systemctl start rc-local;
          systemctl enable rc-local;
 
          systemctl stop apt-daily.timer; systemctl disable apt-daily.timer
          systemctl stop apt-daily-upgrade.timer; systemctl disable apt-daily-upgrade.timer
          systemctl stop apt-daily.service; systemctl disable apt-daily.service
          systemctl stop apt-daily-upgrade.service; systemctl disable apt-daily-upgrade.service
     # 如果 ls -l /dev/nvidia-nvswitch* | grep -E 'nvidia-nvswitch[0-9]' 输出有nvidia-switch0~N的设备，则需要下方步骤
     # AfterPostPkgs:
     #  - name: start fabricmanager
     #    bash: systemctl enable nvidia-fabricmanager.service;systemctl start nvidia-fabricmanager.service |  exit 0
```

注意：需要修改的配置有:

1. spec.hosts: 每一行为一个机器节点的信息
	1. **对于所有 master 节点（同时也是 worker）**, 至少需要以下二个 **labels: labels: { istio.ingress.gateway: enabled, [node-role.kubernetes.io/master](http://node-role.kubernetes.io/master): ""}** ，如果有 nvidia gpu，增加： **gpuType: nvidia** ；昇腾 **gpuType: ascend**
		2. **对于所有独立 worker 节点（0-n 个）**, 至少需要以下一个 **labels: labels: { aicp.group/role: worker }**, 对于有 nvidia gpu 的节点，增加： **gpuType: nvidia** ；昇腾 **gpuType: ascend**
		3. 对于所有节点 dockerRootDisk，需要填写未挂载、未格式化文件系统的，块设备，如：
		![](https://cwiki.yunify.com/download/attachments/205173272/image2024-6-7_12-39-19.png?version=1&modificationDate=1725957047446&api=v2)
		![](https://cwiki.yunify.com/download/attachments/205173272/image2024-6-7_12-40-58.png?version=1&modificationDate=1725957047439&api=v2)
		其中 /dev/vdc 和 /dev/vdd 是符合要求的块设备。
		4. 对于所有节点 ，同上，需要填写未挂载、未格式化文件系统的，块设备，可以填写多个符合要求的块设备，逗号分隔。
2. spec.roleGroups.etcd: 添加所有 master 节点的 name
3. spec.roleGroups.control-plane: 添加所有 master 节点的 name
4. spec.roleGroups.worker: **添加所有节点的 name, 包括所有 master 节点和独立 worker 节点** （上面 a 节点 + b 节点）
5. spec.roleGroups.registry: 添加当前部署节点的 name
6. spec.dns.dnsEtcHosts 没有额外的域名解析。留空即可
7. spec.network.kubePodsCIDR: 10.233.64.0/18 可以支持 64 个节点， 64-128 节点可以配置为：10.233.128.0/17。
8. NVIDIA 根据是否有 nvlink 决定是否安装和启动 nvidia-fabricmanager，只有包含nvlink的显卡才安装，如A100、H100、H20、H200包含nvlink
9. 如果环境有 IB/ROCE、ROCE2 网络，当前版本需要手动在所有节点安装 ofed 驱动

## 3\. 部署智算平台

1. \[强制性\]管理节点免密到计算节点，ssh 免密登录认证
2. \[强制性\]先安装显卡驱动再部署智算相关工作，跟客户再次确认需要的驱动版本

### 0) 安装 ofed 驱动

ofed 驱动安装，针对 **有 IB/ROCE 网络** 的环境，需要手动安装 OFED 驱动

下载地址： [https://network.nvidia.com/products/infiniband-drivers/linux/mlnx\_ofed/](https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/)

比如 ubuntu 20.04 的 5.8-3 版本 ofed 驱动：

```java
# wget https://content.mellanox.com/ofed/MLNX_OFED-5.8-3.0.7.0/MLNX_OFED_LINUX-5.8-3.0.7.0-ubuntu20.04-x86_64.tgz# tar -zxvf /tmp/kubekey/MLNX_OFED_LINUX-5.8-3.0.7.0-ubuntu22.04-x86_64.tgz;
# cd MLNX_OFED_LINUX-5.8-3.0.7.0-ubuntu22.04-x86_64;
# ./mlnxofedinstall --all --force;
# /etc/init.d/openibd restart;
```

至此，管理节点和计算节点已经安装完成，包括驱动程序、cuda、ofed已经安装完成，节点间、节点-存储间网络通信已连接

### 1）部署智算平台

执行 `deploy`

```java
// 可选：使用 tmux 命令，防止 ssh 连接断开后 需要重新部署。 
# tmux ###  退出窗口断开后， 重连终端后可使用 tmux a -t 0进去 部署窗口
 
# ./kk coreshub deploy -f conf/cluster-xxx.yaml -a aicp-cluster.tar.gz  -p
```

参数

1. \--network: 安装 network-operator, 默认不安装 ，IB网络安装
2. \--hami: 安装 vgpu, 默认安装
3. \-p, --free-password 设置免密,默认不设置免密

注意：--hami --network 可以在配置文件中配置。 如果在在命令上执行， 优先级会比配置文件中的高

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-9-18_11-13-3.png?version=1&modificationDate=1758165183678&api=v2)

部署成功后打印：

```java
部署完成。集群服务的相关信息如下：
+---------+-------------+----------------------+----------------+---------------------+
| name    | ip          | domain               | username       | password            |
+---------+-------------+----------------------+----------------+---------------------+
| console | 10.23.1.253| console.core.com     | admin@core.com | 需boss重置密码      |
| boss    | 10.23.1.253| boss.core.com        | boss@core.com  | zhu88jie            |
| cadmin  | 10.23.1.253| cadmin.core.com      | admin          | zhu88jie            |
| kse     |             | 10.23.1.253:30880| admin          | P@88w0rd|
+---------+-------------+----------------------+----------------+---------------------+
 
# 还有以下域名需要在hosts中绑定到 console IP
ai.core.com api.core.com push.core.com
```

#### 1.1) RoCEV2 环境适配

参考: [【山东广电海看】roce 网络 nccl 测试问题](https://cwiki.yunify.com/pages/viewpage.action?pageId=224901517)

**准备：**

收集容器使用的 ROCE 网卡 ID，如一个节点的网卡id （ 0000:3b:00.0、0000:4b:00.0、0000:5d:00.0、0000:ab:00.0、0000:bb:00.0、0000:cb:00.0、0000:db:00.0、0000:16:00.0）

确认仓库中有如下镜像（默认会有）：

dockerhub.aicp.local/aicp-common/aicp\_common/k8snetworkplumbingwg\_sriov-network-device-plugin:2cc723dcbc712290055b763dc9d3c090ba41e929  
dockerhub.aicp.local/aicp-common/aicp\_common/k8snetworkplumbingwg\_plugins:v1.2.0-amd64  
dockerhub.aicp.local/aicp-common/aicp\_common/k8snetworkplumbingwg\_whereabouts:v0.6.1-amd64  
dockerhub.aicp.local/aicp-common/aicp\_common/k8snetworkplumbingwg\_multus-cni:v3.9.3

**创建资源：**

1) 创建 NicClusterPolicy 与 HostDeviceNetwork

sriovDevicePlugin 里面的 pciAddresses 改为实际的网卡 ID

```java
apiVersion: mellanox.com/v1alpha1
kind: NicClusterPolicy
metadata:
  annotations:
    meta.helm.sh/release-name: network-operator
    meta.helm.sh/release-namespace: network-operator
  labels:
    app.kubernetes.io/managed-by: Helm
  name: nic-cluster-policy
spec:
  psp:
    enabled: false
  secondaryNetwork:
    cniPlugins:
      image: k8snetworkplumbingwg_plugins
      imagePullSecrets: []
      repository: dockerhub.aicp.local/aicp-common/aicp_common
      version: v1.2.0-amd64
    ipamPlugin:
      image: k8snetworkplumbingwg_whereabouts
      imagePullSecrets: []
      repository: dockerhub.aicp.local/aicp-common/aicp_common
      version: v0.6.1-amd64
    multus:
      image: k8snetworkplumbingwg_multus-cni
      imagePullSecrets: []
      repository: dockerhub.aicp.local/aicp-common/aicp_common
      version: v3.9.3
  sriovDevicePlugin:
    config: |
      {
        "resourceList": [
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev1",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:3b:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          },
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev2",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:4b:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          },
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev3",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:5d:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          },
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev4",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:ab:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          },
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev5",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:bb:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          },
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev6",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:cb:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          },
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev7",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:db:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          },
          {
            "resourcePrefix": "nvidia.com",
            "resourceName": "hostdev8",
            "selectors": {
              "vendors": ["15b3"],
              "devices": [],
              "drivers": [],
              "pfNames": [],
              "pciAddresses": ["0000:16:00.0"],
              "rootDevices": [],
              "linkTypes": ["ether"],
              "isRdma": true
            }
          }
        ]
      }
    image: k8snetworkplumbingwg_sriov-network-device-plugin
    imagePullSecrets: []
    repository: dockerhub.aicp.local/aicp-common/aicp_common
    version: 2cc723dcbc712290055b763dc9d3c090ba41e929
  tolerations:
  - operator: Exists
  
---
 
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net1
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.11.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev1
---
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net2
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.12.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev2
---
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net3
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.13.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev3
---
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net4
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.14.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev4
---
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net5
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.15.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev5
---
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net6
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.16.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev6
---
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net7
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.17.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev7
---
apiVersion: mellanox.com/v1alpha1
kind: HostDeviceNetwork
metadata:
  name: roce-hostdevice-net8
spec:
  ipam: |
    {
      "type": "whereabouts",
      "datastore": "kubernetes",
      "kubernetes": {
        "kubeconfig": "/etc/cni/net.d/whereabouts.d/whereabouts.kubeconfig"
      },
      "range": "192.168.18.1/24",
      "log_file": "/var/log/whereabouts.log",
      "log_level": "info"
    }
  networkNamespace: default
  resourceName: hostdev8
```

2）config-server 中配置

```java
ib_type: "RoCE"
# 这个列表里面的值对应host-device.yaml里面每一个networkNamespace/resourceName
roce_nets: ["default/roce-hostdevice-net1","default/roce-hostdevice-net2","default/roce-hostdevice-net3","default/roce-hostdevice-net4","default/roce-hostdevice-net5","default/roce-hostdevice-net6","default/roce-hostdevice-net7","default/roce-hostdevice-net8"]
# 这个列表里面的值对应nic.yaml 里面的每一个 resourcePrefix/resourceName
roce_device: ["nvidia.com/hostdev1","nvidia.com/hostdev2","nvidia.com/hostdev3","nvidia.com/hostdev4","nvidia.com/hostdev5","nvidia.com/hostdev6","nvidia.com/hostdev7","nvidia.com/hostdev8"]
```

### 2）部署失败进行重装

如果 K8s 安装节点出现报错，根据报错日志排查失败原因。

如果整个智算 deploy 失败，可以进行重试安装，如果重试安装遇到问题（比如 etcd 问题），可以彻底清除并重新安装：

```java
彻底删除 K8s 集群和上面已经部署的服务，但系统依赖和驱动不会变化
# ./kk delete cluster -f conf/cluster.yaml
 
删除已经完成的步骤标记
# rm kubekey/step/**
 
然后再次执行之前的安装命令， 如：
# ./kk coreshub deploy -f conf/cluster.yaml -a aicp-cluster.tar.gz  -p
```

## 4\. 检查所有服务是否均正常

```java
--- 清理 job 残留 pod ---
# kubectl delete pods -n aicp-system --field-selector=status.phase=Failed
 
--- 查看是否有无法启动 pod ---
# kubectl get pod -o wide -A | grep -v Running | grep -v Com
```

如果有未就绪的服务，通过 kubectl describe 和 kubectl logs 命令查看错误信息进行排查。

## 5.环境默认信息

整个环境安装完成后，会有以下 UI

<table><colgroup><col> <col> <col> <col> <col></colgroup><thead><tr><th><p>平台</p></th><th><p>URL</p></th><th><p>用户名</p></th><th><p>密码</p></th><th colspan="1"><p>作用</p></th></tr></thead><tbody><tr><td><p>Console 控制台</p></td><td>console.主域名 (如 console.core.com)</td><td>@主域名 (如 admin@core.com)</td><td>boss 后台重置密码</td><td colspan="1">用户端 UI 页面</td></tr><tr><td>KSE 管理后台</td><td>masterIp:30880(如 10.23.0.2:30880)</td><td>admin</td><td>P@88w0rd</td><td colspan="1">运维监控后台</td></tr><tr><td>Boss 后台</td><td>boss.主域名 (如 boss.core.com)</td><td>boss@主域名 (如 boss@core.com)</td><td>zhu88jie</td><td colspan="1">用户管理和产品规格中心后台</td></tr><tr><td>Cadmin</td><td>cadmin.主域名 （如 cadmin.core.com）</td><td>admin</td><td>zhu88jie</td><td colspan="1">前端配置中心（开启和关闭前端功能菜单）</td></tr><tr><td colspan="1">Harbor</td><td colspan="1">默认 dockerhub.aicp.local</td><td colspan="1">admin</td><td colspan="1">Harbor12345</td><td colspan="1">镜像仓库 UI</td></tr><tr><td colspan="1"><p>Grafana</p></td><td colspan="1">masterIp:30210(如 10.23.0.2:30210)</td><td colspan="1">admin</td><td colspan="1">admin</td><td colspan="1">Grafana 监控 UI</td></tr></tbody></table>

## 6\. KSE license 导入

完成部署后，智算平台的后台需要导入 KSE License。

导入方式为：

### 1\. 获取集群 ID

```java
# kubectl get ns kube-system -o jsonpath="{.metadata.uid}"$'\n'
 
--- 返回结果如：----
d66442cc-16e3-4455-834f-e87be5f1e825
```

### 2\. 汇总 3 管理节点 + 所有 worker 节点 CPU 总和

```java
# kubectl get nodes -o=jsonpath='{range .items[*]}{.status.capacity.cpu}{"\n"}{end}'| awk '{s+=$1} END {print s}'
 
--- 返回结果如：----
1072
```

计算需要的版权数量，按照合同计算需要的版权数量，如果客户购买了10个节点，前期先上线8台，就也申请10台的，一次性按照合同申请版权数量

说明1：版权数量是CPU的线程数总和，可根据用户选择的CPU型号，提前计算出需要多少核心，管理和计算节点的CPU核心数累加，例如 2 \* intel 6248 24C ，就是 24 \* 2（颗）\* 2（线程） = 96 vCPU（线程）

说明2：实际部署时：也是获取的线程数，如果节点不开超线程，那么也是按照超线程的线程数计算版权

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-7-16_13-55-25.png?version=1&modificationDate=1752645325849&api=v2)

### 3\. 获取 license

商务同事，通过下载并填写下方链接的KSE来获取 [KSE license](https://box.yunify.com/apps/files/files/1858059?dir=/%E4%BA%A7%E5%93%81%E8%B5%84%E6%96%99%E5%BA%93/09-KSE%20%E4%BA%A7%E5%93%81%E8%B5%84%E6%96%99%EF%BC%88%E5%85%A8%EF%BC%89/2-%E6%8A%A5%E4%BB%B7%26%E6%8B%9B%E6%A0%87/KSE%20License%20%E6%A8%A1%E6%9D%BF%EF%BC%88%E5%A1%AB%E5%86%99%E5%90%8E%E8%AF%B7%E9%82%AE%E4%BB%B6%E7%94%B3%E8%AF%B7%EF%BC%89) ，在 word 文档中包括上述信息，点击【 [查看](https://box.yunify.com/apps/files/files/1858047?dir=/%E4%BA%A7%E5%93%81%E8%B5%84%E6%96%99%E5%BA%93/09-KSE%20%E4%BA%A7%E5%93%81%E8%B5%84%E6%96%99%EF%BC%88%E5%85%A8%EF%BC%89/2-%E6%8A%A5%E4%BB%B7%26%E6%8B%9B%E6%A0%87) 】kse版权模板

```java
授权集群 id：d66442cc-16e3-4455-834f-e87be5f1e825 （第 1步中获取的集群 ID）
授权数量与单位：1072vcpu (第 2步中获取的数量)
时间：<根据项目所需的时间>
备注：根据KSE对应的版本选择授权版本
```

**申请方式：** 邮件给苗慧( miaohui@yunify.com)审批，抄送给 孔玮（ [kongwei@yunify.com](mailto:kongwei@yunify.com) ），申请版权，POC版权为有效期3个月，安装交付版权有效期为为 1 个月，交付后注入正式版权开放工单权限

### 4\. 注册 license

登陆 KSE 平台，默认端口：30880。

默认密码：admin / P@88w0rd

点击右上角齿轮菜单，打开配置菜单

![](https://cwiki.yunify.com/download/attachments/205173272/%E6%88%AA%E5%B1%8F2024-04-23%2012.20.49.png?version=1&modificationDate=1725957047429&api=v2)

依次点击 “许可证” → ”许可证管理“ → “添加许可证”

![](https://cwiki.yunify.com/download/attachments/205173272/%E6%88%AA%E5%B1%8F2024-04-23%2012.21.32.png?version=1&modificationDate=1725957047422&api=v2)

然后添加 KSE license。

“许可证信息” 显示已授权表示成功。

![](https://cwiki.yunify.com/download/attachments/205173272/%E6%88%AA%E5%B1%8F2024-04-23%2012.34.11.png?version=1&modificationDate=1725957047415&api=v2)

## 7\. 更新监控节点列表信息

注意：需要等待 gpu-operator namespace 下 pod 正常运行

有时候前面的免密设置失败，再执行一下配置免密

\*\*\* 以及 配置免密（任意一台 master 可以免密到 work 节点，以及 master 自己， 比如 master1 可以免密到 master1，master2， master3， gpu1，gpu2； 同时 master2 和 master3 也能免密到 master1，master2， master3， gpu1，gpu2； ）

\*\*\* 以及 配置免密（任意一台 master 可以免密到 work 节点，以及 master 自己， 比如 master1 可以免密到 master1，master2， master3， gpu1，gpu2； 同时 master2 和 master3 也能免密到 master1，master2， master3， gpu1，gpu2； ）

\*\*\* 以及 配置免密（任意一台 master 可以免密到 work 节点，以及 master 自己， 比如 master1 可以免密到 master1，master2， master3， gpu1，gpu2； 同时 master2 和 master3 也能免密到 master1，master2， master3， gpu1，gpu2； ）

重要的事情说 三 遍

执行:

```java
# kubectl rollout restart deploy aicp-update-job -n aicp-system
```

通过扩展组件进入 AI 智算管理扩展 → 节点 → 节点列表 查看节点信息。

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-2-26_14-54-39.png?version=1&modificationDate=1740552880629&api=v2)

## 8\. （可选）调整前端配置中心适配环境

默认安装部署，相应开发、训练、推理模块均会启用。

按照客户下单的「模块」进行开启/关闭功能

如果有特殊的如 epfs 开启等需求， 可参考 [QAI 智算出厂配置管理](https://cwiki.yunify.com/pages/createpage.action?spaceKey=console&title=QAI+%E6%99%BA%E7%AE%97%E5%87%BA%E5%8E%82%E9%85%8D%E7%BD%AE%E7%AE%A1%E7%90%86) 在前端配置中心修改。

## 9\. （必选）导入预置镜像

导入平台预置的镜像，通过公共 harbro 镜像仓库，特别说明：公有云应用镜像由于长久不更新，不支持导入到私有化环境，公有云的也会下线

智算公共镜像仓库：hub.kubesphere.com.cn

私有化默认 harbor 地址：dockerhub.aicp.local

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-12-29_14-58-57.png?version=1&modificationDate=1766991537579&api=v2)

**快速同步脚本**

可以使用以下脚本快速同步，离线环境下只支持docker

**下载：------> [import-image.tar](https://cwiki.yunify.com/download/attachments/205173272/import-image.tar?version=2&modificationDate=1778835609303&api=v2)**

#### 脚本概述

`import-image.sh` 是一个用于管理容器镜像的辅助脚本，支持三种运行模式：

| 模式 | 功能 |
| --- | --- |
| **online** | 从公网镜像源拉取镜像，直接推送到私有 Harbor |
| **save** | 将公网镜像导出为本地 tar 包，用于离线环境 |
| **load** | 将本地 tar 包加载并推送到私有 Harbor |

#### 前提条件

- 拥有可执行权限的 Linux/macOS/WSL 环境
- 已安装 `docker` （save/load 模式必须）或 `skopeo` （online 模式可选）
- online/load 模式需要在已部署的 K8s 集群环境中执行（用于自动查询 Harbor 配置）
- 如需从 Harbor 自动获取配置，需确保 kubectl 可正常访问集群

#### 参数说明

```
-m, --mode          online|save|load     运行模式（默认：online）
-t, --tool          PATH                 工具路径（默认自动推导）
-P, --public-url    REGISTRY             公网镜像源（默认：hub.kubesphere.com.cn）
-u, --harbor-url    URL                  私有 Harbor 地址
-U, --harbor-user   USERNAME             Harbor 用户名（默认：admin）
-p, --harbor-pass   PASSWORD             Harbor 密码
-r, --repo-prefix   PREFIX               仓库前缀（默认：aicp-common）
-i, --image-list    FILE                 镜像列表文件（可多次指定）
-I, --images        IMAGE1,IMAGE2,...    逗号分隔的镜像列表（优先于 --image-list）
-o, --output-dir    DIR                  离线包目录（默认：./offline_images）
-h, --help                               显示帮助信息
```

> **优先级规则** ： `--images` > `--image-list` > 内置默认列表

#### 使用示例

##### 在线同步模式（online）

从公网镜像源拉取镜像，自动推送到 K8s 集群中配置的私有 Harbor。

**基础用法（使用默认镜像列表）：**

```bash
./import-image.sh
```

**指定运行模式：**

```bash
./import-image.sh --mode online
```

**指定镜像列表文件：**

```bash
./import-image.sh --mode online --image-list ./my-images.txt
```

**直接传入镜像列表（逗号分隔）：**

```bash
./import-image.sh --mode online \
  --images "ai-public/pytorch:2.5.1-cuda12.4-cudnn9-devel,ai-public/tensorflow:2.16.1-gpu-jupyter"
```

##### 离线缓存模式（save）

将公网镜像导出为 tar 包，用于无法访问外网的离线环境。

**基础用法（导出到默认目录）：**

```bash
./import-image.sh --mode save
```

**指定要导出的镜像：**

```bash
./import-image.sh --mode save \
  --images "public/vllm-ascend:v0.15.0rc1,public/pytorch:2.5.1-cuda12.4-cudnn9-devel" \
  --output-dir ./offline_packages
```

> **注意** ：save 模式下镜像列表文件和输出目录都支持自定义。如果不指定镜像列表，默认使用脚本内置的 `import-base-images` 和 `import-reasoning-images` 。

##### 离线加载模式（load）

将已缓存的 tar 包加载并推送到私有仓库。适用于无外网环境。

**基础用法（从默认目录加载）：**

```bash
./import-image.sh --mode load
```

**指定离线包目录：**

```bash
./import-image.sh --mode load --output-dir ./my-offline-images
```

##### 从 FTP 服务器获取离线镜像

如果环境中无法访问公网，可从内部 FTP 服务器下载预缓存的离线镜像包：

```bash
# 1. 从 FTP 下载离线镜像包
wget -r ftp://ins.qingcloud.com/coreshub/container-images/

# 或 lftp 方式
lftp ftp://ins.qingcloud.com/coreshub/container-images/ -e "mirror --continue . ./container-images; exit"
```

> **说明** ：FTP 路径 `ftp://ins.qingcloud.com/coreshub/container-images` 下存放了预导出的 `.tar` 镜像包，下载后直接使用 `load` 模式即可推送到您的私有 Harbor。

#### 镜像列表文件格式

如果使用 `--image-list` 参数指定镜像列表文件，文件格式如下：

```
# 这是一行注释，会被忽略

# 基础镜像
ai-public/pytorch:2.5.1-cuda12.4-cudnn9-devel
ai-public/tensorflow:2.16.1-gpu-jupyter
ai-public/ubuntu:22.04

# 推理镜像
ai-public/vllm/vllm-openai:v0.10.2
public/vllm-ascend:v0.15.0rc1
```
- 每行一个镜像（ `registry/project/image:tag` ）
- 支持空行（自动跳过）
- 支持 `#` 开头的注释行（自动跳过）
- 如果省略 registry，会自动补全 `--public-url` 指定的地址

#### 内置默认镜像

如果不指定镜像列表，脚本默认读取以下两个内置列表文件：

| 文件 | 用途 | 内容示例 |
| --- | --- | --- |
| `import-base-images` | 基础镜像 | `ai-public/pytorch:2.5.1-cuda12.4-cudnn9-devel` |
| `import-reasoning-images` | 推理镜像 | `ai-public/vllm/vllm-openai:v0.10.2` |

这两个文件应与 `import-image.sh` 放在同一目录下。

### 私有化镜像列表（除此之外，其他镜像不可导入到私有化平台）

脚本已经内置以下相关镜像

<table><thead><tr><th>镜像类型</th><th><p>Repo</p></th><th colspan="1">镜像</th></tr></thead><colgroup><col> <col> <col></colgroup><tbody><tr><td rowspan="5">基础镜像<br></td><td rowspan="2">PyTorch</td><td colspan="1"><p>/public/pytorch:2.5.1-cuda12.4-cudnn-devel</p></td></tr><tr><td colspan="1">/public/llama2-train:pytorch-2.1.2-cuda12.1-cudnn8-with-model</td></tr><tr><td>TensorFlow</td><td colspan="1">/public/tensorflow:2.16.1-gpu-jupyter</td></tr><tr><td>Ubuntu</td><td colspan="1">/public/ubuntu:22.04</td></tr><tr><td colspan="1">nccl-test</td><td colspan="1">/public/nccl_test:v3.0</td></tr><tr><td>推理镜像</td><td colspan="1"><p>nvidia：vllm、sglang</p><p>npu：mindie</p></td><td colspan="1"><p><a href="https://cwiki.yunify.com/pages/viewpage.action?pageId=252320176">预置镜像步骤</a></p><p>其中 npu，按照 npu 型号进行导入</p></td></tr></tbody></table>

导入完成后，进入 ks 管理页的 “镜像仓库” 菜单中添加对应的镜像信息

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-8-29_10-55-2.png?version=1&modificationDate=1756436101864&api=v2)

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-8-29_10-55-35.png?version=1&modificationDate=1756436135115&api=v2)

## 10\. 模型广场和大模型服务更新

1、模型数据默认存储目录为节点的/share/maasfile/mode/public目录下

示例：

```java
/share/maasfile/
├── code
└── model
    └── public
        └── Qwen
            └── Qwen3-0.6B
                ├── config.json
                ├── configuration.json
                ├── download.json
                ├── download.log
                ├── generation_config.json
                ├── LICENSE
                ├── merges.txt
                ├── model.safetensors
                ├── README.md
                ├── tokenizer_config.json
                ├── tokenizer.json
                └── vocab.json
```

**请特别注意，没有使用共享存储的前提下：**

**1、如果是手动上传，需要在每个节点上传**

**2、如果使用ModelScope自动下载，只会下载到master节点上，GPU节点需要手动同步**

2、模型广场：使用console admin等管理员账号

- 将模型拷贝到文件存储中
- 使用模型管理注册模型，模型部署测试模型
- 提交上架审批
- 管理端同意，即可发布到模型广场

3、大模型服务：

- 模型部署出来后，得到模型调用连接和API key，以及模型名称
- 管理端模型服务，在线推理服务
- 添加模型，输入模型基本信息、API key、模型名称、URL 即可
- console大模型服务即可查看使用

## 11\. （可选）分布式文件存储对接

[第三方分布式文件存储对接文档](https://cwiki.yunify.com/pages/viewpage.action?pageId=224902632)

注意：对接完成后，8 调整前端配置中心适配环境 中 support\_gpfs 改为 true

## 四、创建规格和算力池

平台调度使用，依赖规格和算力池，否则用户端创建资源时无法查看到规格和可用资源。

（注：该步骤需要依赖上述步骤 7 更新监控节点列表信息）

## 方案一：通过脚本自动初始化规格

脚本使用步骤：

注意有必要的启动参数需要输入。

\# 参数1 预留的 CPU 核数 如果系统有 56 核，输入为 5，则剩余的 51 核参与分配

\# 参数2 预留的内存（Gb）如果系统有 1024 Gb，输入为 100，则剩余的 924 Gb 内存参与分配

\# 参数3 系统盘大小（Gb）保持 50 不变，如果需要修改，参考： [如何修改系统盘大小](https://cwiki.yunify.com/pages/viewpage.action?pageId=189924383#id-%E3%80%90%E4%BA%A4%E4%BB%98%E3%80%91%E6%99%BA%E7%AE%97%E8%BF%90%E7%BB%B4%E6%96%87%E6%A1%A3-%E3%80%90%E4%BA%A4%E4%BB%98%E3%80%91%E6%99%BA%E7%AE%97%E8%BF%90%E7%BB%B4%E6%96%87%E6%A1%A3-26.%E5%A6%82%E4%BD%95%E4%BF%AE%E6%94%B9%E7%B3%BB%E7%BB%9F%E7%9B%98%E5%A4%A7%E5%B0%8F)

\# 参数4 数据盘大小（Gb）当前数据盘使用 openebs zfs-localpv，使用数据盘的容器实例无法灾难迁移。

```java
# kubectl exec -it deploy/aicp-web-app -n aicp-system bash -- python3 app/jobs/init_sku/init_sku.py 510500
```

脚本执行正常退出后，可以在算力池中看到 default 的算力池，在产品中心看到添加的 GPU 规格。

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-1-21_10-38-3.png?version=1&modificationDate=1737427084271&api=v2)

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-1-21_10-40-16.png?version=1&modificationDate=1737427217234&api=v2)

## 方案二：手工自定义规格

参考：「 [算力池与产品产品中心配置](https://cwiki.yunify.com/pages/viewpage.action?pageId=197081957) 」

按照文档，先确认GPU型号，在kse的计算节点标签上的值，再去产品中心配置规格项的「GPU型号」，保证能调度到

## 五、Nccl 测试

为保障服务器的网络传输性能，以应对多节点并行训练场景，所以需要提前进行高性能网络测试：

H100、A100做训练的卡需要测试，4090等消费级卡不要测试

一般情况H100的 8\* 400G IB卡，网卡的平均传输效率为 350Gbps为合理结果

[容器版本 NCCL 测试验证](https://cwiki.yunify.com/pages/viewpage.action?pageId=191693182)

## 六、智算平台功能验证

[v2.18.0版本测试报告（已发布）](https://cwiki.yunify.com/pages/viewpage.action?pageId=224911909)

没有并行文件存储的情况下无法测试模型推理功能。

如包含HPC功能，则增加功能验证项目， [容器版HPC增加交付项](https://cwiki.yunify.com/pages/viewpage.action?pageId=246485876)

## 七、配置告警通知（可选）

进入 ks 平台，平台设置 → 通知管理 → 通知渠道 → 企业微信 → 群机器人设置

在 Webhook URL 中配置企业微信群机器人 webhook 链接并保存

![](https://cwiki.yunify.com/download/attachments/205173272/image2025-12-15_12-26-38.png?version=1&modificationDate=1765772799178&api=v2)

## 八、参考内容

1.[【交付】智算运维文档](https://cwiki.yunify.com/pages/viewpage.action?pageId=189924383)

2\. [故障排除](https://cwiki.yunify.com/pages/viewpage.action?pageId=184648123)