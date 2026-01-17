zoxide init fish | source
source (/usr/bin/starship init fish --print-full-init | psub)

# ── Aliases & Abbr ─────────────────────
# Core shortcuts
alias c clear
alias q exit
alias reload 'exec fish'
alias t tmux
alias ff fastfetch
alias hf hyfetch

abbr --add chafa 'chafa -f symbols'

# Dotfiles
alias dot "git --git-dir $HOME/.dots/ --work-tree $HOME"
alias ld "lazygit --git-dir $HOME/.dots/ --work-tree $HOME"

alias dotstat "dot config status.showUntrackedFiles yes && dot status && dot config status.showUntrackedFiles no"

# LLMs
alias gem gemini
alias olm ollama

# Dev
alias v nvim

alias cg cargo
alias cgr 'cargo run --'

alias py python

alias dk docker
alias ldk lazydocker
alias dkc 'docker compose'
alias dkps 'docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"'

# Git
alias g git
alias lg lazygit
alias gst 'git status'
alias ga 'git add'
alias gp 'git push'
alias gl 'git pull'

# Search & Files
abbr --add ffind 'fd --type f'
alias f fzf
alias ct 'bat -Pp'
alias rg 'rg --color=always'
alias grep 'grep --color=auto'
alias op 'xdg-open (yc)'

# LS family (using eza)
alias ls 'eza --group-directories-first --icons'
alias l 'ls -lAh'
alias la 'ls -Ah'
abbr --add te 'ls -T --level=2'
abbr --add tea 'ls -AhT --level=2'

# System maintenance
alias clnt 'rm -rf ~/.local/share/Trash/files/*'

abbr --add updmirror 'sudo reflector --country Thailand,Singapore --latest 10 --sort rate --save /etc/pacman.d/mirrorlist && yay -Syy'
abbr --add clnlog 'sudo journalctl --vacuum-time=7d'
abbr --add lpkg 'yay -Q | fzf -e'
abbr --add lupkg 'yay -Qet | fzf -e'
abbr --add clnpkg 'yay -Rns (yay -Qtdq)'
abbr --add rmpkg 'yay -Rns (yay -Qetq | fzf -e)'

alias ded 'find . -type d -empty -delete'
alias def 'find . -type f -empty -delete'
alias dbl 'find . -xtype l -delete'


# ── Functions ──────────────────────────

function cfp
    # Copy file/dir path
    readlink -f "$argv[1]" | wl-copy
end

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

function md
    for arg in $argv
        mkdir -pv "$arg"
    end
end

function mf
    for arg in $argv
        mkdir -pv (dirname "$arg")
        touch "$arg"
    end
end

function r
    for arg in $argv
        gio trash $arg
    end
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
