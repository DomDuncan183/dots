#!/usr/bin/bash

usage() {
    echo -e "usage: install.sh <window manager>\n
    base\n
    bspwm
    awesome
    dwm\n
    sway
    hyprland
    dwl\n"
}

install_yay() {
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
}

install_dwl() {
    cd build/arch/dwl
    makepkg -sic
}

install_dwm() {
    cd build/arch/dwm
    makepkg -sic
}

check_package() {
    bin="pacman" # default cmd
    case $1 in
        local)
            cmd="-Qi"
            ;;
        repo)
            cmd="-Si"
            ;;
        aur)
            bin="yay"
            cmd="-Si"
    esac

    $bin $cmd $2 &> /dev/null
    return $?
}

## copies user and system configs
copy_configs() {
    local desktop=$1
    local wm=$2

    ## copy config dirs
    local dirs
    local make_exec
    case $wm in
        bspwm)
            dirs=("bspwm" "sxhkd" "alacritty" "polybar" "rofi" "feh" "flameshot" "wallpapers")
            ;;
        awesome)
            dirs=("awesome" "alacritty" "rofi" "feh" "flameshot" "wallpapers")
            ;;
        hyprland)
            dirs=("hypr" "waybar")
            ;;
        sway)
            dirs=("sway" "waybar")
    esac
    for i in ${dirs[@]}; do
        if ! [[ -d ~/.config/$i/ ]]; then
            cp -r $i ~/.config/
        fi
    done

    ## modify pacman.conf
    if ! grep -qx 'ParallelDownloads = 8' /etc/pacman.conf; then
        sudo sed -i '/Color/s/^#//;
        /ParallelDownloads/s/^#//;
        /ParallelDownloads/s/5/8/' \
            /etc/pacman.conf
    fi

    ## install nvidia configs
    if check_package local nvidia; then
        if ! [[ -f /etc/pacman.d/hooks/nvidia.hook ]]; then
            sudo cp misc/nvidia.hook /etc/pacman.d/hooks/
        fi
        if ! grep -q nvidia /etc/mkinitcpio.conf; then
            sudo sed -i '/MODULES/s/)/ nvidia nvidia_modeset \
                nvidia_uvm nvidia_drm)/' mkinitcpio.conf
        fi
        #if grep -q kms /etc/mkinitcpio.conf; then
        #    sudo sed -i 's/kms// /etc/mkinitcpio.conf'
        #fi
        if ! grep -qr 'modeset.*fbdev\|fbdev.*modeset' /boot/loader/entries/*; then
            echo "options modeset=1 fbdev=1" | sudo tee -a /boot/loader/entries/*
        fi
    fi

    ## stop mouse mouse acceleration
    if check_package local xorg-server; then
        if ! [[ -f /etc/X11/xorg.conf.d/50-mouse-acceleration.conf ]]; then
            sudo cp misc/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
        fi
    fi

    if check_package local vim; then
        if ! [[ -d ~/.vim ]]; then
            cp -r vim ~/.vim/
        fi
    fi

    ## copy interactive shell configs
    if [[ $SHELL != "/usr/bin/zsh" ]]; then
        cp .zshrc ~/
        cp -r lf ~/.config/
        mkdir ~/.config/zsh
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            ~/.config/zsh/zsh-autosuggestions/
        git clone https://github.com/zsh-users/zsh-syntax-highlighting \
            ~/.config/zsh/zsh-syntax-highlighting/
        chsh -s /usr/bin/zsh
    fi

    if [[ $desktop == 0 ]]; then
        sudo systemctl enable tlp --now
    fi
}

## downloads and install packages
## from pacman/yay/makepkg
install() {
    if [[ $1 == "dwm" ]]; then
        install_dwm
    fi
    if [[ $1 == "dwl" ]]; then
        install_dwl
    fi

    local pkg_list=${@:2}
    local official=()
    local aur=()
    for i in ${pkg_list[@]}; do
        if check_package local $i; then
            echo "$i is installed"

        elif check_package repo $i; then
            echo "found $i in the repos"
            official+="$i "

        else
            if ! command -v yay &> /dev/null; then install_yay; fi
            if check_package aur $i; then
                echo "found $i in the aur"
                aur+="$i "
            else
                echo "$i does not exist. Skipping..."
            fi
        fi
    done

    if [[ ${#official[@]} > 0 ]]; then
        echo "installing: ${official[@]}from official repos"
        sudo pacman -Syu $official
    fi
    if [[ ${#aur[@]} > 0 ]]; then
        echo "installing: ${aur[@]}from the aur"
        yay -S $aur
    fi
}

get_list() {
    local desktop=$1
    local wm=$2

    local pkg_list=($desktop $wm)
    if ls /sys/class/backlight/* 1> /dev/null 2>&1; then
        desktop=0
        $pkg_list+=" brightnessctl tlp"
    fi

    pkg_list+=( "zsh" "starship" "lf" "tmux" "neovim" "noto-fonts" \
        "noto-fonts-cjk" "ttf-noto-nerd" "xdg-desktop-portal" "xdg-desktop-portal-gtk")

    local xorg=("xclip" "flameshot")
    local wayland=("wl-clipboard" "grim" "slurp")
    case $wm in
        bspwm)
            pkg_list+=" ${xorg[@]}"
            pkg_list+=("bspwm" "sxhkd" "polybar" "alacritty" "picom" "feh" \
                "rofi" "lightdm" "lightdm-gtk-greeter")
            ;;
        awesome)
            pkg_list+=" ${xorg[@]}"
            pkg_list+=("awesome" "lightdm" "lightdm-gtk-greeter" "picom" \
                "alacritty" "feh" "rofi")
            ;;
        hyprland)
            pkg_list+=" ${wayland[@]}"
            pkg_list+=("hyprland" "hyprpaper" "greetd" "greetd-gtkgreet" \
                "foot" "waybar" "tofi" "jq")
            ;;
        sway)
            pkg_list+=" ${wayland[@]}"
            pkg_list+=("sway" "swaybg" "greetd" "greetd-gtkgreet" "foot" \
                "waybar" "tofi")
    esac

    echo ${pkg_list[@]}
}

main() {
    local desktop=1
    local wm=$1

    if [[ -z $1 ]]; then usage; exit 1; fi
    list=$(get_list $desktop $wm)

    echo "*****Add any extra packages or leave blank*****"
    read extra
    if ! [[ -z $extra ]]; then
        list+=" ${extra[@]}"
    fi

    install ${list[@]}
    copy_configs $desktop $wm
}

main $@
