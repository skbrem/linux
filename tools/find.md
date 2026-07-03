## Finding single file by name

```bash
find / -name "File.txt" 2>dev/null
```

## Find single file by approximate name

```bash
find / -iname "*File*txt" 2>/dev/null
```

- Use "iname" for case insensitive searches

## Find everything

Use the `-ls` flat to make `find` search for things recursively.

```bash
find ~/Documents -ls
```

## Find by content

`find` allows for the usage of other commands on any results. Helpful when trying to find a file by content rather by name, or by both.

```bash
find ~/Documents/ -name "*txt" -exec grep -Hi moose {} \;
```

## Find by type

```bash
find ~ -type f
```

Use the `-type` option to find files by type, including:

- regular files: `-f`
- directory: `-d`
- symlinks: `-l`
- socket: `-s'

It's possible to search for more than one type by separating the types of a comma:

```bash
find ~ -type f,l
```

## Limiting results

```bash
find ~/Documents -maxdepth 1 -type f
```

## Finding empty files

```bash
find ~ -type f -empty
```

## Finding files by age

The `-mtime` option provides the option to older than or newer than a value times 24

```bash
find /var/log -iname "*~" -o -iname "*log*" -mtime +30
```

The `+` here is a conditional that matches for a value of 24 times 30. Here, the command will search for files that have not been modified in the last month or longer. 

```bash
find /var/log -iname "*~" -o -iname "*log*" -mtime -7
```

The `-` conditional ensures that find will search for files that have been modified in the last week.

## Searching a path

To search in a path string, use the `-ipath` option, which ensures that ignores regex characters. 

```bash
find / -type d -name 'img' -path "*old_projects/examples*" 2>dev/null
```
