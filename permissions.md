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

`rw-r--r--`

These represent 3 separate items:

1. `rw-`
2. `r--`
3. `r--`

The first applies to the owner of the file. The second applies to the group that owns the file. The third is referred to as the "others". 

When permissions are set using letters, it's known as **symbolic** mode. 

- User:     `u`
- Group :   `g`
- Others:   `o`
- Read:     `r`
- Write:    `w`
- Execute:  `x`

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

A `d` signifies the directory file type. Although permissions act the same way for directories, they are interpreted differently. 

### Read (r)

The read permission allows the user to view the files within a directory. This permission is required when attempting to use `ls` and other similar commands. 

### Write (w)

Allows a user to modify the contents of a directory, which means either adding or removing files from a directory. Commands like `mv` and `rm` require the write permission to function. Write is also needed in order to create new files with `touch` or to copy files with `cp` from and into the directory.

### Execute (x)

Execute in regard to directories is very different to files. It's easy to understand it as providing access to the directory. It authorizes a user to view extended information about a directory, such as using `ls -l`, which also allowing a user to change to the directory using `cd` and to pass through the directory to subdirectories. 

Without the execute permission, it's not possible to add new files to a directory, even if the write persmission has been granted, because it's impossible to access the metadata of the directory in question. It's for this reason that the execute permission is typically granted to one or more user owners, group owners, or others. 

## Modifying Permissions

The `chmod` command is used to modify the permissions of a file or directory. (`chmod` stands for "change mode"). in order to change the permissions on a file, choose the type of permission structure you want to use - symbolic or absolute - and then use the `chmod` command, followed by the permission modifier, and then the file/directory name. 

For example:

`chmod 744 file.txt` 

Another example:

`chmod ug+rwx file.txt`
`chmod o+r file2.txt`

In the `chmod ug+rwx file.txt` example, the command changes the permissions for the user (`u`) and for the group (`g`), giving both read(`r`), write(`w`), and execute(`x`) permissions. The `o` is for other users that are not in the file group. In order to change the permissions for all users, use `chmod a`. 

It's also possible to change the owners of a file, which can be done with `chown` for users and `chgrp` for groups. 
