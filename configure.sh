#!/bin/bash

pull-config-files(){

    mkdir -p $HOME/.scripts/statusbar
    git clone https://github.com/mohamedrezk122/dot-files  $HOME/.scripts/dot-files

    declare -a files=("i3" "i3blocks" "zathura" "micro" "dunst")
    for file in "${files[@]}"; do
        cp -r $HOME/.scripts/dot-files/$file $HOME/.config/
    done

    declare -a files=(".bashrc" ".bash_aliases" ".xscreensaver" ".xinitrc" ".xprofile")
    for file in "${files[@]}"; do
        cp $HOME/.scripts/dot-files/$file $HOME/
    done

    git clone https://github.com/mohamedrezk122/i3blocks-statusbar-scripts $HOME/.scripts/statusbar
}

install-suckless-utilities(){
    cp -r dot-files/suckless . 
    make -f $HOME/.scripts/suckless/st/Makefile
    sudo make install -f $HOME/.scripts/suckless/st/Makefile

    declare -a progs=("st" "dmenu" "sxiv")
    for prog in "${progs[@]}"; do
        make -f $HOME/.scripts/suckless/$prog/Makefile
        sudo make install -f $HOME/.scripts/suckless/$prog/Makefile
    done
}
configure-zsh(){
    # install oh-my-zsh 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # change default shell to zsh 
    sudo chsh -s /bin/zsh
    # change dot dir to .config/zsh
    echo "export ZDOTDIR=$HOME/.config/zsh/" > $HOME/$USER/.zshenv
    mkdir -p $HOME/.config/zsh/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions     $HOME/.config/zsh/plugins
    cp $HOME/.scripts/dot-files/zsh/.zshrc  $HOME/.config/zsh/
}


pull-config-files
install-suckless-utilities
configure-zsh
