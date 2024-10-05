lfcd() {
    z "$(\lf -print-last-dir "$@")" 
}

cdls() {
    z "$@" && eza -1F --sort=type --color=always --icons=always; 
}

mkday() {
    name=$(date +'%Y-%m-%d')
    mkdir $name
    cd $name
}
