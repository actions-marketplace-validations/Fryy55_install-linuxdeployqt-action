# install-linuxdeployqt-action
A fast (entirely shell-based) and maintained GitHub Action for installing `linuxdeployqt` on x64/ARM64 Linux runners

# Usage
```
- name: Install linuxdeployqt
  uses: Fryy55/install-linuxdeployqt-action@v1.0.0
```
Replace `v1.0.0` with the version you want to use. This project follows semver, thus updating to the latest same major version is always safe

Inputs:
- `arch`
  - Desired ISA for installation. Uses runner's ISA by default. Supported values: `x64`, `arm64` and aliases `amd64`, `arm` respectively
- `cache`
  - Whether or not to cache a tool on the runner. `true` by default
- `tag`
  - Release tag of linuxdeployqt to download from. `continuous` by default
- `asset`
  - Filename of the asset to download from a release with a tag. Note that using this will *ignore* the `arch` input

An example with inputs:
```yaml
- name: Install linuxdeployqt
  uses: Fryy55/install-linuxdeployqt-action@v1.0.0
  with:
    arch: arm
    cache: false
    tag: 11
```

The installed binary will be on PATH and will be named `linuxdeployqt` _independently_ of the ISA of the runner

# License
This project is distributed under the **MIT License**.

See `LICENSE` for permissions, conditions and limitations.
