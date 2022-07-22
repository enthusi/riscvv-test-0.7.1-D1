THIS IS A FORK OF:
https://github.com/gsauthof/riscv
by Georg Sauthoff

Different here:
patches to be compatible with RISC-V "V" vector instructions in version 0.7.1
as implemented in the D1 CPU (used in Nezra or DevTerm R01 board)

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

## Other Examples
