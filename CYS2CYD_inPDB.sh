SS2=`grep -n "SG  CYS " protein.pdb  | awk -F: 'NR==2 {print $1}' `
awk "NR<=$((SS2+2))" protein.pdb | sed -e "s/CYS/CYD/g" > prot_cyd.tmp
awk "NR>$((SS2+2))" protein.pdb >> prot_cyd.tmp

CB1=`grep -n "CB  CYD " prot_cyd.tmp  | awk -F: 'NR==1 {print $1}' `
CYD1=`grep "CB  CYD " prot_cyd.tmp  | awk 'NR==1 {print $6}' `
CB2=`grep -n "CB  CYD " prot_cyd.tmp  | awk -F: 'NR==2 {print $1}' `
CYD2=`grep "CB  CYD " prot_cyd.tmp  | awk 'NR==2 {print $6}' `
 S1=`grep -n "SG  CYD " prot_cyd.tmp  | awk -F: 'NR==1 {print $1}' `
 S2=`grep -n "SG  CYD " prot_cyd.tmp  | awk -F: 'NR==2 {print $1}' `

awk "NR<=$((CB1))" prot_cyd.tmp > prot_cyd.pdb
awk "NR==$((CB1))" prot_cyd.tmp | sed -e "s/CB/Vc/g" >> prot_cyd.pdb
awk "NR==$((CB1+1))" prot_cyd.tmp  >> prot_cyd.pdb
awk "NR==$((CB1+2))" prot_cyd.tmp  >> prot_cyd.pdb
awk "NR==$((S1))" prot_cyd.tmp  >> prot_cyd.pdb
awk "NR==$((S1))" prot_cyd.tmp | sed -e "s/SG/Vs/g" >> prot_cyd.pdb
awk "NR==$((CB1+1))" prot_cyd.tmp | sed -e "s/HB1/HUD/g" >> prot_cyd.pdb

awk "NR<=$((CB2))" prot_cyd.tmp | awk "NR>$((S1))" >> prot_cyd.pdb
awk "NR==$((CB2))" prot_cyd.tmp | sed -e "s/CB/Vc/g" >> prot_cyd.pdb
awk "NR==$((CB2+1))" prot_cyd.tmp  >> prot_cyd.pdb
awk "NR==$((CB2+2))" prot_cyd.tmp  >> prot_cyd.pdb
awk "NR==$((S2))" prot_cyd.tmp  >> prot_cyd.pdb
awk "NR==$((S2))" prot_cyd.tmp | sed -e "s/SG/Vs/g" >> prot_cyd.pdb
awk "NR==$((CB2+1))" prot_cyd.tmp | sed -e "s/HB1/HUD/g" >> prot_cyd.pdb
awk "NR>$S2" prot_cyd.tmp >> prot_cyd.pdb
