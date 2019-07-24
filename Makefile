test:
	@cd project && lein ltest

publish:
	cd project && lein deploy clojars

