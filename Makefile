# Directory
DESTDIR            := /
CURRENT_DIR         = ${shell dirname $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}/${shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}
RELEASE_DIR        := ${CURRENT_DIR}/release-out
Build-Single.sh    := ${CURRENT_DIR}/bin/Build-Single.sh

VERSION            := ""

# FileName
BASIC_FILENAME     := fasbashlib.sh
SNAKE_FILENAME     := fasbashlib-snake.sh
LOWER_FILENAME     := fasbashlib-lower.sh

# Build arguments
ALL_BUILD_ARGS     := -debug -verbose
SINGLE_BUILD_ARGS  := -ignore Misskey 
INSTALL_BUILD_ARGS := -ver "${VERSION}"
RELEASE_BUILD_ARGS := -ver "${VERSION}"
BASIC_BUILD_ARGS   := 
SNAKE_BUILD_ARGS   := -snake
LOWER_BUILD_ARGS   := -lower


all: single single-snake single-lower

single:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${SINGLE_BUILD_ARGS} ${BASIC_BUILD_ARGS} -out ${CURRENT_DIR}/${BASIC_FILENAME}

single-snake:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${SINGLE_BUILD_ARGS} ${SNAKE_BUILD_ARGS} -out ${CURRENT_DIR}/${SNAKE_FILENAME}

single-lower:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${SINGLE_BUILD_ARGS} ${LOWER_BUILD_ARGS} -out ${CURRENT_DIR}/${LOWER_FILENAME}

release:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${RELEASE_BUILD_ARGS} ${BASIC_BUILD_ARGS} -out ${RELEASE_DIR}/${BASIC_FILENAME}
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${RELEASE_BUILD_ARGS} ${SNAKE_BUILD_ARGS} -out ${RELEASE_DIR}/${SNAKE_FILENAME}
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${RELEASE_BUILD_ARGS} ${LOWER_BUILD_ARGS} -out ${RELEASE_DIR}/${LOWER_FILENAME}

docs:
	bash ${CURRENT_DIR}/bin/Build-Docs.sh

install:
	mkdir -p "${DESTDIR}/usr/lib/fasbashlib/"
	mkdir -p "${DESTDIR}/usr/share/doc/fasbashlib/"
	mkdir -p "${DESTDIR}/usr/share/licenses/fasbashlib"

	# install multifile
	"${CURRENT_DIR}/bin/Build-Multi.sh" -out "${DESTDIR}/usr/lib/fasbashlib/"

	# install single file
	"${CURRENT_DIR}/bin/Build-Single.sh" ${ALL_BUILD_ARGS} ${INSTALL_BUILD_ARGS} -out "${DESTDIR}/usr/lib/${BASIC_FILENAME}" 

	# install single snakecase
	"${CURRENT_DIR}/bin/Build-Single.sh" ${ALL_BUILD_ARGS} ${INSTALL_BUILD_ARGS} -out "${DESTDIR}/usr/lib/${SNAKE_FILENAME}" -snake 

	# install docs
	"${CURRENT_DIR}/bin/Build-Docs.sh" -out "${DESTDIR}/usr/share/doc/fasbashlib/"

	# install license
	install -Dm 644 "${CURRENT_DIR}/LICENSE.md" "${DESTDIR}/usr/share/licenses/fasbashlib/LICENSE.md"

	# install fasbashlib command
	install -Dm 755 "${CURRENT_DIR}/misc/fasbashlib" "${DESTDIR}/usr/bin/fasbashlib"

test:
	bash ${CURRENT_DIR}/bin/Check-Lib.sh
	bash ${CURRENT_DIR}/bin/Check-Bin.sh
