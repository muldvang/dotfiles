# Git settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold


# Left prompt customization
function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  # PWD
  set_color $fish_color_cwd
  # echo -n (prompt_pwd)
  # echo -n (pwd|sed "s=$HOME=~=")
  echo -n (pwd | sed -e "s,^$HOME,~," -e "s%^.*/\(.*/.*/.*\)%\1%")
  set_color normal

  printf '%s' (__fish_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '> '
end

# Left prompt customization
function fish_right_prompt -d "Write out the right prompt"
  set_color red
  echo $USER
  set_color normal
  echo '@'
  set_color blue
  hostname
  set_color normal
end

# Aliases
function l
         ls $argv
end

function e
         emacsclient -c -t $argv
end

function r
         trash-put $argv
end

# function mv
#          mv -i $argv
# end

# function cp
#          cp -i $argv
# end

function diff
         colordiff $argv
end

function gs
         git status $argv
end

function ga
         git add $argv
end

function gc
         git commit $argv
end

function gf
         git fetch $argv
end

function gr
         git rebase $argv
end

function gp
         git push $argv
end

function gd
         git diff $argv
end

# function calc
#          calc -d $argv
# end


# Ring the bell when alert is called. This makes urxvt urgent, and awesome wm
# will display it in a different color if it unfocused.
function alert --description 'Make the terminal urgent'
  echo -e \\7
end

# Termites terminfo file misses some color escape sequences. Fix that
# by using xterms terminfo file instead.
set -x TERM xterm-256color

# 80 column width for man pages
set -x MANWIDTH 80

# Disable the greeting
set fish_greeting ""