* analysis with older R15 data file

clear all

use "/Users/agrogan/Library/CloudStorage/Dropbox-UniversityofMichigan/Andrew Grogan-Kaylor/MICS/merging MICS and World Bank WDI/MICS_R15_Oct2023.dta"

recode no_aggress (0=1)(1=0), generate(aggress)

label variable aggress "child aggression"

describe d_*

mixed aggress sex_selected age_selected d_* || country: d_*

est store M1

etable, estimates(M1) /// use these estimate(s)
/* novarlabel */ /// variable names only; could use variable labels 
cstat(_r_b) /// beta's only
showeq /// show equation names
showstars showstarsnote /// show stars and note
column(depvar) /// column is depvar
title("Maximal Model of Parenting and Child Aggression Outcome") ///
export("mytable.md", replace)

spagplot aggress d_phys_spank, id(country) // spaghetti plot

predict u*, reffects // predict random effects

preserve // preserve older data

describe u? u1? // describe random effects

collapse u? u1?, by(country)







