# Lessons Learned

## 2026-03-30: EMD Modernization

### Mistake: Did not commit before making changes
- **Rule**: ALWAYS run `git commit` on the current state before starting any modifications. This preserves a clean rollback point.
- **Why it matters**: If the changes break something, there's no clean baseline to diff against or revert to.

### Mistake: Did not verify the rewritten code runs
- **Rule**: Before marking implementation complete, verify it works — run it, run tests, or at minimum confirm syntax is valid. If no runtime is available, explicitly flag this to the user as an open item.
- **Why it matters**: Shipping untested code violates "Never mark a task complete without proving it works."

### Mistake: Used TodoWrite tool instead of tasks/todo.md
- **Rule**: Track task progress in `tasks/todo.md` per user's CLAUDE.md preferences, not the built-in TodoWrite tool.
