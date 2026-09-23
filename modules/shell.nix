{ ... }: {

  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nil
        nixpkgs-fmt
        statix
        deadnix
      ];
    };
  };
}
