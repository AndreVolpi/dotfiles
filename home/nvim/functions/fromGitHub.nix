{ owner, repo, rev ? "HEAD", sha256 ? "" }:

let
  pkgs = import <nixpkgs> { };
in

pkgs.vimUtils.buildVimPlugin {
  name = "${pkgs.lib.strings.sanitizeDerivationName repo}";
  src = pkgs.fetchFromGitHub {
    inherit owner repo rev sha256;
  };
}
