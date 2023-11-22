#!/usr/bin/bash

wm=
laptop=
server=
nvidia=
pkg_list=()

usage() {
    echo -e "usage: install.sh <window manager>\n
    1. base\n
    2. bspwm
    3. awesome
    4. dwm\n
    5. sway
    6. hyprland
    7. dwl\n"
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
    bin="pacman"
    case $1 in
        installed)
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
    local dirs=("lf" "xdg-desktop-portal" "wallpapers")
    case $wm in
        bspwm)
            dirs+=("bspwm" "sxhkd" "alacritty" "polybar" "rofi" "feh" "flameshot")
            ;;
        awesome)
            dirs+=("awesome" "alacritty" "rofi" "feh" "flameshot")
            ;;
        hyprland)
            dirs+=("hypr" "waybar")
            ;;
        sway)
            dirs+=("sway" "waybar")
    esac
    for i in ${dirs[@]}; do
        if ! [[ -d ~/.config/$i/ ]]; then
            cp -r $i ~/.config/
        fi
    done

    ## install nvidia configs
    if check_package installed nvidia; then
        if ! [[ -d /etc/pacman.d/hooks ]]; then
            sudo mkdir /etc/pacman.d/hooks
        fi
        if ! [[ -f /etc/pacman.d/hooks/nvidia.hook ]]; then
            sudo cp misc/nvidia.hook /etc/pacman.d/hooks/
        fi

        if ! grep -q nvidia /etc/mkinitcpio.conf; then
            sudo sed -i '/MODULES/s/)/ nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
	    sudo mkinitcpio -P
        fi

        if grep -q kms /etc/mkinitcpio.conf; then
            sudo sed -i 's/kms// /etc/mkinitcpio.conf'
        fi

        if ! grep -qr 'modeset.*fbdev\|fbdev.*modeset' /boot/loader/entries/*; then
            echo "options modeset=1 fbdev=1" | sudo tee -a /boot/loader/entries/*
        fi
    fi

    ## stop mouse mouse acceleration
    if [[ $server == "xorg" ]]; then
        if ! [[ -d /etc/X11/xorg.conf.d/50-mouse-acceleration.conf ]]; then
            sudo mkdir -p /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
            if ! [[ -f /etc/X11/xorg.conf.d/50-mouse-acceleration.conf ]]; then
                sudo cp misc/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
            fi
        fi
    fi

    if check_package installed vim; then
        if ! [[ -d ~/.vim ]]; then
            cp -r vim ~/.vim/
        fi
    fi

    ## copy interactive shell configs
    if [[ $SHELL != "/usr/bin/zsh" ]]; then
        cp zshrc ~/.zshrc
        cp zshenv ~/.zshenv
        mkdir -p ~/.config/zsh
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
    ## makes pacman faster
    if ! grep -qx 'ParallelDownloads = 8' /etc/pacman.conf; then
        sudo sed -i '/Color/s/^#//;
        /ParallelDownloads/s/^#//;
        /ParallelDownloads/s/5/8/' \
            /etc/pacman.conf
    fi

    if [[ $wm == "dwm" ]]; then
        install_dwm
    fi
    if [[ $wm == "dwl" ]]; then
        install_dwl
    fi

    local official=()
    local aur=()
    for i in ${pkg_list[@]}; do
        if check_package installed $i; then
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
        echo -e "\ninstalling from official repos:"
        for i in ${official[@]}; do
            echo $i
        done
        sudo pacman -Syu $official
    fi
    if [[ ${#aur[@]} > 0 ]]; then
        echo -e "\ninstalling from the aur:"
        for i in ${aur[@]}; do
            echo $i
        done
        yay -S $aur
    fi
}

make_list() {
    if lspci -k | grep nvidia &> /dev/null; then
        nvidia=1;
        pkg_list+=("nvidia" "nvidia-settings")
    fi

    if ls /sys/class/backlight/* &> /dev/null; then
        laptop=1
        pkg_list+=("brightnessctl" "tlp")
    fi

    pkg_list+=( "zsh" "starship" "lf" "tmux" "neovim" "noto-fonts" \
        "noto-fonts-cjk" "ttf-noto-nerd" "xdg-desktop-portal" \
        "xdg-desktop-portal-gtk" "flatpak")

    local xorg=("xorg-xrandr" "xclip" "flameshot")
    local wayland=("wl-clipboard" "grim" "slurp")
    case $wm in
        bspwm)
            server="xorg"
            pkg_list+=("${xorg[@]}" "bspwm" "sxhkd" "polybar" "alacritty" \
                "picom" "feh" "rofi" "lightdm" "lightdm-gtk-greeter")
            ;;
        awesome)
            server="xorg"
            pkg_list+=("${xorg[@]}" "awesome" "lightdm" "lightdm-gtk-greeter" \
                "picom" "alacritty" "feh" "rofi")
            ;;
        hyprland)
            if [[ $nvidia == 1 ]]; then
                echo "nvidia is not compatable with wayland"
                exit 1
            fi
            server="wayland"
            pkg_list+=("${wayland[@]}" "hyprland" "hyprpaper" "greetd" \
                "greetd-gtkgreet" "foot" "waybar" "tofi" "jq")
            ;;
        sway)
            if [[ $nvidia == 1 ]]; then
                echo "nvidia is not compatable with wayland"
                exit 1
            fi
            server="wayland"
            pkg_list+=("${wayland[@]}" "sway" "swaybg" "greetd" \
                "greetd-gtkgreet" "foot" "waybar" "tofi")
            ;;
        base)
            ;;
        *)
            echo -e "*****Not a valid window manager*****\n"
            usage
            exit 1
    esac

    echo "*****Add any extra packages or leave blank*****"
    read extra
    if ! [[ -z $extra ]]; then
        pkg_list+=" ${extra[@]}"
    fi
}

main() {
    sudo -v; if [[ $? != 0 ]]; then exit 1; fi
    if [[ -z $1 ]]; then usage; exit 1; fi
    wm=$1

    make_list
    install
    copy_configs
}

main $@
