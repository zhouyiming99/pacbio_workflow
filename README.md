# PacBio Long-Read Processing Pipeline

This repository contains a standard workflow for processing Pacific Biosciences (PacBio) sequencing data, moving from raw `subreads.bam` to high-accuracy HiFi reads, primer removal, and genomic alignment.

## Workflow Overview

### 1. HiFi Reads Generation (`ccs`)
Converts raw subreads into Circular Consensus Sequences (HiFi reads).
*   **Input**: `input.subreads.bam`
*   **Output**: `sample.hifi.bam`
*   **Key Parameters**: Minimum passes of 3 and a minimum predicted accuracy of 99% (Q20).

### 2. Primer Removal & Demultiplexing (`lima`)
Identifies and removes primers or adapters, particularly for Iso-Seq or barcoded libraries.
*   **Input**: `sample.hifi.bam` and `primers.fasta`
*   **Output**: Demultiplexed `.bam` files (e.g., `sample.demux.5p--3p.bam`)
*   **Mode**: Optimized for Iso-Seq with automatic primer pair detection.

### 3. Sequence Alignment (`pbmm2`)
Aligns HiFi reads to a reference genome or transcriptome using PacBio’s wrapper for minimap2.
*   **Input**: Demultiplexed `.bam`
*   **Reference**: `reference.fasta`
*   **Output**: Sorted and indexed `sample.aligned.sorted.bam`
*   **Preset**: Specifically tuned for HiFi data.

## Prerequisites

All tools can be installed via `conda` through the **pbbioconda** channel:
```bash
conda install -c bioconda ccs lima pbmm2
```

## Usage

1.  **Generate HiFi Reads**:
    ```bash
    chmod +x 01_ccs.sh
    ./01_ccs.sh
    ```

2.  **Remove Primers**:
    *(Ensure your `primers.fasta` is correctly formatted with your specific adapter sequences)*
    ```bash
    chmod +x 02_lima.sh
    ./02_lima.sh
    ```

3.  **Align to Reference**:
    ```bash
    chmod +x 03_align.sh
    ./03_align.sh
    ```

## Important Notes

*   **Thread Allocation**: Scripts are currently set to use 16 threads (`--threads 16`).
*   **Primer Selection**: The `primers.fasta` used in Step 2 must match the kit used during library preparation (e.g., NEB, PacBio Iso-Seq, or custom barcodes).
*   **Performance**: `pbmm2` automatically sorts the output and generates a `.bai` index, saving additional post-processing steps.
