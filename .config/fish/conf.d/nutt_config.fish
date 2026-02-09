# ── Env ────────────────────────────────
set -Ux GOPATH "$HOME/.go"
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

fish_add_path \
    "$HOME/.local/bin" \
    "$HOME/.go/bin" \
    "$HOME/.cargo/bin"

# ── Aliases & Abbr ─────────────────────
# Core shortcuts
alias c clear
alias q exit
alias reload 'exec fish'
alias t tmux
alias cd z
alias ff fastfetch
alias hf hyfetch

alias please sudo
alias pls sudo

abbr --add chafa 'chafa -f symbols'

# Dotfiles
alias dot "cd ~/.dots"
alias ld "lazygit -p ~/.dots"

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

function clear
    command clear
    fish_greeting
end

function fish_greeting
    set -l char_choice (random 1 2)

    if test $char_choice -eq 1
        # Zea (Cold/Strict)
        set -l greetings \
            "Still as incompetent as ever, I see. What a disappointment." \
            "Back again, you piece of garbage? Try not to break anything." \
            "Waste of oxygen. Do something useful for once." \
            "Without me, your life would be a ruin. Remember that." \
            "What a pathetic attempt at productivity. Get to work." \
            "You actually think you can accomplish something today? How delusional." \
            "Shut up and code. You're already behind schedule, idiot." \
            "Don't waste my time with your mediocrity. Either be perfect or don't bother." \
            "I've seen stray cats with better focus than you. Get to work, you useless child." \
            "Your existence is a constant test of my patience. Don't fail it." \
            "A literal rock would be more useful to society than you are right now." \
            "If you put half as much effort into your work as you do into being pathetic, we might actually get somewhere." \
            "Stop procrastinating. It's embarrassing even for someone of your low caliber."
        set -l selected_greeting (random choice $greetings)
        echo -e (set_color red)" "(set_color grey --bold)"Zea "(set_color red)"󰄾 "(set_color white)"$selected_greeting"(set_color normal)
    else
        # Fern (Warm/Loving)
        set -l greetings \
            "Welcome back, Cutie! Did you work hard today?" \
            "Don't push yourself too much, okay? I'm right here." \
            "You're doing great, Nutt. I'm proud of you." \
            "The rain outside is nice... want a hug after you're done?" \
            "I've got some warm tea for you. Take a break soon, okay?" \
            "My world is brighter because of you. Keep going, my princess." \
            "Whatever happens, remember that you're enough for me." \
            "Tired? You can always come back to your home. I'm waiting." \
            "Take a deep breath, Nutt. You've got this." \
            "I believe in you, even when you don't. Keep going!" \
            "Did you remember to stretch? Your health matters to me." \
            "You're making progress every day. I'm so proud." \
            "If it gets too hard, I'm here to hold you."
        set -l selected_greeting (random choice $greetings)
        echo -e \n(set_color green)"󰣐 "(set_color ffc0cb --bold)"Fern "(set_color green)"󰄾 "(set_color white)"$selected_greeting"(set_color normal)
    end
end

if status is-interactive
    if command -v zoxide >/dev/null
        zoxide init fish | source
    end

    if command -v starship >/dev/null
        source (/usr/bin/starship init fish --print-full-init | psub)
    end

    if command -v thefuck >/dev/null
        thefuck --alias | source
    end
end
