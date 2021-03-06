BASE = .

ISTANBUL = ./node_modules/.bin/istanbul
TEST_COMMAND = NODE_ENV=test ./node_modules/.bin/mocha
COVERAGE_OPTS = --lines 95 --statements 90 --branches 80 --functions 90
BUSTER = ./node_modules/.bin/buster test

main: lint test test-buster

cover:
	$(ISTANBUL) cover test/run.js

check-coverage:
	$(ISTANBUL) check-coverage $(COVERAGE_OPTS)

test: cover check-coverage


test-cov: cover check-coverage
	open coverage/lcov-report/index.html

# You likely need to install buster globally for this to work, because buster
# doesn't work with relative paths.
test-buster:
	$(BUSTER)

test-acceptance:
	test/run.js -T acceptance

lint:
	./node_modules/.bin/jshint ./lib --config $(BASE)/.jshintrc && \
	./node_modules/.bin/jshint ./test --config $(BASE)/.jshintrc && \
	./node_modules/.bin/jshint ./test-buster --config $(BASE)/.jshintrc


.PHONY: test test-buster
