#! /bin/sh

## This is more a guide than a serious shell script.  You can actually
## run it as a script, but don't expect any graceful error handling.

## Disable Install-Suggests and Install-Recommends to save some space
echo 'APT::Install-Suggests "0";' > /etc/apt/apt.conf.d/20no-extra-packages
echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/20no-extra-packages
sudo apt-get update


## Packages
sudo apt-get install \
    build-essential \
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
    libusb-dev \


##
## Things that are not packaged for Debian
##

## discount

wget http://www.pell.portland.or.us/~orc/Code/discount/discount-2.1.5a.tar.bz2
tar xjvf discount-2.1.5a.tar.bz2
cd discount-2.1.5a
sed -e 's/CFLAGS=-g/CFLAGS=-g -fPIC/' Makefile
./configure.sh --prefix=/usr/local
make
sudo make install


### epeg

wget http://www.call-with-current-continuation.org/tarballs/epeg-cvs-20070219.tar.gz
tar xzvf epeg-cvs-20070219.tar.gz
cd epeg
./autogen.sh
./configure --prefix=/usr/local
sudo make install


### proccpuinfo

wget http://download.savannah.gnu.org/releases/proccpuinfo/libproccpuinfo-0.0.8.tar.bz2
tar xjvf libproccpuinfo-0.0.8.tar.bz2
cd libproccpuinfo-0.0.8/
cmake -D CMAKE_INSTALL_PREFIX=/usr/local .
make
make test
sudo make install


### bvspis

mkdir /usr/local/bvspis
chown user:user /usr/local/bvspis
cd /usr/local/bvspis
wget http://www.netlib.org/toms/770
awk 'NR>4' 770 > bvspis.sh
rm 770
sh ./bvspis.sh
rm ./bvspis.sh

# use BVSPIS_PATH=/usr/local/bvspis/ salmonella bvsp-spline


### libgit2
git clone git://github.com/libgit2/libgit2.git
cd libgit2
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local
sudo cmake --build . --target install
