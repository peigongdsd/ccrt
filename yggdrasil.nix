{ pkgs, lib, ... }: {
 services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    settings = {
      Peers = [];
      IfName = "ygg0";
    };
  };

}
