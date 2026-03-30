# EMD Application Modernization

## Completed
- [x] Delete duplicate `emd.julia`
- [x] Create `.gitignore`
- [x] Extract hardcoded data to CSV files (origins, destinations, costs)
- [x] Rewrite `emd.jl` with modern JuMP 1.x / HiGHS
- [x] Create `Project.toml`
- [x] Delete old `result.txt`
- [x] Commit and push

## Open Items
- [ ] Verify `emd.jl` runs correctly with Julia (no runtime available in current environment)

## Review
- All 7 planned changes implemented and pushed to `claude/explore-repo-contents-nyU0S`
- Data extraction verified: 4 origins, 449 destinations, 4x449 cost matrix
- Code not runtime-tested — user should run `julia --project=. -e 'using Pkg; Pkg.instantiate()'` then `julia --project=. emd.jl` to verify
