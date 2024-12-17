## GMPS ##
Pipeline to perform structural search through the Gut Microbial Protein Structure (GMPS) database.

## Installation ##

Most executables are already precompiled for 64bit Linux at "Apps/".
(Optionally) to generate images for the top 10 hits, set up the path to PyMOL executable at line 18 of GMPS_Search_v2.sh:
```bash
pymol=/usr/bin/pymol
```

This package only includes structures of one species (the bacteria Bifidobacterium adolescentis). To download structures of other species:
```bash
./GMPS_download.sh
```

## Run ##

Get help document:
```bash
./GMPS_Search_v2.sh -h
```

An example to search Human AADC through Bifidobacterium adolescentis
```bash
./GMPS_Search_v2.sh -q example/3rbf.pdb  -c Bacteria -s Bifidobacterium_adolescentis -o output
```
or simply
```bash
./GMPS_Search_v2.sh
```
The output files will be written to "output/results/C_Bacteria_S_Bifidobacterium_adolescentis_Q_3rbf/", where usalign_hits.csv is the list of identified hits, while the superimposed structures for the top 10 hits are available at "best_hit_models/".


## Citation ##
H Liu, J Shen, Z Zhang, C Zhang, K Wang, L Zheng, H Ni, D Xue, Y Ma, T Si, L Zheng, S Wang, C Jiang, L Dai
(2025) "Exploring Functional Insights into the Human Gut Microbiome via the Structural Proteome." Under revision.

