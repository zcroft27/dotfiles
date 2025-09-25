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

giff() {
  git diff master >&$1.diff
}

singletest() {
  ruby -I test $1 -n $2
}
