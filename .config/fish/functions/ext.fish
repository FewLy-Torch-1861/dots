function ext
    # auto detect file and extract it using atool
    if test (count $argv) -ne 1
        echo "Usage: ext <archive_file>"
        return 1
    end

    if not type -q atool
        echo "atool is not installed. Please install it with 'sudo pacman -S atool'."
        return 1
    end

    atool -x $argv[1]
end
