THIS IS A FORK OF:
https://github.com/gsauthof/riscv
by Georg Sauthoff

Different here:
patches to be compatible with RISC-V "V" vector instructions in version 0.7.1
as implemented in the XuanTie C906 D1 SOC (used in Nezha or DevTerm R01 board)

Patches are mostly due to the change in 
`vfirst.m` to `vmfirst.m`
see also https://github.com/riscv/riscv-v-spec/releases/tag/0.7.1
versus
https://github.com/riscv/riscv-v-spec/releases/tag/0.8

The makefile defines the location of AS, CC, LD and I compiled those for 0.7.1 through
https://github.com/brucehoult/riscv-gnu-toolchain

## RISC-V Vector Assembly Code Examples

These example use RISC-V "V" vector instructions (now version 0.7.1).

- bcd2ascii.s - convert BCD strings into ASCII strings. See also
  https://gms.tf/riscv-vector.html for details.
- ascii2bcd.s - convert ASCII strings into BCD strings.
- memchr.s - vector version of the well-known
  [`memchr()`](https://manpath.be/c8/3/memchr) libc function
- mempchr.s - similar to `memchr()`, but `mempchr()` returns the
  one-past-the-end pointer instead of `NULL`. This is more useful
  e.g.  in text scanning code.
- memrchr.s - vector version of the well-known
  [`memrchr()`](https://manpath.be/c8/3/memrchr) libc function
- memcmp.s - vector version of the well-known
  [`memcmp()`](https://manpath.be/c8/3/memcmp) libc function
- rawmemchr.s - vector version of the well-known
  [`rawmemchr()`](https://manpath.be/c8/3/rawmemchr) glibc function

## outcome
```
/opt/rvv_071/bin/riscv64-unknown-elf-objdump -d bcd2ascii.o

bcd2ascii.o:     file format elf64-littleriscv

Disassembly of section .text:

0000000000000000 <bcd2ascii-0x2>:
   0:	0001                	nop

0000000000000002 <bcd2ascii>:
   2:	4841                	li	a6,16
   4:	003872d7          	vsetvli	t0,a6,e8,m8,d1
   8:	5a08a457          	vid.v	v8
   c:	7a84b057          	vmsgtu.vi	v0,v8,9
  10:	03000893          	li	a7,48
  14:	0288c457          	vadd.vx	v8,v8,a7
  18:	18dd                	addi	a7,a7,-9
  1a:	0088c457          	vadd.vx	v8,v8,a7,v0.t

000000000000001e <.Loop>:
  1e:	007676d7          	vsetvli	a3,a2,e16,m8,d1
  22:	02058807          	vlbu.v	v16,(a1)
  26:	95b6                	add	a1,a1,a3
  28:	8e15                	sub	a2,a2,a3
  2a:	97043c57          	vsll.vi	v24,v16,8
  2e:	a3023857          	vsrl.vi	v16,v16,4
  32:	0686                	slli	a3,a3,0x1
  34:	0036fed7          	vsetvli	t4,a3,e8,m8,d1
  38:	2787bc57          	vand.vi	v24,v24,15
  3c:	2b0c0857          	vor.vv	v16,v16,v24
  40:	32880c57          	vrgather.vv	v24,v8,v16
  44:	02050c27          	vsb.v	v24,(a0)
  48:	9536                	add	a0,a0,a3
  4a:	fa71                	bnez	a2,1e <.Loop>
  4c:	8082                	ret

```
