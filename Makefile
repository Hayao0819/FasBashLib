DESTDIR := /
CURRENT_DIR = ${shell dirname $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}/${shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}
VERSION := ""
ALL_BUILD_ARGS := #-debug -verbose
SINGLE_BUILD_ARGS := -ignore Misskey
INSTALL_BUILD_ARGS := -ver "${VERSION}"


all: single single-snake single-lower

single:
	bash ${CURRENT_DIR}/bin/Build-Single.sh ${ALL_BUILD_ARGS}

single-snake:
	bash ${CURRENT_DIR}/bin/Build-Single.sh ${ALL_BUILD_ARGS} -snake -out ${CURRENT_DIR}/fasbashlib-snake.sh

single-lower:
	bash ${CURRENT_DIR}/bin/Build-Single.sh ${ALL_BUILD_ARGS} -lower -out ${CURRENT_DIR}/fasbashlib-lower.sh

docs:
	bash ${CURRENT_DIR}/bin/Build-Docs.sh

install:
	mkdir -p "${DESTDIR}/usr/lib/fasbashlib/"
	mkdir -p "${DESTDIR}/usr/share/doc/fasbashlib/"
	mkdir -p "${DESTDIR}/usr/share/licenses/fasbashlib"

	# install multifile
	"${CURRENT_DIR}/bin/Build-Multi.sh" ${ALL_BUILD_ARGS} ${INSTALL_BUILD_ARGS} -out "${DESTDIR}/usr/lib/fasbashlib/"

	# install single file
	"${CURRENT_DIR}/bin/Build-Single.sh" ${ALL_BUILD_ARGS} ${INSTALL_BUILD_ARGS} -out "${DESTDIR}/usr/lib/fasbashlib.sh" 

	# install single snakecase
	"${CURRENT_DIR}/bin/Build-Single.sh" ${ALL_BUILD_ARGS} ${INSTALL_BUILD_ARGS} -out "${DESTDIR}/usr/lib/fasbashlib-snake.sh" -snake 

	# install docs
	"${CURRENT_DIR}/bin/Build-Docs.sh" -out "${DESTDIR}/usr/share/doc/fasbashlib/"

	# install license
	install -Dm 644 "${CURRENT_DIR}/LICENSE.md" "${DESTDIR}/usr/share/licenses/fasbashlib/LICENSE.md"

	# install fasbashlib command
	install -Dm 755 "${CURRENT_DIR}/misc/fasbashlib" "${DESTDIR}/usr/bin/fasbashlib"

test:
	bash ${CURRENT_DIR}/bin/Check-Lib.sh
	bash ${CURRENT_DIR}/bin/Check-Bin.sh
