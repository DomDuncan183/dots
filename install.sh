#!/usr/bin/bash

wm=
laptop=
server=

## universal packages
pkg_list=("zsh" "starship" "eza" "lf" "tmux" "neovim" "noto-fonts" \
    "noto-fonts-cjk" "ttf-noto-nerd" "xdg-desktop-portal" \
    "xdg-desktop-portal-gtk" "flatpak" "pipewire" \
    "pipewire-pulse" "wireplumber" "man-db")

## package names
xorg=("xorg-xrandr" "xclip" "flameshot")
wayland=("wl-clipboard" "grim" "slurp")

bspwm_pkg=("${xorg[@]}" "bspwm" "sxhkd" "polybar" "alacritty" \
    "picom" "feh" "rofi" "lightdm" "lightdm-gtk-greeter")

awesome_pkg=("${xorg[@]}" "awesome" "lightdm" "lightdm-gtk-greeter" \
    "picom" "alacritty" "feh" "rofi")

hyprland_pkg=("${wayland[@]}" "hyprland" "hyprpaper" "greetd" \
    "greetd-gtkgreet" "foot" "waybar" "tofi" "jq")

sway_pkg=("${wayland[@]}" "sway" "swaybg" "greetd" \
    "greetd-gtkgreet" "foot" "waybar" "tofi")

## directory names
dirs=("nvim" "lf" "xdg-desktop-portal" "wallpapers")

bspwm_dirs=("bspwm" "sxhkd" "alacritty" "polybar" "rofi" "picom" "feh" \ 
    "flameshot")

awesome_dirs=("awesome" "alacritty" "rofi" "feh" "flameshot")

hyprland_dirs=("hypr" "waybar" "foot")

sway_dirs=("sway" "waybar" "foot")

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

check_pkg() {
    case $1 in
        local)
            bin="pacman"
            cmd="-Qqi"
            ;;
        aur)
            bin="yay"
            cmd="-Si"
    esac

    $bin $cmd $2 &> /dev/null
    return $?
}

setup_nvidia() {
    if ! [[ -d /etc/pacman.d/hooks ]]; then
        sudo mkdir /etc/pacman.d/hooks
    fi
    if ! [[ -f /etc/pacman.d/hooks/nvidia.hook ]]; then
        sudo cp misc/pacman/nvidia.hook /etc/pacman.d/hooks/
    fi
    if ! grep -q nvidia /etc/mkinitcpio.conf; then
        sudo sed -i '/MODULES/s/)/ nvidia nvidia_modeset nvidia_uvm nvidia_drm )/' /etc/mkinitcpio.conf
        sudo mkinitcpio -P
    fi
    if grep -q kms /etc/mkinitcpio.conf; then
        sudo sed -i 's/kms //' /etc/mkinitcpio.conf
    fi
    if ! [[ -f /etc/modprobe.d/nvidia.conf ]]; then
        sudo cp misc/modprobe/nvidia.conf /etc/modprobe.d/
    fi
}

setup_zsh() {
    cp zshrc ~/.zshrc
    cp zshenv ~/.zshenv
    mkdir -p ~/.config/zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ~/.config/zsh/zsh-autosuggestions/
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        ~/.config/zsh/zsh-syntax-highlighting/
    chsh -s /usr/bin/zsh
}

## copies user and system configs
copy_configs() {
    case $wm in
        bspwm)
            dirs+=(${bspwm_dirs[@]})
            ;;
        awesome)
            dirs+=(${awesome_dirs[@]})
            ;;
        hyprland)
            dirs+=(${hyprland_dirs[@]})
            ;;
        sway)
            dirs+=(${sway_dirs[@]})
    esac
    for i in ${dirs[@]}; do
        if ! [[ -d ~/.config/$i/ ]]; then
            cp -r $i ~/.config/
        fi
    done

    if check_pkg local nvidia; then setup_nvidia; fi
    if [[ $SHELL != "/usr/bin/zsh" ]]; then setup_zsh; fi

    if check_pkg local vim; then
        if ! [[ -d ~/.vim ]]; then cp -r vim ~/.vim/; fi
    fi

    if [[ $desktop == 0 ]]; then
        sudo systemctl enable tlp --now
    fi

    if [[ $server == "xorg" ]]; then
        if ! [[ -d /etc/X11/xorg.conf.d ]]; then
            sudo mkdir /etc/X11/xorg.conf.d/
        fi
        if ! [[ -f /etc/X11/xorg.conf.d/50-mouse-acceleration.conf ]]; then
            sudo cp misc/xorg/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
        fi
    fi

    if check_pkg local rofi; then
        if ! [[ -d ~/.local/share/fonts/ ]]; then
            mkdir -p ~/.local/share/fonts/
        fi
        cp fonts/Icomoon-Feather.ttf ~/.local/share/fonts/
    fi
}

install() {
    if ! grep -qx 'ParallelDownloads = 8' /etc/pacman.conf; then
        sudo sed -i '/Color/s/^#//;
        /ParallelDownloads/s/^#//;
        /ParallelDownloads/s/5/8/' \
            /etc/pacman.conf
    fi

    local installed_list=$(pacman -Qsq)
    local not_installed=$(comm -23 \
        <(printf "%s\n" "${pkg_list[@]}" | sort) \
        <(printf "%s\n" "${installed_list[@]}" | sort))

    if [[ $not_installed == "" ]]; then
        echo -e "\nThere are no packages to install, exiting..."
        exit 0
    fi

    printf "Needs to be installed:\n%s\n \n" "${not_installed[@]}"

    local repo_list=$(pacman -Ssq)
    local in_official=$(comm -12 \
        <(printf "%s\n" "${not_installed[@]}" | sort) \
        <(printf "%s\n" "${repo_list[@]}" | sort))
    local not_in_official=$(comm -23 \
        <(printf "%s\n" "${not_installed[@]}" | sort) \
        <(printf "%s\n" "${repo_list[@]}" | sort))

    local aur_list=()
    if [[ $not_in_official != "" ]]; then
        if ! command -v yay &> /dev/null; then install_yay; fi
        for i in ${not_in_official[@]}; do
            if check_pkg aur $i; then
                echo "found $i in the aur"
                aur_list+=($i)
            else
                echo "$i does not exist. Skipping..."
            fi
        done
    fi

    if [[ ${#in_official[@]} > 0 ]]; then
        printf "\nInstalling from official repos:\n%s\n \n" "${in_official[@]}"
        sudo pacman -Syu ${in_official[*]} --noconfirm
    fi

    if [[ ${#aur_list[@]} > 0 ]]; then
        printf "Installing from aur:\n%s\n \n" "${aur_list[@]}"
        yay -S ${aur_list[*]} --noconfirm
    fi
}

make_list() {
    if lspci | grep NVIDIA &> /dev/null; then
        pkg_list+=("nvidia")
    fi

    if ls /sys/class/backlight/* &> /dev/null; then
        laptop=1
        pkg_list+=("brightnessctl" "tlp")
    fi

    case $wm in
        bspwm)
            pkg_list+=(${bspwm_pkg[@]})
            ;;
        awesome)
            pkg_list+=(${awesome_pkg[@]})
            ;;
        hyprland)
            pkg_list+=(${hyprland_pkg[@]})
            ;;
        sway)
            pkg_list+=(${sway_pkg[@]})
            ;;
        base)
            ;;
        *)
            echo -e "\n*****Not a valid window manager*****\n"
            usage
            exit 1
    esac

    echo "*****Add any extra packages or leave blank*****"
    read extra
    if ! [[ -z $extra ]]; then
        pkg_list+=(${extra[@]})
    fi
}

main() {
    if [[ -z $1 ]]; then usage; exit 1; fi
    sudo -v; if [[ $? != 0 ]]; then exit 1; fi
    wm=$1

    make_list
    install
    copy_configs
}

main $@
