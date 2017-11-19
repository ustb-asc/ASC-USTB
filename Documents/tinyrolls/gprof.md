# gprof
注:因为没有在hpl的Makefile里找到能修改的编译指令，所以这个没有使用，可能在之后的具体应用中使用

改进应用程序的性能是一项非常耗时耗力的工作，但是究竟程序中是哪些函数消耗掉了大部分执行时间，这 通常都不是非常明显的。GNU 编译器工具包所提供了一种剖析工具 GNU profiler(gprof)。gprof 可以为 Linux平台上的程序精确分析性能瓶颈。gprof精确地给出函数被调用的时间和次数，给出函数调用关系。

优势:在GCC里自带gprof，且开源

1. 使用方式
    - 在编译时加入指令 -pg （一般在Makefile里修改）
    - 一般用法： gprof -b 二进制程序 gmon.out > report.txt
      `gprof -b ./xhpl gmon.out > report.txt`
    - 用gprof工具分析 gmon.out 文件
      参考内容
      http://blog.csdn.net/stanjiang2010/article/details/5655143

2. 图形化分析 gmon.out 文件
    ```
    sudo apt-get -y install python graphviz  # graphvizprint node_map
    sudo apt-get -y install python-pip
    pip install gprof2dot # gprof2dot change gmon.out to png
    ```
    参考内容
    http://www.51testing.com/html/97/13997-79952.html
