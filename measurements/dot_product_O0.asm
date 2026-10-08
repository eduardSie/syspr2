
build/dot_product_O0:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000040077b <dot_product>:
  40077b:	55                   	push   rbp
  40077c:	48 89 e5             	mov    rbp,rsp
  40077f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
  400783:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
  400787:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
  40078b:	66 0f ef c0          	pxor   xmm0,xmm0
  40078f:	f2 0f 11 45 f8       	movsd  QWORD PTR [rbp-0x8],xmm0
  400794:	48 c7 45 f0 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
  40079b:	00 
  40079c:	eb 45                	jmp    4007e3 <dot_product+0x68>
  40079e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  4007a2:	48 8d 14 c5 00 00 00 	lea    rdx,[rax*8+0x0]
  4007a9:	00 
  4007aa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
  4007ae:	48 01 d0             	add    rax,rdx
  4007b1:	f2 0f 10 08          	movsd  xmm1,QWORD PTR [rax]
  4007b5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  4007b9:	48 8d 14 c5 00 00 00 	lea    rdx,[rax*8+0x0]
  4007c0:	00 
  4007c1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
  4007c5:	48 01 d0             	add    rax,rdx
  4007c8:	f2 0f 10 00          	movsd  xmm0,QWORD PTR [rax]
  4007cc:	f2 0f 59 c1          	mulsd  xmm0,xmm1
  4007d0:	f2 0f 10 4d f8       	movsd  xmm1,QWORD PTR [rbp-0x8]
  4007d5:	f2 0f 58 c1          	addsd  xmm0,xmm1
  4007d9:	f2 0f 11 45 f8       	movsd  QWORD PTR [rbp-0x8],xmm0
  4007de:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
  4007e3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  4007e7:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
  4007eb:	72 b1                	jb     40079e <dot_product+0x23>
  4007ed:	f2 0f 10 45 f8       	movsd  xmm0,QWORD PTR [rbp-0x8]
  4007f2:	5d                   	pop    rbp
  4007f3:	c3                   	ret

Disassembly of section .fini:
