function mkreport
    set name $(date +'%Y-%m-%d')
    cp "$HOME/.local/repos/dots/misc/template_report.tex" "$name.tex"
end
