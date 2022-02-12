LibDIR  := /usr/lib/fasbashlib/
DESTDIR := /
CURRENT_DIR = ${shell dirname $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}/${shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}

single:
	bash ${CURRENT_DIR}/bin/SingleFile.sh

docs:
	bash ${CURRENT_DIR}/bin/GenDoc.sh

install:
	bash ${CURRENT_DIR}/bin/MuitlFile.sh -out "${DESTDIR}/${LibDIR}"
