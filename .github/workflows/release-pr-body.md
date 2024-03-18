`usmap v{{ .version }}` release candidate

#### Pre-release checklist:
- [ ] Review automated changes
- [ ] Review rhub and win_devel checks (see maintainer email for results)
- [ ] Review reverse dependency checks
- [ ] Review check and test results
- [ ] Verify `DESCRIPTION` and `NEWS.md` are accurate
- [ ] Update `cran-comments.md` if necessary
- [ ] Update `NEWS` if necessary
- [ ] Run `devtools::release()` from this branch
- [ ] Perform necessary CRAN verification release steps (see maintainer email)

Wait for CRAN to publish package. If issues are reported, make changes in this PR and re-run `devtools::release()`.

#### Post-release checklist:
- [ ] `git tag v{{ .version }}`
- [ ] `git push --tags`
- [ ] Update `DESCRIPTION` and `NEWS.md` versions to `{{ .version }}.9000`
- [ ] Add release date of latest version to `NEWS.md`
  - Example `Released Monday, February 31, 2020.`
- [ ] Commit changes with message `Prepare for next release`
- [ ] `usethis::use_github_release()`
- Merge this PR