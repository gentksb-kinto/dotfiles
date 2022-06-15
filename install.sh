#!/usr/bin/env bash
set -xue
sudo apt-get update
sudo apt-get install -y direnv git
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

link_to_homedir() {
  command echo "backup old dotfiles..."

  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

  for dotfile in $script_dir/.??* ; do
    [[ `basename $dotfile` == ".git" ]] && continue
    [[ `basename $dotfile` == ".github" ]] && continue
    [[ `basename $dotfile` == ".devcontainer" ]] && continue
    if [[ -L "$HOME/`basename $dotfile`" ]];then
      command rm -f "$HOME/`basename $dotfile`"
    fi
    if [[ -e "$HOME/`basename $dotfile`" ]];then
      command mv "$HOME/`basename $dotfile`" "$HOME/.dotbackup"
    fi
    command ln -snf $dotfile $HOME
    echo $dotfile
  done
}

link_to_homedir
command echo -e "\e[1;36m Install completed!!!! \e[m"
