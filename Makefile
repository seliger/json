help:
	@echo "jsontool Makefile"
	@echo ""
	@echo "docs     rebuild the man page (from ronn source)"
	@echo "test     run the test suite"
	@echo "tag      create a git tag for current version"

docs:
	mkdir -p man/man1
	node_modules/.bin/ronn -r json.1.ronn > man/man1/json.1
	@echo "# test with 'man man/man1/json.1'"

test:
	(cd test && make test)
testall:
	(cd test && make testall)

tag:
	grep "var VERSION =" lib/jsontool.js | awk -F'"' '{print $$2}' > VERSION
	@echo "* * * Create tag '`cat VERSION`'. * * *"
	git tag -a "`cat VERSION`" -m "version `cat VERSION`"
	rm VERSION
	@echo "* * * Remember to 'git push --tags origin master' then perhaps 'npm publish'. * * *"

.PHONY: test tag
