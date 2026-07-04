## Sessions

Start a new session:

`tmux`  
`tmux new`  
`tmux new-session`  
`:new`

Start new sessions or attach existing session called **test**:

`tmux new-session -A -s test`

Start a new sessions with the name **test**:

`tmux new -s test`  
`:new -s test`  

Kill or delete the current session:

`:kill-session`

Kill or delete the session **test**:

`tmux kill-ses -t test`  
`tmux kill-session -t test`

Kill or delete all sessions except **test**:

`tmux kill-session -a -t test`

Rename a session:

`Prefix $`

Detach from a session:

`Prefix d`

Show all sessions:

`tmux ls`  
`tmux list-sessions`  
`Prefix s`

Attach to last session:

`tmux a`  
`tmux at`  
`tmux attach`  
`tmux attach-session`  

Attach to a session with the name **test**:

`tmux a -t test`  
`tmux at -t test`  
`tmux attach -t test`  
`tmux attach-session -t test`

Session and window preview:

`Prefix w`

Move to previous session:

`Prefix (`

Move to next session:

`Prefix )`

## Windows

Start a new session with the name **testsession** and window name **testwindow**:

`tmux new -s testsession -n window`

Create window:

`Prefix c`

Rename the current window:

`Prefix ,`

Close the current window:

`Prefix &`

List windows:

`Prefix w`

Previous window:

`Prefix p`  

- I have this set to `Prefix h`

Next window:

`Prefix n`

- I have this set to `prefix l`

Select window by number:

`Prefix 0-9`

Toggle the last active window:

`Prefix |`

Window action menu:

`Prefix <`

## Panes

Toggle the last active pane:

`Prefix ;`

Split the current pane with vertical line to create horizontal layout:

`Prefix %`

- I have this set to `Prefix |`

Join two windows as panes:

`:join-pane -s 2 -t 1`

Move pane from one window to another

`:join-pane -s 2.1 -t 1.0`

Move the current pane to the left:

`Prefix {`

Move the current pane to the right:

`Prefix }`

Switch to different panes in the window directionally:

`Prefix up`

- I have this set to `Prefix k`

`Prefix down`

- I have this set to `Prefix j`

`Prefix left`

- I have this set to `Prefix h`

`Prefix right`

- I have this set to `Prefix l`

Toggle to synchronise panes:

`:setw synchronize-panes`

Toggle between pane layouts:

`Prefix spacebar`

Switch to next pane:

`Prefix o`

Show pane numbers:

`Prefix q`

Select pane by number:

`Prefix 0-9`

Toggle pane zoom:

`Prefix z`

Convert a pane into a window:

`Prefix !`

Close current pane:

`Prefix x`

Open the panes action menu:

`Prefix >`

## Copy Mode

Use Vi keys in buffer:

`set:w -g mode-keys vi`

Enter copy mode:

`Prefix [`

Quit copy mode:

`Q`

Go to the top line:

`g`

Go to the bottom line:

`G`

Start selection:

`Spacebar`

Clear selection:

`Esc`

Copy selection:

`Enter`

Paste the contents of buffer:

`Prefix ]`

Show buffer_0 contents:

`:show-buffer`

Copy all visible contents of current pane to buffer:

`:capture-pane`

List all of the buffers:

`list-buffers`

Display buffers and select one to paste:

`:choose-buffer`

Save buffer content to file.txt:

`:save-buffer file.txt`

Delete buffer_1:

`:delete-buffer -b 1`

## Misc

Enter command mode:

`Prefix :`

Enable  mouse mode:

`:set mouse on`

Set OPTION for all sessions:

`:set -g OPTION`

Set OPTION for all windows:

`:setw -g OPTION`

Print tmux version:

`tmux -V`

## Help

List all the key bindings:

`tmux list-keys`
`:list-keys`
`Prefix ?`

Show information about all sessions, windows, panes, etc:

`tmux info`
