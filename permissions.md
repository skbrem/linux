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
> The permission of `744`, for example, shows that `7` belongs to the user, the first `4` belongs to the group, and the third `4` belongs to others. 
