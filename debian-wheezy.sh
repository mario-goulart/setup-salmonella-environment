#! /bin/sh

## Quick&dirty script to install libraries required by eggs.

set -e

SALMONELLA_USER=chicken
SALMONELLA_GROUP=chicken

BITS=32    # 32bit system
# BITS=64  # 64bit system

## Disable Install-Suggests and Install-Recommends to save some space
sudo sh -c "echo 'APT::Install-Suggests \"0\";' > /etc/apt/apt.conf.d/20no-extra-packages"
sudo sh -c "echo 'APT::Install-Recommends \"0\";' >> /etc/apt/apt.conf.d/20no-extra-packages"
sudo apt-get update


## Packages
sudo apt-get install \
    build-essential \
    clang \
    git-core \
    cmake \
    flex \
    subversion \
    automake \
    libf2c2-dev \
    libalut-dev \
    libploticus0-dev \
    libtool \
    libgsl0-dev \
    r-base-core \
    libfcgi-dev \
    libgd2-xpm-dev \
    libimlib2-dev \
    libg2-dev \
    libexif-dev \
    libfann-dev \
    libgts-dev \
    libglpk-dev \
    libaugeas-dev \
    libtokyocabinet-dev \
    libossp-uuid-dev \
    libatlas-base-dev \
    libsundials-serial-dev \
    liblapack-dev \
    libsdl-net1.2-dev \
    libffi-dev \
    libsoil-dev \
    gfortran \
    libplot-dev \
    libqt4-opengl-dev \
    libxosd-dev \
    libreadline6-dev \
    libncurses5-dev \
    libssl-dev \
    libopenmpi-dev \
    libatlas-dev \
    libmysqlclient-dev \
    libopenal-dev \
    python-dev \
    libsqlite3-dev \
    libgdbm-dev \
    freetds-dev \
    libqt4-dev \
    libstemmer-dev \
    zlib1g-dev \
    libsvn-dev \
    liballegro4.2-dev \
    libfltk1.3-dev \
    libzmq-dev \
    libmpfi-dev \
    libphysfs-dev \
    tk8.5 \
    freeglut3-dev \
    libglfw-dev \
    libsdl1.2-dev \
    libsdl-mixer1.2-dev \
    libsdl-sound1.2-dev \
    libsdl-ttf2.0-dev \
    libsdl-gfx1.2-dev \
    libsdl-image1.2-dev \
    libwebkitgtk-3.0-dev \
    openmpi-bin \
    libglm-dev \
    libusb-1.0-0-dev \
    libffcall1-dev \
    libdb-dev \
    openjdk-7-jdk \
    openjdk-7-dbg \
    ant \
    libdb5.1-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    graphviz \
    time \
    libmagic-dev \
    libfuse-dev \
    units \
    postgresql-server-dev-all \
    libmarkdown2-dev \
    xorg-dev \
    libglu1-mesa-dev \
    libglew-dev \
    libleveldb-dev \
    libyaml-dev \
    libudev-dev \

##
## Things that are not packaged for Debian
##

tmpdir=`mktemp -d`
echo "### Using $tmpdir as temporary directory"


### epeg

cd $tmpdir
wget http://www.call-with-current-continuation.org/tarballs/epeg-cvs-20070219.tar.gz
tar xzvf epeg-cvs-20070219.tar.gz
cd epeg
./autogen.sh
./configure --prefix=/usr/local
sudo make install


### proccpuinfo

cd $tmpdir
wget http://download.savannah.gnu.org/releases/proccpuinfo/libproccpuinfo-0.0.8.tar.bz2
tar xjvf libproccpuinfo-0.0.8.tar.bz2
cd libproccpuinfo-0.0.8/
cmake -D CMAKE_INSTALL_PREFIX=/usr/local .
make
make test
sudo make install


### bvspis

sudo mkdir /usr/local/bvspis
sudo chown ${SALMONELLA_USER}:${SALMONELLA_GROUP} /usr/local/bvspis
cd /usr/local/bvspis
sudo wget http://www.netlib.org/toms/770
sudo sh -c "awk 'NR>4' 770 > bvspis.sh"
sudo rm 770
sudo sh ./bvspis.sh
sudo rm ./bvspis.sh

# use "BVSPIS_PATH=/usr/local/bvspis/ salmonella bvsp-spline"


### libgit2

cd $tmpdir
git clone git://github.com/libgit2/libgit2.git
cd libgit2
git checkout v0.23.4
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local
sudo cmake --build . --target install


### iup

mkdir -p $tmpdir/iup
cd $tmpdir/iup
tarball=
if [ "$BITS" = "32" ]; then
    tarball=iup-3.8_Linux32_lib.tar.gz
else
    tarball=iup-3.8_Linux32_64_lib.tar.gz
fi
wget "http://sourceforge.net/projects/iup/files/3.8/Linux%2520Libraries/$tarball"
tar xzvf $tarball
sudo bash install_dev


### canvas draw

# Doesn't really work on wheezy.  Linking against canvas draw
# libraries gives errors like "/usr/bin/ld: skipping incompatible ..."

mkdir -p $tmpdir/cd
cd $tmpdir/cd
if [ "$BITS" = "32" ]; then
    tarball=cd-5.6.1_Linux32_lib.tar.gz
else
    tarball=cd-5.6.1_Linux32_64_lib.tar.gz
fi
wget "http://ufpr.dl.sourceforge.net/project/canvasdraw/5.6.1/Linux%20Libraries/$tarball"
tar xzvf $tarball
sudo bash install_dev


### cryptlib

mkdir -p $tmpdir/cryptlib
cd $tmpdir/cryptlib
wget ftp://ftp.franken.de/pub/crypt/cryptlib/cl342.zip
unzip -a cl342.zip
make
make shared
sudo cp libcl.a libcl.so.3.4.2 /usr/local/lib/
sudo cp *.h /usr/local/include/


### glfw3

mkdir -p $tmpdir/glfw3
cd $tmpdir/glfw3
wget http://ufpr.dl.sourceforge.net/project/glfw/glfw/3.0.4/glfw-3.0.4.zip
unzip glfw-3.0.4.zip
cd glfw-3.0.4
cmake -D BUILD_SHARED_LIBS=1 .
make
sudo make install

# Will install:
# -- Installing: /usr/local/include/GLFW
# -- Installing: /usr/local/include/GLFW/glfw3native.h
# -- Installing: /usr/local/include/GLFW/glfw3.h
# -- Installing: /usr/local/lib/cmake/glfw/glfwConfig.cmake
# -- Installing: /usr/local/lib/cmake/glfw/glfwConfigVersion.cmake
# -- Installing: /usr/local/lib/cmake/glfw/glfwTargets.cmake
# -- Installing: /usr/local/lib/cmake/glfw/glfwTargets-noconfig.cmake
# -- Installing: /usr/local/lib/pkgconfig/glfw3.pc
# -- Installing: /usr/local/lib/libglfw.so.3.0
# -- Installing: /usr/local/lib/libglfw.so.3
# -- Installing: /usr/local/lib/libglfw.so


### nanomsg

mkdir -p $tmpdir/nanomsg
cd $tmpdir/nanomsg
wget http://download.nanomsg.org/nanomsg-0.4-beta.tar.gz
tar xzvf nanomsg-0.4-beta.tar.gz
cd nanomsg-0.4-beta
./configure --prefix=/usr/local
make
sudo make install


### wiring pi (for raspberry-pi-gpio)

mkdir -p $tmpdir/wiringPi
cd $tmpdir/wiringPi
git clone git://git.drogon.net/wiringPi
cd wiringPi
git checkout df45388f6431f7baba31ac1e8e242d89828637a0
./build


### libsass

mkdir -p $tmpdir/libsass
cd $tmpdir/libsass
wget https://github.com/sass/libsass/archive/3.2.5.tar.gz -O libsass-3.2.5.tar.gz
tar xzvf libsass-3.2.5.tar.gz
cd libsass-3.2.5/
make
sudo make install install-shared


### Finishing
sudo ldconfig
