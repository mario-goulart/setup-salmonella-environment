#!/bin/sh

# Notes:
# qt4 depends on postgresql90 and mysql55, it causes trouble if we try to use newer ones
# Allegro-devel uses openal-soft, which conflicts with openal
# There is an imlib2 package, but it cannot be installed (no binary?)
su root -c "pkg install \
	graphviz subversion libsvm leptonica R gsl plotutils \
	ploticus pkgconf libexif cairo epeg expat fcgi-devkit \
	sdl sdl_gfx sdl_net sdl_ttf sdl_image sdl_mixer qt4 qt4-opengl \
	g2 glfw glm glpk gts openjdk fltk blas cblas f2c fann \
	allegro-devel openal-soft openmpi libgit2 tokyocabinet zmq \
	python27 postgresql90-client postgresql90-server \
	augeas ossp-uuid webkit-gtk3 hyperestraier memcached \
	redis discount apache-ant qmake xosd db6 \
	freetds-devel mysql55-client mysql55-server"
