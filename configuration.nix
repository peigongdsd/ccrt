{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [ neovim ];
  users = {
    mutableUsers = false;
    allowNoPasswordLogin = true;
  };
  systemd.tmpfiles.rules = [ "f /var/lib/systemd/linger/root" ];
  system.stateVersion = "23.11";
}
