test:
	@lein ltest

publish:
	@lein deploy clojars

travis-build:
	sudo env LEIN_ROOT=true curl -L -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/2.8.3/bin/lein
	lein deps

new-clone:
	@git submodule update --init

.PHONY: docs
docs:
	@lein gen-docs
	@cd docs && mkdir -p resources/images && \
	cp -r ../resources/images/* resources/images && \
	git checkout gh-pages ; git add * ; git add resources/images/* ; \
	git commit -am "Regenerated docs." ; git push origin gh-pages
	@git add docs && git commit docs -m "Regenerated docs."
	@git push origin master
