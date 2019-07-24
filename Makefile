test:
	@cd project && lein ltest

publish:
	cd project && lein deploy clojars

travis-build:
	sudo env LEIN_ROOT=true curl -L -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/2.8.3/bin/lein
	cd $$TRAVIS_BUILD_DIR/project && lein deps
