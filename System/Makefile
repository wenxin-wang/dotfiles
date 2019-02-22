pkgs ?= keymap

STOW_ARGS = -t / --ignore='.*\.bak'

all:
	stow $(STOW_ARGS) $(foreach p,$(pkgs),$(p))

re:
	stow $(STOW_ARGS) $(foreach p,$(pkgs),-R $(p))

del:
	stow $(STOW_ARGS) $(foreach p,$(pkgs),-D $(p))

.PHONY: all re del pre

pre:
