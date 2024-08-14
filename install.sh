#!/bin/bash

wm=""
display_server=""
pkg_list=(
    "stow"
    "openssh"
    "wget"
    "curl"
    "jq"
    "tmux"
    "fd"
    "fzf"
    "lf"
    "bat"
    "eza"
    "zoxide"
    "dust"
    "duf"
    "git-delta"
    "neovim"
    "starship"
    "btop"
    "gping"
    "lazygit"
    "man-db"
    "fastfetch"
    "tldr"
    "zsh"
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "xdg-desktop-portal"
    "xdg-desktop-portal-gtk"
    "flatpak"
    "pipewire"
    "pipewire-pulse"
    "wireplumber"
)

xorg=(
    "xorg-xrandr"
    "xorg-xsetroot"
    "xclip"
    "flameshot"
)

wayland=(
    "wl-clipboard"
    "grim"
    "slurp"
)

bspwm_pkg=(
    "${xorg[@]}"
    "bspwm"
    "sxhkd"
    "polybar"
    "alacritty"
    "picom"
    "feh"
    "rofi"
    "lightdm"
    "lightdm-gtk-greeter"
)

sway_pkg=(
    "${wayland[@]}"
    "sway"
    "swaybg"
    "foot"
    "waybar"
    "xdg-desktop-portal-wlr"
)

lsp_servers=(
    "bash-language-server"
    "clangd"
    "jdtls"
    "lua-language-server"
    "mypy"
    "python-isort"
    "python-black"
    "python-pylint"
    "shfmt"
    "stylua"
)

usage() {
    echo -e "usage: install.sh <window manager>\n
    base (none)
    sway
    bspwm"
}

install_arch() {
    local installed_list
    local not_installed
    local repo_list
    local in_repo

    installed_list=$(pacman -Qsq)
    not_installed=$(comm -23 \
        <(printf "%s\n" "${pkg_list[@]}" | sort) \
        <(printf "%s\n" "${installed_list[@]}" | sort))

    if [[ $not_installed == "" ]]; then
        echo -e "\nThere are no packages to install, exiting..."
        exit 0
    fi

    repo_list=$(pacman -Ssq)
    in_repo=$(comm -12 \
        <(printf "%s\n" "${not_installed[@]}" | sort) \
        <(printf "%s\n" "${repo_list[@]}" | sort))

    printf "\nInstalling from official repos:\n%s\n \n" "${in_repo[@]}"
    sudo pacman -Syu "${in_repo[*]}" --noconfirm
}

make_list() {
    if lspci | grep NVIDIA &>/dev/null; then
        pkg_list+=("nvidia")
    fi

    if ls /sys/class/backlight/* &>/dev/null; then
        # laptop=1
        pkg_list+=("brightnessctl" "tlp")
    fi

    case $wm in
    bspwm)
        pkg_list+=("${bspwm_pkg[@]}")
        ;;
    awesome)
        pkg_list+=("${awesome_pkg[@]}")
        ;;
    hyprland)
        pkg_list+=("${hyprland_pkg[@]}")
        ;;
    sway)
        pkg_list+=("${sway_pkg[@]}")
        ;;
    base) ;;
    *)
        echo -e "\n*****Not a valid window manager*****\n"
        usage
        exit 1
        ;;
    esac

    echo -n "Add any extra packages: "
    read -r extra
    if [[ -n $extra ]]; then
        pkg_list+=("${extra[@]}")
    fi
}

main() {
    wm=$1
    make_list "$wm"

    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        os=${NAME,,}
    else
        echo "os-release does not exist"
        exit 1
    fi

    case "$os" in
    arch*)
        install_arch
        ;;
    debian*)
        echo debian
        ;;
    esac
}

main "$@"
