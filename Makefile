DESTDIR := /
CURRENT_DIR = ${shell dirname $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}/${shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}
VERSION := ""

all: single single-snake

single:
	bash ${CURRENT_DIR}/bin/SingleFile.sh -debug -verbose

single-snake:
	bash ${CURRENT_DIR}/bin/SingleFile.sh -verbose -debug -snake -out ${CURRENT_DIR}/fasbashlib-snake.sh

docs:
	bash ${CURRENT_DIR}/bin/GenDoc.sh

install:
    mkdir -p "${DESTDIR}/usr/lib/fasbashlib/"
    mkdir -p "${DESTDIR}/usr/share/doc/fasbashlib/"
    mkdir -p "${DESTDIR}/usr/share/licenses/fasbashlib"

    # install multifile
    "${CURRENT_DIR}/bin/MuitlFile.sh" -out "${DESTDIR}/usr/lib/fasbashlib/"

    # install singlefile
    "${CURRENT_DIR}/bin/SingleFile.sh" -debug -out "${DESTDIR}/usr/lib/fasbashlib.sh" -ver "${VERSION}"

    # install docs
    "${CURRENT_DIR}/bin/GenDoc.sh" -out "${DESTDIR}/usr/share/doc/fasbashlib/"

    # install license
    install -Dm 644 "${CURRENT_DIR}/LICENSE.md" "${DESTDIR}/usr/share/licenses/fasbashlib/LICENSE.md"

    # install fasbashlib command
    install -Dm 755 "${CURRENT_DIR}/misc/fasbashlib" "${DESTDIR}/usr/bin/fasbashlib"

test:
	bash ${CURRENT_DIR}/bin/CheckLib.sh
	bash ${CURRENT_DIR}/bin/CheckBin.sh
