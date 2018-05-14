CANDIDATES := $(wildcard .??* .config/*)
EXCLUDES   := .DS_Store .git .config
DOTFILES   := $(filter-out $(EXCLUDES), $(CANDIDATES))

.PHONY: *
.DEFAULT_GOAL := help

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), [ -d $(HOME)/$(val) ] && rm -r $(HOME)/$(val); ln -sFnv $(abspath $(val)) $(HOME)/$(val);)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
