LibDIR  := /usr/lib/fasbashlib/
DESTDIR := /
CURRENT_DIR = ${shell dirname $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}/${shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}

all: single single-snake

single:
	bash ${CURRENT_DIR}/bin/SingleFile.sh -debug

single-snake:
	bash ${CURRENT_DIR}/bin/SingleFile.sh -debug -snake -out ${CURRENT_DIR}/fasbashlib-snake.sh

docs:
	bash ${CURRENT_DIR}/bin/GenDoc.sh

install:
	bash ${CURRENT_DIR}/bin/MuitlFile.sh -out "${DESTDIR}/${LibDIR}"

test:
	bash ${CURRENT_DIR}/bin/CheckLib.sh
