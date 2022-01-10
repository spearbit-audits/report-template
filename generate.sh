#!/bin/bash
# pandoc with gfm flavored markdown seems to have issues regarding
# Skipping --from gfm here
# pandoc summary.md -o summary.tex
pandoc --filter pandoc-minted.py --from gfm report.md -o report.tex
# A temporary work around to have page breaks.
# FIXME figure out a way to natively do this.
sed -i 's/textbackslash clearpage/clearpage/g' report.tex
# On github CI, pandoc seems to be generating the following
sed -i 's/textbackslash{}clearpage/clearpage/g' report.tex
pdflatex -shell-escape -interaction nonstopmode main.tex
# Running it a second time to generate references
pdflatex -shell-escape -interaction nonstopmode main.tex
