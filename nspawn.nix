{ pkgs, lib, ... }:
{
  boot.isContainer = true;
  boot.loader.initScript.enable = true;
  systemd.user.extraConfig = "DefaultEnvironment=PATH=/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
  networking = {
    hostName = lib.mkDefault null;
    useDHCP = false;
    useHostResolvConf = false;
    firewall.enable = false;
    proxy.default = lib.mkDefault null;
    proxy.noProxy = "127.0.0.1,localhost,*.cn";
  };
  services.timesyncd = {
    enable = true;
    servers = [
      "0.cn.pool.ntp.org"
      "1.cn.pool.ntp.org"
      "2.cn.pool.ntp.org"
      "3.cn.pool.ntp.org"
    ];
  };
  time.timeZone = "Asia/Shanghai";
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
