# MutectTitan2PyClone
R script to prepare inputs for PyClone

This script takes outputs of [Mutect2](https://github.com/broadinstitute/gatk) and [TitanCNA](https://github.com/gavinha/TitanCNA) and converts them into a PyClone input format, similar to `sequenza2PyClone` function from [sequenza](https://github.com/cran/sequenza)

Inputs: VariantsToTable (tsv file) from Mutect2 / SampleName.segs.txt file from TitanCNA

Usage:

    Rscript convert.R variants.table copynumber.seg.txt SampleName

