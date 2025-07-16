### 1. What is a safe way to forcefully push history changes to a remote repository?

$A:$

With `--force-with-lease`. This will check if there are changes to the repo. If so, it won't push anything and return an error, otherwise it will change things.

### 2. What are the dangers of history-changing operations?

$A:$

Irreversibly destroying work, making local repos others have in their machine diverge from the main repo in ways that can't easily be reversed, which would make collaboration harder.

### 3. What are best practices of history-changing operations?

$A:$

Only change history in local repos, and only on commits that haven't been pushed remotely yet.
