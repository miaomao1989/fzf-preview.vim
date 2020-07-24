export const GIT_ACTIONS = ["status", "branch", "log"] as const
export const GIT_BRANCH_ACTIONS = ["checkout", "diff", "yank"] as const

export const GIT_BRANCH_COMMAND =
  "git for-each-ref refs/heads refs/remotes --color=always --format='%(color:green)[branch]%(color:reset)    %(color:reset)%(HEAD) %(color:magenta)%(refname:short)%(color:reset)    %(color:yellow)%(authordate:short)%(color:reset)    %(color:blue)[%(authorname)]%(color:reset)%09' 2> /dev/null"

export const GIT_BRANCH_PREVIEW_COMMAND =
  "[[ '{2}' != '*' ]] && git log {2} --decorate --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso --graph --color=always || git log {3} --decorate --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso --graph --color=always"

export const GIT_LOG_COMMAND =
  "git log --decorate --color=always --date=iso  --format='%C(green)[commit]%Creset    %C(magenta)%h%Creset    %C(yellow)%ad %x09%Creset    [%C(blue)%an%Creset]    %x09%C(auto)%s'"

export const GIT_LOG_PREVIEW_COMMAND = "git show {2} --color=always"
