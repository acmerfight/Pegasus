# Pegasus

An cache system use Eralng

###  设计思路

 1. 为写入缓都分配一个独立的存储进程，再将对应的键映射至该进程,缓存中的值相互独立，各有各的生命周期。同时，Erlang本身对大量轻量级进程提供了良好的支持，使得这种设计成为可能。
![](https://raw.githubusercontent.com/acmerfight/Pegasus/master/img/otp0.png)

 2. 缓存应用在结构上由若干持有实际存储数据的存储元素进程组成, 同时还有一张表,记录着每个键与对应的存储元素进程标识符之间的映射关系表，只有这张映射表需要在节点之间以分布式形式进行存储。由于Erlang的位置透明性,没有必要在节点间复制数据:只要Web服务器之间的网络足够高效,即便存储进程位于另一台服务器上,调用远程存储进程的速度也要远快于调用原始的软件包服务器。因此,只要所有节点都能访问到键与pid 间的映射关系,存储元素进程大可静静地待在创建它们的服务器上。
![](https://github.com/acmerfight/Pegasus/blob/master/img/16.d09z.07.png)

### 特点

 - 无单点——这是一套点对点的系统；

 - 无硬编码的网络拓扑——你可以随处添加资源；

 - 易于伸缩——你可以随时加入更多资源；

 - 可以在单个节点上运行多个服务——整个探测过程是位置透明的，完全可以在单个节点上运行（该特性尤其适合于测试）；

 - 易于升级——可以动态完成旧服务的关闭和新服务的启动。移除的服务会被注销，新服务上线后很快便会被探测到。

**整体分为两个模块**

 1. 资源发现模块，发现新启动的资源节点
 2. 提供缓存的模块，提供缓存的存储和接口

### 使用方法

进行编译

    erlc -o ./simple_cache/ebin ./simple_cache/src/*.erl
    erlc -o ./resource_discovery/ebin ./resource_discovery/src/*.erl

启动节点，确保 `sc_app:ensure_contact()` 填写的节点和启动的节点名相同

    erl -sname a -pa ./simple_cache/ebin -pa ./resource_discovery/ebin/

启动 Erlang shell:

    erl -sname b -pa ./simple_cache/ebin -pa ./resource_discovery/ebin/

在 Erlang shell 启动各个部件:

    1> application:start(sasl).
    ok
    2> mnesia:start().
    ok
    3> application:start(resource_discovery).
    ok
    4> application:start(simple_cache).
    ok
    5>

