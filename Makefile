.PHONY: hooks-install hooks-run

hooks-install:
	@bash ./script/install_git_hooks.sh

hooks-run:
	@bash ./script/pre_commit.sh
