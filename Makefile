top_srcdir = .
prefix = /usr/local
bindir = ${prefix}/bin
mandir = ${prefix}/share/man

cpabe_dir = ${top_srcdir}/cpabe-0.11
MyCPABE_dir = ${top_srcdir}/MyCPABE
pbc_dir = ${top_srcdir}/pbc-0.5.14
bswabe_dir = ${top_srcdir}/libbswabe-0.9
glib_dir = ${top_srcdir}/glib-2.25.2
gmp_dir = ${top_srcdir}/gmp-6.1.2
openssl_dir = ${top_srcdir}/openssl-1.0.2l

CC = gcc
CFLAGS  = -O3 -Wall -g -fPIC \
	-I${JNI_H_PATH} \
	-I${JNI_OS_H_PATH} \
	-I/usr/include/glib-2.0 \
	-I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
	-I/usr/include/pbc \
	-I/usr/local/include/pbc \
	-DPACKAGE_NAME=\"cpabe\" -DPACKAGE_TARNAME=\"cpabe\" -DPACKAGE_VERSION=\"0.11\" -DPACKAGE_STRING=\"cpabe\ 0.11\" -DPACKAGE_BUGREPORT=\"bethenco@cs.berkeley.edu\" -DPACKAGE_URL=\"\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DSTDC_HEADERS=1 -DHAVE_FCNTL_H=1 -DHAVE_STDDEF_H=1 -DHAVE_STRING_H=1 -DHAVE_STDLIB_H=1 -DHAVE_MALLOC=1 -DLSTAT_FOLLOWS_SLASHED_SYMLINK=1 -DHAVE_VPRINTF=1 -DHAVE_LIBCRYPTO=0 -DHAVE_LIBCRYPTO=0 -DHAVE_STRCHR=1 -DHAVE_STRDUP=1 -DHAVE_MEMSET=1 -DHAVE_GMP=1 -DHAVE_PBC=1 -DHAVE_BSWABE=1

LDFLAGS = -L. -lbeebit-cpabe \
	-lglib-2.0   \
	-Wl,-rpath /usr/local/lib -lgmp \
	-Wl,-rpath /usr/local/lib -lbswabe \
	-lpbc \
	-lcrypto \
	-lgmp

DISTNAME = beebit-cpabe-0.1

TARGETS  = libbeebit-cpabe-0.1.a setup keygen enc dec encdec encdecb

DEVTARGS = test-lang TAGS

MANUALS  = $(TARGETS:=.1)
HTMLMANS = $(MANUALS:.1=.html)

all: $(TARGETS)
_pycpabe.so: ${cpabe_dir}/bee-setup.o ${cpabe_dir}/common.o ${cpabe_dir}/bee-enc.o ${cpabe_dir}/policy_lang.o ${cpabe_dir}/bee-keygen.o ${cpabe_dir}/bee-dec.o ${python_dir}/pycpabe_wrap.o ${cpabe_dir}/cpabebuf.o
	$(CC) -shared -o $@ $^ /usr/local/lib/libbswabe.a /usr/local/lib/libpbc.a -lgmp -lglib-2.0 -lcrypto

libbeebit-cpabe-0.1.so: ${cpabe_dir}/bee-setup.o ${cpabe_dir}/common.o ${cpabe_dir}/bee-enc.o ${cpabe_dir}/policy_lang.o ${cpabe_dir}/bee-keygen.o ${cpabe_dir}/#bee-dec.o ${java_dir}/cpabeJNI.o
	$(CC) -shared -o $@ $^ /usr/local/lib/libbswabe.a /usr/local/lib/libpbc.a -lgmp -lglib-2.0 -lcrypto
	ln -f -s $@ libbeebit-cpabe.so

# user-level compilation
libbeebit-cpabe-0.1.a: ${cpabe_dir}/bee-setup.o ${cpabe_dir}/common.o ${cpabe_dir}/bee-enc.o ${cpabe_dir}/policy_lang.o ${cpabe_dir}/bee-keygen.o ${cpabe_dir}/bee-dec.o ${cpabe_dir}/cpabebuf.o
#	$(CC) -c $^ $(CFLAGS)
	$(AR) rcs -o $@ $^ 
	ln -f -s $@ libbeebit-cpabe.a

#setup.o common.o enc.o policy_lang.o keygen.o dec.

setup:$(MyCPABE_dir)/setup.o 
	$(CC) -o $(MyCPABE_dir)/$@ $^ $(LDFLAGS)

keygen:$(MyCPABE_dir)/keygen.o 
	$(CC) -o $(MyCPABE_dir)/$@ $^ $(LDFLAGS)

enc:$(MyCPABE_dir)/enc.o
	$(CC) -o $(MyCPABE_dir)/$@ $^ $(LDFLAGS)

dec:$(MyCPABE_dir)/dec.o
	$(CC) -o $(MyCPABE_dir)/$@ $^ $(LDFLAGS)
encdec:$(MyCPABE_dir)/encdec.o
	$(CC) -o $(MyCPABE_dir)/$@ $^ $(LDFLAGS)
encdecb:$(MyCPABE_dir)/encdecb.o
	$(CC) -o $(MyCPABE_dir)/$@ $^ $(LDFLAGS)
cpabe-encdecb:$(MyCPABE_dir)/cpabe-encdecb.o
	$(CC) -o $(MyCPABE_dir)/$@ $^ $(LDFLAGS)

clean:
	rm -f libbeebit-cpabe-0.1.a libbeebit-cpabe.a libbeebit-cpabe-0.1.so libbeebit-cpabe.so _pycpabe.so
	rm -f ${MyCPABE_dir}/setup ${MyCPABE_dir}/keygen ${MyCPABE_dir}/enc ${MyCPABE_dir}/dec ${MyCPABE_dir}/encdec ${MyCPABE_dir}/encdecb ${MyCPABE_dir}/*.o 
	echo "Lam Thanh Ngan - Tran Tuan Nam - MMH2021 - NT219.L21" > ${MyCPABE_dir}/data
	$(shell cd cpabe-0.11; rm -f *.o)

install:
	cp libbeebit-cpabe-0.1.a /usr/local/lib
	ln -f -s /usr/local/lib/libbeebit-cpabe-0.1.a /usr/local/lib/libbeebit-cpabe.a
	cp beebitcpabe.h /usr/local/include
	cp cpabebuf.h /usr/local/include

uninstall:
	rm /usr/local/lib/libbeebit-cpabe-0.1.a
	rm /usr/local/lib/libbeebit-cpabe.a
	rm /usr/local/include/beebitcpabe.h
	rm /usr/local/include/cpabebuf.h
