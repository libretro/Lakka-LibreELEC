# Pull requests

All the code contributions are submitted in the form of Pull Requests. Team members should also use Pull Requests except in case of emergency.

A good PR is:

 * Atomic, changes as less things as possible
 * Well named
 * Well described
 * Tested locally by the sender (on real hardware)
 * Doesn't break other projects (you have to build all of them locally)
 * Idealy doesn't contain merge messages (you can pull --rebase if necessary)
 * Doesn't mix important changes with massive reindentation (send two separate PRs)
 * Doesn't introduce too much changes that would make merging upstream difficult

PRs will be reviewed by the core team. The project leader have the final word on merging a PR or not, but all the core team members are invited to do code reviews.

PRs should be merged using the *Squash and merge* button only.

If a PR is not in a mergeable state, mark the title with [WIP].

Commit messages should be formatted like the [LibreELEC](https://github.com/LibreELEC/LibreELEC.tv)'s upstream, in the following format:
```
package-name: update something on the package
```
