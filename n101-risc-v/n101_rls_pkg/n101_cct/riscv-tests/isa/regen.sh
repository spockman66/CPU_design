rm generated/* -rf
make -C generated -f ../Makefile src_dir=../ XLEN=32
