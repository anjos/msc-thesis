#!/bin/sh

# Este script extrai a informação de tamanho de um eps no diretório figures

if [ $# = 0 ]; then
	echo "uso: $0 imagem (EPS)";
	exit 1;
fi

name=`echo $1 | sed -e "s/\.eps//"`;
val=`fgrep "%%BoundingBox" $1 | uniq`;
bb=`echo $val | sed -e "s/\%\%BoundingBox\:\ //"`;
echo "\\includegraphics[type=eps,ext=.eps,bb=$bb]{$name}"

exit 0;
