.SUFFIXES:

SHELL:=/bin/bash -e -o pipefail
WGET_OPTIONS:=--config=/dev/null -e robots=off -P tmp --no-parent --mirror --no-verbose

.PHONY: update
update:
	rm -fr tmp; mkdir -p tmp
	-wget ${WGET_OPTIONS} http://www.hgvs.org/mutnomen/ 2>&1 >tmp/update.log
	rm -fr mutnomen~
	mv -b tmp/www.hgvs.org/mutnomen .
	mv tmp/update.log mutnomen/
	rm -fr tmp

.PHONY: up-push
up-push: update
	git commit -a -m "automatic update"
	git push
