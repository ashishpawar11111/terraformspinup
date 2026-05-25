- Open your terminal and navigate to your local git repository.
- Create a file named `commit-msg` in the `.git/hooks/` directory.
- Place contents of `commit-msg` in the file
- Save and close the `commit-msg` file.
- Make the commit-msg file executable by running the following command in the terminal:
  - `chmod +x .git/hooks/commit-msg`

That's it! 

The git commit hook is now in place, and every time you try to make a commit, it will validate the commit message against the conventional commit format. If the commit message doesn't match the format, it will show an error message and prevent the commit. If it matches, the commit will go through successfully.
