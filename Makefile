.SUFFIXES: .md .html
ifeq ($(shell uname),Darwin)
	SED=sed -i bak
else
	SED=sed -i
endif

.md.html:
	pathprefix=`echo $< | tr -d -c '/' | sed -r 's/\//..\//g'` && \
		pandoc --standalone -V "pagetitle:$$(head -1 $<)" -f markdown -c $$pathprefix"uvafs.css" --columns=9999 -t html5 -o $@ $<
	@echo wrote $@
	#$(SED) s_"</body>"_"$(LICENSE)</body>"_g $@
	#pathprefix=`echo $< | tr -d -c '/' | sed -r 's/\//..\//g'` && \

markdown:
	@find . | grep -e "\.md$$" | grep -v reveal.js | grep -v node_modules | sed s/.md$$/.html/g | awk '{print "make -s "$$1}' | bash
