

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

<!-- html table generated in R 2.15.2 by xtable 1.7-1 package -->
<!-- Fri May 10 09:45:42 2013 -->
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

1. **LH2-BIOTI25 (Linux)**  
**Model**: HP EliteBook Folio 9470M  
**OS**: openSUSE 12.3 x86_64 (kernel version 3.7.10-1.4-desktop)  
**Specs**:
  * RAM: 8 GB
  * CPU: 

### Benchmark







![plot of chunk plotting](figure/plotting1.png) ![plot of chunk plotting](figure/plotting2.png) 

