{ self, inputs, ... }: {

  flake.nixosModules.ociddConfiguration =
    {
      config,
      pkgs,
      lib,
      ...
    }:

    {
      imports = [
        self.nixosModules.ociddHardware
        self.nixosModules.niri
        self.nixosModules.noctalia
        self.nixosModules.ociddHome
        inputs.home-manager.nixosModules.home-manager
      ];

      # Bootloader

      boot = {
        loader = {
          systemd-boot.enable = true;
          systemd-boot.configurationLimit = 10;
          efi.canTouchEfiVariables = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;

        extraModulePackages = with config.boot.kernelPackages; [
          msi-ec
          v4l2loopback
        ];

        kernelModules = [
          "msi_ec"
          "v4l2loopback"
          "ntsync"
        ];

        extraModprobeConfig = ''
          options v4l2loopback devices=1 card_label="OBS Virtual Camera" exclusive_caps=1
        '';

        plymouth = {
          enable = false;
          themePackages = [ inputs.MikuPlymouth.packages.${pkgs.system}.default ];
          theme = "MikuPlymouth";
        };

        initrd = {
          systemd.enable = true;
          # kernelModules = [ "amdgpu" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
        };

        consoleLogLevel = 3;

        initrd.verbose = false;

        kernelParams = [
          "quiet"
          "splash"
          "rd.udev.log_level=3"
          "rd.systemd.show_status=auto"
        ];

        loader.timeout = 5;
      };

      # Enable flake
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      networking.hostName = "nixos";
      networking.networkmanager.enable = true;

      time.timeZone = "Asia/Makassar";
      i18n.defaultLocale = "en_US.UTF-8";

      # trusted users
      nix.settings.trusted-users = [
        "root"
        "ocidd"
      ];

      # Desktop
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      # services.xserver.xkb = {
      #   layout = "us";
      #   variant = "";
      # };
      # environment.variables = {
      #   XCURSOR_THEME = "Adwaita";
      #   XCURSOR_SIZE = "10";
      #   };

      services.printing.enable = true;

      # Audio (pipewire)
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      # Development
      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
      };

      services.nginx = {
        enable = true;
        virtualHosts."localhost" = {
          locations."/" = {
            root = "${pkgs.adminer}";
            index = "adminer.php";
            extraConfig = ''
              fastcgi_pass 127.0.0.1:9000;
              fastcgi_index adminer.php;
              include ${pkgs.nginx}/conf/fastcgi_params;
              fastcgi_param SCRIPT_FILENAME ${pkgs.adminer}/adminer.php;
            '';
          };
        };
      };

      services.phpfpm.pools.adminer = {
        user = "nginx";
        settings = {
          "listen" = "127.0.0.1:9000";
          "pm" = "dynamic";
          "pm.max_children" = 5;
          "pm.start_servers" = 2;
          "pm.min_spare_servers" = 1;
          "pm.max_spare_servers" = 3;
        };
      };

      services.cloudflare-warp.enable = true;

      systemd.services = {
        mysql.wantedBy = lib.mkForce [ ];
        cloudflare-warp.wantedBy = lib.mkForce [ ];
      };

      users.users."ocidd" = {
        isNormalUser = true;
        description = "ocidd";
        extraGroups = [
          "networkmanager"
          "adbusers"
          "wheel"
        ];
        packages = with pkgs; [ ];
        shell = pkgs.fish;
      };

      # Programs
      programs = {
        neovim.enable = true;
        neovim.defaultEditor = true;

        fish.enable = true;

        direnv.enable = true;
        direnv.nix-direnv.enable = true;

        firefox.enable = true;

        nix-ld.enable = true;

        gamemode.enable = true;
        gamescope.enable = true;
      };

      services.tailscale.enable = true;

      nixpkgs.config.allowUnfree = true;

      services.flatpak.enable = true;

      systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        '';
      };

      environment.systemPackages = with pkgs; [
        git
        vim
        wget
        btop
        alacritty
        foot
        fastfetch
        freshfetch
        inotify-tools
        spotify
        lazygit
        cava
        unimatrix
        cloudflare-warp
        discord
        bruno
        unzip
        nwg-displays
        obsidian
        gh
        github-desktop
        gamemode
        adminer
        android-tools
        protonup-qt
        xwayland
        xwayland-satellite
        mpvpaper
        obs-studio
        qemu

        nerd-fonts.jetbrains-mono
      ];

      nix.gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };

      # Gaming
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      hardware.steam-hardware.enable = true;

      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        # # Konfigurasi Prime Offload
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
      system.stateVersion = "26.05";
      fonts.fontconfig.enable = true;
    };
}
