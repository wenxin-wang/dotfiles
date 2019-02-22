pkgs ?= shell localbin git python ranger i3wm polybar dunst fcitx font pulse X

STOW_ARGS = -t $(HOME) --ignore='.*\.bak'

all: pre
	stow $(STOW_ARGS) $(foreach p,$(pkgs),$(p))

re:
	stow $(STOW_ARGS) $(foreach p,$(pkgs),-R $(p))

del:
	stow $(STOW_ARGS) $(foreach p,$(pkgs),-D $(p))

.PHONY: all re del pre

pre:
	mkdir -p ~/.local/bin
	mkdir -p ~/.config/ranger
