
# TDMStoMAT
The following scriptis intended to read the TDMS file `Prod_<date>.tdms` generated from the LabVIEW-based acquisition system every day from the PXI output files.
If necessary for the further analysis pay attention to the timestamps, beacause can happend that the events stored in a file are not related only to that date, but can vary (e.g. it happened that every night the file was generated at 23.00 inthead of at 00.00, so it was containing the events from 23.00 of the day befor the timestamp to the 22.59 of the correct day).

_The aim of the script is:_
- read the TDMS file `Prod_<date>.tdms` and generate the equivalent matfile `Prod_<date>.mat` keeping the same structure inside

_Pay attention to:_
- start the script using a date referring to an existing file
- load the correct dependencies stored in the _function_ folder
