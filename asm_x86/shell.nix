{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "asmzone";
  targetPkgs = pkgs: (with pkgs; [
    libGL
    glib
    gcc
    nasm
    xxd
    hexdump
    linux_6_1.perf
  ]);
  runScript = "bash";
}).env
