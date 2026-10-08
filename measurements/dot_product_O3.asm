
build/dot_product_O3:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000004007c0 <dot_product>:
  4007c0:	48 85 d2             	test   rdx,rdx
  4007c3:	49 89 f8             	mov    r8,rdi
  4007c6:	49 89 f1             	mov    r9,rsi
  4007c9:	0f 84 91 01 00 00    	je     400960 <dot_product+0x1a0>
  4007cf:	48 8d 42 ff          	lea    rax,[rdx-0x1]
  4007d3:	c5 f9 ef c0          	vpxor  xmm0,xmm0,xmm0
  4007d7:	48 83 f8 0e          	cmp    rax,0xe
  4007db:	0f 86 88 01 00 00    	jbe    400969 <dot_product+0x1a9>
  4007e1:	48 89 d7             	mov    rdi,rdx
  4007e4:	48 89 f1             	mov    rcx,rsi
  4007e7:	c5 fd 28 d8          	vmovapd ymm3,ymm0
  4007eb:	4c 89 c0             	mov    rax,r8
  4007ee:	48 c1 ef 04          	shr    rdi,0x4
  4007f2:	c5 fd 28 c8          	vmovapd ymm1,ymm0
  4007f6:	c5 fd 28 d0          	vmovapd ymm2,ymm0
  4007fa:	48 89 fe             	mov    rsi,rdi
  4007fd:	48 c1 e6 07          	shl    rsi,0x7
  400801:	4c 01 c6             	add    rsi,r8
  400804:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  400809:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  400810:	00 00 00 00 
  400814:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  40081b:	00 00 00 00 
  40081f:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  400826:	00 00 00 00 
  40082a:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  400831:	00 00 00 00 
  400835:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  40083c:	00 00 00 00 
  400840:	c5 fd 10 20          	vmovupd ymm4,YMMWORD PTR [rax]
  400844:	c5 fd 10 68 20       	vmovupd ymm5,YMMWORD PTR [rax+0x20]
  400849:	48 83 e8 80          	sub    rax,0xffffffffffffff80
  40084d:	48 83 e9 80          	sub    rcx,0xffffffffffffff80
  400851:	c5 fd 10 70 c0       	vmovupd ymm6,YMMWORD PTR [rax-0x40]
  400856:	c5 fd 10 78 e0       	vmovupd ymm7,YMMWORD PTR [rax-0x20]
  40085b:	c4 e2 dd b8 41 80    	vfmadd231pd ymm0,ymm4,YMMWORD PTR [rcx-0x80]
  400861:	c4 e2 d5 b8 51 a0    	vfmadd231pd ymm2,ymm5,YMMWORD PTR [rcx-0x60]
  400867:	c4 e2 cd b8 49 c0    	vfmadd231pd ymm1,ymm6,YMMWORD PTR [rcx-0x40]
  40086d:	c4 e2 c5 b8 59 e0    	vfmadd231pd ymm3,ymm7,YMMWORD PTR [rcx-0x20]
  400873:	48 39 f0             	cmp    rax,rsi
  400876:	75 c8                	jne    400840 <dot_product+0x80>
  400878:	c5 fd 58 c2          	vaddpd ymm0,ymm0,ymm2
  40087c:	c5 f5 58 cb          	vaddpd ymm1,ymm1,ymm3
  400880:	48 89 f8             	mov    rax,rdi
  400883:	48 c1 e0 04          	shl    rax,0x4
  400887:	48 39 c2             	cmp    rdx,rax
  40088a:	c5 f5 58 c8          	vaddpd ymm1,ymm1,ymm0
  40088e:	c4 e3 7d 19 c8 01    	vextractf128 xmm0,ymm1,0x1
  400894:	c5 f9 58 c1          	vaddpd xmm0,xmm0,xmm1
  400898:	c5 f9 15 c8          	vunpckhpd xmm1,xmm0,xmm0
  40089c:	c5 f1 58 c8          	vaddpd xmm1,xmm1,xmm0
  4008a0:	0f 84 ce 00 00 00    	je     400974 <dot_product+0x1b4>
  4008a6:	c5 f8 77             	vzeroupper
  4008a9:	48 29 c2             	sub    rdx,rax
  4008ac:	48 83 fa 01          	cmp    rdx,0x1
  4008b0:	0f 84 97 00 00 00    	je     40094d <dot_product+0x18d>
  4008b6:	48 89 d1             	mov    rcx,rdx
  4008b9:	48 8d 34 c5 00 00 00 	lea    rsi,[rax*8+0x0]
  4008c0:	00 
  4008c1:	48 d1 e9             	shr    rcx,1
  4008c4:	49 8d 3c 30          	lea    rdi,[r8+rsi*1]
  4008c8:	4c 01 ce             	add    rsi,r9
  4008cb:	48 83 f9 01          	cmp    rcx,0x1
  4008cf:	c5 f9 10 17          	vmovupd xmm2,XMMWORD PTR [rdi]
  4008d3:	c4 e2 e9 b8 06       	vfmadd231pd xmm0,xmm2,XMMWORD PTR [rsi]
  4008d8:	74 60                	je     40093a <dot_product+0x17a>
  4008da:	48 83 f9 02          	cmp    rcx,0x2
  4008de:	c5 f9 10 5e 10       	vmovupd xmm3,XMMWORD PTR [rsi+0x10]
  4008e3:	c4 e2 e1 b8 47 10    	vfmadd231pd xmm0,xmm3,XMMWORD PTR [rdi+0x10]
  4008e9:	74 4f                	je     40093a <dot_product+0x17a>
  4008eb:	48 83 f9 03          	cmp    rcx,0x3
  4008ef:	c5 f9 10 57 20       	vmovupd xmm2,XMMWORD PTR [rdi+0x20]
  4008f4:	c4 e2 e9 b8 46 20    	vfmadd231pd xmm0,xmm2,XMMWORD PTR [rsi+0x20]
  4008fa:	74 3e                	je     40093a <dot_product+0x17a>
  4008fc:	48 83 f9 04          	cmp    rcx,0x4
  400900:	c5 f9 10 5f 30       	vmovupd xmm3,XMMWORD PTR [rdi+0x30]
  400905:	c4 e2 e1 b8 46 30    	vfmadd231pd xmm0,xmm3,XMMWORD PTR [rsi+0x30]
  40090b:	74 2d                	je     40093a <dot_product+0x17a>
  40090d:	48 83 f9 05          	cmp    rcx,0x5
  400911:	c5 f9 10 57 40       	vmovupd xmm2,XMMWORD PTR [rdi+0x40]
  400916:	c4 e2 e9 b8 46 40    	vfmadd231pd xmm0,xmm2,XMMWORD PTR [rsi+0x40]
  40091c:	74 1c                	je     40093a <dot_product+0x17a>
  40091e:	48 83 f9 06          	cmp    rcx,0x6
  400922:	c5 f9 10 5f 50       	vmovupd xmm3,XMMWORD PTR [rdi+0x50]
  400927:	c4 e2 e1 b8 46 50    	vfmadd231pd xmm0,xmm3,XMMWORD PTR [rsi+0x50]
  40092d:	74 0b                	je     40093a <dot_product+0x17a>
  40092f:	c5 f9 10 57 60       	vmovupd xmm2,XMMWORD PTR [rdi+0x60]
  400934:	c4 e2 e9 b8 46 60    	vfmadd231pd xmm0,xmm2,XMMWORD PTR [rsi+0x60]
  40093a:	48 01 c9             	add    rcx,rcx
  40093d:	c5 f9 15 c8          	vunpckhpd xmm1,xmm0,xmm0
  400941:	48 39 ca             	cmp    rdx,rcx
  400944:	c5 f1 58 c8          	vaddpd xmm1,xmm1,xmm0
  400948:	74 0f                	je     400959 <dot_product+0x199>
  40094a:	48 01 c8             	add    rax,rcx
  40094d:	c4 c1 7b 10 1c c0    	vmovsd xmm3,QWORD PTR [r8+rax*8]
  400953:	c4 c2 e1 b9 0c c1    	vfmadd231sd xmm1,xmm3,QWORD PTR [r9+rax*8]
  400959:	c5 f9 28 c1          	vmovapd xmm0,xmm1
  40095d:	c3                   	ret
  40095e:	66 90                	xchg   ax,ax
  400960:	c5 f1 57 c9          	vxorpd xmm1,xmm1,xmm1
  400964:	c5 f9 28 c1          	vmovapd xmm0,xmm1
  400968:	c3                   	ret
  400969:	31 c0                	xor    eax,eax
  40096b:	c5 f1 57 c9          	vxorpd xmm1,xmm1,xmm1
  40096f:	e9 35 ff ff ff       	jmp    4008a9 <dot_product+0xe9>
  400974:	c5 f8 77             	vzeroupper
  400977:	eb e0                	jmp    400959 <dot_product+0x199>

Disassembly of section .fini:
