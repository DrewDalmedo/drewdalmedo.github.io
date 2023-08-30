# drewdalmedo.github.io
My personal site.

## Usage
Uses `nix flakes` for reproducible development environments.

Ensure you have [nix installed](https://nixos.org/download) and [flakes enabled](https://nixos.wiki/wiki/Flakes#Enable_flakes) before continuing.

After enabling flakes, enter the following commands:

```sh
git clone --recursive https://github.com/DrewDalmedo/drewdalmedo.github.io drews-site
cd drews-site
nix develop
```

After being dropped into a new bash shell, you'll have access to `hugo`. For more information about hugo, see the hugo documentation or run `hugo --help` for a quick reference to common commands.

To exit the development environment, type `exit` in your terminal, or press Ctrl-d if your terminal supports it.
