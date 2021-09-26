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

The upstream branch, LibreELEC 9.2, will be merged on a regular basis by the maintainers. Merging upstream should be discussed and announced on IRC in presence of the project leader.

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

# Good practices guide

This branch is based on [LibreELEC 9.2](https://github.com/LibreELEC/LibreELEC.tv/tree/libreelec-9.2).

After you fork and clone to your local development environment, fetch and switch to branch `Lakka-LE9.2` and add the upstream repository:

```
git fetch origin Lakka-LE9.2:Lakka-LE9.2
git checkout -b Lakka-LE9.2 origin/Lakka-LE9.2
git remote add upstream https://github.com/libretro/Lakka-LibreELEC
git fetch upstream
git branch --set-upstream-to=upstream/Lakka-LE9.2
```

To update your local Lakka-LE9.2 branch from upstream (do this every time before you create a new branch which you mean to PR):
```
git checkout Lakka-LE9.2
git pull upstream Lakka-LE9.2
git push origin Lakka-LE9.2
```

Do not commit anything into Lakka-LE9.2 branch but create branches for each PR, otherwise you will have merge commits when updating from upstream:
```
git checkout -b <name_of_branch> Lakka-LE9.2
```

To rebase your branch (you might need to resovle some conflicts - do this only when your PR has conflicts with the base):
```
git checkout <name_of_branch>
git rebase upstream Lakka-LE9.2
```

## Add LibreELEC repository
To merge commits from the base, LibreELEC repository has to be added:
```
git remote add libreelec https://github.com/LibreELEC/LibreELEC.tv
```

Lakka-LE9.2 is based on the libreelec-9.2 branch, so fetch it:
```
git fetch libreelec libreelec-9.2:libreelec-9.2
```

To update the base branch later:
```
git checkout libreelec-9.2
git pull libreelec libreelec-9.2
```

List of new commits in base branch:
```
git log Lakka-LE9.2..libreelec-9.2
```

If you want to merge up to a specific commit hash or tag:
```
git checkout libreelec-9.2
git reset --hard <commit|tag>
```

Create new branch and merge the commits:
```
git checkout -b update_from_libreelec Lakka-LE9.2
git merge libreelec-9.2
```

Push the changes to your remote repository (and open pull request on GitHub):
```
git push origin udpate_from_libreelec
```

