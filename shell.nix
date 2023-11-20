{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "ocamlzone";
  targetPkgs = pkgs: (with pkgs; [
    libGL
    glib
    gcc
    ocaml
    ocamlPackages.findlib   #mandatory package for ocamlfind
    ocamlPackages.batteries #mandaroty package for ocamlfind
    opam                    #Ocaml package manager
    darcs                   #Opam distributed smart revision control source
  ]);
  runScript = "bash";
}).env

# get the ocaml version: ocaml --version
# opam switch create 4.14.1
# eval $(opam env --switch=4.14.1)
# opam install lwt <--- this is an example
