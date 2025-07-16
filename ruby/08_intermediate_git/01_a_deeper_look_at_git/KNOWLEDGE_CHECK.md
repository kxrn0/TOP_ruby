### 1.- How can you amend your last commit?

$A:$

With `git commit --amend`.

### 2. What are some different ways to rewrite history?

$A:$

By amending, reseting, or rebasing.

#### `rebase`

We can squash commits with reset in interactive mode.
Let's say we have a history like

```
* 64e4d2e (HEAD -> main) final commit
* f498e23 third meaningful commit
* fa92fb6 second meaningful commit
* f6091a4 first meaningful commit
* b743add init
```

and we want to squash the "second" and "third" commits together into one commit. We first enter

```
git rebase -i --root
```

The editor opens with

```
pick b743add init
pick f6091a4 first meaningful commit
pick fa92fb6 second meaningful commit
pick f498e23 third meaningful commit
pick 64e4d2e final commit
```

we squash our commits together by changing the third's option from `pick` to `squash`.

```
pick b743add init
pick f6091a4 first meaningful commit
pick fa92fb6 second meaningful commit
squash f498e23 third meaningful commit
pick 64e4d2e final commit
```

We save and close the editor, after which the editor opens up again with

```
# This is a combination of 2 commits.
# This is the 1st commit message:

second meaningful commit

# This is the commit message #2:

third meaningful commit
```

We can edit the commit message. After we close the editor the commits are squashed.

#### `reset`

The history is now

```
* f54424c (HEAD -> main) final commit
* 9a3899e second meaningful commit
* f6091a4 first meaningful commit
* b743add init
```

We can squash the last two commits by first soft resetting to "first" commit. After the soft reset HEAD points to "first" commit, but the index has the contents of "final" commit, so if we commit now we create a new commit with the contents of "final" commit, and "second" and "final" commits are orphaned, and hopefully killed so they don't waste resources.

### 3. What does it mean for branches to be pointers?

Branches point to commits. That's it. A branch is a pointer to a commit.
