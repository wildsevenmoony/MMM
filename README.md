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
  - Disable Eden animation preview per module when an animation would move the unit while editing.
  - Use custom animation class names where supported.
- ACE Arsenal module:
  - Add an ACE Arsenal action to synced objects.
  - Optionally add a scroll-wheel action as well.
  - Apply a blacklist, or make a limited arsenal from a whitelist.
  - Optionally add all compatible magazines and attachments for whitelisted weapons.
- ZEN Intel module:
  - Add Zeus Enhanced style diary intel to any synced object from Eden.
  - Configure sharing target, delete-on-completion, hold action or ACE interaction, action sound, duration, title, and text.
- Gear randomizer modules:
  - Full gear randomization.
  - Separate modules for backpacks, goggles, headgear, uniforms, vests, and weapons.
  - Classname lists, forced equipment, empty chances, and weapon attachment options.
  - Optional MMA preset support through Eden and Zeus modules when Moony's Magnificent Additions is loaded.
- Vehicle utility:
  - Spawn synced vehicles as wrecks.
  - Optional ACE cookoff and explosion behavior.
- Mobile HQ support:
  - Mark synced objects, units, or vehicles as Mobile HQs.
  - Configure respawn side, respawn name, always-deployed state, initial deployed state, and teleport actions.
- Extra small utilities and compatibility classes for older module names.
- Zeus utilities:
  - Add ACE Arsenal to objects during live missions.
  - Toggle ACE carryable/draggable state.
  - Destroy without explosion.
  - Set respawn time for one player or selected sides, groups, and players.
  - Remove crater decals.
  - Enable unlimited ammo or fuel.
  - Manage Mobile HQs during live missions.
  - Add MMA Zeus self-action eligibility to a unit when Moony's Magnificent Additions is loaded.
- Infection Zeus helpers when the related infection systems are loaded:
  - Infect, cure, set infection value, toggle immunity, kill infected units, and create toxic areas.
- Custom medic insignia.

## Requirements

MMM is built around the Arma 3 modding stack used by the modules:

- Arma 3
- CBA
- ACE
- ZEN
- Moony's Magnificent Base

Some functionality depends on ACE medical, ACE interactions, or ZEN module behavior being available in the loaded modset. MMA preset randomization, infection Zeus helpers, and the Zeus-action eligibility helper are available when Moony's Magnificent Additions is loaded.

## Usage

In Eden, look for the modules under `Moony's Magnificent Modules`. Place a module, configure its attributes, and synchronize it to the relevant units, vehicles, or objects.

In Zeus, the ZEN modules expose the same kind of utility for live mission management. This is especially useful for quickly adjusting AI behavior, applying medical states, randomizing units, or handling vehicles during an active operation.

The Set Respawn Time Zeus module targets the player it is placed on. If it is not placed on a player, it opens an owner-style selector for sides, groups, and players. The timer can be applied only to the current respawn instance, or kept after future respawns.

The Add ACE Arsenal module works in Eden and Zeus. It can add only an ACE interaction, or also a scroll action, and can be configured as a normal arsenal with blacklist or a limited arsenal with optional compatible magazine and attachment expansion.

The Add ZEN Intel module works in Eden and mirrors Zeus Enhanced's Create/Edit Intel behavior. It attaches hold-action or ACE-interaction intel to synced objects and creates diary intel for the finder, group, or side when collected. Zeus does not need a duplicate MMM module because Zeus Enhanced already provides the live Create/Edit Intel module.

Gear randomization modules can either use their normal manual fields or an MMA preset ID. Presets are defined in MMA through addon config, mission `description.ext`, or script; the MMM modules simply apply the matching preset or category to the selected units.

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
