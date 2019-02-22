pkgs ?= shell python ranger i3wm polybar dunst fcitx font pulse

all: pre
	stow $(foreach p,$(pkgs),$(p))

re:
	stow $(foreach p,$(pkgs),-R $(p))

del:
	stow $(foreach p,$(pkgs),-D $(p))

.PHONY: pre

pre:
	mkdir -p ~/.config/ranger
