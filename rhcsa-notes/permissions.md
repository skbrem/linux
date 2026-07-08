## File Ownership

### Showing Ownership

The user, group, and other owners are shown for a file when using the `ls -l` command. When a file is first created, the user creating it becomes the owner of the file, and the primary group of that user becomes the group owner. To check whether a user has permissions to a file or a folder, the shell checks ownership in the following order"

1. The shell checks whether the user is the user owner of the file being accessed. If the user is the owner of the file, the user gets the permissions that are set for the user and the shell does not check any further.
2. If the file is not owned by the user, the shell checks whether the user is in the same group that owns the file. If the user is a member of the group, they get access to the file with permissions of the group, and the shell does not look further.
3. If the user is not the owner nor in the group that owns the file and has not received permissions from the access control lists, the permissions from the others entity are assigned to the user.

While the `ls` command can provide ownership details for a specific directory, it can be helpful to get a list of all the files on a system that are owned by a user. This can be done with the `find` command and the `-user` argument. For example: 

```sh
find / -user fred
```

It's also possible to use `find` to look for files that have a specific group as their owner. The following command will search for files that are owned by the group **friends**:

```sh
find / -group users
```

### Changing User Ownership

When wanting to apply permissions, the first consideration should be ownership. The `chown` command is used for changing ownership. This is the syntax of the `chown` commmand:

```sh
chown who what
```

For example, the following command changes ownership for the file **todo** to the user fred:

```sh
chown fred todo
```

## Changing Group Ownership

There are two ways to change group ownership, with one being `chown`, or by using the command designed to do it, which is `chgrp`. When using the `chown` command, make sure to add `.` or `:` in front of the name of the group. The following command will change the group owner of the folder `/home/projects` to the group **friends**:

```sh
chown .friends /home/projects
```
There are many different ways that `chown` can be used. Some examples include:

- `chown fred file`: Sets user fred as the owner of file
- `chwon fred.friends file`: Sets user fred as user own and group friends as group owner of file.
- `chown fred:friends file`: Sets user fred as user owner and the group friends as group owner of file.
- `chown .friends file`: Sets group friends as group owner of file without changing the user owner.
- `chown :friends file`: Sets group friends as group owner of file without changing the user owner.

The `chgrp` command is used to change group ownership. Here is an example of changing the group ownership of the directory `/home/projects` to the friends group.

```sh
chgrp friends /home/projects
```

To change group ownership recursively, use the `-R` argument with `chgrp`.

### Default Ownership

When a user creates a new file, default ownership is applied. The primary group of that user also becomes the group owner. This is normally the group that is set in the `/etc/passwd` file as the user's primary group. If the user is a member of more groups, the user can use the `newgrp` command to change the primary group so that new files will get the new primary group as the group owner.

In order to see the primary group of a user, the `groups` command can be used. Of the different groups that are listed, the primary group is the first group found after the :.

Changing the primary group can be done with the `newgrp` command, followed by the name of the group that the user wants so set as the new primary group. This creats a new shell where the new temporary primary group is set. To use the `newgrp` command, the user must be a member of that group. A group password is able to be said for the group with the `gpasswd` command, but this isn't common. 

## Basic Permissions

### Read, Write, and Execute

The main three basic permissions allow a user to **read**, **write**, and **execute** files. The effects of these permissions is different when applied to files versus directories. When applied to a file, the read permission gives a user the right to open a file for viewing. When applied to a directory, it allows the user to list the contents within that directory. Worth noting that the read permission does not allow the user to read the files that are in the directory as the permissions system does not know inheritance, and read permissions on the file itself are necessary in order for the user to read it.

To open a file to read will still mean that the user will need to have read as well as execute permissions for the directory that the file is in otherwise the file would not be viewable to start with.

The write permission allows the user to modify the contents of a file, but it does not allow the user to create or delete a file, where the write permission o the directory is needed instead. To modify the permissions on a file, the user will need to be the owner or root. The write permission on a directory allows for the creation and remove of subdirectories.

The execute permission is used to run a program file. It's also needed on a directory if the user wants to do anything within that directory. This permission is never set by default, which is a part of what makes Linux inherently resistant to viruses. Only the user owner and the root is able to apply execute permissions.

Execute on a directory allows the user to `cd` into that directory. Without this permission, users are unable to enter into a directory. 

The following table illustrates the different permissions for files and directories:

| Permission | Files | Directories |
| --- | --- | --- |
| Read | View file content | List directory contents |
| Write | Change file contents | Create, delete files and subdirectories |
| Execute | Run program file | Change to directory |

### Applying Read, Write, and Execute

Applying is done by using the `chmod` command. When using `chmod`, the user can set the permissions for user, group, and others. It's possible to use `chmod` in both relative mode or absolute mode. In absolute mode, 3 digits are used for setting permissions.

### Numeric representation of permissions

| Permission | Representation |
| --- | --- |
| Read | 4 |
| Write | 2 |
| Execute | 1 |

Calculate the value needed for permissions using these numbers. For instance, to set the read, write, and execute for the user, read and write for the group, and only read for others, use this command:

`chmod 764 <file>`

All current permissions for the file will be replaced by these new permissions. If order to use `chmod` in relative mode, we switch away from numbers and instead use indicators.:

- Specifiy whether the change will be for the (**u**) user, (**g**), group, (**o**) others, or for all (**a**).
- Use an operator to add or remove permissions for the current mode.
- At the end of the command, use, `r`, `w`, or `x` to choose the permission to change to.

It's possible to omit the "for whom" part of the `chmod` command, or to remove permissions for everyone. The following will add the execute permission for all users:

`chmod +x <file>`

More complex commands can be strung together with `chmod`, for example:

`chmod g+w, o-r <file>`

This command will give write permission to the group while removing read permission for others. 

It's worth knowing how recursively changing permissions works as well. Consider the following:

1. Start a root shell and type `mkdir ~/files`.
2. Use `cp/etc[a-e]* ~/files`. Ignore any warnings that are presented. 
3. Use `ls -l ~/files/*` and see what permissions are given.
4. Use `chmod -R a+x ~/files`.
5. Type `ls -l ~/files/*`. All files have become executable as well.

Setting so many files to be executable can lead to some serious security issues. To recursively change permissions, it's a good idea to use `X` rather than `x`. For instance, `chmod -R a+X files` is better.

## Advanced Permissions

Along with the basic permissions, it's also possible to use advanced permissions in Linux. There are three advanced permissions available:

1. The set user ID (SUID) permission. This can be helpful in specific situations but it's overall better to avoid setting this permission as much as possible as it can cause security holes.
2. Group ID (GUID) is the next advanced permission. Similar to SUID but based on groups. 
3. Sticky bit. Useful for protecting a file against accidental deletion where multiple users have write permissions.

### Table for SUID, GUID, and Sticky Bit

| Permission | Numeric | Relative | Files | Directories |
| --- | --- | --- | --- | --- |
| SUID | 4 | u+s | User executes file with permission of owner | No use |
| GUID | 2 | g+s | User executes file with permission of group owner | File created in dir get same group owner |
| Sticky Bit | 1 | +t | No Use | Prevents users from deleting files from other users |

## Default permissions with umask

ACLs or umask are used to set the default permissions, but umask is the more common way of doing this. When a new file is created, it has a set of permissions that are automatically applied to it. A numeric value is used which is then subtracted from the max permissions that can be applied for a file or directory. The max that can be set for a file is 666, and the max for a directory is 777.

A default `umask` setting of 022 means a permissions value of 644 for all new files and a permission value of 755 for all new directories. 

### umask values and results

| Value | Files | Directories |
| --- | --- | --- |
| 0 | Read and write | Everything |
| 1 | Read and write | Read and write |
| 2 | Read | Read and execute |
| 3 | Read | Read |
| 4 | Write | Write and execute |
| 5 | Write | Write |
| 6 | Nothing | Execute |

There are two different ways to change the umask setting: for either all users or for individual users. In order to change the umask for all users, the umask setting needs to be checked when starting the shell environment as directed by `/etc/profile`. The correct way to do it is by creating a shell script with the name `umask.sh` in the `/etc/profile.d` directory and specifying the umask that should be used in the script. 

An alternative to setting umask throughh `/etc/profile` and related files is to instead change the umask settings in a file with the name of `.profile`. This is created in the home directory of an individual user, meaning that any settings are applied only to that user.

## Extended Attributes

One way of securing the files on a server is by using attributes. Some of the most common attributes include the following:

- **A**: Ensurse that the file access time of a file is not able to be modified. This is helpful for files that are accessed on a regular basis and which this regular access can cause performance issues as every time it's accessed this is written to the file's metadata.
- **a**: Allows a file to be added to but not removed.
- **c**: This attribute ensures that a file is compressed the first time that a compression engine becomes active - only available where volume-level compression is supported.
- **D**: Ensures that any changes to a file are written to disk immediately instead of to the cache first. Good for important database files to make sure that there's no chance of them being lost.
- **d**: Ensures the file is not backed up in backups where the `dump` tool is used.
- **I**: Ensures that indexing for the directory is enabled.
- **i**: This will make a file immutable. No changes can be made to the file at all, useful for files that need a bit of extra protection.
- **s**: Overwrites the blocks where the file is stored with zeroes after that file has been deleted. This makes it almost impossible to recover this file once removed.
- **u**: Saves undelete information. Allows a utility to be developed that works with info to salvage deleted files.

The `chattr` command is used to apply attributes to a file. The command `chattr +s <file>` will apply the `s` attribute to a file. To remove an attribute from a file, use the same command; in this case: `chattr -s <file>` will remove the `s` attribute.
