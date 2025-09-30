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

just_git_branch() {
  echo $(git symbolic-ref --short HEAD 2>/dev/null)
}

parse_git_branch() {
  gb=$(just_git_branch)
  if [ -z "$gb" ]; then
    echo $gb
  else
    echo " ($gb$(parse_git_tag)) "
  fi
}

parse_git_tag() {
  gt=$(git tag --points-at HEAD)
  if [ -z "$gt" ]; then
    echo $gt
  else
    echo ":$gt"
  fi
}

#shorthand escape characters
open="\[\033[01;38;5;"
close="\[\e[0m\]"

#colors
green="028m\]"
blue="020m\]"

#building out modular pieces
user="${open}${green}\u${close}"
at="${open}${green}@${close}"
host="${open}${green}\h${close}"
current_path="${open}${blue}\w${close}"

export PS1="${user}${at}${host}:${current_path}\$(parse_git_branch)\$ "
