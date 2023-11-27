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
  ]);
  runScript = "bash";
}).env
