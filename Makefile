test:
	@cd project && lein ltest

publish:
	cd project && lein deploy clojars

travis-build:
	sudo env LEIN_ROOT=true curl -L -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/2.8.3/bin/lein
	cd $$TRAVIS_BUILD_DIR/project && lein deps

.PHONY: docs
docs:
	@cd project && lein gen-docs
	@cd docs && mkdir -p resources/images && \
	cp -r ../project/resources/images/* resources/images && \
	git checkout gh-pages ; git add * ; git add resources/images/* ; \
	git commit -am "Regenerated docs." ; git push origin gh-pages
	@git add docs && git commit docs -m "Regenerated docs."
	@git push origin master
