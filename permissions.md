The `ls` command is used to view metadata about files on Linux. 

```bash
$ ls -l
drwxr-xr-x. 4 root root    68 Jun 13 20:25 tuned
-rw-r--r--. 1 root root  4017 Feb 24  2022 vimrc
```

- File type: `-`
- Permission settings: `rw-r--r--`
- Extended attributes: `(.)`
- User owner: `root`
- Group owner: `root`

## How to Read File Permission

> [!note]
> `rw-r--r--`

These represent 3 separate items:

1. `rw-`
2. `r--`
3. `r--`

The first applies to the owner of the file. The second applies to the group that owns the file. The third is referred to as the "others". 

When permissions are set using letters, it's known as **symbolic** mode. 

- User: `u`
- Group: `g`
- Others: `o`
- Read: `r`
- Write: `w`
- Execute: `x`

## Octal Values

When Linux permissions are changed using numbers, this is known as **numeric mode** or **absolute mode**. A 3-digit number represents specific file permissions, which are known as octal values. The first represents the owner permissions, the second group permissions, and the third is for others.

- r(read): 4 
- w(write): 2 
- x(execute): 1 

> [!note]
> The permission of `744`, for example, shows that `7` belongs to the user, the first `4` belongs to the group, and the second `4` belongs to others. Adding up the values of each one shows you what permissions have been granted over. 
>
> - Owner: rwx = 4+2+1 = 7
> - Group: r-- = 4+0+0 = 4 
> - Others: r-- = 4+0+0 = 4

## Understanding Permissions

### Read (r)

The read permissions allows a user or group to access the contents of a file. Tools like `less` or `cat` can be used on a file to show the contents if the read permission has been granted. The read permission is needed in order to make copies of a file as access to the content is needed for duplication. 

### Write (w)

The write permissions is needed to change or modify the contents of a file. Along with this, the write permission grants the user the ability to redirect or append operators within the shell in order to modify the file's contents. 

### Execute (x)

The execute permissions allows the user to execute the contents of a file. This includes running commands or compiled binary applications. The execute persmission is also needed in order to run Bash shell scripts, as well as Python scripts and other interpreted languages. 

## Understanding Directory Permissions


