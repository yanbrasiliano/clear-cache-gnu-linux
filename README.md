## Clear Cache GNU/Linux 🧹

### Introduction

This script is designed to clear and deflate cache memory on GNU/Linux systems. Cache memory, used by the operating system to quickly access frequently used data, can sometimes consume significant resources. Clearing it can help free up memory, potentially improving system performance. This tool is particularly useful for systems that remain up for long periods.

### Requirements

- GNU/Linux operating system
- Bash shell
- Root or sudo privileges

### Installation

To download the script, use the following command:

```sh
git clone git@github.com:yanbrasiliano/clear-cache-gnu-linux.git
```

### Setting Permissions

Before running the script, you need to make it executable. This is done with the chmod command:

```sh
sudo ./clear-cache.sh
```

Upon execution, the script will clear the cache memory and provide a summary of the memory status before and after the operation.

### Safety Warning

Please be aware that clearing the cache can affect system stability and performance, especially on production systems. It is recommended to use this script responsibly and preferably test it in a controlled environment before regular use.
