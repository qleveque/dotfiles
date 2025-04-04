def r(pattern, n='1'):
    """find pattern and return n lines"""
    return rf"maJ\eb?{pattern}\nmm{RESET}'a|m^Phead -n {n}|{REMOVE_COLORS}"


RESET = r'/\ek\ek\n'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[[0-9;]*[mGK]//g'"
NA = 'noaction'
RUN = 'xargs bash -c '
CUT = "cut -d' ' -f"

COMMIT = r'\^commit \\w{40}'
STASH = r'\^stash@\\{[0-9]\+\\}: '
REFLOG = r'\^\\w{6} (\\(.*\\) )?HEAD@\\{[0-9]\+\\}: '
GRAPH_COMMIT = r'\^([\\|\\*] )+\\w{6} '
ANY_COMMIT = f"{COMMIT}|{STASH}|{REFLOG}|{GRAPH_COMMIT}"

print(rf'''#env
LESS = -irR --mouse --wheel-lines=1 +k
#command
gg goto-line
G goto-end \e\40
o back-screen-force
zz back-scroll
j forw-line-force
^a {NA} mm|m^P{REMOVE_COLORS}|nvim -c 'syn off' -c 'set ls=0' -c 'set nonu'\n
yy {NA} ma|a^Phead -1|{REMOVE_COLORS}|cb copy\n
# Git
l {NA} {r(ANY_COMMIT)}|git_wrap log-commit\n
gd {NA} {r(COMMIT, '-0')}|git_wrap log-diff\n
yc {NA} {r(ANY_COMMIT)}|git_wrap log-commit -c\n
yf {NA} {r(COMMIT, '-0')}|git_wrap log-diff -c\n
c {NA} J/{COMMIT}\nma{RESET}'a
C {NA} \eb?{COMMIT}\nma{RESET}'a
''')
