# GitHooks
Pre-Commit setup example which can be shared with other. Using gitleaks for detecting secrets prior to commit.

# What is the purpose of GitHooks?
Githooks allows us to make use of run custom scripts prior to running commit, or pushing. These scripts can run tools for devs(linter, formatter, etc.) or security(secret scanning, vulnerable code). Based on the results of each of the tools we can prevent the user from pushing code vulnerable or not up-to standard, effectivly giving the developer faster feedback loop to address issues and maintainers to not have to identify/pin-point issues related to standards which can be identified by linter or other tooling.  

# What hooks are available?
Available commits can be viewed in the `./git/hooks/` directory. See also [git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- applypatch-msg
- commit-msg
- fsmonitor-watchman
- post-update
- pre-applypatch
- pre-commit
- pre-merge-commit
- pre-push
- pre-rebase
- pre-receive
- prepare-commit-msg
- push-to-checkout
- update.sample

# How to set it up?
- Create a directory named `hooks` in the root of your project.  
- Create a bash executeable script named `setup.sh` in the `hooks` directory.  
- Add the following code to `setup.sh` - [source](https://gist.github.com/Bazze/870fee0bb38ca0917b3cffa21063b04d).  
```bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${DIR}/.."

# Symlink git hooks
for filename in ${DIR}/git/*; do
	filename=$(basename ${filename})
	ln -s "../../hooks/git/${filename}" ".git/hooks/${filename}"
	if test -f ".git/hooks/${filename}.sample"; then
		rm -f ".git/hooks/${filename}.sample" # removes the .sample from the file
	fi
done
```  
- Create a sub-directory in the `hooks` directory named `git` which will now contain our hooks.  
- Create a file with the same name as the hook that you want to setup. In this case lets setup a `pre-commit` hook.
- Add the code you want to run when a user attempts to commit code. Maybe run a linter or formatter. Try adding `echo ("Running prior to commit code";`
- Now when run the `./hooks/setup.sh` to setup the symlink between your hook in the `hook/git/pre-commit` and `.git/hooks/pre-commit`.
- Now try to commit some code and you will the the line `Running prior to commit code` printed before your code is commited.

<!-- EOF -->