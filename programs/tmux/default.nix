{ config, pkgs, ... }:

let
  plugins  = pkgs.tmuxPlugins // pkgs.callPackage ./custom-plugins.nix {};
  tmuxConf = builtins.readFile ./default.conf;
in
{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    extraConfig = tmuxConf;
    escapeTime = 0;
    keyMode = "vi";
    plugins = with plugins; [
      {
        plugin = pain-control;
      }
      {
        plugin = power-theme;
      }
      {
        plugin = themepack;
        extraConfig = "set -g @themepack 'powerline/default/green'";
      }
      {
        plugin = open;
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
    shortcut = "b";
    terminal = "screen-256color";
  };
}
