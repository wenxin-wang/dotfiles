pkgs ?= shell python ranger i3wm polybar dunst fcitx font pulse

all: pre
	stow -t $(HOME) $(foreach p,$(pkgs),$(p))

re:
	stow -t $(HOME) $(foreach p,$(pkgs),-R $(p))

del:
	stow -t $(HOME) $(foreach p,$(pkgs),-D $(p))

.PHONY: pre

pre:
	mkdir -p ~/.config/ranger
