VIM = vim -N -u NORC -i NONE --cmd 'set rtp+=tests/vader rtp+=$$PWD'

test: tests/vader
	$(VIM) '+Vader! tests/*.vader'

testnvim: tests/vader
	VADER_OUTPUT_FILE=/dev/stderr n$(VIM) --headless '+Vader! tests/*.vader'

watch: tests/vader
	watchman-make -p 'plugin/*' 'tests/*' --make=VADER_OUTPUT_FILE=/dev/stderr n"$(VIM)" --headless '+Vader! tests/*.vader'

testinteractive: tests/vader
	$(VIM) '+Vader tests/*.vader'

tests/vader:
	git clone https://github.com/junegunn/vader.vim tests/vader || ( cd tests/vader && git pull --rebase; )

# watchman-make -p 'plugin/*' 'tests/*' --make='make testnvim' -t plugin/javascript-switch.vim

.PHONY: test testinteractive
