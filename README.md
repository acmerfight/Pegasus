# Pegasus

An cache system use Eralng

###  设计思路

为写入缓都分配一个独立的存储进程，再将对应的键映射至该进程,缓存中的值相互独立，各有各的生命周期。同时，Erlang本身对大量轻量级进程提供了良好的支持，使得这种设计成为可能。
![](https://raw.githubusercontent.com/acmerfight/Pegasus/master/img/otp0.png)
