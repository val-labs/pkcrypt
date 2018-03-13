all: clean unit end2end
clean: ; @rm -fr x.* *.pyc */*.pyc
unit:  ; @PYTHONPATH=. ./pkcrypt/test.py
end2end:
	@python -um pkcrypt gensk -o       x.sk
	@python -um pkcrypt genvk -o x.vk  x.sk
	@cat x.vk x.sk >x.key
	@rm  x.vk x.sk
	@python -um pkcrypt sign  -o x.sig x.key < Makefile
	@python -um pkcrypt sign  -o x.sig x.key < Makefile
	@cat x.sig Makefile | python -um pkcrypt verify x.key
