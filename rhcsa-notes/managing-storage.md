## MBR and GPT Partitions

Partitions are needed in order to use a hard drive. Some operating systems use one parition, while others like Linux make use of multiple partitions at once. The latter is beneficial because:

- Easier to distinguish data types.
- It allows us to use specific mount options for the different partitions.
- It makes backup strategies easier.
- Filling up one partition does not make the rest of the system unstalbe. 

It's also possible to use LVM logic volumes or Startis file systems rather than multiple partitions.

### MBR 

The Master Boot Record (MBR) was created in the 1980s to define thelayout of hard disks. During this period, users could have multiple operating systems installed on their computer. MBR allowed the segmentation on the disk for each OS. The MBR used the first 512 bytes of the HDD, and the boot loader was present. 64 bytes were used for the partition table, and the MBR would allow no more than 4 partitions to be used at once. 

The maximum size a partition could be was 2 TiB. It was possible to created **extended partitions** as opposed to **primary partitions**. An extended partition allowed for the creation of up to 15 logical partitions.

### GPT

MBR is not suitable for modern drive sizes, so a new partition scheme was created. This partition scheme is the **GUID Partition Table** (GPT). Computers that use the **Unified Extensible Firmware Interface (UEFI)**, GPT partitions are the only options that are available for addressing disks.

The benefits of GUID include:

- Maximum partition size of 8 zebibytes.
- Maximum of up to 128 partitions.
- No need to distinguish between primary, extended, and logical partitions.
- GPT used 128-bit GUID to identify partitions.
- Be default, a backup GUID partition is created at the end of the disk. This solves the single point of failure issue that afflicted MBR partition tables.

## Storage Measurement Units

Different measurement units are utilised when it comes to storage. In some cases it may be a megabyte (MB), in others it might be a mebibyte (MiB). The difference between these two are:

- A megabyte is a multiple of 1000.
- A mebibyte is a multiple of 1024.

In the early days of computing, this difference was unimportant, but large storage sizes of the modern era have changed this. When it comes to Linux, the binary numbers - MiB, not MB - have become the standard. The following table captures the different measurement units:

| Symbol | Name | Value | Symbol | Name | Value |
| --- | --- | --- | --- | --- | --- |
| KB | Kilobyte | 1000^1^ | KiB | Kibibyte | 1024^1^ |
| MB | Megabyte | 1000^2^ | MiB | Mebibyte | 1024^2^ |
| GB | Gigabyte | 1000^3^ | GiB | Gibibyte | 1024^3^ |
| TB | Terabyte | 1000^4^ | TiB | Tebibyte | 1024^4^ |
| PB | Petabyte | 1000^5^ | PiB | Pebibyte | 1024^5^ |
| EB | Exabyte | 1000^6^ | EiB | Exbibyte | 1024^6^ |
| ZB | Zettabyte | 1000^7^ | ZiB | Zebibyte | 1024^7^ |
| YB | Yottabyte | 1000^8^ | YiB | Yobibyte | 1024^8^ |

## Managing File Systems and Parititions

Modern RHEL systems can use both MBR and GPT. The `fdisk` utility has been around for a long time and can be used for MBR and GPT. The `gdisk` utlity is used for GPT partitions. Another option is `parted`. `parted` is easier to use, but hides more advanced features.

First, we need to specify the name of the disk device to use as an argument, which can be done through the `lsblk` command. The following table shows common disk devices.

| Device | Description |
| --- | --- |
| `/dev/sda` | A disk that uses the SCSI driver. Used for both SCSI and SATA. |
| `/dev/nvmn1` | The first drive on the NVM express interface. |
| `/dev/hda` | Legacy IDE device type. |
| `/dev/vda` | Common disk drive for KVM virtual machines. |
| `/dev/xvda` | Disk in the Xen virtual macine that uses the Xen disk driver. |

Notice that almost all the devices end in an **a**. The reason for this is that it's the first disk found by the system. The second would be something with a **b** at the end, and going up to **z**, such as `/dev/sdz`. After this, the kernel will create names like `/dev/sdaa`, `/dev/sdab`. For NVMe devices, numbers are used instead of letters.

## MBR Extended and Logical Partitions
