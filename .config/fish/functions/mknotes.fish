function mknotes
    set name $(date +'%Y-%m-%d')
    cp "$HOME/.local/repos/dots/misc/template_notes.tex" "$name.tex"
end
