## What are regular expressions

Regular expressions are symbolic notations used to identify patterns in text. 

## grep

One of the main tools around for working with regular expressions is grep. grep searches text files for texts that match a certain regular expression and then outputs the line containing a match to standard output.

For example:

`ls /usr/bin | grep zip`

This lists all of the files in /usr/bin that contain the substring "zip" in their names. 

The following is how `grep` accepts options and arguments, with *regex* being the regular expression:

`grep [option] regex <file>`

Common `grep` options:

| Option | Long | Description |
| --- | --- | --- |
| `-i` | `--ignore-case` | Ignore uppercase and lowercase. |
| `-v` | `--invert-match` | Invert match. `grep` will usually print lines that contain a specified match. This option makes it so `grep` instead prints out every line that is not the specified match. |
| `-c` | `--count` | Prints the number of matches instead of the lines themselves. If using the `-v` option, it prints the number of non-matches. |
| `-l` | `--files-with-matches` | Prints the name of each file that contains a match instead of the lines themselves. |
| `-n` | `--line-number` | Prefix each of the matching lines with the number of the line in the file. |
| `-h` | `--no-file` | For multi-search, suppresses the output of the filenames. |
| `q` | `--quiet`, `--silent` | Suppress all of the output. Useful when creating scripts when we want to test if a match has been found. |

## Metacharacters and Literals

When searching for something simple like `bzip` using `grep`, the regular expression here is bzip, and `grep` will only match the same characters in the same order. This means that the line in the file will need to have four characters in the order b z i p, with no characters inbetween. The characters in the string bzip are **literal** characters in that they match themselves. Along with literal characters, regular expression can also include metacharacters, which can help for doing more complex matching. These characters include:

`^ $ . [ ] { } - ? * + ( ) | \`

Any character apart from these is considered literal. The backslash is sometimes used to create meta sequences as well as allowing metacharacters to be escaped and treated as literals.

> [!tip]
> Many metacharacters are the same characters that Bash will expand when used. This means that it's a good idea to enclose characters in quotes when using regular expression to stop the shell from trying to expand them.

## Any character

The dot or period character is used to match any character, matching any character where the dot is placed. 

`grep -h '.zip' dirlist*.txt`

It's interesting to note that adding the any character as a dot increases the regex size to 4 characters, meaning that names that are 3 characters in length will not be included in the result. Any files that have the file extension `.zip` will also have been matched. 

## Anchors

The dollar sign $ and the caret ^ are known as anchors. It means that the match only takes place if the regular expression is found at the end of the line $ or at the beginning of the line ^. 

```bash
[me@linuxbox ~]$ grep -h '^zip' dirlist*.txt
zip
zipcloak
zipgrep
zipinfo
zipnote
zipsplit
[me@linuxbox ~]$ grep -h 'zip$' dirlist*.txt
gunzip
gzip
funzip
gpg-zip
preunzip
prezip
unzip
zip
[me@linuxbox ~]$ grep -h '^zip$' dirlist*.txt
zip
```

> [!note]
> Using `^$` with nothing in between will match blank lines.

## Bracket Expansion and Character Classes

Bracket expansion allow us to specify a set of characters, which includes characters that would otherwise be metacharacters to be matched with.

`grep -h '[bg]zip' dirlist*.txt`

Will give us:

```bash
bzip2
bzip2recover
gzip
```

Metacharacters lose their meaning in brackets, and expect for two cases:

- The caret ^ indicates negation
- The dash - indicates a character range

### Negation

If the caret ^ is found at the beginning of the bracket expansion, the other characters in the brackets are interpreted as characters that must not be included at the given character position. 

`grep -h '[^bg]zip' dirlist*.txt`

The ^ only works when at the front of the bracket expansion. If placed anywhere else, it acts as a regular literal character within the set.

### Traditional Character Ranges

If we wanted to create a regex that found every file in our lists that began with an uppercase letter, the long and inefficient way to do it would be to use:

`grep -h '^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]' dirlist*.txt`

Which is basically typing every uppercase letter into the brackets, and takes a lot of work. Fortunately there is an easier way to go about this:

`grep -h '^[A-B]' dirlist*.txt`

This is essentially abbreviating the range of 26 letters. There are a lot of ways of using this, for example:

`grep -h '^[A-Za-z0-9]' dirlist*.txt`

In order to include a dash - character in the bracket expansion, make it the first character in the brackets. 

`grep -h '[-AZ]' dirlist*.txt`

### POSIX Character Classes

| Character Class | Description |
| --- | ---- |
| `[:alnum:]` | Alphanumeric characters, equivalent to `[A-Za-z0-9]` in ASCII. |
| `[:word:]` | The same as `[:alnum:]`, but includes the underscore _ characters. |
| `[:alpha:]` | Alphabetic characters, equivalent to `[A-Za-z]`. |
| `[:blank:]` | Includes the tab and space characters. |
| `[:cntrl:]` | The ASCII control codes, which includes the ASCII characters 0 to 31 and 127. |
| `[:digit:]` | Numerals 0 to 9. |
| `[:graph:]` | Visible characters. Includes characters 33 to 126 in ASCII. |
| `[:lower:]` | Lowercase characters. |
| `[:punct:]` | The punctuation characters. The equivalent to [-!"#$%&'()*+,./:;<=>?@[\\\]_`{|}~] |
| `[:print:]` | Printable characters. Includes all the characters in `[:graph:]` as well as the space characters. |
| `[:space:]` | Whitespace characters including space, tab, carriage return, newline, vertical tab, and form feed. Equivalent to: [ /t /r /n /v /f ] |
| `[:upper:]` | Uppercase characters. |
| `[:xdigit:]` | Characters that are used to express hexadecimal numbers, equivalent of: [0-9A-Fa-f]. |

This means that instead of using:

`ls /usr/sbin/[A-Z]*`

We can use:

`ls /usr/sbin/[[:upper:]]*`

Which provides the same result. 

## POSIX Basic Expression vs. Extended Expression

POSIX splits regular expression implementations into two kinds:

- Basic regular expression (BRE)
- Extended regular expression (ERE)

In BRE, these metacharacters are recognised:

`^ $ . [ ] *`

All other characters are interpreted as literals. With ERE, on the other hand, the following characters are included:

`( ) { } ? + |`

However, the (, ), {, and } characters are seen as metacharacters within BRE **if** they are escaped using a backslash. In ERE, on the other hand, preceding the metacharacters with a backslash will cause them to be seen as a literal. 

## Alternation

Alternation is a capability that allows matching to take place from among a set of expressions. It allows for matches from a set of strings or other regular expressions. 

```bash
$ echo "AAA" | grep AAA
AAA
$ echo "BBB" | grep AAA
$
```

Alternation can be signified by the vertical-bar metacharacter.
Another example:

```bash
echo "AAA" | grep -E 'AAA|BBB'
AAA
echo "BBB" | grep -E 'AAA|BBB'
BBB
echo "CCC" | grep -E 'AAA|BBB'

```

Alternation can be used when there are multiple choices:

```bash
echo "AAA" | grep -E 'AAA|BBB|CCC'
AAA
```

It's also possible to use alternation combined with other regular expression elements, using () to separate the alternation. 

`grep -Eh '^(bz|gz|zip)' dirlist*.txt`

Here, the expression will match with filenames that start with `bz`, `gz`, or `zip`. Without the parenthesis, the meaning of the regex changes to instead match any filename that begins with `bz`, or otherwise contains `gz` or `zip`. 

`grep -Eh '^bz|gz|zip' dirlist*.txt`

## Quantifiers

Regular expressions support many different ways to show the number of times that an element is matched. 

### ? - Matching an Element Zero or a Single Time

This quantifier means to make the preceding element optional. For example, if we are wanting to check if a phone number if valid, and we would consider a number to be valid if it matched either of two forms, where *x* is the numeral:

- *(xxx) xxx-xxx*
- *xxx xxx-xxx*

The regular expression would look like:

`^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9]$`

The parenthesis characters are followed by ? marks to indicate that they must be matched zero or one time. Note that we precede the parentheses with backslashes so that they are treated as literals. 

Let's use this expression to match a number: 

```bash
echo "(033) 502-1100" | grep -E '^\(?[0-9][0-9][0-9]
\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'
$ (033) 502-1100
echo "033 502-1100" | grep -E '^\(?[0-9][0-9][0-9]\)
? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'
$ 033 502-1100
echo "AAA 502-1100" | grep -E '^\(?[0-9][0-9][0-9]\)
? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'
$
```

