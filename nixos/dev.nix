{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    clang
    gdb
    cmake
    ninja
    valgrind
    bear
    clang-tools
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    python3
    uv
    ruff
    mypy
    nodejs
    pnpm
    typescript
    jq
    ripgrep
    fd
    bat
    eza
    delta
    tmux
    yazi
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
