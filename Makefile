.PHONY: hooks-install hooks-run hooks-run-commit-msg

hooks-install:
	@bash ./script/install_git_hooks.sh

hooks-run:
	@bash ./script/pre_commit.sh

hooks-run-commit-msg:
	@bash ./script/commit_msg.sh "$(MSG)"
