{ self, inputs, ... }: {

  flake.nixosModules.ociddHardware = { config, lib, pkgs, modulesPath, ... }:

  {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/fdb199f6-2454-4576-aa31-5e0cb97eab71";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3944-1BDF";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/a4008914-a0ff-4fcf-a3a6-8b0eda70cbc0"; }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
