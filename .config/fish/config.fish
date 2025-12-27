## ── Global ENVs ──────────────────────────
set -x EDITOR nvim
set -x FZF_DEFAULT_OPTS "\
--layout=reverse \
--border \
--no-preview"

set -x GOPATH $HOME/.go

fish_add_path \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/.spicetify

if status is-interactive
    ## ── Greeting ───────────────────────────
    set fish_greeting

    ## ── Prompt ─────────────────────────────
    zoxide init fish | source
    starship init fish | source

    ## ── Aliases & Abbr ─────────────────────
    # Core shortcuts
    alias c clear
    alias reload 'exec fish'
    alias t tmux
    alias ff fastfetch
    alias hf hyfetch

    abbr --add chafa 'chafa -f symbols'

    # Dev
    alias v nvim
    alias gem gemini

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
    alias dot "git --git-dir=$HOME/.dots/ --work-tree=$HOME"
    alias ld "lazygit --git-dir=$HOME/.dots/ --work-tree=$HOME"
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
    alias md 'mkdir -p'

    # LS family (using eza)
    alias ls 'eza --icons'
    alias l 'ls -lAh'
    alias la 'ls -Ah'
    abbr --add te 'ls -T --level=2'
    abbr --add tea 'ls -AhT --level=2'

    # System maintenance
    alias clnt 'gio trash --empty'

    abbr --add updmirror 'sudo reflector --country Thailand,Singapore,Japan --latest 10 --sort rate --save /etc/pacman.d/mirrorlist && yay -Syy'
    abbr --add clnlog 'sudo journalctl --vacuum-time=7d'
    abbr --add lpkg 'yay -Q | fzf -e'
    abbr --add lupkg 'yay -Qet | fzf -e'
    abbr --add clnpkg 'yay -Rns (yay -Qtdq)'
    abbr --add rmpkg 'yay -Rns (yay -Qetq | fzf -e)'

    alias ded 'find . -type d -empty -delete'
    alias def 'find . -type f -empty -delete'
    alias dbl 'find . -xtype l -delete'
end
