---
created: 2026-01-28
tags:
  - linux
  - security
---

The [[ls]] command provides metadata about files on a Linux system.

```bash
$ ls -l
drwxr-xr-x. 4 root root    68 Jun 13 20:25 tuned
-rw-r--r--. 1 root root  4017 Feb 24  2022 vimrc
```

- File type: `-`
- Permission settings: `rw-r--r--`
- Extended attributes: (`.`)
- User owner: `root`
- Group owner: `root`

## Reading file permissions
 
`rw-r--r--`

This represents the following:

1. `rw-`
2. `r--`
3. `r--`

The first set of permissions applies to the owner of the file. The second applies to the group that owns the file. The third set is referred to as 'others'. 

When permissions and users are represented by letters, that is called **symbolic mode**. 

- User: `u`
- Group: `g`
- Others: `o`
- Read: `r`
- Write: `w`
- Execute: `x`

## Octal Values

When Linux permissions are represented by numbers, this is known as **numeric mode** or **absolute mode**. In numeric mode, a 3 digit value represents specific file permissions, known as octal values. The first is for owner permissions, the second for group permissions, and the third for others. 

- r (read): 4
- w (write): 2
- x (execute): 1

> [!tip]
>  In the permission value 744, the first digit corresponds to the user, the second to the group, and the third to others. Adding up the values of each classification allows you to find the file permissions. 
> 
> - Owner: rwx = 4+2+1 = 7
> - Group: r-- = 4+0+0 = 4
> - Others r-- = 4+0+0 = 4

## What do permissions do?

### Read (r)

Read permission is used to access the file's contents. You can use a tool like `cat` or `less` on the file to display the file contents. You could also use a text editor like Vi or `view` on the file to display the contents of the file. Read permission is required to make copies of a file, because you need to access the file's contents to make a duplicate of it.

### Write (w)

Write permission allows you to modify or change the contents of a file. Write permission also allows you to use the redirect or append operators in the shell (`>` or `>>`) to change the contents of a file. Without write permission, changes to the file's contents are not permitted.

### Execute (x)

Execute permission allows you to execute the contents of a file. Typically, executables would be things like commands or compiled binary applications. However, execute permission also allows someone to run Bash shell scripts, Python programs, and a variety of interpreted languages.

## How do directory permissions work?

Directory file types are indicated with `d`. Conceptually, permissions act the same way, but directories interpret these operations differently. 

### Read (r)

Like regular files, this permission allows you to read the contents of the directory. However, that means that you can view the contents (or files) stored within the directory. This permission is required to have things like the `ls` command work.

### Write (w)

As with regular files, this allows someone to modify the contents of the directory. When you are changing the contents of the directory, you are either adding files to the directory or removing files from the directory. As such, you must have write permission on a directory to move (`mv`) or remove (`rm`) files from it. You also need write permission to create new files (using `touch` or a file-redirect operator) or copy (`cp`) files into the directory.

### Execute (x)

This permission is very different on directories compared to files. Essentially, you can think of it as providing access to the directory. Having execute permission on a directory authorizes you to look at extended information on files in the directory (using `ls -l`, for instance) but also allows you to change your working directory (using `cd`) or pass through this directory on your way to a subdirectory underneath.

Lacking execute permission on a directory can limit the other permissions in interesting ways. For example, how can you add a new file to a directory (by leveraging the write permission) if you can't access the directory's metadata to store the information for a new, additional file? You cannot. It is for this reason that directory-type files generally offer execute permission to one or more of the user owner, group owner, or others.

## How do you modify Linux file permissions?

You can modify file and directory permissions with the `chmod` command, which stands for "change mode." To change file permissions in numeric mode, you enter `chmod` and the octal value you desire, such as 744, alongside the file name. To change file permissions in symbolic mode, you enter a user class and the permissions you want to grant them next to the file name. 

> [!tip]
> ```bash
> $ chmod ug+rwx example.txt
> $ chmod o+r example2.txt
> ```

This grants read, write, and execute for the user and group, and only read for others. In symbolic mode, `chmod u` represents permissions for the user owner, `chmod g` represents other users in the file's group, `chmod o` represents other users not in the file's group. For all users, use `chmod a`.

Maybe you want to change the user owner itself. You can do that with the `chown` command. Similarly, the `chgrp` command can be used to change the group ownership of a file.