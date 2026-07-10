## The Role of the Linux Kernel

The kernel manages the I/O instructions that it receives from the software and then translates them into the processing instructions that are then processed and executed by the CPU and other hardware. It takes care of many different system tasks, including the scheduler.

## Kernel Threads and Drivers

Operating system tasks performed by the kernel are implemented by different kernel threads. These threads can be viewed with the command `ps aux`. The names of the kernel threads are displayed between brackets.

Hardware initialisation is another important task that the kernel handles. All hardware on the computer is controlled by drivers, and drivers must be loaded by the kernel in order to use the features provided by a component. The kernel is modular, and drivers are loaded as kernel modules.

It's not uncommon to come across a piece of hardware that does not function as it should because the manufacturer does not provide an open source driver, and an alternative to this is to make use of closed source drivers. Closed source drivers are not ideal, because if a driver causes the kernel to crash, developers are not able to check out the source code and figure out what's causing the problem. A tainted kernel is a kernal that contains closed source drivers. Identifying a kernel as tainted can be helpful because a kernel crash is likely being caused by a closed source driver.

### Analysing the Kernel

Linux provides some tools that allow us to check what the kernel is doing:

- `dmesg`
- The `/proc` filesystem
- `uname`

When requiring detailed information about the kernel, it's a good idea to first turn to `dmesg`. This utility provides information about the kernel ring buffer, which is an area of memory where the kernel keeps its most recent log messages. An alternative method to get the same info in the kernel ring buffer is to use `journalctl --dmesg`, which is also the equivalent of `journalctl -k`.

When using the `dmesg` utility, all kernel related message are shown. Each begins with a timestamp that shows the second that the event was logged. This indicator is relative to the start of the kernel, which makes it easy to see how many seconds have passed between the start of the kernel and an event. 

Another way to get information is through `/proc`. This filesystem is an interface to the Linux kernel, and contains files with detailed status info about what is happening on the server. Many of the files in here are very readable and contain info about the CPU, mounts, memory, and much more. An example is `/proc/meminfo`, which provides details about different memory segments and what is happening in these segments.


The `uname` command also provides useful information.

- `uname -a`: Provides an overview of the system
- `uname -r`: Provides the version of the kernel being used

Another good one is `hostnamectl status`, which offers general information about the system.

## Kernel Modules

Before Linux 2.0, the kernel needed to be compiled every time specific drivers were needed for a computer to work correctly. Today, the kernel is modular, meaning that the drivers are loaded as modules when needed on top of an otherwise small core kernel. This is a very efficient system, as it includes only those modules that are needed for the system.

### Hardware Initialisation

The loading of drivers is automated, and follows these steps:

1. During the boot process, the kernel probes all available hardware.
2. When a hardware component is detected, the `systemd-udevd` process loads the appropriate driver and then makes the hardware device available to the system.
3. In order to decide how devices are loaded and used, `systemd-udevd` follows the rules set in `/usr/lib/udev/rules.d`. These files should not be modifed as they are provided by the system.
4. After this, `systemd-udevd` next checks `/etc/udev/rules.d` to see if there are any custom rules if available.
5. All required kernel modules are loaded automatically during this process and the status about each module and its associated hardware is written to the `sysf` file system, located at the `/sys` directory. The kernel tracks this pseudo file system in order to keep up with any settings that are related to hardware.

The `systemd-udevd` process does not run just a single time; rather it continuously monitors the plugging and unplugging of any new hardware devices. Try the following command to get an idea of how this works: `sudo udevadm monitor`, which lists all the events that are processed when new hardware devices are added.

### Managing Kernel Modules

Although the loading of modules is automatic, there may be occasions where the admin will need to load the correct modules manually.

Some of the most common commands to do this include:

| Command | Description |
| --- | --- |
| `lsmod` | Lists currently loaded modules |
| `modinfo` | Displays details about modules |
| `modprobe` | Loads modules, including dependencies |
| `modprobe -r` | Unload modules, and considers dependencies |

The `/etc/modules-load.d` directory can also be used to load modules. Here, files can be created to load modules automatically that have not been loaded by the system automatically. For default modules that need to always be loaded, there is a counterpart directory at `/usr/lib/modules-load.d`.

One of the best ways to figure out whether the module for a piece of hardware is not being loaded is by using the `lscpi` command. If no arguments are used, it shows all hardware devices that have been detected by the PCI bus. A useful argument is `-k`, which lists all of the modules that are used for PCI devices that were detected.

If there are PCI devices which have been found but no modules could be loaded, it likely means that that device is not supported by the kernel. It might be then worth checking to see if there's a closed source driver available for the device. 

### Managing Kernel Module Parameters

Sometimes it may be necessary to load modules with specific parameters. First, the correct parameter needs to be identified, and then it needs to be loaded manually by specifying the name of the parameter followed by the value that needs to be assigned. It's also possible to make this an automated process by creating a file inside `/etc/modprobe.d`, from which the module is loaded.

## Upgrading the Kernel

To upgrade the kernel on an RPM-bases system, use `dnf upgrade kernel`. For Debian-based systems, use `apt update && apt upgrade kernel`. 
