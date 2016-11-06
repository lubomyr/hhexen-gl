#!/bin/sh

LOCAL_PATH=`dirname $0`
LOCAL_PATH=`cd $LOCAL_PATH && pwd`

ln -sf libsdl_mixer.so $LOCAL_PATH/../../../obj/local/$1/libSDL_mixer.so
ln -sf libgl4es.a $LOCAL_PATH/../../../obj/local/$1/libGL.a
ln -sf libglu.a $LOCAL_PATH/../../../obj/local/$1/libGLU.a

[ -d hhexen-1.6.3-src ] || { curl "http://netix.dl.sourceforge.net/project/hhexen/hhexen/1.6.3/hhexen-1.6.3-src.tgz" | tar zxv && patch -p0 < hhexen-1.6.3-android.diff || exit 1 ; }

cd hhexen-1.6.3-src
if [ \! -f Makefile ] ; then
	../../setEnvironment.sh ./configure --host=arm-linux-androideabi --disable-asm --without-x
fi
rm -f ../libapplication.so
make
mv -f hhexen-gl ../libapplication.so
