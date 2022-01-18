环境:
	win10 
	python3.9.6
	g++ 11.1.0

cpu里为整个流水线的设计文档和相关模块

test里为自动测试工具：
	mips_gnrt.cpp 为自动生成mips程序
	auto_test.py 为自动测试程序
	run_mips.cpp 为模拟mips运行程序
	analyse_data.py 为自动分析数据程序

tools里为代码生成、分析工具：
	gnrt_crtlsignal.py 可格式化生成控制信号表
	gnrt_io.py 可生成模块实例化时的端口表
	cnt_lines.py 用于计算程序总行数

analysis为官方提供的数据分析程序