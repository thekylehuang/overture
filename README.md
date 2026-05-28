# overture.nix

A nix-darwin setup used for development. Includes programs, home manager, and system configurations.

## Commands

The repository includes a `Makefile` which provides utility commands for various Nix tasks. Run each of these with the root of the overture repository set as the CWD.

### Reload config

```bash
make
```

### Update external inputs

```bash
make update
```

### Delete previous generations and unreachable store paths

```bash
make gc
```
### Check flake for correctness

```bash
make check
```
