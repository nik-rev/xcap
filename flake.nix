{
  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:

      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            dbus
            dbus.dev
            pkg-config
            xorg.libxcb
            xorg.libXrandr
          ];
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.dbus
            pkgs.xorg.libxcb
            pkgs.xorg.libXrandr
          ];
        };
      }
    );
}
