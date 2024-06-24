# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	../../home/ionut/Games/Minecraft/flake.nix
    ];

  # Bootloader.
  #Systemd-boot
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.systemd-boot.consoleMode = "keep";
  #boot.loader.systemd-boot.configurationLimit = 10;
  #boot.loader.systemd-boot.extraEntries ={
  #      "windows.conf"=''
  #      title Windows
  #      efi /dev/nvme0n1p1@/efi/Microsoft/Boot/bootmgfw.efi
  #      sort-key o_memtest
  #      '';
  #};

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true; 
  boot.loader.grub.useOSProber = true;

  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  # Configure keymap in X11

 # services.xserver.enable = true;
 # services.xserver.displayManager.sddm.enable = true;
 # services.xserver.displayManager.sddm.wayland.enable = true;
 # services.xserver.displayManager.sddm.theme = "";
  services.xserver.videoDrivers = [ "nvidia" ];
 # services.xserver = {
 #   layout = "us";
 #   xkbVariant = "";
 # };
  services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd Hyprland";
	  user = "greeter";
        };
      };
    };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ionut = {
    isNormalUser = true;
    description = "ionut";
    extraGroups = ["input" "audio" "networkmanager" "wheel" "video" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  # List packages installed in system profile.

  environment.systemPackages = with pkgs; [
    #bluetooth and sound
    pipewire
    wireplumber
    alsaLib
    pwvucontrol
    bluez-tools
    bluez

    #Utils 
    rar
    unzip
    zip
    brillo
    brightnessctl
    networkmanager
    networkmanagerapplet
    lazygit
    git
    starship
    chntpw
    wl-clipboard
    grim
    slurp
    sxiv
    zathura
    yazi
    lf
    kitty
    trash-cli
    pistol
    imagemagick
    ghostscript
    poppler

    tmux
    mpv
    lsd
    cava
    lshw
    pandoc
    texliveTeTeX

    obsidian
    obs-studio
    ffmpeg

    #Mine
    fish
    entr
    udiskie
    udisks
    ncdu
    btop
    asusctl
    discord
    webcord
    signal-desktop
    jre
    neovim 
    inkscape
    libreoffice
    librecad

    freecad
    prettierd
    firefox
    fastfetch
    blender
    lutris

    heroic
    wine
    wine-wayland
    wineWowPackages.stable
    wineWowPackages.waylandFull

    bottles
    fragments
    alacritty

    wget
    gnome.gnome-clocks
    gnome.nautilus
    xfce.thunar
    xfce.tumbler

    #Dev
    rustc
    clang
    llvm
    cargo
    gcc 
    cmake
    gnumake

    #GTK
    gtk2
    gtk3
    gtk4
    lxappearance-gtk2
    gnome.gnome-themes-extra
    gtk-engine-murrine
    gruvbox-gtk-theme
    gruvbox-dark-gtk

    #Hyprland rice 
    qt5.qtwayland
    qt6.qtwayland
    pkgs.dunst
    waybar
    wofi
    pam
    mpd 
    hyprland
    hypridle
    hyprlock
    hyprpaper
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    libnotify
    bibata-cursors

    #Secure boot
    sbctl
    niv

    #Nix Stuff
    home-manager
  ];

  #Default app
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  #Wayland
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk];	

  #fonts
  fonts.packages = with pkgs; [
	(nerdfonts.override { fonts = [ "JetBrainsMono" "Noto" ]; })
  ];
  #PipeWire
  security.rtkit.enable = true;
  services.flatpak.enable = true; 
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = true; 

  #Asus ctl 
  services.asusd = {
	enable = true;
	profileConfig = "Quiet";
	userLedModesConfig = "strobe";
  }; 
  #udisks
  services.udisks2.enable = true;
  #SSH config
  programs.ssh.startAgent = true;
  programs.ssh.knownHosts.ionut.publicKey = "~/home/ionut/.ssh/keygen";

  services.printing.enable = true;
  services.printing.drivers = [pkgs.hplipWithPlugin];
  services.mpd = {
	enable = true;
	startWhenNeeded = true;
  };
  #Hyprland setup
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
  };
  programs.steam = {
 	enable = true;
 	#remotePlay.openFirewall = true; 
 	#dedicatedServer.openFirewall = true;
  };
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSOR = "1";
	NIXOS_OZONE_WL = "1";
	EDITOR = "nvim";
	VISUAL = "nvim";
	TERM= "alacritty";

  };
  hardware = {
	opengl.enable = true;
	#opengl.driSupport = true;
    	#opengl.driSuppdriSupport32Bit = true;
	bluetooth.enable = true;
	bluetooth.powerOnBoot = true;
	pulseaudio.enable = false;
	bluetooth.settings = {
		General = {
      			Enable = "Source,Sink,Media,Socket";
    		};
	};
  };
  hardware.nvidia = {
	modesetting.enable = true;
	powerManagement.enable = false;
	powerManagement.finegrained = false;
	open = false;
	nvidiaSettings = true;
  };
  hardware.nvidia.prime = {
	offload = {
		enable = true;
		enableOffloadCmd = true;
		};
	amdgpuBusId = "PCI:5:0:0";
	nvidiaBusId = "PCI:1:0:0";	
  };

  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
