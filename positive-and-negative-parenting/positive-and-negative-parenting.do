clear all

use "/Users/agrogan/Library/CloudStorage/Dropbox-UniversityofMichigan/Andrew Grogan-Kaylor/MICS/merging MICS and World Bank WDI/MICS_R15_Oct2023.dta"

tabulate no_aggress 

recode no_aggress (0=1)(1=0), generate(aggress)

d d_*

mixed aggress cage sex_selected d_* || country: d_*
