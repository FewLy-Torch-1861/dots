function dotstat
    dot config status.showUntrackedFiles yes
    dot status
    dot config status.showUntrackedFiles no
end
