#!/bin/bash

# Input file containing names and email addresses
input_file="names_emails.txt"

# Using awk and tr
echo "Using awk and tr:"
awk '{print $NF}' "$input_file" | tr '[:upper:]' '[:lower:]'

# Using grep and sed
echo "Using grep and sed:"
grep -o '[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:].]{2,}' "$input_file" | sed 's/.*/\L&/'
