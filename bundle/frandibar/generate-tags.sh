#!/bin/bash

ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ cpp_src && mv tags cpp
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/GL/ && mv tags gl # for OpenGL
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/SDL/ && mv tags sdl # for SDL
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/qt4/ && mv tags qt4 # for QT4

