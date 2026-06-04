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

`chgrp friends /home/projects`

To change group ownership recursively, use the `-R` argument with `chgrp`.

### Default Ownership

When a user creates a new file, default ownership is applied. The primary group of that user also becomes the group owner. This is normally the group that is set in the `/etc/passwd` file as the user's primary group. If the user is a member of more groups, the user can use the `newgrp` command to change the primary group so that new files will get the new primary group as the group owner.

In order to see the primary group of a user, the `groups` command can be used. Of the different groups that are listed, the primary group is the first group found after the :.

Changing the primary group can be done with the `newgrp` command, followed by the name of the group that the user wants so set as the new primary group. This creats a new shell where the new temporary primary group is set. To use the `newgrp` command, the user must be a member of that group. A group password is able to be said for the group with the `gpasswd` command, but this isn't common. 

## Basic Permissions

### Read, Write, and Execute

The main three basic permissions allow a user to **read**, **write**, and **execute** files. The effects of these permissions is different when applied to files versus directories. When applied to a file, the read permission gives a user the right to open a file for viewing. When applied to a directory, it allows the user to list the contents within that directory.
