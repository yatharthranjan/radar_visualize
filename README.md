# radar_visualize
Matlab Scripts for gathering and visualising Data collected from RADAR platform 


## visualize.m
This is the entry point for all the other scripts. Usage is defined in the script. Currently only works with Battery level and Acceleration Data from [RADAR-base platform](https://github.com/RADAR-base)

Data is extracted from HDFS in CSV format.

## ftp_client.m
This script intends to download a folder of data from an FTP server. With context of the RADAR-base platform, data is identified under a subject ID and a topic. This is for getting data for a particular subject and topic.
After downloading it also lists all the available subject IDs.
