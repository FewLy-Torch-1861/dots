function gc
    # clone + cd
    if test (count $argv) -ge 2
        set repo $argv[2]
    else
        set repo (basename (string replace -r '\.git$' '' $argv[1]))
    end

    git clone $argv[1] $repo
    cd $repo
end
