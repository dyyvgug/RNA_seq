#!/bin/bash

# Read each line in the SRR.txt file
while IFS= read -r srr_id || [ -n "$srr_id" ]; do
  # Use the prefetch command to download each SRR file
  prefetch "$srr_id"
done < SRR_Acc_List.txt
