all: clean unit end2end lend2end
clean:
	@find . -name __pycache__ | xargs rm -fr
	@find . -name *.pyc | xargs rm
	@rm -fr tmp.*
unit:  ; @PYTHONPATH=. ./pkcrypt/test.py
end2end:
	@python3 -um pkcrypt genkey -o tmp.key
	@python3 -um pkcrypt sign  -o tmp.sig tmp.key < Makefile
	@cat tmp.sig Makefile | python3 -um pkcrypt verify tmp.key
test/data/test1.key:
	@python3 -um pkcrypt genkey -o test/data/test1.key
lend2end: test/data/test1.key
	@python3 -um pkcrypt sign  -o test/data/LICENSE.sig test/data/test1.key < LICENSE
	@cat test/data/LICENSE.sig LICENSE|python3 -um pkcrypt verify test/data/test1.key
