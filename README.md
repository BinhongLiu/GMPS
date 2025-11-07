# Exploring Functional Insights into the Human Gut Microbiome via the Structural Proteome

Here we provide associated scripts and PDB files for the manuscript: Functional Discovery of the Human Gut Microbiome via the Structural Proteome.


## 1. Scripts
The scripts to analyze the data and plot the figures in the manuscript are deposed in the fold `scripts`.<br />

Mainly including codes to do:<br />
a. structure alignment<br />
b. structure clustering<br />
c. structural tree visualization<br />
d. structural domain segmentation<br />
<br />
<br />

## 2. The human Gut Microbial Protein Structure database (GMPS)
The human Gut Microbial Protein Structure database (GMPS) includes AlphaFold2 predicted protein structures from 1255 phage genomes and 968 bacteria genomes. The GMPS database is freely available to the public without registration or login requirements (https://www.gmpsdb.cn). Users can freely download the genomes, protein sequences, and protein structures. Users can also perform online searches across microbial genomes for human gut microbial proteins have similar structures to the uploaded structural template. 
<br />
<br />

<img src="https://github.com/user-attachments/assets/c54e946c-0b68-4b8a-9553-cd457b4fc208" width="500" />
<br />

<br />
<br />
<img src="https://github.com/user-attachments/assets/64f38fd2-acae-42be-a890-f7deb9377dfa" width="500" />
<br />
<br />

### 2.1 Download GMPS via wget
We have provided a file ([wget_links_download.csv](https://github.com/BinhongLiu/GMPS/blob/main/wget_links_download.csv)) containing links through which users can directly download the database using e.g. wget.
<br />
### 2.2 Bulk download of GMPS
The GMPS database, along with the genomes, protein sequences, and predicted protein structures of the 12 well-studied bacteriophages of E. coli, are also available for bulk download from Zenodo (https://doi.org/10.5281/zenodo.14305030, https://doi.org/10.5281/zenodo.17461341, https://doi.org/10.5281/zenodo.17461360).
<br />
<br />
<br />

## 3. GMPS pipeline (for local test)
Pipeline (https://github.com/kad-ecoli/GMPS/) to perform structural search through the Gut Microbial Protein Structure (GMPS) database.

### Installation ###

Most executables are already precompiled for 64bit Linux at "Apps/".
(Optionally) to generate images for the top 10 hits, set up the path to PyMOL executable at line 18 of GMPS_Search_v2.sh:
```bash
pymol=/usr/bin/pymol
```

This package only includes structures of one species (the bacteria Bifidobacterium adolescentis). To download structures of other species:
```bash
./GMPS_download.sh
```

### Run ###

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

## 4. Dense Enzyme Retrieval (DEER)
DEER (Dense Enzyme Retrieval) provides a method for finding functionally related human-bacteria isozymes using learned dense vector representations (embeddings). This repository (https://github.com/WangJiuming/deer) contains the code, pre-trained models, and example data necessary to reproduce the results and apply DEER to new enzyme sequences, as presented in our paper.
### CAUTION! ###
The current DEER model was pre-trained on the CARE enzyme dataset and is specifically optimized for enzyme retrieval. DEER results should not be used for downstream analysis when non-enzyme templates are employed for remote homolog searches. To apply DEER for other protein types (e.g., spike protein), users must retrain the model.

### Citation ###
If you use DEER or this codebase in your research, please cite our paper:
```
<br />
<br />

@misc{liu2025Exploring,
  author={Liu, H. and Shen, J. and others},
  title={Exploring Functional Insights into the Human Gut Microbiome via the Structural Proteome},
  year={2025},
  note={Cell Host & Microbe}
}
```


