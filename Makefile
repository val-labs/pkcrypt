all: clean unit end2end lend2end
clean: ; @rm -fr x.* *.pyc */*.pyc y.*
unit:  ; @PYTHONPATH=. ./pkcrypt/test.py
end2end:
	@python3 -um pkcrypt gensk -o       x.sk
	@python3 -um pkcrypt genvk -o x.key  x.sk
	@cat x.sk >>x.key && rm x.sk
	@python3 -um pkcrypt sign  -o x.sig x.key < Makefile
	@cat x.sig Makefile | python3 -um pkcrypt verify x.key
test/data/test1.key:
	@python3 -um pkcrypt gensk -o y.sk
	@python3 -um pkcrypt genvk -o test/data/test1.key y.sk
	@cat y.sk >>test/data/test1.key && rm y.sk
lend2end: test/data/test1.key
	@python3 -um pkcrypt sign  -o test/data/LICENSE.sig test/data/test1.key < LICENSE
	@cat test/data/LICENSE.sig LICENSE|python3 -um pkcrypt verify test/data/test1.key
