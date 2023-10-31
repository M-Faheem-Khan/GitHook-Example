# GitHooks
Pre-Commit setup example which can be shared with other. Using gitleaks for detecting secrets prior to commit.
- [What is the purpose of GitHooks?](#what-is-the-purpose-of-githooks-)
- [Can this replace pipeline steps or actions?](#can-this-replace-pipeline-steps-or-actions-)
- [What tools should I run part of my githooks?](#what-tools-should-i-run-part-of-my-githooks-)
    + [Development Tools](#development-tools)
    + [Security Tools](#security-tools)
- [How to setup a githook?](#how-to-setup-a-githook-)
- [What hooks are available?](#what-hooks-are-available-)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

# What is the purpose of GitHooks?
Githooks allows us to make use of run custom scripts prior to running commit, or pushing. These scripts can run tools for devs(linter, formatter, etc.) or security(secret scanning, vulnerable code). Based on the results of each of the tools we can prevent the user from pushing code vulnerable or not up-to standard, effectivly giving the developer faster feedback loop to address issues and maintainers to not have to identify/pin-point issues related to standards which can be identified by linter or other tooling.  

# Can this replace pipeline steps or actions?
You could, but you shouldn't for the below reasons. Githooks should be used in conjunection with the pipeline as they act as a preliminerary gate on the developers device rather than in the central repository. The hooks should detect/catch major of the issues that will be found later on.  
- Faster feedback loop for devs (don't have to wait for maintainers or pipeline steps to run)
- Code pushed to PR meets standards prior to review - Linting/Formatting should be lower priority for maintainers when reviewing code as this can be automated.
- Cheaper(Time vs Resource) to fix issues when they are caught as the code is commited rather than when its in production and identified months later. 
- Save Cost on Build Minutes - why run entire pipeline just to findout the code does not meet standards. Some pipeline run for 10 minutes or longer.

# What tools should I run part of my githooks?
I'm not sure. As githooks act as the first set of checks/gates in a SDLC which is why it is important these only catch the most common issues and run automation which reduces the effort required by the reviewer to review the code. So, for example linters and formatter the maintiners do not want to spend time on enforcing standards why its a waste of their time and can be automated. These tools should not hinder the developer experience. Remember these are tools to help standardize good practicies and such should only run tools to catch issues early/faster. 

### Development Tools
- Code Linter
- Code Formatter
- Test Status Checker(all test must pass prior to push)

### Security Tools 
- Scan for vulnerable code
- Scan for vulnerable dependencies
- Scan for hardcoded secrets

# How to setup a githook?
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

<!-- EOF -->