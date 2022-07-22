

ASFLAGS = -march=rv64gcv

AS = /opt/rvv_071/bin/riscv64-unknown-elf-as
CC = /opt/rvv_071/bin/riscv64-unknown-elf-gcc
LD = /opt/rvv_071/bin/riscv64-unknown-elf-ld

CFLAGSW_GCC = -Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wmissing-prototypes -Wfloat-equal \
    -Wwrite-strings -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Werror=multichar -Werror=sizeof-pointer-memaccess -Werror=return-type \
    -fstrict-aliasing

CFLAGS = $(CFLAGSW_GCC) $(CFLAGS0) $(CFLAGS1)


.PHONY: all
all: bcd2a bcd2asc a2bcd memchr memrchr memcmp 


bcd2a: bcd2ascii.o start_bcd2a.o 
	$(LD) $(LDFLAGS) $^ -o $@

TEMP += bcd2a bcd2ascii.o start_bcd2a.o


bcd2asc: bcd2ascii.o main_bcd2a.o
	$(CC) $(LDFLAGS) $^ -o $@

TEMP += bcd2asc main_bcd2a.o

a2bcd: ascii2bcd.o main_a2bcd.o
	$(CC) $(LDFLAGS) $^ -o $@

TEMP += a2bcd ascii2bcd.o main_a2bcd.o

memchr: main_memchr.o memchr.o mempchr.o
	$(CC) $(LDFLAGS) $^ -o $@

TEMP += memchr main_memchr.o memchr.o mempchr.o

memrchr: main_memrchr.o memrchr.o
	$(CC) $(LDFLAGS) $^ -o $@

TEMP += memrchr main_memrchr.o memrchr.o

memcmp: main_memcmp.o memcmp.o
	$(CC) $(LDFLAGS) $^ -o $@

TEMP += memcmp main_memcmp.o memcmp.o

#strlen: main_strlen.o rawmemchr.o strlen.o
#	$(CC) $(LDFLAGS) $^ -o $@

#TEMP += strlen main_strlen.o rawmemchr.o strlen.o

#strlen_small: main_strlen.o rawmemchr.o strlen_small.o
#	$(CC) $(LDFLAGS) $^ -o $@

#TEMP += strlen_small strlen_small.o

.PHONY: clean
clean:
	rm -f $(TEMP)
