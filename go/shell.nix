{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "golangzone";
  profile = ''
      export PATH=$PATH:${pkgs.go}/bin
  '';
  targetPkgs = pkgs: (with pkgs; [
    libGL
    glib
    libcap
    gcc
    go
    go-tools
    golint
    gopkgs
    gore
  ]);
  runScript = "bash";
}).env

# run test with color
# go test -v . | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/''
