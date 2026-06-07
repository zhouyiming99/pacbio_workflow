#!/bin/bash

# 参考基因组路径
ref=reference.fasta
# 输入 lima 处理后的文件（通常取 .flnc.bam 或特定条码文件）
input_bam=sample.demux.5p--3p.bam
# 输出排序后的比对文件
aligned_bam=sample.aligned.sorted.bam

# 运行 pbmm2 比对
# --preset HIFI 针对高准确度长读段优化
# --sort 自动对输出进行排序并生成索引
pbmm2 align $ref $input_bam $aligned_bam \
    --preset HIFI \
    --sort \
    --threads 16 \
    --log-level INFO
