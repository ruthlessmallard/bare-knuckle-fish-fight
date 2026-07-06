# Bare Knuckle Fish Fight - Design Document

## Concept
"Madness Combat meets possession mechanics in a mid-century office building."

You are a ghost. They have your goldfish. You cannot interact with the physical world directly.

## Core Mechanic: Possession
- Ghost form: Cannot attack, cannot be hurt (mostly), can move freely
- Possession: Hold aim reticle over enemy until progress bar fills (like Pokémon catch, but without HP dependence)
- Fail possession: Host takes damage, cooldown on that host
- Success: Ghost enters host, gains their body + weapon + abilities
- Host dies: Ghost ejected, ragdoll drops, find new host
- Enemies SHOOT possessed friends (they know it's not their buddy)

## Controls: Thumb Input (Mobile)
- **Touch down**: Start aiming (gun/arm points at thumb)
- **Drag**: Update aim continuously
- **Lift + retouch ~same spot (~30px tolerance)**: FIRE
- Single thumb controls aim AND fire. No cluttered buttons.

## Visual Style
- Mid-century office: wood paneling, beige walls, amber accents
- Archer aesthetic meets supernatural chaos
- Pixel art sprites, modular assembly

## Sprite System (Modular)
Each character assembled from parts:
- `body.png` - Torso + legs (flips left/right based on aim)
- `head.png` - Bob animation when idle
- `hand.png` - Pivot point for weapon attachment
- `gun.png` - Weapon sprite (rotates toward aim target)
- `gun_firing.png` - Muzzle flash/recoil (brief swap on fire)
- `bullet.png` - Projectile sprite

Animation: Procedural part movement, not frame-based walk cycles.
- Head bobs subtly (timer-based)
- Gun rotates smoothly toward aim
- Body flips horizontally based on aim direction

## Milestones

### ✅ Milestone 1: Dude Who Can Walk
- Basic Flutter + Flame project scaffolded
- Modular fighter component system
- Thumb aim controls
- Web build + CI/CD via GitHub Actions

### ⬜ Milestone 2: Dude With Gun
- [x] Gun sprite attaches to hand
- [x] Bullets spawn and travel
- [ ] Muzzle flash works properly
- [ ] Hostile targets to shoot at

### ⬜ Milestone 3: Possession
- Ghost form sprite
- Possession reticle + progress bar mini-game
- Enemy AI (walk, aim, shoot at player)
- Cooldown system for failed possessions

### ⬜ Milestone 4: Goldfish Rescue
- Multiple enemy types ( Different weapons/abilities)
- Office level design (desks, cubicles, break rooms)
- Boss fight: The guy who has your fish
- Escape sequence?

## Technical Notes
- Flutter 3.22.0 (GitHub Actions)
- Flame game engine for 2D rendering
- GitHub Actions builds both APK (Android) and web
- Web uses `flutter build web --release`
- Android uses `flutter build apk --release` with AndroidX

## Known Issues
- Head bob animation uses simple timer (not synced to walk cycle)
- Gun flip/mirror logic may need tuning for natural feel
- Retouch-to-fire tolerance (30px) needs playtesting

## Credits
- Design: Shawn + Doug (reluctantly)
- Sprite art: Shawn (15 min/day for a month, apparently)
- Code: Doug (while complaining)
- Emotional support: Nobody
