function mf
    for arg in $argv
        mkdir -pv (dirname "$arg")
        touch "$arg"
    end
end
