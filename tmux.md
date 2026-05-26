## Session

Start a new session

`tmux`  
`tmux new`  
`tmux new-session`  
`:new`

Start new sessions or attach existing session called **test**

`tmux new-session -A -s test`

Start a new sessions with the name **test**

`tmux new -s test`  
`:new -s test`  

Kill or delete the current session

`:kill-session`

Kill or delete the session **test**

`tmux kill-ses -t test`  
`tmux kill-session -t test`

Kill or delete all sessions except **test**

`tmux kill-session -a -t test`

Rename a session

`Prefix $`

Detach from a session

`Prefix d`

Show all sessions

`tmux ls`  
`tmux list-sessions`  
`Prefix s`

Attach to last session

`tmux a`  
`tmux at`  
`tmux attach`  
`tmux attach-session`  

Attach to a session with the name **test**

`tmux a -t test`  
`tmux at -t test`  
`tmux attach -t test`  
`tmux attach-session -t test`

Session and window preview

`Prefix w`

Move to previous session

`Prefix (`

Move to next session

`Prefix )`

## Windows

Start a new session with the name **testsession** and window name **testwindow**

`tmux new -s testsession -n window`

Create window 

`Prefix c`

Rename the current window

`Prefix ,`

Close the current window

`Prefix &`

List windows

`Prefix w`

Previous window

`Prefix p`  

I have this set to `Prefix h`

Next window

`Prefix n`

I have this set to `prefix l`

Select window by number

`Prefix 0-9`

Toggle the last active window

`Prefix |`

Window action menu

`Prefix <`

## Panes
