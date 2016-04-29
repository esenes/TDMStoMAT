
# TDMStoMAT
The following scriptis intended to read the TDMS file 'Prod_<date>.tdms' generated from the LabVIEW-based acquisition system every day from the PXI output files.
If necessary for the further analysis pay attention to the timestamps, beacause can happend that the events stored in a file are not related only to that date, but can vary (e.g. it happened that every night the file was generated at 23.00 inthead of at 00.00, so it was containing the events from 23.00 of the day befor the timestamp to the 22.59 of the correct day).


2) __readMATandsort.m__

reads the files `Prod_<date>.mat`, discard the backup pulses, perform a first analysis and save as output files named `Data_<date>.mat`.
If `buildExperiment=true` the Data files are merged in `Exp_<expname>.mat`.
This feature is intended to group a long data acquisition into a single file.

_The aim of the script is:_
- select just interlocks discarding the backup pulses
- save fields for the calibrated signals for INC, TRA, REF, IQs (for all three)
- calculate and save the metric (both INC-TRA and INC-REF)
- save fields for the calibrated signals of BPMs and the integral of the signals (-> info on charge)
- detect spikes, using or a digital filter or the comparison with the previous pulse


3) __Filtering.m__

still a work in progress.... 
