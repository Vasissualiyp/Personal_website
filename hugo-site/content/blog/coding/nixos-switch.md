---
title: "Why I Switched to NixOS"
date: 2025-12-01
draft: false
author: "Vasilii Pustovoit"
tags: ["NixOS", "Linux", "system administration"]
summary: "My journey from Arch Linux to NixOS and why I'm never going back"
---

# Why I Switched to NixOS

After years of using Arch Linux, I recently made the switch to NixOS. Here's why I believe it's the future of Linux distributions.

## The Arch Experience

Don't get me wrong - I loved Arch. The AUR is fantastic, rolling releases keep you on the cutting edge, and the Arch Wiki is legendary. But I kept running into problems:

- **System breakage**: Updates occasionally broke things
- **Configuration drift**: After a year, I could never quite remember what I'd changed
- **Difficult to replicate**: Setting up a new machine meant hours of manual configuration

## Enter NixOS

NixOS takes a radically different approach: your entire system configuration is declared in a single file (or set of files).

Here's a taste of my `configuration.nix`:

```nix
{ config, pkgs, ... }:

{
  # Enable X11
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Install packages
  environment.systemPackages = with pkgs; [
    vim
    git
    hugo
    python3
    gcc
  ];

  # User configuration
  users.users.vasilii = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
```

## Key Benefits

### 1. Reproducibility
I can recreate my entire system from a single config file. New laptop? Just copy the config and rebuild. Perfect.

### 2. Rollbacks
Every system change creates a new "generation." If an update breaks something, I just reboot into the previous generation. No more recovery mode headaches!

### 3. Declarative Configuration
No more "what did I change?" Everything is in version control. I can see exactly how my system evolved over time.

### 4. Per-Project Environments
Nix flakes let me specify exact versions of tools per project. No more "works on my machine" - if the flake builds, it builds everywhere.

## Challenges

NixOS isn't perfect:

- **Learning curve**: The Nix language takes time to learn
- **Documentation**: Sometimes sparse for advanced use cases  
- **Binary cache**: Occasionally you'll build from source (though it's improving)
- **FHS filesystem**: Some proprietary software expects traditional filesystem layouts

## Bottom Line

For scientific computing where reproducibility is crucial, NixOS is a game-changer. I can now share my exact computational environment with collaborators, ensure simulations run identically across clusters, and never worry about losing my configuration.

If you're a power user who values reproducibility, give NixOS a try!
