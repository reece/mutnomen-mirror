.SUFFIXES:

SHELL:=/bin/bash -e -o pipefail
WGET_OPTIONS:=--config=/dev/null -e robots=off -P tmp --no-parent --mirror --no-verbose

.PHONY: update
update:
	rm -fr tmp; mkdir -p tmp
	-wget ${WGET_OPTIONS} http://www.hgvs.org/mutnomen/ 2>&1 >tmp/update.log
	dos2unix mutnomen/*.html
	rm -fr mutnomen~
	mv -b tmp/www.hgvs.org/mutnomen .
	mv tmp/update.log mutnomen/
	rm -fr tmp

.PHONY: uppu
uppu: update
	git commit -a -m "automatic update"
	git push


.PHONY: clean cleaner cleanest
clean:
	find . -regex '.*\(~\|\.bak\)' -type f -print0 | xargs -0r /bin/rm
cleaner: clean
cleanest: cleaner
