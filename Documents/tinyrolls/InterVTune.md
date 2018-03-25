# InterVTune
Vtune可视化性能分析器(Intel VTune Performance Analyzer)是一个用于分析和优化程序性能的工具，作 为Intel为众多开发者们提供的专门针对寻找软硬件性能瓶颈的一款分析工具，它能帮助你确定程序的热点 (hotspot)，帮助你找到导致性能不理想的原因，从而让你能据此对程序进行优化。

官方网址
https://software.intel.com/en-us/node/256997

1. 安装过程
```
tar -zxvf vtune_amplifier_2018.tar.gz
cd vtune_amplifier_2018
sh install.sh
//  一系安装选项，有accept 以及试 选项要选，其他默认的回 即可
source /opt/intel/vtune_amplifier_2018.0.2.525261/amplxe-vars.sh
```

参考内容
http://blog.csdn.net/huangjw_806/article/details/53027015
官方指南
https://software.intel.com/en-us/vtune-amplifier-install-guide-linux

2. 使用教程
更具体的参数使用和应用分析还需进一步探索
    - 命令行模式
    ```
    // 基础指令
    amplxe-cl -collect hotspots -r xhpl_hot ./xhpl
    ```

    - GUI模式
    操作更友好，但限于环境，没有使用

    参考内容
    http://qiusuoge.com/12069.html

3. 安装过程出现的小问题
    - `amplxe: Error: Cannot start data collection because the scope of ptrace system call
          application is limited. To enable profiling, please set
          /proc/sys/kernel/yama/ptrace_scope to 0. See the Release Notes for instructions on
          enabling it permanently.`
    要设置系统参数，但是ptrace_scope文件不能直接vim修改
    解决办法——在设置里改
    ```
    echo  "kernel/yama/ptrace_scope = 1" >> /etc/sysctl.conf
    sudo sysctl -p
    ```
