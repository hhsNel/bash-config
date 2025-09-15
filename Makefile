files=aliases.sh colors.sh expl.sh hist.sh includes.sh main.sh main-tty.sh work.sh
cdir=$(HOME)/config/bash-config

dir: $(files)
	mkdir -p $(cdir)
	if [ "$(PWD)" != "$(cdir)" ]; then cp $(files) $(cdir); fi

install: dir
	echo "source $(cdir)/main.sh" > $(HOME)/.bashrc
	echo "source $(cdir)/main-tty.sh" > $(HOME)/.profile

clean:
	rm -rf $(cdir)

.PHONY: install dir clean
