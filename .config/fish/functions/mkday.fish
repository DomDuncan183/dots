function mkday
    set name $(date +'%Y-%m-%d')
    mkdir $name && cd $name
end
