def r(pattern, n=1):
    """find pattern and return n lines"""
    return rf"maJ/{pattern}\nNmm{RESET}'a|mhead -{n}|{REMOVE_COLORS}"


RESET = r'/\ek\ek\n'
REMOVE_COLORS = r"sed -r 's/\\x1B\\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g'"
NA = 'noaction'
RUN = 'xargs bash -c '
CUT = "cut -d' ' -f"

COMMIT = r'\^commit \\w{40}'
READ_COMMIT = f"{r(COMMIT)}|{CUT}2"
IDX = r'\^index \\S*\\w{7}\\.\\.\\w{7}'
READ_IDX_FILE = fr"{r(IDX, 3)}|grep -v ' /'|cut -c7-|{RUN}'echo $0 ${{@:$\#}}'"

print(rf'''#env
LESS = -irFRX --mouse --wheel-lines=1
#command
gg goto-line
# Git
gc {NA} {READ_COMMIT}|{RUN}'new -c "tig show $0"'\n
gd {NA} {READ_IDX_FILE}|{RUN}'new -c "FILE=\\"$PWD/$1\\" git difftool $0"'\n
yc {NA} {READ_COMMIT}|c\n
yf {NA} {READ_IDX_FILE}|{CUT}2|c\n
]c {NA} J/{COMMIT}\nma{RESET}'a
[c {NA} /{COMMIT}\nNma{RESET}'a
]f {NA} J/{IDX}\nma{RESET}'a
[f {NA} /{IDX}\nNma{RESET}'a''')
