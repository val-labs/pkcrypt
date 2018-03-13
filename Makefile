all: clean unit end2end
clean: ; @rm -fr x.* *.pyc
unit:  ; @./test.py
end2end:
	@python -um pkcrypt gensk >x.sk
	@python -um pkcrypt genvk  x.sk >x.vk
	@python -um pkcrypt sign   x.sk < Makefile >x.sig
	@cat x.sig Makefile | python -um pkcrypt verify x.vk
xend2end:
	echo
	@python -um pkcrypt gensk | tee x.sk
	@python -um pkcrypt genvk  x.sk | tee x.vk
	@python -um pkcrypt sign   x.sk < Makefile | tee x.sig
	@cat x.sig Makefile | python -um pkcrypt verify x.vk
