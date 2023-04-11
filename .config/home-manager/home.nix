{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wenxin";
  home.homeDirectory = "/home/wenxin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Desktop
    pkgs.flameshot
    pkgs.qtile
    pkgs.rofi
    # Fonts
    pkgs.font-awesome
    pkgs.google-fonts
    pkgs.material-design-icons
    pkgs.sarasa-gothic
    # Config management
    pkgs.vcsh
    # Dev tools
    pkgs.git
    pkgs.git-lfs
    pkgs.ranger
  ];

  # Fonts.
  fonts.fontconfig.enable = true;

  # Input method.
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk
    ];
  };

  # Emacs.
  programs.emacs = {
    enable = true;
  };
  systemd.user.services.emacs-daemon = {
    Unit = {
      Description = "Emacs text editor";
      Documentation = "info:emacs man:emacs(1) https://gnu.org/software/emacs/";
    };
    Service = {
      Type = "simple";
      ExecStart = "%h/.nix-profile/bin/emacs --fg-daemon";
      ExecStop = "%h/.nix-profile/bin/emacsclient --eval '(kill-emacs)'";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wenxin/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
