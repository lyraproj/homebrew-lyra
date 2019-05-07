# Homebrew for Lyra

This is a [Homebrew](https://brew.sh) tap for Lyra Project builds.

## How do I install these packages?

This repo follows an implicit magic naming scheme that Homebrew uses. The brew tools will automatically search
github.com/_username_/homebrew-_project_/_package_ when installing, so you can simply use:

```
brew cask install lyraproj/lyra/lyra
```

To get the Cask (pre-built binary) version of Lyra itself.

## Notes

Steps for a release:

* set up your development environment
  - get the latest homebrew and mac development tools
  - clone this repo and symlink it to `/usr/local/Homebrew/Library/Taps/lyraproj/homebrew-lyra`
* create the release in upstream lyra github repo
  - create & push a tag in the lyra repo following `vX.y.z` semver format
  - create a 'release' off the github page for that tag and get the sha256sum for it:
    `openssl sha256 ~/Downlaods/lyra-x.y.z.tar.gz`
* build the bottle
  - edit homebrew-lyra/Formula/lyra.rb,  bump `version` and `tag` (based on the sha256 from the previous step)
  - run `brew install --build-bottle lyra` (you may want to add `--keep-tmp` if troubleshooting the build itself, as otherwise there's no way to debug a failing build)
  - run `brew bottle lyra` to create the actual bottle, and then rename it to remove the extra hyphen (necessary due to [this insanity](https://github.com/Homebrew/brew/commit/d33241bc11054af79c45bd355bf58c7304e18882#r29994607)):  `mv "$file" "$(echo "$file" | sed s/--/-/)"`
  - paste the line with `sha256 "d34db33f....` into the `bottle do` section in the formula
* make the bottle available
  - add the bottle.tar.gz to the lyraproj/lyra release on github
  - Smoke test locally that it's working: `brew uninstall lyra && brew install lyra` to make sure the SHAs match and the install works.
  - commit and push the updated formula with the new bottle

... And you're (finally) done.