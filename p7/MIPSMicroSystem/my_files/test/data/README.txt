testpoint_P6：P6的测试冲突的数据，用于检测新增模块后CPU的正确性

P7测试点：

注：没有单独针对tb的interrupt的测试点，因为在自动测试工具中，可以自动修改mips_tb
中期望产生中断的宏观pc值，从而实现对每一个pc都进行中断，所以一个测试点可以根据中
断产生位置，自动进行n种不同测试（n为指令条数）

testpoint0：测试除AdEL_Instr之外的异常
testpoint1：测试AdEL_Instr异常（跳转到错误地址引起）
testpoint2：测试延迟槽相关异常
testpoint3：测试计时器模式0与IO
testpoint4：测试计时器模式1与IO
testpoint5~n：程序自动生成的随机测试样例，用于全面测试除计时器外的其他点