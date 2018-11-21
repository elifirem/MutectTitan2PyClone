# MutectTitan2PyClone
R script to prepare inputs for PyClone

This script takes outputs of [Mutect2](https://github.com/broadinstitute/gatk) and [TitanCNA](https://github.com/gavinha/TitanCNA) and converts them into a PyClone input format, similar to `sequenza2PyClone` function from [sequenza](https://github.com/cran/sequenza).

**Inputs**: VariantsToTable (tsv file) for variants that 'PASS'ed from Mutect2 and *.segs.txt file from TitanCNA

**Usage**:

    $ Rscript convert.R variants.table copynumber.segs.txt SampleName

