{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "Jake-DT";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  services.printing.enable = true;

  hardware.opengl.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.yeehawitsjake = {
    isNormalUser = true;
    description = "Jake Smith";
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers"];
    packages = with pkgs; [
      kate
    ];
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

  system.stateVersion = "23.11";

  environment.systemPackages = [
        #desktop stuff
        pkgs.libsForQt5.qtcurve
        #COMMs
        pkgs.telegram-desktop
        pkgs.signal-desktop
        pkgs.slack
        pkgs.vesktop
        #dev stuff
        pkgs.jetbrains.phpstorm
        pkgs.jetbrains.datagrip
        pkgs.jetbrains.rider
        pkgs.jetbrains.pycharm-professional
        pkgs.php
        ##pkgs.postman
        pkgs.nodejs_21
        pkgs.typescript
        pkgs.mono
        pkgs.dotnet-sdk_8
        #gayming
        pkgs.steam
        pkgs.prismlauncher
        #misc tools
        pkgs.git
        pkgs.etcher
        pkgs.vim
        pkgs.wget
        pkgs.neofetch
        pkgs.android-tools
        pkgs.kexec-tools
        pkgs.chromium
        pkgs.libsForQt5.kfind
        pkgs.btop
        pkgs.openssl
        pkgs.openjdk8-bootstrap
        #data security
        pkgs.veracrypt
        #auditing tools
        pkgs.hashcat
        pkgs.hashcat-utils
        pkgs.armitage
        pkgs.metasploit 
        pkgs.wifite2
        pkgs.nmap
        pkgs.burpsuite
        pkgs.airgeddon
        pkgs.aircrack-ng
        pkgs.binwalk
        #media
        pkgs.spotify
        pkgs.vlc
        pkgs.obs-studio
        pkgs.libsForQt5.kdenlive
        pkgs.glaxnimate
        pkgs.gimp
        pkgs.arduino
        #networking
        pkgs.tailscale
        pkgs.protonvpn-gui
        pkgs.dig
        #shitposting
        pkgs.blender
        pkgs.thefuck
        #infra management
        pkgs.freerdp
        pkgs.remmina
  ];  

  nixpkgs.config.permittedInsecurePackages = [
        "electron-19.1.9"
  ];

  security = {
    protectKernelImage = true;
    lockKernelModules = false;
    rtkit.enable = true;
    polkit.enable = true;

    pam = {
      services.gtklock = {
        text = "auth include login";
      };
    };

    doas = {
      enable = true;
      extraRules = [{
        users = [ "yeeehawitsjake" ];
        keepEnv = true;
        persist = true;
      }];
    };

    sudo.enable = true;
  };

  services = {
    dnscrypt-proxy2 = {
      enable = false;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };
  };

  networking = {

    firewall = rec {
      enable = false;
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
      allowPing = false;
      logReversePathDrops = true;
    };
  };


}
