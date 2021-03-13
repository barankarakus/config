# Defining zsh keybindings.

# It's important to understand that zsh (and other shells) *do not* receive
# input directly from your keyboard. Your keyboard gives input to the *terminal*
# which then converts each keystroke into a *key sequence* which is then
# sent over to the shell. Thus, the shell takes in *not* your key presses but
# the key sequences that your terminal converted them into.
# Note that these key sequences are nothing more than a sequence of ASCII-encoded
# bytes. Thus, they are often represented as sequences of 2-digit hex numbers, each
# such number representing an ASCII character. There are also other representations
# of some of these characters; for example, 'a' usually represents the ASCII
# character corresponding to 'a', '^X' the ASCII character that the terminal
# sends when you type in <Ctrl-X> for X \in {A, B, ..., Z}, '^[' the special
# ASCII 'escape character' that the terminal sends when you type in either
# <Ctrl-[> or press the <Esc> button.
#
# When defining keybindings for zsh (or any other shell) one has to take
# into account the actual key sequence that the terminal sends to the shell
# upon pressing the key(s) that one would like to bind to a specific shell
# action. The easiest way to find this out is to type <Ctrl-V> followed by
# the desired keystroke; <Ctrl-V> forces the shell to interpret the next
# character (byte) *literally* and not perform any action that that character
# might otherwise be bound to. Then, some representation of the key sequence
# sent by the terminal will appear on-screen; it seems to be the ^X
# representation.
#
# Some terminal emulators, iTerm among them, allow for modifying the key sequence
# sent by a particular keystroke (where a 'keystroke' is just one particular
# action, like typing 'a' or 'j' or holding down some modifier keys like
# Ctrl/Option/Command and then typing 'a' or 'j' or something; in particular,
# a *sequence* of key presses like 'aj' is *not* a keystroke). This can be
# a useful tool to employ when trying to get zsh to behave just the way one wants
# it to upon pressing a specific keystroke. But note that this sort of
# modification on the iTerm end affects *every* application running in the terminal,
# it is *not* specific to zsh (so, for example, it'll change the key sequences
# sent to Vim, too).
# In iTerm, this is achieved via Profiles > Keys > +. There, a keystroke can be
# recorded and assigned to an action. The relevant options for modifying the key
# sequence sent are 'Send Hex Codes', 'Send Escape Sequence', 'Send Text with "vim"
# Special Chars". The first allows to specify a byte/character sequence in hex.
# An 'escape sequence' is just a sequence of ASCII characters where the first is
# the escape character (often represented as '^['), so the second option will
# take whatever sequence you give it (say, 'abc') and send the key sequence
# '^[abc' when you type your desired keystroke. The third option allows to
# specify the sequence sent in a Vim-like fashion, e.g. \<C-J> corresponds
# to <Ctrl-J>. For more details, see iTerm's documentation.

# OK, so that's the interaction between the terminal and zsh. How do we
# actually *define* key bindings (to be more precise, how do we tell zsh to
# execute particular actions when it receives particular key sequences)?
#
# Documentation on configuring zsh key bindings:
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html.
# Equivalently, check the man pages for zshzle.
#
# In a nutshell, ZLE is the Zsh Line Editor: it's the part of zsh that
# interprets the key sequences sent to zsh by the terminal (which are derived
# from the user's key presses) and it's what we're interacting with when we type
# stuff. When defining custom keybindings for zsh, we're really modifying the 
# way that the ZLE interprets key sequences sent to it.
#
# The key idea is that the ZLE has several 'keymaps' by default. These are
# nothing more than distinct collections of key bindings. So, the same key
# sequence might do different things when different keymaps are 'active'.
# We can define keybindings within keymaps whose sole action is to switch the active
# keymap to a different keymap, thus allowing us to emulate the modal behaviour
# of Vim - the keymaps essentially become the different modes.
#
# The ZLE already provides us with keymaps by default which enable us to
# emulate Vim pretty accurately. The main two are 'viins' (like Vim's
# insert mode) and 'vicmd' (basically normal mode; there's not really such
# a thing as command mode in the ZLE).
#
# zsh provides the built-in `bindkey` command for manipulating keymaps and
# key bindings. It can be used to query the action that a particular key sequence
# is bound to, to create new keymaps (I won't be doing this), to create new key
# bindings for existing keymaps, and more.
#
# Two common usage patterns are:
# 1) `bindkey [-M keymap] <in_string> widget`
# 2) `bindkey [-M keymap] -s <in_string> <out_string>
# The first of these tells the ZLE that, when it receives the key sequence
# specified by <in_string> (if there are multiple characters in the sequence,
# it has to receive them in quick succession; the exact timing is specified
# by the KEYTIMEOUT parameter; do a Google search), it should invoke
# the 'widget'. Widgets are nothing more than actions. There are loads of built-in
# ones, e.g. the vi-cmd-mode widget activates the vicmd keymap, but it's also
# possible to create custom ones. See the docs for more details.
# The second statement tells the ZLE that when it receives the key sequence
# <in_string> it should pretend like it's actually received the key sequence
# <out_string>
# The docs explain how <in_string> and <out_string> may be formatted. For
# example, control characters can be indicated like so: '^A', '^B', etc.
# Without the optional [-M keymap], the binding specified is created within
# *every* keymap. But if we specify, say, -M vicmd, then we force the binding
# to apply only to the vicmd keymap.

# Here's a Git repo of some-one else's dot files - they have lots of Vim
# key-bindings for zsh: https://github.com/mkomitee/dotfiles. Good to look at
# for inspiration and for an understanding of how to define key bindings for
# zsh.

# Telling zsh to use vi mode (technically, telling the ZLE to use the
# 'viins' keymap as its default or 'main' keymap; see the docs).
bindkey -v

# Defining a new 'no-op' function/widget, doing nothing
zsh-widget-noop () {}  # Define function like a normal zsh function
zle -N zsh-widget-noop  # Allow the function to be a ZLE widget

# Problem: I want to be able to press <Shift-Enter> to take new lines but *not*
# send what I've typed to be interpreted by zsh.
# Turns out that, by default, iTerm sends the control character '^M' upon
# pressing <Enter> or <Shift-Enter>. This character is also known as the ASCII
# 'carriage return' character. Thus, <Shift-Enter> has the same effect as
# <Enter> by default, which is to send what's typed so far to be interpreted
# by zsh and move the command prompt down; running `bindkey '^M'` we see that
# the zsh widget corresponding to this character is 'accept-line'.
# Now, I definitely can't be mapping '^M' to some other action, because otherwise
# I'll break the action of <Enter>. So, I'll need to map <Shift-Enter> on the iTerm
# end to send a different character (and this'll apply to ALL programs running
# inside iTerm). 
# Now note that the control character '^J' is the ASCII 'linefeed' character, also
# denoted as '\n'. Running `bindkey '\n'` we see that the zsh widget corresponding
# to this character is also 'accept-line' (indeed, one can verify that pressing
# <Ctrl-J> has the same effect as <Enter>).
# Here's my first solution:
# 1) Bind '^J' to the widget 'self-insert', so that the '^J'
# (or '\n') character is literally inserted into the buffer when zsh receives it,
# rather than invoking the 'accept-line' widget. 
# 2) On the iTerm end, modify <Shift-Enter> to send '^J' rather than '^M'. The
# easiest way to do this is to use the 'Send Text ax "vim" Special Chars' option
# and input \<C-J> as the text to be sent.
# This does mean that *every* program running in iTerm now receives ^J instead of
# ^M when I press <Shift-Enter>, but this isn't very consequential I don't think.
# bindkey -M viins '^J' self-insert
# Here's my second (preferred) solution:
# First, why am I unhappy with the above? Precisely because it mangles  <Shift-Enter>
# and <Ctrl-J>. I don't want this because when I have a terminal running inside
# vim, I want to use <Shift-Enter> for entering newlines and <Ctrl-J> for whatever
# I've mapped <Ctrl-J> in vim (at time of writing, I make <Ctrl-J> switch to the window
# below).
# In this second solution, I map some random character I'll never use to the key
# sequence <Ctrl-V><Ctrl-J>, on the ZLE end. Then, on the iTerm end, I map <Shift-Enter>
# to this character.
# Why does this work? Because <Ctrl-V> launches the vi-quoted-insert widget, when in
# viins mode. When this is launched, the next key received is interpreted literally.
# So, when the ZLE sees <Ctrl-J> immediately after <Ctrl-V>, it doesn't ask itself
# 'Hmm... what have I mapped <Ctrl-V> to?'; it simply inserts the newline character.
# The 'random character' I've chosen is å, which is what <Alt-a> defaults to sending.
bindkey -s -M viins 'å' '^V^J'

# Using 'jk' typed in quick succession to Esc to Normal mode from Insert
bindkey -M viins 'jk' vi-cmd-mode

# Mapping <Ctrl-K> and <Ctrl-J> to do nothing in Normal mode,
# because I find myself accidentally pressing them (I'm confusing
# them for <Cmd-K>, <Cmd-J>, which I've set up to move up and down
# within iTerm panes)
bindkey -M vicmd '^K' zsh-widget-noop
bindkey -M vicmd '^J' zsh-widget-noop

# Mapping H, L to what they're mapped to in my .vimrc,
# i.e H takes us to first non-blank character in line (alias for ^),
# L to end of line (alias for $)
bindkey -M vicmd 'H' vi-first-non-blank
bindkey -M vicmd 'L' vi-end-of-line

# By default, <Ctrl-P> and <Ctrl-N> go up and down in the command history, but
# only in Command/Normal mode. Here, I define it to work in Insert mode too.
bindkey -M viins '^P' up-history
bindkey -M viins '^N' down-history

# Mapping : so that while in 'Command mode', it does nothing, because: 
# 1) No such thing as Ex mode here, and
# 2) : is opening up a prompt to type a ZLE command, and I don't see a
# use for any of these.
bindkey -M vicmd ':' vi-cmd-mode

# Mapping backspace so that while in 'Insert mode', it works like you'd bloody
# expect: Deletes the character before the cursor. By default, it doesn't let
# you delete before the point at which you entered Insert mode (????).
# This 'backward-delete-char' widget also allows us to backspace through new lines.
# The zsh ZLE documentation says \b represents the backspace key, and ^?
# represents 'delete'; I've got both here because the first line didn't do the
# job (but it might on other systems?) and the second did.
bindkey -M viins '\b' backward-delete-char
bindkey -M viins '^?' backward-delete-char

# fzf (the command-line fuzzy finder) uses <Alt-c> to search for a directory to
# cd to. iTerm on Mac sends the key sequence representing the character ç when
# <Alt-c> is pressed, which doesn't seem to be what fzf is expecting. Here is a fix
# courtesy of https://github.com/junegunn/fzf/issues/164:
bindkey -M viins 'ç' fzf-cd-widget
