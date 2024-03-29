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
ALL_BUILD_ARGS     :=
SINGLE_BUILD_ARGS  :=
INSTALL_BUILD_ARGS := -ver "${VERSION}"
BASIC_BUILD_ARGS   := 
SNAKE_BUILD_ARGS   := -snake
LOWER_BUILD_ARGS   := -lower
ADDITIONAL_BUILD_ARGS :=

TARGET_LIB         :=
DEBUG              := false
STDIO              := false

ifeq (${DEBUG},true)
	ALL_BUILD_ARGS+= -debug -verbose
endif

ifeq (${STDIO},true)
	ADDITIONAL_BUILD_ARGS+= -out /dev/stdout
endif

all: single single-snake single-lower

single:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${SINGLE_BUILD_ARGS} ${BASIC_BUILD_ARGS} -out ${CURRENT_DIR}/${BASIC_FILENAME} ${ADDITIONAL_BUILD_ARGS} ${TARGET_LIB}

single-snake:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${SINGLE_BUILD_ARGS} ${SNAKE_BUILD_ARGS} -out ${CURRENT_DIR}/${SNAKE_FILENAME} ${ADDITIONAL_BUILD_ARGS} ${TARGET_LIB}

single-lower:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${SINGLE_BUILD_ARGS} ${LOWER_BUILD_ARGS} -out ${CURRENT_DIR}/${LOWER_FILENAME} ${ADDITIONAL_BUILD_ARGS} ${TARGET_LIB}

release:
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${RELEASE_BUILD_ARGS} ${BASIC_BUILD_ARGS} -out ${RELEASE_DIR}/${BASIC_FILENAME} ${ADDITIONAL_BUILD_ARGS} ${TARGET_LIB}
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${RELEASE_BUILD_ARGS} ${SNAKE_BUILD_ARGS} -out ${RELEASE_DIR}/${SNAKE_FILENAME} ${ADDITIONAL_BUILD_ARGS} ${TARGET_LIB}
	${Build-Single.sh} ${ALL_BUILD_ARGS} ${RELEASE_BUILD_ARGS} ${LOWER_BUILD_ARGS} -out ${RELEASE_DIR}/${LOWER_FILENAME} ${ADDITIONAL_BUILD_ARGS} ${TARGET_LIB}
	${CURRENT_DIR}/bin/Build-Archive.sh -out ${RELEASE_DIR} -- ${ALL_BUILD_ARGS} ${RELEASE_BUILD_ARGS}
	${CURRENT_DIR}/bin/Build-Info.sh -out ${RELEASE_DIR}/fasbashlib.json

docs:
	bash ${CURRENT_DIR}/bin/Build-Docs.sh

install:
	bash ${CURRENT_DIR}/bin/Build-Install.sh -dir "${DESTDIR}"

uninstall:
	[[ -e /usr/lib/fasbashlib/filelist ]] || exit 1
	xargs rm < <(sed "s|^|/|g" /usr/lib/fasbashlib/filelist)
	find /usr/lib/fasbashlib -type d -empty -delete

test:
	bash ${CURRENT_DIR}/bin/Check-Lib.sh
	bash ${CURRENT_DIR}/bin/Check-Bin.sh
