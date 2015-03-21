# Pegasus

An cache system use Eralng

###  设计思路

为写入缓都分配一个独立的存储进程，再将对应的键映射至该进程,缓存中的值相互独立，各有各的生命周期。同时，Erlang本身对大量轻量级进程提供了良好的支持，使得这种设计成为可能。
![](https://raw.githubusercontent.com/acmerfight/Pegasus/master/img/otp0.png)


erlc -o ./simple_cache/ebin ./simple_cache/src/*.erl
erlc -o ./resource_discovery/ebin ./resource_discovery/src/*.erl


erl -name contact1

To run the program, start Erlang like this:

erl -name mynode -pa ./simple_cache/ebin -pa ./resource_discovery/ebin/

Then, run the following in the Erlang shell:

1> application:start(sasl).
ok
2> mnesia:start().
ok
3> application:start(resource_discovery).
ok
4> application:start(simple_cache).
ok
5>
