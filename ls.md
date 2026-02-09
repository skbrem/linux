---
created: 2026-01-03
tags:
  - cli
  - linux
---

`ls` is a command for listing information about a directory and/or files. 

Use `ls` as well as two arguments, the first to modify the command and the second to choose a target for the command. 

> [!tip] 
> - `ls -l` for the current working directory.
> - `ls -l ~` For the home directory.

Use `ls -d */` to list only the subdirectories within a directory. 

Here are some common `ls` commands:

| Description | Option | Full Option |
| --- | --- | --- |
| `-a` | `--all` | Lists all the files in a directory, even those that are hidden. |
| `-A` | `--almost-all` | Similar to the `-a` option, expect that the current directory (.) and parent directory (..) are not shown. |
| `-d` | `--directory` | Usually when using `ls` on a directory, it will display the contents of that directory. The `-d` option instead displays metadata about the directory instead. |
| `-F` | `--classify` | Appends an indicator character to the end of each file name, and a forward slash if the file is a directory. |
| `-h` | `--human-readable` | When listing in long format, display the file sizes in a format that humans can understand rather than in bytes. |
| `-l` | | Display files and directories in long format. |
| `-r` | `--reversible` | Show the list results in reverse order. Typically, `ls` will show results in ascending alphabetical order. |
| `-S` | | Sort the files by size. |
| `-t` | | Sort the files by their modfication time. |
