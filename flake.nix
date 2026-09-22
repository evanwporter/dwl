{
	description = "Development environment for dwl";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = {nixpkgs, ...}: let
		systems = [
			"x86_64-linux"
			"aarch64-linux"
		];
		forAllSystems = nixpkgs.lib.genAttrs systems;
	in {
		devShells =
			forAllSystems (system: let
					pkgs = import nixpkgs {inherit system;};
				in {
					default =
						pkgs.mkShell {
							packages = with pkgs; [
								pkg-config
								bear
								wayland-scanner
								libinput
								libxcb
								libxcb-wm
								libxkbcommon
								libx11
								pixman
								wayland
								wayland-protocols
								wlroots_0_20
								wlr-randr
								xwayland
							];
						};
				});
	};
}
