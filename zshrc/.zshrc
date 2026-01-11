alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias ber="bundle exec rails"
alias bert="bundle exec rails test"
alias console="bundle exec rails console"
alias migrate="bundle exec rails db:migrate"
alias rollback="bundle exec rails db:rollback"
alias preptest="bundle exec rake db:test:prepare && RAILS_ENV=test bundle exec rake db:test:parallel:prepare"
alias testsuite="RAILS_ENV=test bundle exec rake test:parallel | tee testrun.log"
alias server="bundle exec rails server -p 4535 -b 0.0.0.0"
alias dbconsole="bundle exec rails dbconsole"
alias p3="python3"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

bindkey -e
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# bun completions
[ -s "/Users/zcroft/.bun/_bun" ] && source "/Users/zcroft/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
