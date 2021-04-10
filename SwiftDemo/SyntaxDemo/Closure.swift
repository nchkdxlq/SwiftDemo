//
//  Closure.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/21.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


/*
 
 ## 闭包的定义
 一个函数和它所捕获的变量/常量环境组合起来，称为闭包
 1. 一般是指定义在函数内部的函数
 2. 一般它捕获的是外层函数的局部变量/常量
 
 可以把闭包想象成一个类的实例对象
 1. 内存在堆空间
 2. 捕获的局部变量/常量就是对象的成员(存储属性)
 3. 组成闭包的函数就是类内部定义的方法

 */
struct NKFunction {
    var num = 0
    func plus(_ i: Int) -> Int {
//        num += i
        return num
    }
}


func closure_entry() {
    print("------- Closure ------")
    
//    test_getFn0()
    test_getFn1()
//    test_getFn2()
}


typealias Fn = (Int) -> Int
typealias Fn2 = (Int) -> (Int, Int)


/*
 0x10000a250 <+0>:  pushq  %rbp
 0x10000a251 <+1>:  movq   %rsp, %rbp
 0x10000a254 <+4>:  subq   $0x10, %rsp
 0x10000a258 <+8>:  xorps  %xmm0, %xmm0
 0x10000a25b <+11>: movaps %xmm0, -0x10(%rbp)
 0x10000a25f <+15>: callq  0x10000a280                  ; 调用 getFn0
 0x10000a264 <+20>: movq   %rax, -0x10(%rbp)
 0x10000a268 <+24>: movq   %rdx, -0x8(%rbp)
 0x10000a26c <+28>: movq   %rdx, %rdi
->  0x10000a26f <+31>: callq  0x100022e80               ; symbol stub for: swift_release
 0x10000a274 <+36>: addq   $0x10, %rsp
 0x10000a278 <+40>: popq   %rbp
 0x10000a279 <+41>: retq
 */
func test_getFn0() {
    let fn = getFn0()
    fn(1)
    /*
         fn是一个Function类型的变量, Function是结构体类型, 占用16个字节,
         前8个字节为实际调用的函数地址, 后8个字节是函数用到的堆空间内存地址,
         如果函数中没有使用到堆空间地址，则后8个字节内容为0.
         类似下面的结构
         struct Function {
             var funAddr: UInt64
             var heapAddr: UInt64 = 0
         }
     */
}


/*
 SyntaxDemo`getFn0():
 ->  0x10000a270 <+0>:  pushq  %rbp
     0x10000a271 <+1>:  movq   %rsp, %rbp
     0x10000a274 <+4>:  leaq   0x355(%rip), %rax  // %rip+0x355的地址值存在%rax中, %rip+0x355的值就是 fn函数的地址
     0x10000a27b <+11>: xorl   %ecx, %ecx // ecx清零
     0x10000a27d <+13>: movl   %ecx, %edx
     0x10000a27f <+15>: popq   %rbp
     0x10000a280 <+16>: retq
 */
func getFn0() -> Fn {
    func fn(_ i: Int) -> Int {
        return i
    }
    return fn
}


// MARK: - 捕获一个局部变量

/*
 SyntaxDemo`test_getFn1():
     0x10000a220 <+0>:  pushq  %rbp
     0x10000a221 <+1>:  movq   %rsp, %rbp
     0x10000a224 <+4>:  pushq  %r13
     0x10000a226 <+6>:  subq   $0x38, %rsp
     0x10000a22a <+10>: xorps  %xmm0, %xmm0
     0x10000a22d <+13>: movaps %xmm0, -0x20(%rbp)
     0x10000a231 <+17>: callq  0x10000a320               ; SyntaxDemo.getFn1() -> (Swift.Int) -> Swift.Int at Closure.swift:134
     0x10000a236 <+22>: movq   %rax, -0x20(%rbp)         ; rax / -0x20(%rbp) 函数地址
     0x10000a23a <+26>: movq   %rdx, -0x18(%rbp)         ; rdx / -0x18(%rbp) 堆空间地址
 ->  0x10000a23e <+30>: movq   %rdx, %rdi
     0x10000a241 <+33>: movq   %rax, -0x28(%rbp)         ; -0x28(%rbp) 函数地址
     0x10000a245 <+37>: movq   %rdx, -0x30(%rbp)         ; -0x30(%rbp) 堆空间地址
     0x10000a249 <+41>: callq  0x100022e86               ; symbol stub for: swift_retain
     0x10000a24e <+46>: movl   $0x1, %edi
     0x10000a253 <+51>: movq   -0x30(%rbp), %r13         ; %r13 堆空间地址
     0x10000a257 <+55>: movq   -0x28(%rbp), %rcx         ; %rcx 函数地址
     0x10000a25b <+59>: movq   %rax, -0x38(%rbp)         ; -0x38(%rbp) 函数地址
     0x10000a25f <+63>: callq  *%rcx                     ; 调用函数, %edi 为参数
     0x10000a261 <+65>: movq   -0x30(%rbp), %rdi
     0x10000a265 <+69>: movq   %rax, -0x40(%rbp)
     0x10000a269 <+73>: callq  0x100022e80               ; symbol stub for: swift_release
     0x10000a26e <+78>: movq   -0x30(%rbp), %rdi
     0x10000a272 <+82>: callq  0x100022e80               ; symbol stub for: swift_release
     0x10000a277 <+87>: addq   $0x38, %rsp
     0x10000a27b <+91>: popq   %r13
     0x10000a27d <+93>: popq   %rbp
     0x10000a27e <+94>: retq
 
 
 SyntaxDemo`partial apply for plus #1 (_:) in getFn1(): plus的外层函数
 ->  0x10000a4c0 <+0>: pushq  %rbp
     0x10000a4c1 <+1>: movq   %rsp, %rbp
     0x10000a4c4 <+4>: movq   %r13, %rsi                ; 根据上面的汇编, r13为堆空间地址, 所以 %rsi 为堆空间地址, 作为参数传递给plus函数
     0x10000a4c7 <+7>: popq   %rbp
     0x10000a4c8 <+8>: jmp    0x10000a3b0               ; plus 函数
 */
func test_getFn1() {
    let fn = getFn1()
    fn(1)
//    print(fn)
//    print(fn(1))
//    print(fn(1))
//    print(fn(1))
//    print(fn(1))
}

/*
 SyntaxDemo`getFn1():
     0x10000a320 <+0>:  pushq  %rbp
     0x10000a321 <+1>:  movq   %rsp, %rbp
     0x10000a324 <+4>:  subq   $0x20, %rsp
     0x10000a328 <+8>:  movq   $0x0, -0x8(%rbp)
     0x10000a330 <+16>: leaq   0x1e681(%rip), %rdi       ; type metadata for SyntaxDemo.Point + 40
     0x10000a337 <+23>: movl   $0x18, %esi
     0x10000a33c <+28>: movl   $0x7, %edx
     0x10000a341 <+33>: callq  0x100022df6               ; symbol stub for: swift_allocObject (申请堆空间)
     0x10000a346 <+38>: movq   %rax, %rcx                ; rax/rcx值为堆空间地址
     0x10000a349 <+41>: addq   $0x10, %rcx               ; rcx指向堆空间的第16个字节
     0x10000a34d <+45>: movq   %rcx, -0x8(%rbp)
 ->  0x10000a351 <+49>: movq   $0xa, 0x10(%rax)          ; 把0x10赋值给堆空间的第三个8字节
     0x10000a359 <+57>: movq   %rax, %rdi
     0x10000a35c <+60>: movq   %rax, -0x10(%rbp)         ; -0x10(%rbp) 为堆空间地址
     0x10000a360 <+64>: callq  0x100022e86               ; symbol stub for: swift_retain
     0x10000a365 <+69>: movq   -0x10(%rbp), %rdi
     0x10000a369 <+73>: movq   %rax, -0x18(%rbp)
     0x10000a36d <+77>: callq  0x100022e80               ; symbol stub for: swift_release
     0x10000a372 <+82>: leaq   0x147(%rip), %rax         ; rax中为函数地址, 这个函数实际上是对getFn1的包装, 内部调用 plus 函数
     0x10000a379 <+89>: movq   -0x10(%rbp), %rdx         ; rdx中为堆空间地址
     0x10000a37d <+93>: addq   $0x20, %rsp
     0x10000a381 <+97>: popq   %rbp
     0x10000a382 <+98>: retq
 */
func getFn1() -> Fn {
    var num1 = 10
    func plus(_ i: Int) -> Int {
        num1 += i
        return num1
    }
    return plus
}


func test_getFn2() {
    let (p, m) = getFn2()
    
    print(p(5))
    print(m(4))
}


func getFn2() -> (Fn2, Fn2) {
    var num1 = 10
    var num2 = 11
    
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return (num1, num2)
    }
    
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1, num2)
    }
    
    return (plus, minus)
}
