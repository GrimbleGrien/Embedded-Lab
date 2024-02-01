=============================
New Project uVision
=============================

Project -> New uVision Project -> (select path) gib filename exp0 -> INTEL -> 80C51GB
-> Copy startup: Y -> 

    BAM new project
        clk RGY icon -> Add Files: 

        ELSE

        Project Directory -> Source Group (double clk) -> (filename.A51) (type: Asm source file) -> Add -> OK

    filename.A51 (clk) -> add files -> (dialog box closes) Save As

ELSE

    File -> new -> save -> Project Directory -> (dclk) new file -> (filename.A51) (type: Asm source file) -> Add -> OK


=================================
Assignment var, ptr
=================================
CPU
    MOV DPTR, #9000H
>>> ptr => *dptr 
>>> dptr = memloc
>>> 

External <-> CPU
    MOVX A, @DPTR
>>> MOVX @DPTR, B
>>> var => A = *dptr

=================================
CONTROL
=================================
control transfer => function, loop
NO RETURN KEYWORD

sequential flow of control
use JMP family to skip

Loop_1:
    ...

Loop_2:
    ...

Loop_3:
    ...
    CJMP loop_2

Loop_4:
    ...
    CJNE loop_1

=======================================
COMPILATION
=======================================
HEX file 51e trainer
gen .hex <- rebuild all target files (keil vision)

open 51e -> Download .hex from explorer
DisAssem -> Start addr 8100H
Set PC 8100H -> run stepwise

=======================================
LOGIC
=======================================
cmp=> JC jmp if carry

Run ---> break
Search key => X memory -> show [lower bit] index (update)
