function cfp
    # Copy file/dir path
    readlink -f "$argv[1]" | wl-copy
end
