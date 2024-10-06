function lfcd --wraps="lf"
    cd "$(command lf -print-last-dir $argv)"
end
