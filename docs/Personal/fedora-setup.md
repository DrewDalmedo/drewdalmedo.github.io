# Fedora Linux + Nix

## Initializing the environment

First, download the live CD and flash it to a USB with [Fedora Media Writer](https://fedoraproject.org/workstation/download)

Afterwards, boot into the live USB and complete the setup process from beginning to end (disk partitioning -> setting up your user account).

## Installing Nix

Open a terminal. Copy and paste the command below to run the Determinate Systems Nix Installer:

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

If the above command doesn't work, you can find the installer's instructions [here](https://determinate.systems/posts/determinate-nix-installer/).

After installing Nix, make sure Nix is in your path by closing and reopening your terminal. Then, ensure Nix is installed properly by running the following:

```sh
nix run nixpkgs#hello
```

You should see `Hello, world!` appear on your screen after a few moments.

## Installing home-manager

With Nix installed, you can now install home-manager. Run the following command in your terminal:

```sh
nix run home-manager/master -- init --switch
```

This should set up a flake.nix in the `~/.config/home-manager` directory.

(NOTE: Special thanks to [Red Tomato's Blog](https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/) for the elegant one-liner to install home-manager. It supposedly came from the home-manager docs, but I couldn't find it on first glance.)

### Installing Nixvim and Devenv

Now that we have home-manager as a flake, we can now install software such as Nixvim and Devenv. For my own reference I'll be using [my personal Nixvim config](https://github.com/DrewDalmedo/nixvimrc), but I highly encourage you to make your own or to fork mine and make whatever additions or changes you would like to it. 

To edit our home-manager config inside of my Nixvim config, run the following command:

```sh
nix run github:DrewDalmedo/nixvimrc -- .
```

Then, replace your flake.nix with the following:

```nix
{

  # ...


  inputs = {
    # ...

    nixvimrc.url = "github:DrewDalmedo/nixvimrc";
  };


  # ...


  outputs = { nixpkgs, home-manager, nixvimrc, ... }:
    let
      # ...
    in {
      homeConfiguration."yourusername" = home-manager.lib.homeManagerConfiguration {
        # ...

        extraSpecialArgs = {
          inherit nixvimrc;
        };
      };
    };
}


```

The key components are the **extra line at the end of inputs**, the addition of **nixvimrc to set of inputs to outputs**, and the **extraSpecialArgs block**.

Finally, open `home.nix` and enter the following:

```nix
  home.packages = [

    # ...

    nixvimrc.packages."x86_64-linux".default
    pkgs.ripgrep
    pkgs.nerd-fonts.ubuntu-mono

    pkgs.devenv
  ];

  fonts.fontconfig.enable = true;
```

Now, simply run the following command to install everything:

```sh
home-manager switch
```

#### (Optional) Cleaning up after installation

To clean up the unused packages on your system, you can simply run:

```sh
nix-collect-garbage -d
```

This will remove unneeded packages such as the `hello` package we used earlier to test if Nix was installed correctly.

## References

- [Fedora Media Writer](https://fedoraproject.org/workstation/download)
- [Determinate System Nix Installer](https://determinate.systems/posts/determinate-nix-installer/)
- [Red Tomato's Blog](https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/)
- [My Nixvim Config](https://github.com/DrewDalmedo/nixvimrc)
- [Devenv](https://devenv.sh/)
