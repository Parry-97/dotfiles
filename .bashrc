# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'
  alias icat='kitty +kitten icat'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#Custom Aliases
alias tm-dev='tm-dev.sh'
alias tm-q='tm-q.sh'
alias v="fd --type f --hidden --exclude .git | fzf --reverse --header='Open file in Neovim' --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"

alias l='exa -la --icons'
alias tm='tmux'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias zl='zellij'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

eval "$(starship init bash)"
eval "$(zoxide init bash)"

# fnm
export PATH=/home/parry/.fnm:$PATH
export PATH="$HOME/.local/bin:$PATH"
eval "$(fnm env --use-on-cd)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/parry/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/parry/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/parry/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/parry/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# conda config --set auto_activate_base false
# <<< conda initialize <<<

#FLY IO
export FLYCTL_INSTALL="/home/parry/.fly/bin"
export PATH="$FLYCTL_INSTALL:$PATH"
alias fly="flyctl"

#BOB NEOVIM
export BOB_NVIM="/home/parry/.local/share/neovim/bin"
export PATH="$BOB_NVIM:$PATH"
alias nv="nvim"

#NEOVIDE
alias nd="neovide --maximized"

#GH ALIAS
export GH_BASE="https://github.com/Parry-97"

alias lg="lazygit"

#PNPM ALIASES
alias pn="pnpm"

#LARAVEL
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
export LARAVEL_INSTALL="/home/parry/.config/composer/vendor/bin/"
export PATH="$LARAVEL_INSTALL:$PATH"

# pnpm
export PNPM_HOME="/home/parry/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
complete -C /usr/bin/terraform terraform
_zellij() {
	local i cur prev opts cmds
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD - 1]}"
	cmd=""
	opts=""

	for i in ${COMP_WORDS[@]}; do
		case "${i}" in
		"$1")
			cmd="zellij"
			;;
		action)
			cmd+="__action"
			;;
		attach)
			cmd+="__attach"
			;;
		close-pane)
			cmd+="__close__pane"
			;;
		close-tab)
			cmd+="__close__tab"
			;;
		convert-config)
			cmd+="__convert__config"
			;;
		convert-layout)
			cmd+="__convert__layout"
			;;
		convert-theme)
			cmd+="__convert__theme"
			;;
		dump-screen)
			cmd+="__dump__screen"
			;;
		edit)
			cmd+="__edit"
			;;
		edit-scrollback)
			cmd+="__edit__scrollback"
			;;
		focus-next-pane)
			cmd+="__focus__next__pane"
			;;
		focus-previous-pane)
			cmd+="__focus__previous__pane"
			;;
		go-to-next-tab)
			cmd+="__go__to__next__tab"
			;;
		go-to-previous-tab)
			cmd+="__go__to__previous__tab"
			;;
		go-to-tab)
			cmd+="__go__to__tab"
			;;
		go-to-tab-name)
			cmd+="__go__to__tab__name"
			;;
		half-page-scroll-down)
			cmd+="__half__page__scroll__down"
			;;
		half-page-scroll-up)
			cmd+="__half__page__scroll__up"
			;;
		help)
			cmd+="__help"
			;;
		kill-all-sessions)
			cmd+="__kill__all__sessions"
			;;
		kill-session)
			cmd+="__kill__session"
			;;
		list-sessions)
			cmd+="__list__sessions"
			;;
		move-focus)
			cmd+="__move__focus"
			;;
		move-focus-or-tab)
			cmd+="__move__focus__or__tab"
			;;
		move-pane)
			cmd+="__move__pane"
			;;
		move-pane-backwards)
			cmd+="__move__pane__backwards"
			;;
		new-pane)
			cmd+="__new__pane"
			;;
		new-tab)
			cmd+="__new__tab"
			;;
		next-swap-layout)
			cmd+="__next__swap__layout"
			;;
		options)
			cmd+="__options"
			;;
		page-scroll-down)
			cmd+="__page__scroll__down"
			;;
		page-scroll-up)
			cmd+="__page__scroll__up"
			;;
		previous-swap-layout)
			cmd+="__previous__swap__layout"
			;;
		query-tab-names)
			cmd+="__query__tab__names"
			;;
		rename-pane)
			cmd+="__rename__pane"
			;;
		rename-tab)
			cmd+="__rename__tab"
			;;
		resize)
			cmd+="__resize"
			;;
		run)
			cmd+="__run"
			;;
		scroll-down)
			cmd+="__scroll__down"
			;;
		scroll-to-bottom)
			cmd+="__scroll__to__bottom"
			;;
		scroll-to-top)
			cmd+="__scroll__to__top"
			;;
		scroll-up)
			cmd+="__scroll__up"
			;;
		setup)
			cmd+="__setup"
			;;
		switch-mode)
			cmd+="__switch__mode"
			;;
		toggle-active-sync-tab)
			cmd+="__toggle__active__sync__tab"
			;;
		toggle-floating-panes)
			cmd+="__toggle__floating__panes"
			;;
		toggle-fullscreen)
			cmd+="__toggle__fullscreen"
			;;
		toggle-pane-embed-or-floating)
			cmd+="__toggle__pane__embed__or__floating"
			;;
		toggle-pane-frames)
			cmd+="__toggle__pane__frames"
			;;
		undo-rename-pane)
			cmd+="__undo__rename__pane"
			;;
		undo-rename-tab)
			cmd+="__undo__rename__tab"
			;;
		write)
			cmd+="__write"
			;;
		write-chars)
			cmd+="__write__chars"
			;;
		*) ;;
		esac
	done

	case "${cmd}" in
	zellij)
		opts="-h -V -s -l -c -d --help --version --max-panes --data-dir --server --session --layout --config --config-dir --debug options setup list-sessions attach kill-session kill-all-sessions action run edit convert-config convert-layout convert-theme help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--max-panes)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--data-dir)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--server)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--session)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-s)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--layout)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-l)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--config)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-c)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--config-dir)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action)
		opts="-h --help write write-chars resize focus-next-pane focus-previous-pane move-focus move-focus-or-tab move-pane move-pane-backwards dump-screen edit-scrollback scroll-up scroll-down scroll-to-bottom scroll-to-top page-scroll-up page-scroll-down half-page-scroll-up half-page-scroll-down toggle-fullscreen toggle-pane-frames toggle-active-sync-tab new-pane edit switch-mode toggle-pane-embed-or-floating toggle-floating-panes close-pane rename-pane undo-rename-pane go-to-next-tab go-to-previous-tab close-tab go-to-tab go-to-tab-name rename-tab undo-rename-tab new-tab previous-swap-layout next-swap-layout query-tab-names help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__close__pane)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__close__tab)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__dump__screen)
		opts="-f -h --full --help <PATH>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__edit)
		opts="-d -l -f -h --direction --line-number --floating --cwd --help <FILE>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--direction)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-d)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--line-number)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-l)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--cwd)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__edit__scrollback)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__focus__next__pane)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__focus__previous__pane)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__go__to__next__tab)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__go__to__previous__tab)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__go__to__tab)
		opts="-h --help <INDEX>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__go__to__tab__name)
		opts="-c -h --create --help <NAME>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__half__page__scroll__down)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__half__page__scroll__up)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__help)
		opts="<SUBCOMMAND>..."
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__move__focus)
		opts="-h --help <DIRECTION>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__move__focus__or__tab)
		opts="-h --help <DIRECTION>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__move__pane)
		opts="-h --help <DIRECTION>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__move__pane__backwards)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__new__pane)
		opts="-d -f -n -c -s -h --direction --cwd --floating --name --close-on-exit --start-suspended --help <COMMAND>..."
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--direction)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-d)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--cwd)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--name)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-n)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__new__tab)
		opts="-l -n -c -h --layout --layout-dir --name --cwd --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--layout)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-l)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--layout-dir)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--name)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-n)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--cwd)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-c)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__next__swap__layout)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__page__scroll__down)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__page__scroll__up)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__previous__swap__layout)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__query__tab__names)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__rename__pane)
		opts="-h --help <NAME>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__rename__tab)
		opts="-h --help <NAME>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__resize)
		opts="-h --help <RESIZE> <DIRECTION>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__scroll__down)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__scroll__to__bottom)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__scroll__to__top)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__scroll__up)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__switch__mode)
		opts="-h --help <INPUT_MODE>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__toggle__active__sync__tab)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__toggle__floating__panes)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__toggle__fullscreen)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__toggle__pane__embed__or__floating)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__toggle__pane__frames)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__undo__rename__pane)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__undo__rename__tab)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__write)
		opts="-h --help <BYTES>..."
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__action__write__chars)
		opts="-h --help <CHARS>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__attach)
		opts="-c -h --create --index --help <SESSION_NAME> options help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--index)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__attach__help)
		opts="<SUBCOMMAND>..."
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__attach__options)
		opts="-h --disable-mouse-mode --no-pane-frames --simplified-ui --theme --default-mode --default-shell --default-layout --layout-dir --theme-dir --mouse-mode --pane-frames --mirror-session --on-force-close --scroll-buffer-size --copy-command --copy-clipboard --copy-on-select --scrollback-editor --session-name --attach-to-session --auto-layout --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--simplified-ui)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--theme)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--default-mode)
			COMPREPLY=($(compgen -W "normal locked resize pane tab scroll enter-search search rename-tab rename-pane session move prompt tmux" -- "${cur}"))
			return 0
			;;
		--default-shell)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--default-layout)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--layout-dir)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--theme-dir)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--mouse-mode)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--pane-frames)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--mirror-session)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--on-force-close)
			COMPREPLY=($(compgen -W "quit detach" -- "${cur}"))
			return 0
			;;
		--scroll-buffer-size)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--copy-command)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--copy-clipboard)
			COMPREPLY=($(compgen -W "system primary" -- "${cur}"))
			return 0
			;;
		--copy-on-select)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--scrollback-editor)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--session-name)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--attach-to-session)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--auto-layout)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__convert__config)
		opts="-h --help <OLD_CONFIG_FILE>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__convert__layout)
		opts="-h --help <OLD_LAYOUT_FILE>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__convert__theme)
		opts="-h --help <OLD_THEME_FILE>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__edit)
		opts="-l -d -f -h --line-number --direction --floating --cwd --help <FILE>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--line-number)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-l)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--direction)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-d)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--cwd)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__help)
		opts="<SUBCOMMAND>..."
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__kill__all__sessions)
		opts="-y -h --yes --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__kill__session)
		opts="-h --help <TARGET_SESSION>"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__list__sessions)
		opts="-h --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__options)
		opts="-h --disable-mouse-mode --no-pane-frames --simplified-ui --theme --default-mode --default-shell --default-layout --layout-dir --theme-dir --mouse-mode --pane-frames --mirror-session --on-force-close --scroll-buffer-size --copy-command --copy-clipboard --copy-on-select --scrollback-editor --session-name --attach-to-session --auto-layout --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--simplified-ui)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--theme)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--default-mode)
			COMPREPLY=($(compgen -W "normal locked resize pane tab scroll enter-search search rename-tab rename-pane session move prompt tmux" -- "${cur}"))
			return 0
			;;
		--default-shell)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--default-layout)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--layout-dir)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--theme-dir)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--mouse-mode)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--pane-frames)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--mirror-session)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--on-force-close)
			COMPREPLY=($(compgen -W "quit detach" -- "${cur}"))
			return 0
			;;
		--scroll-buffer-size)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--copy-command)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--copy-clipboard)
			COMPREPLY=($(compgen -W "system primary" -- "${cur}"))
			return 0
			;;
		--copy-on-select)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--scrollback-editor)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--session-name)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--attach-to-session)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		--auto-layout)
			COMPREPLY=($(compgen -W "true false" -- "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__run)
		opts="-d -f -n -c -s -h --direction --cwd --floating --name --close-on-exit --start-suspended --help <COMMAND>..."
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--direction)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-d)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--cwd)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--name)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		-n)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	zellij__setup)
		opts="-h --dump-config --clean --check --dump-layout --dump-swap-layout --dump-plugins --generate-completion --generate-auto-start --help"
		if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
			COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
			return 0
		fi
		case "${prev}" in
		--dump-layout)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--dump-swap-layout)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--dump-plugins)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--generate-completion)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		--generate-auto-start)
			COMPREPLY=($(compgen -f "${cur}"))
			return 0
			;;
		*)
			COMPREPLY=()
			;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
		return 0
		;;
	esac
}

complete -F _zellij -o bashdefault -o default zellij
function zlr() { zellij run --name "$*" -- bash -ic "$*"; }
function zrf() { zellij run --name "$*" --floating -- bash -ic "$*"; }
function ze() { zellij edit "$*"; }
function zef() { zellij edit --floating "$*"; }
_fnm() {
    local i cur prev opts cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${i}" in
            "$1")
                cmd="fnm"
                ;;
            alias)
                cmd+="__alias"
                ;;
            completions)
                cmd+="__completions"
                ;;
            current)
                cmd+="__current"
                ;;
            default)
                cmd+="__default"
                ;;
            env)
                cmd+="__env"
                ;;
            exec)
                cmd+="__exec"
                ;;
            install)
                cmd+="__install"
                ;;
            list)
                cmd+="__list"
                ;;
            list-remote)
                cmd+="__list__remote"
                ;;
            unalias)
                cmd+="__unalias"
                ;;
            uninstall)
                cmd+="__uninstall"
                ;;
            use)
                cmd+="__use"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        fnm)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        alias)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        completions)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        current)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        default)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        env)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        exec)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        install)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        list)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        list__remote)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        unalias)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uninstall)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        use)
            opts="--help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy list-remote list install use env completions alias unalias default current exec uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet info all error" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

complete -F _fnm -o bashdefault -o default fnm
