RESET_SEARCH = r'mS/^A^A\n\'S\emS'
SAVE = 'mO'
RESTORE = rf'\'O\emO'
NA = 'noaction'

commit_pattern = r'\^commit \\w{40}'
stash_pattern = r'\^stash@\\{[0-9]\+\\}: '
reflog_pattern = r'\^\\w{6} (\\(.*\\) )?HEAD@\\{[0-9]\+\\}: '
graph_pattern = r'\^([\\|\\*] )+\\w{6} '
COMMIT_PATTERN = f"{commit_pattern}|{stash_pattern}|{reflog_pattern}|{graph_pattern}"

remove_colors = r"sed -r 's/\\x1B\\[[0-9;]*[mGK]//g'"
BUFFER = f"|.^P{remove_colors}"
COMMIT = f"{BUFFER}|git_wrap log-commit"
UNTIL_COMMIT_LINE = rf"JK\eb?{COMMIT_PATTERN}\n|O^P{remove_colors}"

print(rf'''#env
LESS = -irR --mouse --wheel-lines=1 +/\^
#line-edit
\e abort
^A up
#command
gg goto-line
G goto-end \e\40
zz back-scroll
j forw-line-force
^a {NA} {BUFFER}|nvim -c 'syn off' -c 'set ls=0' -c 'set nonu'\n
yy {NA} {BUFFER}|head -1|cb copy\n
^q quit
# Git
l {NA} {COMMIT}|xargs gitrs show\n
yc {NA} {COMMIT}|cb copy\n
dd {NA} {COMMIT}|xargs stash drop\n
R {NA} {COMMIT}|xargs -i git rebase -i {{}}\^\n
gd {NA} {SAVE}{UNTIL_COMMIT_LINE}|git_wrap log-diff\n{RESET_SEARCH}{RESTORE}
yf {NA} {SAVE}{UNTIL_COMMIT_LINE}|git_wrap log-diff copy\n{RESET_SEARCH}{RESTORE}
c {NA} J/{COMMIT_PATTERN}\n{RESET_SEARCH}
C {NA} \eb?{COMMIT_PATTERN}\n{RESET_SEARCH}
''')
