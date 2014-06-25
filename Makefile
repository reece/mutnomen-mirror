.PHONY: FORCE
.SUFFIXES:

SHELL:=/bin/bash -e -o pipefail
WGET_OPTIONS:=--config=/dev/null -e robots=off -P tmp --no-parent --mirror --no-verbose

.PHONY: update
update: update.log
update.log: FORCE
	rm -fr tmp; mkdir -p tmp
	-wget ${WGET_OPTIONS} http://www.hgvs.org/mutnomen/ 2>&1 >$@
	mv -b tmp/www.hgvs.org/mutnomen .
	mv $@ mutnomen/
	rm -fr tmp
