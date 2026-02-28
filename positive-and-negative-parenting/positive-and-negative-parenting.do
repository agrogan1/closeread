* SETUP

clear all // clear workspace

timer clear // clear timers

* GET DATA

* use "/Users/agrogan/Library/CloudStorage/Dropbox-UniversityofMichigan/Andrew Grogan-Kaylor/MICS/merging MICS and World Bank WDI/MICS_R15_Oct2023.dta"

use "/Users/agrogan/Library/CloudStorage/Dropbox-UniversityofMichigan/Andrew Grogan-Kaylor/Global Families MICS/H.O. MICS Feb 26/mergedMICSUpdate.dta"

* DATA WRANGLING

global discipline = "discprivileges discwhywrong discshook discshout discnewtask discspank discstrike disccallname dischithead dischitlimb discbeathard"

timer on 1 // turn on timer 1

* Child kicks, bites or hits other children or adults

codebook cdhitoth

recode cdhitoth (0/2=0)(3/14 = 1)(97/99 = .), generate(cdhitothR)

* discipline

// tab1 disc*

// codebook disc*

recode $discipline (0=0) (1=1) (7/9=.)

summarize disc*

timer off 1 // turn off timer 1

timer list

* ANALYSIS

timer on 2 // turn on timer 2

sample 25 // random sample

mixed cdhitothR $discipline || country: $discipline

timer off 2 // turn off timer 2

timer list // list out timers 


