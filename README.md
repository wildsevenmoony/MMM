# Moony's Magnificent Modules

Moony's Magnificent Modules, or MMM, is an Arma 3 utility mod for mission makers, Zeus operators, and unit scenarios. It adds a collection of Eden and Zeus modules that make common mission setup tasks faster: medical staging, ambient animation placement, wreck spawning, stationary AI, and configurable gear randomization.

The mod was built for the groups I play with, so some behavior and wording is intentionally tailored to that workflow. It is still useful as a toolbox for other units, especially if you like having small, practical mission-making helpers available in both Eden and Zeus.

## Features

- Eden modules for scripted scenario setup.
- Zeus modules and ZEN integration for live mission control.
- ACE medical helpers:
  - Apply configurable ACE damage to synced units.
  - Add a base medic healing action to synced objects.
- AI and ambience tools:
  - Turn individual AI or whole groups stationary.
  - Apply `ambientAnim`, `switchMove`, or `playMove` animations.
  - Preview supported animations in Eden.
  - Use custom animation class names where supported.
- Gear randomizer modules:
  - Full gear randomization.
  - Separate modules for backpacks, goggles, headgear, uniforms, vests, and weapons.
  - Classname lists, forced equipment, empty chances, and weapon attachment options.
- Vehicle utility:
  - Spawn synced vehicles as wrecks.
  - Optional ACE cookoff and explosion behavior.
- Extra small utilities and compatibility classes for older module names.
- Custom medic insignia.

## Requirements

MMM is built around the Arma 3 modding stack used by the modules:

- Arma 3
- CBA
- ACE
- ZEN

Some functionality depends on ACE medical, ACE interactions, or ZEN module behavior being available in the loaded modset.

## Usage

In Eden, look for the modules under `Moony's Magnificent Modules`. Place a module, configure its attributes, and synchronize it to the relevant units, vehicles, or objects.

In Zeus, the ZEN modules expose the same kind of utility for live mission management. This is especially useful for quickly adjusting AI behavior, applying medical states, randomizing units, or handling vehicles during an active operation.

## Building

This repository is structured as a HEMTT-based Arma 3 mod project.

Common commands:

```sh
hemtt check
hemtt build
hemtt release
```

Generated build output, releases, private keys, and packed PBO files are ignored by Git.

## Notes

This is a personal/unit-focused mod, not a polished framework. Expect pragmatic solutions, very specific helper behavior, and the occasional rough edge. Pull requests and local forks are welcome if you want to adapt it to your own unit's workflow.

## License

See [LICENSE](LICENSE).
