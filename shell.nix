{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell { packages = with pkgs; [ pre-commit nixd nixpkgs-fmt ]; }
