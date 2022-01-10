# A Markdown based template for writing audit reports
## Requirements
1. [Pandoc](https://pandoc.org/)
2. [Pandocfilters](https://github.com/jgm/pandocfilters): `pip install pandocfilters`.
3. [LaTeX toolchain](https://www.latex-project.org/get/). We recommend a full install of LaTeX (installing individual `.sty` files are hard).
4. [Pygments](https://pygments.org/): `pip install pygments`.
5. bash

## Manual Changes

Manually update `title.tex` and `summary.tex`.

## Generating the PDF

*Manually*: Run `./generate.sh`. The report would be generated 

*CI*: There is a github action that generates the PDF.

1. Go to `Actions`, click on the last workflow.
2. `Artifacts` -> `Spearbit.pdf`: a ZIP file containing the pdf.

