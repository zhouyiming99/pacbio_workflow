#!/bin/bash

# 输入上一步生成的 HiFi 文件
hifi_input=sample.hifi.bam
# 引物序列文件 (fasta 格式)
primers=primers.fasta
# 输出前缀
output_prefix=sample.demux

# 运行 lima 
# --isoseq 模式会自动识别 5' 和 3' 端引物
# --peek-guess 用于自动检测条码组合
lima $hifi_input $primers $output_prefix.bam \
    --isoseq \
    --peek-guess \
    --threads 16
