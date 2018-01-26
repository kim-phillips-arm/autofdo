#git show 26c80a7ed4e67074817dcdacbaa8d5a6f83308fd:.gitignore > .gitignore
git reset --hard HEAD
git clean -f -x

#make maintainer-clean: (we might not have a Makefile)
test -z "create_gcov dump_gcov sample_merger profile_merger profile_diff profile_update create_llvm_prof" || rm -f create_gcov dump_gcov sample_merger profile_merger profile_diff profile_update create_llvm_prof
test -z "libquipper.a libglog.a libgflags.a libsymbolize.a" || rm -f libquipper.a libglog.a libgflags.a libsymbolize.a
rm -f *.o
rm -f chromiumos-wide-profiling/*.o
rm -f gflags/*.o
rm -f glog/src/*.o
rm -f symbolize/*.o
rm -f *.tab.c
test -z "glog/src/glog/logging.h glog/src/glog/raw_logging.h glog/src/glog/vlog_is_on.h glog/src/glog/stl_logging.h" || rm -f glog/src/glog/logging.h glog/src/glog/raw_logging.h glog/src/glog/vlog_is_on.h glog/src/glog/stl_logging.h
test . = "." || test -z "" || rm -f 
rm -f chromiumos-wide-profiling/.deps/.dirstamp
rm -f chromiumos-wide-profiling/.dirstamp
rm -f gflags/.deps/.dirstamp
rm -f gflags/.dirstamp
rm -f glog/src/.deps/.dirstamp
rm -f glog/src/.dirstamp
rm -f symbolize/.deps/.dirstamp
rm -f symbolize/.dirstamp
rm -f config.h stamp-h1 glog/src/config.h glog/src/stamp-h2
rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
rm -f cscope.out cscope.in.out cscope.po.out cscope.files
#This command is intended for maintainers to use
#it deletes files that may require special tools to rebuild.
rm -f config.status config.cache config.log configure.lineno config.status.lineno
rm -rf ./autom4te.cache
rm -rf ./.deps chromiumos-wide-profiling/.deps gflags/.deps glog/src/.deps symbolize/.deps
rm -f Makefile

rm -f Makefile.in
rm -f aclocal.m4
rm -f configure
rm -f depcomp
rm -f glog/src/config.h.in~
rm -f install-sh
rm -f missing
rm -f config.h.in
rm -f compile
rm -f depcomp

exit
aclocal -I . && autoheader && autoconf && automake --add-missing -c
./configure # --with-llvm=....
