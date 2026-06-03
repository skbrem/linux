This is a vim cheatsheet that I got from [vim.rtorr.com](vim.rtorr.com). All credit goes to the original author.

## Global

`:h[elp]` - open help for keyword  
`:sav[eas] file` - save file as is  
`:clo[se]` - close current pane  
`:ter[minal]` - open a terminal window  
`K` - open man page for the word under the cursor  

> [!tip]
> Use `vimtutor` to get a tutorial on Vim.  

## Cursor Movements

`h` - move cursor left  
`j` - move cursor down  
`k` - move cursor up  
`l` - move cursor right  
`gj` - move cursor down (multi-line text)  
`gk` - move cursor up (multi-line text)  
`H` - move cursor to the top of the screen  
`M` - move cursor to the middle of the screen  
`L` - move cursor to the bottom of the screen  
`w` - move to the start of a word (excluding punctuation)  
`W` - move to the start of the word (including punctuation)   
`e` - move to the end of a word (excluding punctuation)  
`E` - move to the end of a word (including punctuation)  
`b` - move back to the start of a word (excluding punctuation)  
`B` - move back to the start of a word (including punctuation)  
`ge` - jump back to the end of a word (excluding punctuation)  
`gE` - jump back to the end of a word (including punctuation)  
`%` - move cursor to matching character. use `:h matchpairs` to learn more  
`0` - jump to the start of the line  
`^` - jump to the first non-blank character on the line  
`$` - jump to the end of the line  
`g_` -  jump to the last non-blank character on the line  
`gg` - go to the first line on the file  
`G` - go to the last line of the file  
`5gg` or `5G` - go to line 5  
`gd` - move to local declaration  
`gD` - move to global declaration  
`fx` - move to the next occurrence of the character x  
`tx` - move to before next occurrence of the character x  
`Fx` - move to previous occurrence of the character x  
`Tx` - move to after previous occurrence of the character x  
`;` - repeat previous f, t, F, or T movement  
`,` - repeat previous f, t, F, or T movement backwards  
`}` - move to the next paragraph (or function/block in editing mode)  
`{` - move to the previous paragraph (or function/block in editing mode)  
`zz` - center cursor on screen  
`zt` - position cursor at the top of screen  
`zb` - position cursor at the bottom of screen  
`Ctrl` + `e` - move screen down one line (without moving cursor)  
`Ctrl` + `y` - move screen up one line (without moving cursor)  
`Ctrl` + `b` - move screen up one page (move cursor to last line)  
`Ctrl` + `f` - move screen down one page (move cursor to first line)  
`Ctrl` + `d` - move cursor and screen down half a page  
`Ctrl` + `u` - moved cursor and screen up half a page  
