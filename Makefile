all: clean unit end2end regress

clean:
	@find . -name __pycache__ | xargs rm -fr
	@find . -name *.pyc | xargs rm
	@rm -fr tmp.*

unit:  ; @PYTHONPATH=. ./pkcrypt/test.py

end2end:
	@python3 -um pkcrypt genpair -o tmp.key
	@python3 -um pkcrypt sign  -o tmp.sig tmp.key < Makefile
	@cat tmp.sig Makefile | python3 -um pkcrypt verify tmp.key

test/data/test1.key:
	@python3 -um pkcrypt genpair -o test/data/test1.key
	@python3 -um pkcrypt sign  -o test/data/LICENSE.sig test/data/test1.key < LICENSE

regress: regress.vk regress.vfy
regress.vk: test/data/test1.key
	@head -1 test/data/test1.key >tmp.vk1
	@python3 -um pkcrypt getvk -o               tmp.vk2 test/data/test1.key
	@diff tmp.vk1 tmp.vk2
regress.vfy: test/data/test1.key
	@cat test/data/LICENSE.sig LICENSE|python3 -um pkcrypt verify test/data/test1.key
	@python3 -um pkcrypt sign  -o               tmp.sig test/data/test1.key < LICENSE
	@diff tmp.sig test/data/LICENSE.sig
