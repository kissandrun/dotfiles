# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
  atload"zpcdreplay" wait"1" \
    OMZP::kubectl \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  as"completion" is-snippet \
    https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
    https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/git-flow/git-flow.plugin.zsh
zinit snippet OMZ::plugins/autojump/autojump.plugin.zsh
zinit snippet OMZ::plugins/mvn/mvn.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit snippet OMZ::plugins/tmuxinator/tmuxinator.plugin.zsh
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zinit snippet OMZ::plugins/pip/pip.plugin.zsh

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Gitignore plugin – commands gii and gi
zinit ice wait"2" lucid
zinit load voronkovich/gitignore.plugin.zsh

zinit load djui/alias-tips

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kissandrun/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kissandrun/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kissandrun/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kissandrun/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# PATH
export PATH="/home/kissandrun/node/bin:$PATH"
 
# alias
alias zshconfig="vim ~/.zshrc"
alias i3config="vim ~/dotfiles/.i3/config"
alias vimconfig="vim ~/dotfiles/.vimrc"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
#alias vim=nvim
set bell-style none
alias pls=sudo

#eval $(thefuck --alias)

# env of autojump
#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
#autoload -U compinit && compinit -u
#source /Users/kissandrun/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#export PATH="/Applications/NEURON-7.7/nrn/x86_64/bin":$PATH #added by NEURON installer
#export PYTHONPATH="/Applications/NEURON-7.7/nrn/lib/python":$PYTHONPATH #added by NEURON installer

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export MANPATH=${MANPATH}:/usr/local/texlive/2019/texmf-dist/doc/man
export INFOPATH=${INFOPATH}:/usr/local/texlive/2019/texmf-dist/doc/info
export PATH=${PATH}:/usr/local/texlive/2019/bin/x86_64-linux
export LANG="zh_CN.UTF-8"
export LANGUAGE="zh_CN:zh"
