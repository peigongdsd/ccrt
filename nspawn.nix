{ pkgs, lib, ... }:
{
  boot.isContainer = true;
  boot.loader.initScript.enable = true;
  systemd.user.extraConfig = "DefaultEnvironment=PATH=/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
  networking = {
    # Fill in a unique hostname
    hostName = null;
    useDHCP = false;
    useHostResolvConf = false;
    firewall.enable = false;
    proxy.default = null;
    proxy.noProxy = "127.0.0.1,localhost,*.cn";
  };
  systemd.network.enable = true;
  services.resolved.enable = true;
  nix.extraOptions = ''
    store = daemon
    experimental-features = nix-command flakes repl-flake
  '';
  systemd.sockets.nix-daemon.enable = false;
  systemd.services.nix-daemon.enable = false;
  
  environment.systemPackages = with pkgs; [ neovim ];
  users = {
    mutableUsers = false;
    allowNoPasswordLogin = true;
  };
  systemd.tmpfiles.rules = [ "f /var/lib/systemd/linger/root" ];
  system.stateVersion = "23.11";

}
