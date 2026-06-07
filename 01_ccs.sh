01_ccs.sh#!/bin/bash

# 输入原始 subreads 文件
subreads=input.subreads.bam
# 输出 HiFi 文件
hifi_output=sample.hifi.bam

# 运行 ccs 
# --min-passes 默认通常为 3 圈
# --min-rq 默认 0.99 (Q20)
ccs $subreads $hifi_output \
    --threads 16 \
    --min-passes 3 \
    --min-rq 0.99
