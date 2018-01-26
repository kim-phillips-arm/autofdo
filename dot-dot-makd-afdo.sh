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

#for some reason, doing this removes a large part of the Ubuntu universe (gnome etc.):
##sudo apt remove llvm-4.0-dev llvm-4.0 llvm-4.0-runtime libllvm5.0 libllvm4.0 libclang-common-4.0-dev clang-4.0 clang
##sudo apt remove llvm-4.0-dev llvm-4.0 llvm-4.0-runtime libllvm5.0 libllvm4.0 libclang-common-4.0-dev clang-4.0 clang
#do this instead:
#sudo apt remove llvm-4.0

#sudo apt install llvm
#$ ls -l `which llvm-config`
#lrwxrwxrwx 1 root root 31 Sep  4 10:19 /usr/bin/llvm-config -> ../lib/llvm-4.0/bin/llvm-config
#$ llvm-config --version
#4.0.1

aclocal -I .  # makes aclocal.m4, autom4te.cache/*
autoheader # config.h.in, mas autom4te.cache/*
autoconf # configure
automake --add-missing -c  # Makefile.in, compile, depcomp, install-sh, missing

./configure # --with-llvm=....
make -j 8
./create_llvm_prof

exit

checking whether we can compile and link with llvm(ProfileData)... yes
configure: Using shared LLVM libraries.  Setting -rpath to /usr/lib/llvm-4.0/lib.


g++ -DHAVE_CONFIG_H -I. -I./glog/src  -I. -I./glog/src  -I/usr/lib/llvm-4.0/include   -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -DCREATE_LLVM_PROF -g -O2 -MT create_llvm_prof-source_info.o -MD -MP -MF .deps/create_llvm_prof-source_info.Tpo -c -o create_llvm_prof-source_info.o `test -f 'source_info.cc' || echo './'`source_info.cc
In file included from addr2line.h:24:0,
                 from addr2line.cc:17:
source_info.h: In member function ‘uint32 autofdo::SourceInfo::Offset(bool) const’:
source_info.h:63:37: error: ‘getBaseDiscriminatorFromDiscriminator’ is not a member of ‘llvm::DILocation’
                 ? llvm::DILocation::getBaseDiscriminatorFromDiscriminator(
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source_info.h: In member function ‘uint32 autofdo::SourceInfo::DuplicationFactor() const’:
source_info.h:73:30: error: ‘getDuplicationFactorFromDiscriminator’ is not a member of ‘llvm::DILocation’
     return llvm::DILocation::getDuplicationFactorFromDiscriminator(
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


