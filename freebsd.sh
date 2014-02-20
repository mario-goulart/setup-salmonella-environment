#!/bin/sh

su root -c "pkg install \
	graphviz subversion \
	libgit2 tokyocabinet \
	postgresql93-client postgresql93-server \
	freetds-devel mysql56-client mysql56-server"
