#!/bin/bash

# Homer installation
perl configureHomer.pl -install
nano ~/.bashrc
PATH=$PATH:/mnt/d/Software/Homer/.//bin/
source ~/.bashrc

# Preparing files
cat /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | less
cat /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | grep -n ^chr | less
cat /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | tail -n +30 | less
cat /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | tail -n +30 | cut -f 1,2,3,10 > /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_Homer_peaks.txt

# finding motifs
perl configureHomer.pl -list
perl configureHomer.pl -install hg38
findMotifsGenome.pl /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_Homer_peaks.txt hg38 /mnt/d/NGS/Samples/P6/Results/ -size 200

# finding a specific motif peaks
findMotifsGenome.pl /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_Homer_peaks.txt hg38 /mnt/d/NGS/Samples/P6/Results/ -find /mnt/d/NGS/Samples/P6/Results/knownResults/known41.motif > /mnt/d/NGS/Samples/P6/Results/Trachea-p73-ChIP-Seq.txt
annotatePeaks.pl /mnt/d/NGS/Samples/P6/Data/GSE129314_RUNX1ChIP_Homer_peaks.txt hg38 -m /mnt/d/NGS/Samples/P6/Results/knownResults/known41.motif > /mnt/d/NGS/Samples/P6/Results/Trachea-p73-ChIP-Seq2.txt
