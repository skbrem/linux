## The Shebang

The shebang `#!/bin/bash` is usually found at the top of every bash script. The function of the shebang is to tell the operating system which interpreter it needs to use in order to run the file. Without the shebang, the system will guess, which can lead to it guessing wrong.

`#!/bin/bash` specifically tells the kernel to use Bash no matter what other interpreter the user might be using at the time. Leaving out the shebang means that the script is not considered **portable**.
