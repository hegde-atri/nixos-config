{ config, lib, ... }:

{
  # Prevent replacing the running kernel without reboot
  security.protectKernelImage = true;

  # tmpfs = /tmp is mounted in ram.
  boot.tmpOnTmpfs = lib.mkDefault true;
  # If not using tmpfs, clean /tmp manually.
  boot.cleanTmpDir = lib.mkDefault (!config.boot.tmpOnTmpfs);

  # Security hole
  boot.loader.systemd-boot.editor = false;

  boot.kernel.sysctl = {
    # Disable the Magic SysRq key
    "kernel.sysrq" = 0;

    ## TCP hardening
    # Disable bogus ICMP errors
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    # Perform reverse path filtering on packets from all interfaces.
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    # Protects against SYN flood attacks
    "net.ipv4.tcp_syncookies" = 1;
    # Incomplete protections against TIME-WAIT assassination
    "net.ipv4.tcp_rfc1337" = 1;

    ## TCP Optimisation
    # Reduce network latency by packing data in the sender's inital TCP SYN.
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };
  boot.kernelModules = [ "tcp_bbr" ];

  user.initialPassword = "nixos";
  user.users.root.initialPassword = "nixos";

  security.acme.acceptTerms = true;
}
