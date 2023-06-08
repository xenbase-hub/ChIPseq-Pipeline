#!bin/bash

alignDNA {
  if(LIBRARY == "PAIRED-END" && SPECIES == "xenopus-trop-v10")
      """
      bowtie2 -x ${params.bowtie_trop} -1 ${FASTQ[0]} -2 ${FASTQ[1]} -S ${SAMPLE}.sam --threads 4
      samtools view -@ 4 -b -o ${SAMPLE}.bam ${SAMPLE}.sam
      rm ${SAMPLE}.sam
      samtools fixmate -@ 4 -m ${SAMPLE}.bam ${SAMPLE}.temp.bam
      rm ${SAMPLE}.bam
      nreads=`samtools view -@ 4 -c -F 4 ${SAMPLE}.temp.bam`
      frac=`gawk -v total="\$nreads" 'BEGIN {frac=500000000/total; if (frac > 1) {print 0.999} else {print frac}}'`
      samtools view -@ 4 -bs \$frac ${SAMPLE}.temp.bam -o ${SAMPLE}.downsample.bam
      rm ${SAMPLE}.temp.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.downsample.bam -o ${SAMPLE}.sorted.bam
      rm ${SAMPLE}.downsample.bam
      samtools markdup -@ 4 -r ${SAMPLE}.sorted.bam ${SAMPLE}.final.bam
      rm ${SAMPLE}.sorted.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.final.bam -o ${SAMPLE}.final.sorted.bam
      rm ${SAMPLE}.final.bam
      samtools index -@ 4 ${SAMPLE}.final.sorted.bam
      """
  else if(LIBRARY == "PAIRED-END" && SPECIES == "xenopus-laevis-v10")
      """
      bowtie2 -x ${params.bowtie_laevis} -1 ${FASTQ[0]} -2 ${FASTQ[1]} -S ${SAMPLE}.sam --threads 4
      samtools view -@ 4 -b -o ${SAMPLE}.bam ${SAMPLE}.sam
      rm ${SAMPLE}.sam
      samtools fixmate -@ 4 -m ${SAMPLE}.bam ${SAMPLE}.temp.bam
      rm ${SAMPLE}.bam
      nreads=`samtools view -@ 4 -c -F 4 ${SAMPLE}.temp.bam`
      frac=`gawk -v total="\$nreads" 'BEGIN {frac=500000000/total; if (frac > 1) {print 0.999} else {print frac}}'`
      samtools view -@ 4 -bs \$frac ${SAMPLE}.temp.bam -o ${SAMPLE}.downsample.bam
      rm ${SAMPLE}.temp.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.downsample.bam -o ${SAMPLE}.sorted.bam
      rm ${SAMPLE}.downsample.bam
      samtools markdup -@ 4 -r ${SAMPLE}.sorted.bam ${SAMPLE}.final.bam
      rm ${SAMPLE}.sorted.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.final.bam -o ${SAMPLE}.final.sorted.bam
      rm ${SAMPLE}.final.bam
      samtools index -@ 4 ${SAMPLE}.final.sorted.bam
      """
  else if(LIBRARY == "SINGLE-END" && SPECIES == "xenopus-trop-v10")
      """
      bowtie2 -x ${params.bowtie_trop} -q -U ${FASTQ[0]} -S ${SAMPLE}.sam --threads 4
      samtools view -@ 4 -b -o ${SAMPLE}.bam ${SAMPLE}.sam
      rm ${SAMPLE}.sam
      nreads=`samtools view -@ 4 -c -F 4 ${SAMPLE}.bam`
      frac=`gawk -v total="\$nreads" 'BEGIN {frac=500000000/total; if (frac > 1) {print 0.999} else {print frac}}'`
      samtools view -@ 4 -bs \$frac ${SAMPLE}.bam -o ${SAMPLE}.downsample.bam
      rm ${SAMPLE}.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.downsample.bam -o ${SAMPLE}.sorted.bam
      rm ${SAMPLE}.downsample.bam
      samtools markdup -@ 4 -r ${SAMPLE}.sorted.bam ${SAMPLE}.final.bam
      rm ${SAMPLE}.sorted.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.final.bam -o ${SAMPLE}.final.sorted.bam
      rm ${SAMPLE}.final.bam
      samtools index -@ 4 ${SAMPLE}.final.sorted.bam
      """
  else if(LIBRARY == "SINGLE-END" && SPECIES == "xenopus-laevis-v10")
      """
      bowtie2 -x ${params.bowtie_laevis} -q -U ${FASTQ[0]} -S ${SAMPLE}.sam --threads 4
      samtools view -@ 4 -b -o ${SAMPLE}.bam ${SAMPLE}.sam
      rm ${SAMPLE}.sam
      nreads=`samtools view -@ 4 -c -F 4 ${SAMPLE}.bam`
      frac=`gawk -v total="\$nreads" 'BEGIN {frac=500000000/total; if (frac > 1) {print 0.999} else {print frac}}'`
      samtools view -@ 4 -bs \$frac ${SAMPLE}.bam -o ${SAMPLE}.downsample.bam
      rm ${SAMPLE}.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.downsample.bam -o ${SAMPLE}.sorted.bam
      rm ${SAMPLE}.downsample.bam
      samtools markdup -@ 4 -r ${SAMPLE}.sorted.bam ${SAMPLE}.final.bam
      rm ${SAMPLE}.sorted.bam
      samtools sort -@ 4 -m 12G ${SAMPLE}.final.bam -o ${SAMPLE}.final.sorted.bam
      rm ${SAMPLE}.final.bam
      samtools index -@ 4 ${SAMPLE}.final.sorted.bam
      """
}
