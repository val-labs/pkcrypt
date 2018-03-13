all: clean unit end2end lend2end
clean:
	@find . -name __pycache__ | xargs rm -fr
	@find . -name *.pyc | xargs rm
	@rm -fr tmp.*
unit:  ; @PYTHONPATH=. ./pkcrypt/test.py
end2end:
	@python3 -um pkcrypt gensk -o       tmp.sk
	@python3 -um pkcrypt genvk -o tmp.key  tmp.sk
	@cat tmp.sk >>tmp.key && rm tmp.sk
	@python3 -um pkcrypt sign  -o tmp.sig tmp.key < Makefile
	@cat tmp.sig Makefile | python3 -um pkcrypt verify tmp.key
test/data/test1.key:
	@python3 -um pkcrypt gensk -o y.sk
	@python3 -um pkcrypt genvk -o test/data/test1.key y.sk
	@cat y.sk >>test/data/test1.key && rm y.sk
lend2end: test/data/test1.key
	@python3 -um pkcrypt sign  -o test/data/LICENSE.sig test/data/test1.key < LICENSE
	@cat test/data/LICENSE.sig LICENSE|python3 -um pkcrypt verify test/data/test1.key
