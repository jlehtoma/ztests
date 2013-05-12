

## Zonation 3.1.9 benchmarks

Main questions:

1. How fast does Zonation run on various hardware resources?
1. How hast does Zonation run on various operating systems?

### Data

Data from real-life analysis from the forest center of South-Savo is used. 20 
forest structure index layers form the basis of the biodiversity features. This
stack is duplicated accordingly if the analysis setup (e.g. matrix connectivity)
requires so.

While the analysis variants used (N=5) in this benchmark are not huge 
(~4 million effective cells), they are big enough to give an idea on Zonation 
performance in real-life planning related analysis.

Statistics on the biodiversity features as reported by Zonation:

    Matrix x dimension: 3044  
    Matrix y dimension: 2815  
    Cells with data = 3955305 locations with missing values = 4613555  

### Analysis variants

All variants are run using:

    removal rule = 2  
    warp factor = 1000  
    edge removal = 1  
    add edge points = 0   

Different analysis options used:

<!-- html table generated in R 3.0.0 by xtable 1.7-1 package -->
<!-- Sun May 12 17:28:42 2013 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> id </TH> <TH> nfeatures </TH> <TH> weights </TH> <TH> condition </TH> <TH> cmatrix </TH> <TH> cwkh </TH> <TH> cres </TH> <TH> mask </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD align="right">  15 </TD> <TD align="right"> 20.00 </TD> <TD> no </TD> <TD> yes </TD> <TD> no </TD> <TD> no </TD> <TD> no </TD> <TD> no </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD align="right">  16 </TD> <TD align="right"> 20.00 </TD> <TD> yes </TD> <TD> yes </TD> <TD> no </TD> <TD> no </TD> <TD> no </TD> <TD> no </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD align="right">  17 </TD> <TD align="right"> 40.00 </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> no </TD> <TD> no </TD> <TD> no </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD align="right">  18 </TD> <TD align="right"> 80.00 </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> no </TD> <TD> no </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD align="right">  19 </TD> <TD align="right"> 80.00 </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> no </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD align="right">  20 </TD> <TD align="right"> 80.00 </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> <TD> yes </TD> </TR>
   </TABLE>


`nfeatures` = Number of features  
`weights` = Weights  
`condition` = Condition layer (forest management operations) used  
`cmatrix` = Connecitivity matrix used (between forest types)  
`cwkh` = Interaction connectivity to woodland key-habitats used  
`cres` = Interaction connectivity to existing PAs used  
`mask` = Existing PAs masked in  

### Machines

Machines 1 and 2 are the same computer runinng with different OS.

1. **LH2-BIOTI25 (Linux)**  
**Model**: HP EliteBook Folio 9470M Laptop  
**OS**: openSUSE 12.3 x86_64 (kernel version 3.7.10-1.4-desktop)  
**Specs**:
  * RAM: 8 GB
  * CPU: Intel(R) Core(TM) i7-3667U CPU @ 2.00GHz, 2501 Mhz, 2 Core(s), 4 Logical Processor(s)
  * Hard-disk: ~256 GB SSD
  
1. **LH2-BIOTI25 (Windows)**  
**Model**: HP EliteBook Folio 9470M Laptop  
**OS**:  Windows 7 (version 6.1.7601)  
**Specs**:
  * RAM: 8 GB
  * CPU: Intel(R) Core(TM) i7-3667U CPU @ 2.00GHz, 2501 Mhz, 2 Core(s), 4 Logical Processor(s)  
  * Hard-disk: ~256 GB SSD  
  
1. **MRGTESLA (Windows)**  
**Model**: Dell Precision T7500 Workstation  
**OS**:  Windows 7 (version 6.1.7601, post2008Server)  
**Specs**:
  * RAM: 92 GB
  * CPU (2x): Processor: Intel(R) Xeon(R) CPU X5650  @ 2.67GHz, 2660 Mhz, 6 Core(s), 12 Logical Processor(s)
  * Hard-disk: ~500 GB SAS RAID disk array (10 000 rpm)

### Benchmark

All analysis runs were run 1 at a time. All time measures are parsed from the
resulting run-info file, so they are the ones reported by Zonation.





![plot of chunk plotting-elapsed](figure/plotting-elapsed.png) 

Out of these comparisons, the Linux machine performs the fastest. By scaling 
MRGTESLA to 1.0, the others perform in a following way:
<!-- html table generated in R 3.0.0 by xtable 1.7-1 package -->
<!-- Sun May 12 17:28:43 2013 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> MRGTESLA.win </TH> <TH> LH2BIOTI25.win </TH> <TH> LH2BIOTI25.linux </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.76 </TD> <TD align="right"> 0.41 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.73 </TD> <TD align="right"> 0.39 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.75 </TD> <TD align="right"> 0.41 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.69 </TD> <TD align="right"> 0.38 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.70 </TD> <TD align="right"> 0.38 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.70 </TD> <TD align="right"> 0.38 </TD> </TR>
   </TABLE>

Comparing Zonation on different operating systems on the same machine show the
following:
<!-- html table generated in R 3.0.0 by xtable 1.7-1 package -->
<!-- Sun May 12 17:28:43 2013 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> LH2BIOTI25.win </TH> <TH> LH2BIOTI25.linux </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.54 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.54 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.55 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.55 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.55 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD align="right"> 1.00 </TD> <TD align="right"> 0.53 </TD> </TR>
   </TABLE>

Averaging over all the variants, Linux machine performs ~1.8 times faster.

Looking at the time needed for initializing the analysis (reading in the data +
doing connectivity smoothings etc) show some differences as well.
![plot of chunk plotting-init](figure/plotting-init.png) 


### Comparing rank rasters

One essential question is, whether Zonation produces the same (or similar 
enough) results on different platforms. Following table summarizes the 
differences between different variants produced on two systems: 
`LH-BIOTI25 (Win)` and `LH-BIOTI25 (Linux)`. Table columns mean the following:

*Overall similarity*  

[Jaccard index](http://en.wikipedia.org/wiki/Jaccard_index)  is a statistic used for comparing the similarity and diversity of sample sets.

`jaccard.threshold`: which proportion of the ranks is compared using Jaccard 
index. Complement to "top-fraction", i.e. `0.99` means the best 1% of the 
landscape.

`jaccard.index`: value of the Jaccard index. Value 1 means that the compared 
sets overlap perfectly.

[Kendall tau rank correlation coefficient](http://en.wikipedia.org/wiki/Kendall_tau_rank_correlation_coefficient) is a measure of rank correlation, i.e., the similarity of
the orderings of the data when ranked by each of the quantities.

*Element-wise differentials*  



<!-- html table generated in R 3.0.0 by xtable 1.7-1 package -->
<!-- Sun May 12 17:28:43 2013 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> run </TH> <TH> jaccard.threshold </TH> <TH> jaccard.index </TH> <TH> kendall.tau </TH> <TH> kendall.tau.p </TH> <TH> max </TH> <TH> mean </TH> <TH> min </TH> <TH> std </TH>  </TR>
  <TR> <TD align="right"> 2 </TD> <TD align="right"> 17 </TD> <TD align="right"> 0.99 </TD> <TD align="right"> 0.99813 </TD> <TD align="right"> 0.99993 </TD> <TD align="right"> 0.000 </TD> <TD align="right"> 0.00064 </TD> <TD align="right"> 0.00 </TD> <TD align="right"> -0.00064 </TD> <TD align="right"> 0.00007 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD align="right"> 18 </TD> <TD align="right"> 0.99 </TD> <TD align="right"> 0.99581 </TD> <TD align="right"> 0.99993 </TD> <TD align="right"> 0.000 </TD> <TD align="right"> 0.00050 </TD> <TD align="right"> 0.00 </TD> <TD align="right"> -0.00050 </TD> <TD align="right"> 0.00007 </TD> </TR>
  <TR> <TD align="right"> 1 </TD> <TD align="right"> 19 </TD> <TD align="right"> 0.99 </TD> <TD align="right"> 0.99536 </TD> <TD align="right"> 0.99980 </TD> <TD align="right"> 0.000 </TD> <TD align="right"> 0.13363 </TD> <TD align="right"> 0.00 </TD> <TD align="right"> -0.17557 </TD> <TD align="right"> 0.00092 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD align="right"> 20 </TD> <TD align="right"> 0.99 </TD> <TD align="right"> 0.99753 </TD> <TD align="right"> 0.99980 </TD> <TD align="right"> 0.000 </TD> <TD align="right"> 0.13384 </TD> <TD align="right"> 0.00 </TD> <TD align="right"> -0.17571 </TD> <TD align="right"> 0.00092 </TD> </TR>
   </TABLE>


### Misc

If running a large set of analysis, MRGTESLA would obviously benefit from being
able to run several runs at the same time (more cores and RAM available).
