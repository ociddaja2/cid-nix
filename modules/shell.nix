{ ... }: {

  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        php
        nodejs
        nil
        nixpkgs-fmt
        statix
        deadnix
      ];
    };
  };
}
