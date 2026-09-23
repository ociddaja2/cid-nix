{ self, inputs, ... }: {
  flake.nixosModules.ociddHome = { config, pkgs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.ocidd = { config, pkgs, ... }: {
        home.stateVersion = "26.05";

        home.file.".config/nvim".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/nvim";

        home.packages = [
          pkgs.dbeaver-bin
          pkgs.ripgrep
          pkgs.fd
          pkgs.unzip
          pkgs.tree-sitter
          pkgs.wl-clipboard
          pkgs.cliphist
          pkgs.playerctl
        ];

        home.pointerCursor = {
          enable = true;
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
          size = 10;
        };

        xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;
        xdg.configFile."foot/foot.ini".source = ./foot.ini;

        programs.foot.enable = true;
        programs.fish = {
          enable = true;
          shellAliases = {
            ll = "ls -la";
            cl = "clear";
          };
          shellInit = ''
            set -g fish_greeting ""
            direnv hook fish | source
          '';
        };

        imports = [
          inputs.spicetify-nix.homeManagerModules.default
        ];
        programs.spicetify =
          let
            spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
          in
          {
            enable = true;

            enabledExtensions = with spicePkgs.extensions; [
              adblock
            ];

            # theme = spicePkgs.themes.text;
          };
      };
    };
    home-manager.backupFileExtension = "backup";

  };
}
