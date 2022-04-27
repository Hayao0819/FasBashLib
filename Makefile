DESTDIR := /
CURRENT_DIR = ${shell dirname $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}/${shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}
VERSION := ""
BUILD_ARGS= #-debug -verbose

all: single single-snake single-lower

single:
	bash ${CURRENT_DIR}/bin/Build-Single.sh ${BUILD_ARGS}

single-snake:
	bash ${CURRENT_DIR}/bin/Build-Single.sh ${BUILD_ARGS} -snake -out ${CURRENT_DIR}/fasbashlib-snake.sh

single-lower:
	bash ${CURRENT_DIR}/bin/Build-Single.sh ${BUILD_ARGS} -lower -out ${CURRENT_DIR}/fasbashlib-lower.sh

docs:
	bash ${CURRENT_DIR}/bin/Build-Docs.sh

install:
	mkdir -p "${DESTDIR}/usr/lib/fasbashlib/"
	mkdir -p "${DESTDIR}/usr/share/doc/fasbashlib/"
	mkdir -p "${DESTDIR}/usr/share/licenses/fasbashlib"

	# install multifile
	"${CURRENT_DIR}/bin/Build-Multi.sh" -out "${DESTDIR}/usr/lib/fasbashlib/"

	# install single file
	"${CURRENT_DIR}/bin/Build-Single.sh" -debug -out "${DESTDIR}/usr/lib/fasbashlib.sh" -ver "${VERSION}"

	# install single snakecase
	"${CURRENT_DIR}/bin/Build-Single.sh" -debug -snake -out "${DESTDIR}/usr/lib/fasbashlib-snake.sh" -ver "${VERSION}"

	# install docs
	"${CURRENT_DIR}/bin/Build-Docs.sh" -out "${DESTDIR}/usr/share/doc/fasbashlib/"

	# install license
	install -Dm 644 "${CURRENT_DIR}/LICENSE.md" "${DESTDIR}/usr/share/licenses/fasbashlib/LICENSE.md"

	# install fasbashlib command
	install -Dm 755 "${CURRENT_DIR}/misc/fasbashlib" "${DESTDIR}/usr/bin/fasbashlib"

test:
	bash ${CURRENT_DIR}/bin/Check-Lib.sh
	bash ${CURRENT_DIR}/bin/Check-Bin.sh
