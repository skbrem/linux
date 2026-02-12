## Archiving and Compressing

### Archiving a directory or single file

`tar -cvf <name-of-archive.tar> /path/to/directory-or-file`

- `c`: **C**reates an archive
- `v`: **V**erbose mode to provide information about the compression process within the terminal. 
- `f`: Specify the **f**ile name of the archive. 

### Compressing

It's also possible to integrate the gzip utility in order to **compress** an archive so it uses less space on the disk. This is done using the `z` option within tar if using the Gzip tool for compression. 

`tar -cvzf <name of archive.tar.gz> /path/to/directory-or-file`

This will create a archived file with the `tar.gz` appended on the end to show that it has been both archived with tar and compressed with gzip. 

An easy way to remember the order:

1. **C**reated
2. **V**erbosely
3. **Z**ipped
4. **F**ile

Note that `f` always needs to come at the end of the command.

### Extracting an archived file

Extraction of an archive file is simple as it's a reverse of the original commands. 

`tar -xvf <archive.tar`

Notice that the `c` has been swapped for `x`. 

- `x`: Uncompress

If the file is also zipped, use the following command:

`tar -xvzf <archive.tar.gz`

Files that use the format `.tgz` are the same as `tar.gz` but they are not as common. 

### Other compression options

While Gzip is the most common, there are others that are in use:

- `Bzip2`
- `XZ`
- `Zstandard (zstd)`

These can be implemented in the following way:

| Format | Tar flag | Speed | Size (Ratio) | Resource Usage | Use Case |
| --- | --- | --- | --- | --- | --- |
| .tar | (None) | Instant | None | Very low | Bundling files together |
| .tar.gz | -z | Fast | Good | Low | Scripts, logs, everyday Linux usage. |
| .tar.zst | --zstd | Very fast | Great | Moderate | Modern cloud backups |
| .tar.xz | -J | Slowest | Best | High | Software distribution (Kernel) and long-term cold storage |
| .tar.bz2 | -j | Slow | Great | Moderate | Legacy systems; largely being replaced |

Zstd has become the standard in much of the modern DevOps and cloud world and is superior to other choices in virtually every metric. Use the following to create a `.tar.zst` compressed archive. 

`tar --zstd -cvf <name-of-archive.tar.zst>` 
