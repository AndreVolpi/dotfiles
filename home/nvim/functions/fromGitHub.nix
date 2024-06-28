{ pkgs, owner, repo, rev ? "HEAD", sha256 ? "" }:

pkgs.vimUtils.buildVimPlugin {
  name = "${pkgs.lib.strings.sanitizeDerivationName repo}";
  src = pkgs.fetchFromGitHub {
    inherit owner repo rev sha256;
  };
}
