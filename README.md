Samsung 960 EVO SmartLog
===============
Short script to retrieve written and read data units, temperatures and number of unsafe shutdowns from S.M.A.R.T for Samsung 960 EVO NVMe SSD on Linux using the `nvme-cli` package. The raw data is converted to understandable units.

### Running

Since the script needs direct hardware access you should run it with 'sudo' or as root.

The script is created to read the info from `/dev/nvme0n1` but you can change that according to your needs. You can list all compatible devices available using:

`sudo nvme list`

### Dependencies

nvme-cli

You can install it using:

`sudo apt-get install nvme-cli`

### Additional info

Samsung offers different warranty levels depending on capacity of the SSD. The warnings set on this script apply to the 500 GB model. 
