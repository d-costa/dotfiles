# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";


# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,bash_prompt,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

