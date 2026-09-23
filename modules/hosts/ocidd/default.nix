{self, inputs, ...}: {

flake.nixosConfigurations.ocidd = inputs.nixpkgs.lib.nixosSystem {
	modules = [ 
		self.nixosModules.ociddConfiguration
		];
	};
}
