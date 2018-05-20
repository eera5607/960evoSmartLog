Samsung SSD S.M.A.R.T. Log
===============
Short script to retrieve terabytes written (TBW), temperatures and number of unsafe shutdowns from S.M.A.R.T for Samsung SSDs on Linux. The raw data is converted to understandable units.

### Running

Since the script needs direct hardware access you should run it with 'sudo' or as root.

At this moment, I have 2 scripts, one for the Samsung 960 EVO NVME and another for the Samsung 850 EVO mSATA. 

The scripts were created to read the info from `/dev/nvme0n1` (960 EVO) or `/dev/sda` (850 EVO) but you can change that according to your needs. You can list all compatible devices available using 1 of this 2 commands:

`sudo nvme list`

`smartctl --scan`

### Dependencies

- nvme-cli
- smartctl

You can install them using:

`sudo apt-get install nvme-cli`

`sudo apt install smartmontools`

### Additional info

Samsung offers different warranty levels depending on capacity of the SSD. The warnings set on this script apply to the 500 GB models. 

All conversions are made to show the exact same results as on Samsung Magician software for Windows. 
