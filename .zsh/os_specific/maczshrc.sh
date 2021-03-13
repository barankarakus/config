# Mac-specific zshrc settings

# brew-installed command-line tools
# ---------------------------------
# MacOS is derived from Unix, specifically the BSD variant of Unix. In particularly,
# it is not built on Linux. While Linux systems generally ship with the GNU command-line
# tools, MacOS ships with the FreeBSD flavour of tools. Both sets of tools are compliant
# with the POSIX standards (which aim to provide some standardisation among Unix-like
# systems), but they have slight differences which, for me, are quite annoying to have
# to deal with. I'd rather use one or the other *all the time*. Since I sometimes work on 
# Linux machines sometimes, and since there's probably more users of the GNU tools than
# the FreeBSD tools, I've opted to replicate the Linux environment on MacOS.

# To do this, I install GNU tools using brew. As usual, brew symlinks everything
# to /usr/local/bin.
# If an installed tool also exists on MacOS by default (e.g. `ls`), brew pre-pends 'g'
# to the tool's name when symlinking to /usr/local/bin, e.g. 'ls' is 'gls'. When it does
# this, the brew installation output gives us a directory to append to our PATH to be able
# to use the tools with their proper names. This is what the below exports are doing.

U_add_to_PATH_if_exists "/usr/local/opt/coreutils/libexec/gnubin"  # ls, wc, uniq, mkdir etc
U_add_to_PATH_if_exists "/usr/local/opt/grep/libexec/gnubin"  # grep, egrep, fgrep
U_add_to_PATH_if_exists "/usr/local/opt/findutils/libexec/gnubin"  # find, xargs

# Note: We also, obviously, want `man ls` etc to show us the man page for the
# GNU tools, *not* whatever variation of it MacOS provides. I didn't have to do
# anything extra to enable this behaviour (and brew did not tell me to upon installation).
# Protip: You can tell it's a man page for a GNU tool if credit is given to the
# GNU project; try searching for 'GNU' in the file. 
# Many MacOS tools' man pages mention BSD instead - you know it's not a GNU man page if 
# 'BSD General Commands Manual' is at the top of the man page.

# brew-installed ruby
# -------------------
# Use brew-installed ruby/gem, not the default ruby/gem; the latter leads to obscure
# errors for me; I suspect it's just there for use by the system, and not for use by
# the programmer, just like the default Python interpreter.
# Both are installed like so: `brew install ruby`
# This'll install ruby in /usr/local/Cellar/ruby and will print a message telling us
# that it *has not* symlinked ruby anything to /usr/local/bin because MacOS already
# provides ruby. It gives us directory to append to PATH if we want to use the brew
# version of ruby over the MacOS default version. Moreover, it tells us to append the
# directory where gem will install its binaries to our PATH.

U_add_to_PATH_if_exists "/usr/local/opt/ruby/bin"  # brew-installed ruby/gem live here
U_add_to_PATH_if_exists "/usr/local/lib/ruby/gems/3.0.0/bin"  # gem-installed binaries live here
