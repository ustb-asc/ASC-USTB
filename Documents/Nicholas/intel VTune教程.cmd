一些概念：基于硬件事件，多个运行，堆栈，外部收集工具，命令行，CSV格式，集合的持续时间，终结。Functions翻译为函数还是功能？分析类型<analyze type>,堆栈上的循环，列，数据分组，filter过滤器

该工具的使用命令是amplxe-cl，命令格式如下 amplxe-cl [操作选项] [操作选项的选项][ Global Options ] [[--] target [target 选项]]
为了在GUI中看结果，可以双击<resultname>.amplxe
Global Options:
-q, -quiet                    
Suppress non-essential messages
抑制不必要的信息.
-user-data-dir=<string>       Specify the base directory for result paths
                              provided by --result-dir option. By default, the 
                              current working directory is used.
指定结果路径的基本目录由——result-dir选项提供。默认情况下,当前工作目录被使用。
-v, -verbose                  Print additional information
打印附加信息

Collect的选项参数:
-allow-multiple-runs | -no-allow-multiple-runs (default)
Enable multiple runs to achieve more precise results for hardware event-based collections. When disabled, the collector multiplexes events running a single collection, which lowers result precision.
启用多个运行以实现更精确基于硬件事件的集合的结果。当禁用时，收集器将发生多路事件
运行单个集合，这会降低结果精度。
-analyze-system | -no-analyze-system (default)
Enable to analyze all processes running on the system. When disabled, only the attached process and its children are analyzed. This option is applicable to hardware event-based analysis types only.
能够分析跑在系统上的所有进程。当禁用时，只有附加的进程并对其子进程进行了分析。这个选项是适用于基于硬件事件的分析类型。
-app-working-dir=<string>
Specify a directory where the application will be run.
指定要运行的应用程序的目录。
-call-stack-mode=user-only | user-plus-one | all
 Choose how to show system functions in the stack.
选择如何显示堆栈中的系统功能。
-cpu-mask=<string>            
Specify CPU(s) to collect data on (for example:
                              2-8,10,12-14). This option is applicable to
                              hardware event-based analysis types only.
指定CPU来收集数据(例如:2 - 8、10、12 - 14)。此选项适用于
只针对基于硬件事件的分析类型。
-custom-collector=<string>    
Provide a command line for launching an external collection tool. You can later import custom collection data (time intervals and counters) in a CSV format to the VTune Amplifier result.
提供一个用于启动外部的收集工具的命令行。您可以稍后导入csv格式的custom收集数据(时间间隔和计数器)VTune放大器结果。
-data-limit=<integer> (500)   
Limit the amount of raw data to be collected by setting the maximum possible result size (in MB).VTune Amplifier starts collecting data from the beginning of the target execution and ends when the limit for the result size is reached. For unlimited data size, specify 0.
限制原始数据的收集量，通过设置最大可能的结果大小(以MB为单位)。VTune放大器在目标执行文件开始时进行收集数据，在达到了结果大小的极限时结束。为了无限制的数据大小，指定为0。
-discard-raw-data | -no-discard-raw-data (default)
Discard raw collector data from the result upon finalization.
从最终的结果中丢弃原始收集的数据。
-d, -duration=<string>        
Specify a duration for collection (in seconds).Required for system-wide collection. Can also be 'unlimited'.
指定集合的持续时间(以秒为单位)。要求全系统的集合。也可以“无限”。
-finalization-mode=full | deferred | none
                              Define finalization mode: full (default) -
                              perform full finalization; deferred - calculate
                              only binary checksum for finalization on another 
                              machine; none - skip finalization.
定义终结模式:full(默认)执行完整的终结;延迟——计算只有二进制校验和在另一个上完成机没有,跳过终结。
-follow-child (default) | -no-follow-child
                              Collect data on processes launched by the target 
                              process (recommended for applications launched by
                              a script).
收集由目标发起的进程的进程们上的数据
(推荐应用程序被一个脚本启动)。
-inline-mode=on | off         Choose to show or hide inline functions in the
                              stack.
选择显示或隐藏内联函数堆栈。
-k, -knob=<string>            Set knob value for selected analysis type as
                              -knob knobName=knobValue. For a list of knobs
                              available for an analysis, enter: -help collect
                              <analysis_type>.
为选择的分析类型设置旋钮值 -knob knobName = knobValue.关于旋钮的列表可用于分析，输入:-help collect< analysis_type >。
-loop-mode=loop-only | loop-and-function | function-only
                              Choose to show or hide loops in the stack.
选择显示或隐藏堆栈中的循环
-mrte-mode=auto | native | mixed | managed (auto)
                              Select a profiling mode. The Native mode does not
                              attribute data to managed source. The Mixed mode 
                              attributes data to managed source where
                              appropriate. The Managed mode tries to limit
                              attribution to managed source when available.
选择一个分析模式。本机模式没有管理源的属性数据。混合模式属性数据到托管合适的源。管理模式试图限制在可用的时候归属于管理源。
-r, -result-dir=<string> (r@@@{at})
                              Specify result directory path. The default name
                              for a result directory is r@@@{at}, where @@@ is 
                              the incremented number of the result, and {at} is
                              a two- or three-letter abbreviation for the
                              analysis type.
指定结果目录路径。默认的名字对于结果目录，@ @ @是@ @结果的递增数和{at}是两个或三个字母的缩写分析类型。
-resume-after=<double>        Specify time (in seconds, with fractions allowed)
                              to delay data collection after the application
                              starts. For example, 1.56 is 1 sec 560 msec.
指定时间(以秒为单位)在应用程序后延迟数据收集就开始了。例如，1.56是1秒560秒。
-return-app-exitcode | -no-return-app-exitcode (default)
                              Return the target exit code instead of the
                              command line interface exit code.
返回目标退出代码，而不是命令行接口退出代码。
-ring-buffer=<integer> (0)    Limit the amount of raw data to be collected by
                              setting the timer enabling the analysis only for 
                              the last seconds before the target or collection 
                              is terminated.
限制原始数据的采集量设置计时器，只允许分析在目标或集合前的最后几秒是终止。
-search-dir=<string>          Specify search directories for binary and symbol 
                              files. When the files are in multiple
                              directories, use the search-dir option multiple
                              times so that all the necessary directories are
                              searched.
指定用于二进制和符号的搜索目录文件。当文件有多个时目录，使用search-dir选项多次
以至于所有必要的目录被搜索。
-source-search-dir=<string>   Specify search directories for source files. When
                              your source files are in multiple directories,
                              use the source-search-dir option multiple times
                              so that all the necessary directories are
                              searched.
指定源文件的搜索目录。何时源文件在多个目录中，多次使用source -search dir选项
所有必要的目录都是搜索。
-start-paused                 Start data collection paused.
开始被暂停的数据收集
-strategy=<string>            Specify details for parent and child processes
                              analysis.
                              Format:<process_name1>:<profiling_mode>,<process_
                              name2>:<profiling_mode>,... Available profiling
                              mode values are: trace:trace, trace:notrace,
                              notrace:notrace, notrace:trace. This option is
                              not applicable to hardware event-based analysis
                              types.
指定父进程和子进程的细节分析。格式:< process_name1 >:< profiling_mode >、< process_name2 >:< profiling_mode >,……可用的分析模式值为:trace:trace,trace:notrace，notrace:notrace notrace:跟踪。这个选项是
不适用于基于硬件事件的分析类型。
-summary (default) | -no-summary
                              Turn on/off showing the summary report after data
                              collection/import.
数据收集/导入后，打开/关闭数据后的总结报告。
-target-duration-type=veryshort | short | medium | long (short)
                              Estimate the application duration time. This
                              value affects the size of collected data. For
                              long running targets, sampling interval is
                              increased to reduce the result size. For hardware
                              event-based analysis types, the duration estimate
                              affects a multiplier applied to the configured
                              Sample after value.
估算应用程序的持续时间。这个值影响收集数据的大小。为了长期运行目标，采样间隔增加以减小结果大小。对硬件基于事件的分析类型，持续时间估计影响一个应用于配置的乘数样品后的价值。
-target-install-dir=<string>  Specify a path to VTune Amplifier on the remote
                              system. If the default location is used, this
                              path is automatically supplied.
在远程系统中指定到VTune Amplifier的路径。如果使用了默认的位置，那么这个路径自动提供。
-target-pid=<unsigned integer>
                              Attach collection to a running process specified 
                              by process ID.
将集合附加到被进程ID指定的一个运行进程。
-target-process=<string>      Attach collection to a running process specified 
                              by process name.
将集合附加到指定的运行过程进程名称。
-target-tmp-dir=<string>      Specify a directory on the remote system where
                              performance results are temporarily stored. By
                              default, /tmp directory is used.
指定远程系统上的暂时存储性能结果的一个目录。通过默认，/ tmp目录被使用。
-trace-mpi | -no-trace-mpi (default)
                              Configure collectors to trace MPI code, and
                              determine MPI rank IDs in case of a non-Intel MPI
                              library implementation.
配置收集器以跟踪MPI代码，以及在非intel MPI库实现的情况下，确定MPI序列id。

Report操作的参数：
-call-stack-mode=user-only | user-plus-one | all
                              Choose how to show system functions in the stack.
选择如何在堆栈中显示系统函数。
-column=<string>              Specify substrings for the column names to
                              display only corresponding columns in the report.
                              Columns used for data grouping are always
                              displayed. 
                              Use -R <report-name> -r <result-dir> -column=?
                              for the list of available columns.
为列名指定子字符串在报表中只显示相应的列。用于数据分组的列总是显示出来。
使用 – R<report-name>-r < result-dir > -column=?列出可用列的列表。
-csv-delimiter=<string>       Specify delimiter character for CSV output.
                              Possible values are any character or the words:
comma, semicolon, colon, or tab.
为CSV输出指定分隔字符。可能的值是任何字符或单词: 逗号，分号，冒号，或标签。
-cumulative-threshold-percent=<string>
                              Show top percent of data output.
显示最高的数据输出。
-discard-raw-data | -no-discard-raw-data (default)
                              Discard raw collector data from the result upon
                              finalization.
从结果中丢弃原始收集器数据终结。
-filter=<string>              Specify items to include or exclude as follows:
                              <column name> [= | !=] <value>. 
                              Use -R <report name> -r <result-dir> -filter=?
                              for the list of available filters.
指定要包括或排除的项目如下:
< 列名>[= | !=]<价值>。
使用- r <报告名称> -r < result-dir > -filter=?
列出可用的过滤器列表。
-format=text | csv            Specify output format for report.
指定报告的输出格式。
-group-by=<string>            Specify a grouping level for displaying results. 
                              Default value is function. 
                              Use -R <report name> -r <result-dir> -group-by=? 
                              for the list of available groupings.
指定显示结果的分组级别。
默认值是函数。
使用- r <报告名称> -r < resultdir > -group-by=?
对于可用的分组列表。
-inline-mode=on | off         Choose to show or hide inline functions in the
                              stack.
选择显示或隐藏内联函数堆栈。
-limit=<integer>              Show top number of items in output.
在输出中显示最多的项。
-loop-mode=loop-only | loop-and-function | function-only
                              Choose to show or hide loops in the stack.
选择显示或隐藏堆栈中的循环。
-report-output=<string>       Write report output to a file.
写报告输出到文件。
-report-width=<integer>       Set output width limit.
设置输出宽度限制。
-r, -result-dir=<string> (r@@@{at})
                              Specify result directory path. The default name
                              for a result directory is r@@@{at}, where @@@ is 
                              the incremented number of the result, and {at} is
                              a two- or three-letter abbreviation for the
                              analysis type.
指定结果目录路径。默认的名字
对于结果目录，@ @ @是@ @
结果的递增数和{at}是
两个或三个字母的缩写
分析类型。
-search-dir=<string>          Specify search directories for binary and symbol 
                              files. When the files are in multiple
                              directories, use the search-dir option multiple
                              times so that all the necessary directories are
                              searched.
指定用于二进制和符号文件的搜索的目录。当文件有多个目录，使用search-dir选项多次
以至于所有必要的目录都被搜索。
-show-as=samples | values | percent
                              Specify a data format for the report values:
                              values - numeric values in original measurement
                              units (sec, GHz, etc.);
                              samples - number of samples collected for each
                              event;
                              percent - percentage of the cell value to the sum
                              of values in the column.
为报表值指定数据格式:
值-原始度量中的数字值
单位(sec,GHz等);
样本-为每个样本收集的样本数量
事件;
计算单元格值的百分比
列中的值。
-s, -sort-asc=<string>        Sort data in ascending order by the given column 
                              name.
排序数据按给定列的名字升序排序。
-S, -sort-desc=<string>       Sort data in descending order by the given column
                              name.
排序数据按给定列的名字降序排列。
-source-object=<string>       Specify a program unit for source or assembly
                              analysis as <program_unit> = <name>. Example:
                              -source-object function=foo. Add the '-group-by' 
                              option for assembly view, for example:
                              -source-object function=foo -group-by address.
为源或者分析指定程序单元 <program unit>=<name>.例子：-source-object function=foo.。添加'-group-by'选项装配视图，例如:
-source-object function=foo -group-by address.
-source-search-dir=<string>   Specify search directories for source files. When
                              your source files are in multiple directories,
                              use the source-search-dir option multiple times
                              so that all the necessary directories are
                              searched.
指定源文件的搜索目录。当源文件有多个目录，
多次使用source –search-dir选项以至于所有必要的目录都被搜索。
-time-filter=<string>         Specify filtered time range using format
                              <begin_time>:<end_time>. For example,
                              "-time-filter 2.3:5.4" reports data collected
                              from 2.3 seconds to 5.4 seconds of elapsed time.
指定过滤的时间范围使用格式
< begin_time >:< end_time >。例如，“-time-filter 2.3:5.4”从2.3秒到5.4秒的运行时间内手机数据进行报告。
