all: clean unit end2end
clean: ; @rm -fr x.* *.pyc
unit:  ; @./test.py
end2end:
	@python -um pkcrypt gensk -o       x.sk
	@python -um pkcrypt genvk -o x.vk  x.sk
	@python -um pkcrypt sign  -o x.sig x.sk < Makefile
	@cat x.sig Makefile | python -um pkcrypt verify x.vk
