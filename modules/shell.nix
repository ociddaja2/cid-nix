{ ... }: {

  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        php
        nil
        nixpkgs-fmt
        statix
        deadnix
      ];
    };
  };
}
