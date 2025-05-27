🚀 `usmap v{{ .version }}` release candidate

### 📝 Pre-release checklist
- [ ] Review automated changes
- [ ] Review reverse dependency checks (see `release` workflow artifacts)
- [ ] Review check and test results
- [ ] Verify `DESCRIPTION` and `NEWS.md` are accurate
- [ ] Update `cran-comments.md` if necessary
- [ ] Run `devtools::release()` from this branch
- [ ] Perform necessary CRAN verification release steps (see maintainer email)

⏳ Wait for CRAN to publish package. If changes are requested, commit fixes to this pull request and re-run `devtools::release()`.

### 📝 Post-release checklist
- [ ] `git tag v{{ .version }}`
- [ ] `git push --tags`
- [ ] Update `DESCRIPTION` versions to `{{ .version }}.9000`
- [ ] Add `[unreleased]` title at top of `NEWS.md`
- [ ] Add release date of latest version to `NEWS.md`
  - Example `Released Monday, February 31, 2020.`
- [ ] Commit changes with message `Prepare for next release`

✅ Merge this pull request when all post-release tasks are complete.

### 📝 Post-merge Steps
- Create [release](https://github.com/pdil/usmap/releases) linked to `v{{ .version }}` tag with release notes from `NEWS.md`.
