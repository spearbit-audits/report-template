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

# Replacing the count placeholders in summary.tex
# First, we need severity_counts.sh in the current directory
if [ ! -f ./severity_counts.sh ]; then
    echo "You need to copy severity_counts.sh from compile-issues to the current directory."
    exit 1
fi
# If the file exists, import it and check if the TOTAL_RISK_COUNT var is set
. ./severity_counts.sh
if [ -z ${TOTAL_RISK_COUNT+x} ]; then
    echo "Values missing in severity_counts.sh. Copy the correct file from compile-issues."
    exit 1
fi
# Values are correct, replace in summary.tex
sed -i "s/TOTAL_RISK_COUNT/$TOTAL_RISK_COUNT/g" summary.tex
sed -i "s/CRITICAL_RISK_COUNT/$CRITICAL_RISK_COUNT/g" summary.tex
sed -i "s/HIGH_RISK_COUNT/$HIGH_RISK_COUNT/g" summary.tex
sed -i "s/MEDIUM_RISK_COUNT/$MEDIUM_RISK_COUNT/g" summary.tex
sed -i "s/LOW_RISK_COUNT/$LOW_RISK_COUNT/g" summary.tex
sed -i "s/GAS_INFO_COUNT/$(($GAS_OPTIMIZATION_COUNT+$INFORMATIONAL_COUNT))/g" summary.tex

# Generate PDF
pdflatex -shell-escape -interaction nonstopmode main.tex
# Running it a second time to generate references
pdflatex -shell-escape -interaction nonstopmode main.tex
