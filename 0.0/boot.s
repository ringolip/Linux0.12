;
; boot.s -- bootsect.S的框架程序
;
.global begtext,begdata,begbss,endtext,enddata,endbss   ; 全局标识符，供ld86链接使用
.text    ; 正文段
begtext:
.data    ; 数据段
begdata:
.bss     ; 未初始化数据段
begbss:
.text    ; 正文段
BOOTSEG = 0x07c0    ; BIOS加载bootsect代码的原始段地址

entry start    ; 告知链接程序，程序从strat标号处开始执行
start:
    jmpi go,BOOTSEG    ; 段间跳转。BOOTSEG指出跳转段地址，标号go是偏移地址
go:
    mov ax,cs    ; 初始化段寄存器ds和es
    mov ds,ax
    mov es,ax
    mov cx,#20    ; 共显示20个字符，包括回车换行符
    mov dx,#0x1004    ; 字符串将显示在屏幕第17行，第5列处
    mov bx,#0x000c    ; 字符显示属性（红色）
    mov bp,#msg1    ; 指向要显示的字符串
    mov ax,#0x1301    ; 写字符串并移动光标到串结尾处
    int 0x10    ; BIOS中断调用0x10，功能0x13，子功能01
loop0: jmp loop0    ; 死循环
msg1: .ascii "Loading system..."    ; 调用BIOS中断显示的信息。共20个ASCII个字符
      .byte 13,10
.org 510    ; 表示以后语句从地址510（0x1FE）开始存放
    .word 0xAA55    ; 有效引导扇区标志，供BIOS加载引导扇区使用
.text
endtext:
.data
enddata:
.bss
endbss:
