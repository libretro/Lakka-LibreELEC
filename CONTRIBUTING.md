# General rules

 * Lakka focuses on stability rather than bleeding edge
 * We try to maintain all the supported platforms, but we know that 95% of our users are using PC and RPi
 * You are responsible for your own changes, if you break something, you need to fix it
 * Everybody has to test their own changes
 * Testing means manual testing on real hardware
 * If you are unsure how to contribute code, meet us on IRC (#lakkatv on freenode) or Discord (libretro server)
 * Our users want the latest working versions of RetroArch and the libretro cores. They don't want non working / half working versions.

# Team members

Project leader: natinusala

Team members: kivutar, Ntemis, gouchi, ToKe79, RobLoach, natinusala, plaidman

# The development branch

The development happens on the branch master. This branch follows LibreELEC 8.2 stable.

We consider this branch as a rolling release, and we ensure that:

 * All the projects build fine at least on Ubuntu 16.04 and 18.04
 * All the projects boot
 * All the projects boot to RetroArch

We don't have a stable branch + unstable branches. For now, we only work on master which should be as stable as possible.
 
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

# Merging upstream

The upstream branch, LibreELEC 8.2, will be merged on a regular basis by the maintainers. Merging upstream should be discussed and announced on IRC in presence of the project leader.

It should be done once every release cycle, at the beginning of the cycle.

# RetroArch updates

Updating RetroArch requires a lot of manual testing. So leave this task to the core team.

# Release cycle

We try to release images to the public one time per month.

Before every release or release candidate, we have a one week code freeze that is announced on IRC or Discord by the team leader.

During the code freeze:

 * Everybody tests the images on real hardware
 * We merge only critical fixes
 * We don't merge upstream
 * We don't update RetroArch or cores for no reasons
 * If we update RetroArch or a core, it better be done by adding a build time patch than updating the commit ID
