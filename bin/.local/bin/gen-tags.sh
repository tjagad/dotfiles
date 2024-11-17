#! /bin/bash

set -x


echo "removing old cscope.file"
rm cscope.files > /dev/null

echo "generating g_taggable"
export NV_SOURCE=`pwd`
pushd drivers/resman/config
make g_taggable.c
popd
unset NV_SOURCE

echo "creating new cscope.file using find"
find ./drivers/resman/ -iname "*.[ch]" | grep -v _out > cscope.files
find ./drivers/resman/ -iname "*.cpp" | grep -v _out >> cscope.files

#find ./drivers/common/inc/ -iname "*.[ch]" > cscope.files
#find ./drivers/common/inc/ -iname "*.cpp" >> cscope.files

find ./drivers/vgpu/ -iname "*.[ch]" >> cscope.files
find ./drivers/vgpu/ -iname "*.cpp" >> cscope.files

find ./drivers/display/ -iname "*.[ch]" >> cscope.files
find ./drivers/display/ -iname "*.cpp" >> cscope.files

find ./drivers/resman/config/ctrldefs/ -iname ".def" >> cscope.files

find ./sdk/ -iname "*.[ch]" >> cscope.files
find ./sdk/ -iname "*.cpp" >> cscope.files

#find . -iname "*.nvmk" >> cscope.files
#find . -iname "*.cfg" >> cscope.files
#find . -iname "*.sh" >> cscope.files
#find . -iname "*.pl" >> cscope.files
#find . -iname "*.pm" >> cscope.files
#find . -iname "*.spec" >> cscope.files
#find . -iname "*.mk" >> cscope.files

echo "removing old tags/csope.out files"
rm -f tags cscope.out cscope.in.out cscope.po.out > /dev/null

echo "creating tags..."
/usr/bin/ctags -L cscope.files

echo "creating cscope.out..."
/usr/bin/cscope -b -q -k -i cscope.files
