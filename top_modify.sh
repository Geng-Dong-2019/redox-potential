no=`grep -n "CYD     HA" unmodified.top | awk -F: '{print $1}' | awk 'NR==1'`
awk "NR<$((no+1))"  unmodified.top  > modified.top

# the following part needs modifications: 
no2=`awk "NR>$no" unmodified.top | grep -n residue | awk -F: '{print $1}' | awk 'NR==1'`
awk "NR>$no" unmodified.top | head -n $((no2 -1)) |  cut  -c1-70 > orig.tmp
paste orig.tmp lambdaB.dat >> modified.top

# middle part
no3=`grep -n "CYD     HA" unmodified.top | awk -F: '{print $1}' | awk 'NR==2'`
awk "NR>$((no+no2-1))" unmodified.top | head -n $((no3-no-no2+1)) >> modified.top

# second CYD
awk "NR>$no3" unmodified.top | head -n $((no2 -1)) |  cut  -c1-70 > orig.tmp
paste orig.tmp lambdaB.dat >> modified.top

no4=`grep -n pairs unmodified.top | awk -F: '{print $1}'`
awk "NR<$((no4-1))" unmodified.top | awk "NR>$((no3+no2-1))"  >> modified.top

# bonds
 s1=`grep "CYD     SG" unmodified.top |  awk 'NR==1 {print $1}'`
 s2=`grep "CYD     SG" unmodified.top |  awk 'NR==2 {print $1}'`
echo " " $s1 " "  $s2 "    1         0.2029  144766.4        0.2029  0.00 ; the disulfide bond " >> modified.top

# pairs

# find atom numbers
hn1=`grep "CYD     HN" unmodified.top  |  awk 'NR==1 {print $1}'`
n1=`grep "CYD      N" unmodified.top  |  awk 'NR==1 {print $1}'`
ca1=`grep "CYD     CA" unmodified.top  |  awk 'NR==1 {print $1}'`
ha1=`grep "CYD     HA" unmodified.top  |  awk 'NR==1 {print $1}'`
cb1=`grep "CYD     CB" unmodified.top  |  awk 'NR==1 {print $1}'`
vc1=`grep "CYD     Vc" unmodified.top  |  awk 'NR==1 {print $1}'`
hb1a=`grep "CYD    HB1" unmodified.top  |  awk 'NR==1 {print $1}'`		# that's HB1 in the first CYD
hb2a=`grep "CYD    HB2" unmodified.top  |  awk 'NR==1 {print $1}'`		# that's HB2 in the first CYD
vs1=`grep "CYD     Vs" unmodified.top  |  awk 'NR==1 {print $1}'`
vh1=`grep "CYD    HUD" unmodified.top  |  awk 'NR==1 {print $1}'`
c1=`grep "CYD      C" unmodified.top  |  awk 'NR==1 {print $1}'`
o1=`grep "CYD      O" unmodified.top  |  awk 'NR==1 {print $1}'`

hn2=`grep "CYD     HN" unmodified.top  |  awk 'NR==2 {print $1}'`
n2=`grep "CYD      N" unmodified.top  |  awk 'NR==2 {print $1}'`
ca2=`grep "CYD     CA" unmodified.top  |  awk 'NR==2 {print $1}'`
ha2=`grep "CYD     HA" unmodified.top  |  awk 'NR==2 {print $1}'`
cb2=`grep "CYD     CB" unmodified.top  |  awk 'NR==2 {print $1}'`
vc2=`grep "CYD     Vc" unmodified.top  |  awk 'NR==2 {print $1}'`
hb1b=`grep "CYD    HB1" unmodified.top  |  awk 'NR==2 {print $1}'`
hb2b=`grep "CYD    HB2" unmodified.top  |  awk 'NR==2 {print $1}'`
vs2=`grep "CYD     Vs" unmodified.top  |  awk 'NR==2 {print $1}'`
vh2=`grep "CYD    HUD" unmodified.top  |  awk 'NR==2 {print $1}'`
c2=`grep "CYD      C" unmodified.top  |  awk 'NR==2 {print $1}'`
o2=`grep "CYD      O" unmodified.top  |  awk 'NR==2 {print $1}'`


no5=`grep -n exclusions unmodified.top | awk -F: '{print $1}'`
awk "NR>$((no4-2))" unmodified.top | awk "NR<$((no5-no4+1))" >> modified.top

# 1-4 interactions to short range 
echo " " $cb1 " " $cb2 "    1       0.33854         0.04184         0.387540942391  0.23012         ; CB-CB' " >> modified.top

echo " " $ca1 " " $s2 "    1       0.345223253279  0.257919081884  0.380859202005  0.396929091904  ; CA-SG' " >> modified.top
echo " " $s1  " " $ca2 "    1       0.345223253279  0.257919081884  0.380859202005  0.396929091904  ; SG-CA' " >> modified.top

echo " " $hb1a " " $s2 "    1       0.2935511       0.3825558       0.2957784       0.4163027       ; HB1-SG' " >> modified.top
echo " " $hb2a " " $s2 "    1       0.2935511       0.3825558       0.2957784       0.4163027       ; HB2-SG'" >> modified.top
echo " " $s1 " " $hb1b "    1       0.2935511       0.3825558       0.2957784       0.4163027       ; SG-HB1' " >> modified.top
echo " " $s1 " " $hb2b "    1       0.2935511       0.3825558       0.2957784       0.4163027       ; SG-HB2' " >> modified.top

echo " " $vh1 " " $vh2 "    1       0.00            0.00            0.0801808846326 0.4184          ; HUD-HUD' " >> modified.top

# not see in state A, but see each other in state B between two CYDs
echo " " $s1 " " $vs2 "    1       0.00            0.00            0.356359487256  1.8828          ; SG-Vs' " >> modified.top

echo " " $cb1  " " $vs2 "    1       0.00            0.00            0.371950214823  0.658232433112  ; CB-Vs'  " >> modified.top
echo " " $cb2  " " $vs1 "    1       0.00            0.00            0.371950214823  0.658232433112  ; CB'-Vs " >> modified.top

echo " " $cb1 " " $vh2 "    1       0.00            0.00            0.2338609135118 0.310293744700  ; CB-HUD' " >> modified.top
echo " " $cb2 " " $vh1 "    1       0.00            0.00            0.2338609135118 0.310293744700  ; CB'-HUD " >> modified.top

echo " " $s1 " " $vh2  "    1       0.00            0.00            0.2182701859443 0.887560431745  ; SG-HUD' " >> modified.top
echo " " $s2 " " $vh1  "    1       0.00            0.00            0.2182701859443 0.887560431745  ; SG'-HUD " >> modified.top



no6=`grep -n dihedrals unmodified.top | awk -F: '{print $1}' | awk 'NR==1' `
no7=`grep -n dihedrals unmodified.top | awk -F: '{print $1}' | awk 'NR==2' `

# the angles section
ang1=`grep -n  "$ca1[ \t]\+$cb1[ \t]\+$s1[ \t]\+5" unmodified.top  | awk -F: '{print $1}' | awk 'NR==1' `
ang2=`grep -n  "$ca2[ \t]\+$cb2[ \t]\+$s2[ \t]\+5" unmodified.top  | awk -F: '{print $1}' | awk 'NR==1' `
awk "NR>$((no5-2))" unmodified.top | awk "NR<$((ang1-no5+4))"  >> modified.top
echo " " $hb1a " " $cb1 " " $s1 "    1  111.0000        317.984         111.3000        385.7648   ; HCS"  >> modified.top
echo " " $hb2a " " $cb1 " " $s1 "    1  111.0000        317.984         111.3000        385.7648   ; HCS"  >> modified.top
echo " " $cb1 " " $s1 " " $vh1 "    1   95.0000 0.0     95.0000 324.6784 ; CSH"  >> modified.top

awk "NR>$((ang1+4))" unmodified.top | awk "NR<$((ang2-ang1-2))"  >> modified.top
echo " " $hb1b " " $cb2 " " $s2 "    1  111.0000        317.984         111.3000        385.7648   ; HCS"  >> modified.top
echo " " $hb2b " " $cb2 " " $s2 "    1  111.0000        317.984         111.3000        385.7648   ; HCS"  >> modified.top
echo " " $cb2 " " $s2 " " $vh2 "    1   95.0000 0.0     95.0000 324.6784 ; CSH"  >> modified.top
awk "NR>$((ang2+4))" unmodified.top | awk "NR<$((no6-ang2-5))"  >> modified.top

echo " " $cb1 " " $s1 " " $s2 "    1         103.3000        606.68  103.3000        0.000   ; CSS"  >> modified.top
echo " " $s1 " " $s2 " " $cb2 "    1         103.3000        606.68  103.3000        0.000   ; SSC"  >> modified.top

# the proper dihedral section
dih1=`grep -n  "$ca1[ \t]\+$cb1[ \t]\+$s1[ \t]\+$vh1[ \t]\+9" unmodified.top  | awk -F: '{print $1}' | awk 'NR==1' `
dih2=`grep -n  "$ca2[ \t]\+$cb2[ \t]\+$s2[ \t]\+$vh2[ \t]\+9" unmodified.top  | awk -F: '{print $1}' | awk 'NR==1' `

awk "NR>$((no6-2))" unmodified.top | awk "NR<$((dih1-no6+2))" >> modified.top
awk "NR>$((dih1+2))" unmodified.top | awk "NR<$((dih2-dih1-2))"  >> modified.top
awk "NR>$((dih2+2))" unmodified.top | awk "NR<$((no7-dih2-3))"  >> modified.top


echo " $cb1   $s1    $s2   $cb2     9        dih_M1_C_S_S_C    dih_M1_zero    ; CB-S-S'-CB'" >> modified.top
echo " $cb1   $s1    $s2   $cb2     9        dih_M2_C_S_S_C    dih_M2_zero    ; CB-S-S'-CB'" >> modified.top
echo " $cb1   $s1    $s2   $cb2     9        dih_M3_C_S_S_C    dih_M3_zero    ; CB-S-S'-CB'" >> modified.top
echo " $ca1   $cb1    $s1   $s2     9        dih_M3_C_C_S_S    dih_M3_zero    ; CA-CB-S-S'" >> modified.top
echo " $hb1a   $cb1    $s1   $s2     9        dih_M3_H_C_S_S    dih_M3_zero    ; HB-CB-S-S'" >> modified.top
echo " $hb2a   $cb1    $s1   $s2     9        dih_M3_H_C_S_S    dih_M3_zero    ; HB-CB-S-S'" >> modified.top
echo " $s1   $s2    $cb2   $ca2     9        dih_M3_C_C_S_S    dih_M3_zero    ; S-S'-CB'-CA'" >> modified.top
echo " $s1   $s2    $cb2   $hb1b     9        dih_M3_H_C_S_S    dih_M3_zero    ; S-S'-CB'-HB'" >> modified.top
echo " $s1   $s2    $cb2   $hb2b     9        dih_M3_H_C_S_S    dih_M3_zero    ; S-S'-CB'-HB'" >> modified.top

echo " $ca1   $cb1    $s1   $vh1     9        dih_M1_zero             dih_M1_C_C_S_H" >> modified.top
echo " $ca1   $cb1    $s1   $vh1     9        dih_M2_zero             dih_M2_C_C_S_H" >> modified.top
echo " $ca1   $cb1    $s1   $vh1     9        dih_M3_zero             dih_M3_C_C_S_H" >> modified.top
echo " $hb1a   $cb1    $s1   $vh1     9        dih_M3_zero		dih_M3_H_C_S_H" >> modified.top
echo " $hb2a   $cb1    $s1   $vh1     9        dih_M3_zero		dih_M3_H_C_S_H" >> modified.top
echo " $ca2   $cb2    $s2   $vh2     9        dih_M1_zero             dih_M1_C_C_S_H" >> modified.top
echo " $ca2   $cb2    $s2   $vh2     9        dih_M2_zero             dih_M2_C_C_S_H" >> modified.top
echo " $ca2   $cb2    $s2   $vh2     9        dih_M3_zero             dih_M3_C_C_S_H" >> modified.top
echo " $hb1b   $cb2    $s2   $vh2     9        dih_M3_zero             dih_M3_H_C_S_H" >> modified.top
echo " $hb2b   $cb2    $s2   $vh2     9        dih_M3_zero             dih_M3_H_C_S_H" >> modified.top

no8=`grep -n "Include Position restraint file" unmodified.top  | awk -F: '{print $1}'`

awk "NR>$((no7-2))" unmodified.top | awk "NR<$((no8-no7+2))" >> modified.top

echo " [ virtual_sites2 ] "	>> modified.top
echo " ;dummy atom     atom bondtype position" >> modified.top
echo " ; VS   fix1     fix2    from" >> modified.top
echo "$vc1    $ca1    $cb1    1    1.000       ; Vc"  >> modified.top
echo "$vs1    $cb1    $s1    1    1.000       ; Vs"  >> modified.top
echo "$vc2    $ca2    $cb2    1    1.000       ; Vc'"  >> modified.top
echo "$vs2    $cb2    $s2    1    1.000       ; Vs'"  >> modified.top

awk "NR>$((no8-2))" unmodified.top >> modified.top

mv modified.top protein.top

