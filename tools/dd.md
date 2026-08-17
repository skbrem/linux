It's possible to use the `dd` command to write ISO files to an external drive, like a USB. Note that `dd` is a powerful and potentially dangerous tool and all commmands should be double checked. We can write an ISO file to a USB with the following command:

```bash
sudo dd if=/path/to/file.iso of=/dev/sda bs=4M status=progress oflag=sync
```

- `bs=4M` is used to specify a block size of 4 Megabytes per operation, which can speed up data throughput and put less strain on the CPU.
- `status=progress` provides real-time progress on the total elapsed time, the data written, and how fast it's being written.
- `oflag=sync` forces write operations to complete on the drive for every block before moving to the next one, which prevents any false finished signals. It's also possible to swap this out for `conv=fsync`, which writes everything to RAM buffers and then issues a full flush at the end before exiting.

Always remember to double check that the correct device is being written to with `lsblk` as it's very easy to wipe out a working drive with `dd`. Also keep in mind that because we are writing at a block level, we target the physical device itself with `/dev/sda` rather than a partition on the device.

## Securely Wiping A Drive

Another use for `dd` is to wipe a drive, either in preparation for selling the drive or for getting it ready for encrypting with LUKS.

The most secure way of doing this is with the following command:

```bash
sudo dd if=/dev/urandom of=/dev/sda bs=4M status=progress
```

This is recommended for preparing a drive for encryption or for sanitising a drive. This needs a fair amount of CPU overhead and depending on the size of the drive, can take quite a long time as it fills the drive's entire capacity with cryptographically secure random bytes. 

Another way of doing something similar is with the following command:

```bash
sudo dd if=/dev/zero of=/dev/sda bs=4M status=progress
```

This instead fills the drive with zeroes, which is significantly faster and makes the data on the drive irrecoverable. This is a good idea if the drive is going to be sold or for resetting corrupted partition tables, but it does not provide forensic obfuscation like the previous command.
