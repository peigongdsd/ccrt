{ pkgs, lib, ... }:
{
  boot.isContainer = true;
  boot.loader.initScript.enable = true;
  systemd.user.extraConfig = "DefaultEnvironment=PATH=/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
  systemd.sockets.proxy = {
    partOf = [ "proxy.service" ];
    wantedBy = [ "multi-user.target" ];
    socketConfig = {
      ListenStream = 7890;
      BindIPv6Only = "both";
      Accept = false;
   };
  };
  systemd.services.proxy = {
    serviceConfig = {
      ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd /run/host/proxy-containers.sock";
    };
  };
  networking = {
    hostName = "ccrt";
    useDHCP = false;
    useHostResolvConf = false;
    firewall.enable = false;
    proxy.default = "http://127.0.0.1:7890/";
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
}
