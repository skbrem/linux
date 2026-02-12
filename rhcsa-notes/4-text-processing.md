## Processing Text Files

- Using `grep` and regular expressions is important for working with text. 
- Creating and editing text files is necessary for any sysadmin working with Linux. 

| Command | Description |
| --- | --- |
| cat | Dumps content of a file on to the terminal screen. |
| less | Dislays text in a pager, allowing for navigation and easier reading. |
| head | Displays the top few lines of a text file. |
| tail | Displays the bottom few lines of a text file. |
| wc | Shows the count of the lines, words, and characters in a file. |
| sort | Sorts the contents of a file. |
| cut | Filters columns or characters in a file. |

### less

It's common to pipe to less to be able to read through text. Use the Page Up and Page Down keys to browse through contents, and then `q` to quit. 

It's also possible to search for text in less using `/sometext` for searching forward, and `?sometext` for searching backward. Repeat the last search by using `n`. 

The more command also allows for more interactive parsing by using the `more -p` command. It's important to keep in mind as the `more` tool will be found on every Linux system, while `less` is not necessarily installed. 

## Using cat

If a text is not too long, it's worth using `cat` to view the contents, which are dumped into the terminal. 

> [!tip]
> `cat` will dump all the contents onto the screen from beginning to end, which means that in a long file, only the last few lines will be visible. In order to see the first few lines, use the utility `tac` instead, which provides the inverse results of `cat`. 

## `head` and `tail`

`head` will show the first ten lines of a file. `tail` will show the last ten lines of a file. 

It's possible to adjust how many lines are shown by adding `-n` followed by the number. For example:

`tail -n /etc/passwd`

Modern versions of head and tail don't need the `-n` option, so it's possible to get the same result with:

`tail -5 /etc/passwd`

The `-f` option can also be useful. It shows the last ten lines of a file, and then refreshes if new lines are added. It's useful for keeping an eye of log files as they are updated. For example:

`tail -f /var/log/messages`. (This will need to be used with `sudo`)

It's also possible to combine `head` and `tail` together. For instance, trying to see line 10 from the /etc/passwd file. This can be done with:

`head -n 10 /etc/passwd | tail - 1`

## Filtering with `cut`

It can be helpful to filter out specific fields within a text file, such as seeing all of the users in the /etc/passwd file. `cut` can be used here, where we'd use `-d` to specify the field delimiter and then `-f` with the number of the field to be filtered out. The total command would look like:

`cut -d : -f 1 /etc/passwd`

## Sorting with `sort`

The `sort` command sorts text. using `sort /etc/passwd` will sort the contents of the file in byte order. 

It's a good idea to use sort with other commands like cut. `cut -f 1 -d : /etc/passwd | sort` which sorts the contents of the first column within that file.

`sort` will sort in byte order by default, which is based on the order in which characters appear in the ASCII text table. Although it initially looks like it's alphabetical order, it's technically not, because all uppercase letters are shown before lowercase letter. This may cause issues when using `sort` and trying to find specific data. 

One way to get around this is by using a command like: `cut -f 3 -d : /etc/passwd | sort -n` which sorts the third field of the file in **numeric** order. It's also possible to sort in reverse order with `-rn`. For example: `du -h | sort -rn`.

The `sort` command also allows you to specify which column that should be sorted. Use `sort -ke -t : /etc/passwd` to sort the 3rd column of the file. Using the `-n` option will sort in numeric order. 

## Counting with `wc`

The `wc` command provides the following:

- Number of lines
- Number of words
- Number of characters


For example, the `ps aux | wc` command provides the following result:

`366    5897   71438`

## Regular Expressions

Regular expressions are a means of finding patterns in text. They are also known as regex. It's a search pattern that allows for the searching of specific text in a flexible and powerful way. 

### Line Anchors

The expression ^ is used to indicate that you are searching for a line where a specific expression is at the start of the line. 

Another line anchor is $, which states that the line ends with a specific set of text. 

`grep name$ /etc/passwd`

### Escaping Characters

It's a good idea to use escaping to prevent the shell from expanding on certain expressions, such as * or $. One way to get around this is by enclosing the regular expression within quotes. 

### Wildcards and Multipliers

The wildcard expression is a dot (.), and it looks for one specific character. So `m.d` will look for both "mad" and "mud".

Another way to look for things is with brackets. For example, using `m[auo]` will look for "mad", "mud" and "mod". 

The multiplier * matches zero or more of the previous character. If you are looking for a specific amount of characters, it's useful to wrap the number like this `re\{2\}d`, which matches with "reed" rather than "red". 

Finally, ? matches zero or one of the previous characters.


