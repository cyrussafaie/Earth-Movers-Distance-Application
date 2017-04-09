using JuMP
using Clp
#using GLPKMathProgInterface

solver = ClpSolver()
#solver = GLPKSolverLP()

ORIG = ["Chicago", "Detroit", "Indianapolis", "Milwaukee"]
DEST = ["EL PASO,TX","MISSION,TX","PHARR,TX","MCALLEN,TX","BROWNSVILLE,TX","EDINBURG,TX","HARLINGEN,TX","LAREDO,TX","CORPUS CHRISTI,TX","ODESSA,TX","SAN ANTONIO,TX","MIDLAND,TX","VICTORIA,TX","NEW BRAUNFELS,TX","SAN ANGELO,TX","SAN MARCOS,TX","AUSTIN,TX","CEDAR PARK,TX","PFLUGERVILLE,TX","LUBBOCK,TX","ROUND ROCK,TX","MISSOURI CITY,TX","SUGAR LAND,TX","GALVESTON,TX","GEORGETOWN,TX","LEAGUE CITY,TX","PEARLAND,TX","PASADENA,TX","HOUSTON,TX","BAYTOWN,TX","ABILENE,TX","KILLEEN,TX","TEMPLE,TX","COLLEGE STATION,TX","BRYAN,TX","CONROE,TX","PORT ARTHUR,TX","AMARILLO,TX","BEAUMONT,TX","WACO,TX","MANSFIELD,TX","FORT WORTH,TX","GUYMON,OK","ARLINGTON,TX","NORTH RICHLAND HILLS,TX","DESOTO,TX","GRAND PRAIRIE,TX","EULESS,TX","WICHITA FALLS,TX","GRAPEVINE,TX","IRVING,TX","ALTUS,OK","DALLAS,TX","FLOWER MOUND,TX","MESQUITE,TX","LEWISVILLE,TX","CARROLLTON,TX","DENTON,TX","GARLAND,TX","RICHARDSON,TX","ROWLETT,TX","PLANO,TX","FRISCO,TX","ALLEN,TX","TYLER,TX","ELK CITY,OK","MCKINNEY,TX","LAWTON,OK","LONGVIEW,TX","DUNCAN,OK","CLINTON,OK","ARDMORE,OK","WEATHERFORD,OK","WOODWARD,OK","CHICKASHA,OK","DURANT,OK","EL RENO,OK","NEWCASTLE,OK","MUSTANG,OK","YUKON,OK","NORMAN,OK","BETHANY,OK","ADA,OK","DEL CITY,OK","MIDWEST CITY,OK","MOORE,OK","THE VILLAGE,OK","WARR ACRES,OK","CHOCTAW,OK","EDMOND,OK","SHAWNEE,OK","GUTHRIE,OK","ENID,OK","MCALESTER,OK","STILLWATER,OK","OKMULGEE,OK","PONCA CITY,OK","SAPULPA,OK","GLENPOOL,OK","POTEAU,OK","SAND SPRINGS,OK","JENKS,OK","BIXBY,OK","TULSA,OK","BROKEN ARROW,OK","COWETA,OK","MUSKOGEE,OK","OWASSO,OK","WAGONER,OK","CLAREMORE,OK","TAHLEQUAH,OK","BARTLESVILLE,OK","PRYOR CREEK,OK","MIAMI,OK","COPPERHILL,TN","DUCKTOWN,TN","COLLEGEDALE,TN","LOOKOUT MOUNTAIN,TN","BENTON,TN","MOUNTAIN CITY,TN","CHATTANOOGA,TN","EAST RIDGE,TN","RED BANK,TN","RIDGESIDE,TN","CLEVELAND,TN","ERWIN,TN","UNICOI,TN","NEW HOPE,TN","ORME,TN","SOUTH PITTSBURG,TN","TELLICO PLAINS,TN","BARTLETT,TN","JASPER,TN","KIMBALL,TN","MEMPHIS,TN","COLLIERVILLE,TN","PIPERTON,TN","ETOWAH,TN","GERMANTOWN,TN","SIGNAL MOUNTAIN,TN","WALDEN,TN","ELIZABETHTON,TN","CHARLESTON,TN","CALHOUN,TN","GATLINBURG,TN","GRAND JUNCTION,TN","WILLISTON,TN","WATAUGA,TN","ENGLEWOOD,TN","TOWNSEND,TN","SAULSBURY,TN","ROSSVILLE,TN","JOHNSON CITY,TN","HUNTLAND,TN","JONESBOROUGH,TN","LAKESITE,TN","SODDY-DAISY,TN","MOSCOW,TN","GUYS,TN","WHITWELL,TN","MIDDLETON,TN","PARROTTSVILLE,TN","NEWPORT,TN","MADISONVILLE,TN","ATHENS,TN","BAILEYTON,TN","GREENEVILLE,TN","TUSCULUM,TN","ARDMORE,TN","MINOR HILL,TN","BLUFF CITY,TN","IRON CITY,TN","EASTVIEW,TN","RAMER,TN","ELKTON,TN","COWAN,TN","MICHIE,TN","VONORE,TN","OAKLAND,TN","PIGEON FORGE,TN","SEVIERVILLE,TN","NIOTA,TN","HICKORY VALLEY,TN","BRISTOL,TN","WINCHESTER,TN","GREENBACK,TN","LORETTO,TN","TRACY CITY,TN","FAYETTEVILLE,TN","DECHERD,TN","PITTMAN CENTER,TN","MONTEAGLE,TN","MARYVILLE,TN","ARLINGTON,TN","LAKELAND,TN","MOSHEIM,TN","MILLINGTON,TN","SWEETWATER,TN","STANTONVILLE,TN","DUNLAP,TN","GRAYSVILLE,TN","DECATUR,TN","SOMERVILLE,TN","SELMER,TN","ALCOA,TN","DANDRIDGE,TN","PALMER,TN","ROCKFORD,TN","ESTILL SPRINGS,TN","COALMONT,TN","FRIENDSVILLE,TN","BANEBERRY,TN","WHITE PINE,TN","DAYTON,TN","HORNSBY,TN","GALLAWAY,TN","PHILADELPHIA,TN","COLLINWOOD,TN","PULASKI,TN","MASON,TN","BOLIVAR,TN","LOUISVILLE,TN","BETHEL SPRINGS,TN","BRADEN,TN","LYNCHBURG,TN","KINGSPORT,TN","LOUDON,TN","SAVANNAH,TN","ADAMSVILLE,TN","BULLS GAP,TN","CRUMP,TN","WHITEVILLE,TN","MUNFORD,TN","LAWRENCEBURG,TN","ATOKA,TN","ALTAMONT,TN","MORRISTOWN,TN","LENOIR CITY,TN","JEFFERSON CITY,TN","NEW MARKET,TN","PETERSBURG,TN","BEERSHEBA SPRINGS,TN","TULLAHOMA,TN","BRIGHTON,TN","TOONE,TN","CHURCH HILL,TN","MOUNT CARMEL,TN","SILERTON,TN","FARRAGUT,TN","KNOXVILLE,TN","SURGOINSVILLE,TN","ROGERSVILLE,TN","PIKEVILLE,TN","FINGER,TN","ETHRIDGE,TN","CORNERSVILLE,TN","WAYNESBORO,TN","STANTON,TN","SPRING CITY,TN","MANCHESTER,TN","BURLISON,TN","GILT EDGE,TN","LYNNVILLE,TN","MILLEDGEVILLE,TN","BLAINE,TN","NORMANDY,TN","ENVILLE,TN","SALTILLO,TN","BEAN STATION,TN","VIOLA,TN","CLIFTON,TN","COVINGTON,TN","GARLAND,TN","KINGSTON,TN","MEDON,TN","OAK RIDGE,TN","HENDERSON,TN","LEWISBURG,TN","RUTLEDGE,TN","SHELBYVILLE,TN","SARDIS,TN","LUTTRELL,TN","ROCKWOOD,TN","WARTRACE,TN","MORRISON,TN","HARRIMAN,TN","CLINTON,TN","OLIVER SPRINGS,TN","BROWNSVILLE,TN","MAYNARDVILLE,TN","SCOTTS HILL,TN","OAKDALE,TN","HENNING,TN","SPENCER,TN","SNEEDVILLE,TN","CENTERTOWN,TN","MCMINNVILLE,TN","BELL BUCKLE,TN","CRAB ORCHARD,TN","MOUNT PLEASANT,TN","NORRIS,TN","HOHENWALD,TN","JACKSON,TN","DECATURVILLE,TN","RIPLEY,TN","CHAPEL HILL,TN","NEW TAZEWELL,TN","TAZEWELL,TN","CROSSVILLE,TN","COLUMBIA,TN","LINDEN,TN","BELLS,TN","WARTBURG,TN","DOYLE,TN","LEXINGTON,TN","PARSONS,TN","PLEASANT HILL,TN","HARROGATE,TN","ALAMO,TN","GATES,TN","SPARTA,TN","GADSDEN,TN","EAGLEVILLE,TN","WOODBURY,TN","MAURY CITY,TN","CARYVILLE,TN","JACKSBORO,TN","SPRING HILL,TN","LA FOLLETTE,TN","HALLS,TN","CUMBERLAND GAP,TN","MEDINA,TN","HUMBOLDT,TN","THREE WAY,TN","LOBELVILLE,TN","MURFREESBORO,TN","SUNBRIGHT,TN","SMITHVILLE,TN","FRIENDSHIP,TN","CENTERVILLE,TN","GIBSON,TN","AUBURNTOWN,TN","MONTEREY,TN","CLARKSBURG,TN","MILAN,TN","LIBERTY,TN","DOWELLTOWN,TN","HUNTSVILLE,TN","DYERSBURG,TN","FRANKLIN,TN","NOLENSVILLE,TN","TRENTON,TN","JELLICO,TN","ALGOOD,TN","COOKEVILLE,TN","SMYRNA,TN","ATWOOD,TN","LA VERGNE,TN","ALEXANDRIA,TN","BAXTER,TN","MCLEMORESVILLE,TN","BRENTWOOD,TN","FAIRVIEW,TN","ONEIDA,TN","ALLARDT,TN","TREZEVANT,TN","WATERTOWN,TN","HUNTINGDON,TN","NEWBERN,TN","DYER,TN","YORKVILLE,TN","WINFIELD,TN","BRADFORD,TN","NEW JOHNSONVILLE,TN","HOLLOW ROCK,TN","BRUCETON,TN","GORDONSVILLE,TN","JAMESTOWN,TN","RUTHERFORD,TN","BURNS,TN","CAMDEN,TN","DICKSON,TN","FOREST HILLS,TN","KINGSTON SPRINGS,TN","PEGRAM,TN","TRIMBLE,TN","LIVINGSTON,TN","GREENFIELD,TN","RIDGELY,TN","WHITE BLUFF,TN","CARTHAGE,TN","SOUTH CARTHAGE,TN","WAVERLY,TN","KENTON,TN","MCEWEN,TN","LEBANON,TN","NASHVILLE,TN","BERRY HILL,TN","OAK HILL,TN","MOUNT JULIET,TN","GAINESBORO,TN","OBION,TN","SHARON,TN","GLEASON,TN","HENRY,TN","CHARLOTTE,TN","HORNBEAK,TN","TIPTONVILLE,TN","TROY,TN","BYRDSTOWN,TN","DRESDEN,TN","BIG SANDY,TN","VANLEER,TN","HENDERSONVILLE,TN","SAMBURG,TN","ASHLAND CITY,TN","RIVES,TN","HARTSVILLE,TN","MARTIN,TN","CELINA,TN","GOODLETTSVILLE,TN","MILLERSVILLE,TN","PARIS,TN","SLAYDEN,TN","GALLATIN,TN","TN RIDGE,TN","ERIN,TN","UNION CITY,TN","COTTAGE GROVE,TN","RED BOILING SPRINGS,TN","RIDGETOP,TN","PLEASANT VIEW,TN","WOODLAND MILLS,TN","LAFAYETTE,TN","GREENBRIER,TN","CUMBERLAND CITY,TN","WHITE HOUSE,TN","SOUTH FULTON,TN","PURYEAR,TN","WESTMORELAND,TN","SPRINGFIELD,TN","DOVER,TN","CROSS PLAINS,TN","PORTLAND,TN","CEDAR HILL,TN","ORLINDA,TN","CLARKSVILLE,TN","MITCHELLVILLE,TN","ADAMS,TN","DIE"];

DIEPOP = 1052452 / .2

supply     = [2695598 686888 852866 594833]
population = [565952  102841  46199  94892  144583  81467  60708  181748  227414  108013  1195461  108806  65015  78216  81744  36746  698371  53714  54968  180277  109818  78237  125373  33948  56347  58519  89828  106140  2137434  80936  94477  138941  55044  54883  63294  94889  39590  172249  115554  120788  50138  698333  11623  292572  105780  38597  132597  48646  80485  63968  167856  16572  942908  57037  129290  184505  103201  97134  196665  82338  47252  235179  94754  94935  109560  11623  113359  72588  81461  22112  7947  26983  9002  12690  14764  15619  12754  5751  17621  48029  80727  15228  22965  36843  44496  77590  27488  53676  17389  112717  30844  15668  41936  20899  32605  11899  25977  24942  8425  8890  24032  13004  17939  315118  98113  11363  35182  32540  10721  35820  19793  32949  12169  13435  1777  645  1733  1832  3923  8327  149143  17869  18396  13435  68422  9419  3840  4855  4855  4855  5989  72771  6433  6433  580312  42702  42702  5677  38144  13508  13508  25115  3517  1752  5103  1629  6049  1415  4204  2283  1047  2961  68033  1750  22261  21291  21291  3739  575  7331  2948  2947  17159  12486  19201  32748  33557  13441  2519  855  10576  1977  2011  2011  0  1520  2162  4154  8770  45779  45779  3500  692  30545  11829  4844  3203  3246  17374  4041  22377  2019  66092  30998  30998  4149  22854  11330  975  8481  2306  6315  19611  6614  6070  12966  1114  3124  5640  915  4914  5271  5271  13731  721  0  3870  2055  13697  12062  7573  9280  2751  0  2638  70071  15756  13532  4536  3868  0  2918  8770  16715  8834  1213  38434  21833  9183  6133  2674  558  20304  7861  1200  16683  4533  0  51670  303378  3242  15803  6766  1408  2522  1948  4948  2136  7972  20352  2294  2294  2244  0  2849  1407  860  522  4967  0  1379  11989  11989  12836  1933  24761  8919  16740  6167  25930  958  2819  9352  2544  4350  13895  20345  7474  11781  7401  1568  1365  2010  2835  3434  23490  24328  3945  782  6158  1392  7770  65917  2558  12214  5501  6531  7154  40616  43764  4191  4081  3997  1002  14048  4358  572  4847  3400  1370  17899  1139  1948  6711  679  3270  6975  22942  13441  4031  1614  4790  12415  12415  1559  121605  1562  10335  2142  5682  0  714  6439  0  9401  1504  1242  2113  21215  77922  7720  7651  2314  24783  47654  40372  1527  25682  1740  5176  0  46259  8951  6736  1138  1242  4610  7014  6187  3159  0  1405  2322  2664  1173  1745  1967  8279  1542  4593  8278  21189  70216  5512  3423  701  7328  2816  1767  5633  5410  5410  6660  2199  5110  44113  327225  9258  5889  40305  4587  1710  1852  2261  1436  4605  1475  2377  3347  2871  4684  2476  1127  50478  0  14315  964  5419  10359  3107  24940  24301  15360  0  34739  1636  3811  13332  805  3646  0  6155  0  10331  11103  1329  11999  3778  2197  7280  23898  5399  2827  18152  3691  918  117454  0  3891 DIEPOP]
demand = population * .2

total_supply = sum(supply)
total_demand = round(Int64, sum(demand))
remaining = total_supply - total_demand

println("$total_supply people need to be evacuated from $(length(ORIG)) cities and moved to $(length(DEST)) cities, which can host $total_demand people.")
if remaining > 0
	println("Due to limited space, $remaining people will not be evacuated.")
end

cost = [1998 1988 1988 1987 1984 1970 1965 1917 1792 1710 1685 1679 1672 1640 1619 1615 1570 1551 1547 1546 1542 1535 1534 1533 1531 1527 1526 1510 1510 1493 1491 1491 1473 1467 1464 1457 1441 1430 1427 1421 1325 1319 1317 1314 1312 1309 1308 1298 1295 1290 1290 1290 1285 1283 1278 1277 1275 1268 1266 1265 1264 1261 1256 1255 1254 1243 1242 1233 1210 1210 1205 1185 1183 1175 1169 1159 1132 1130 1127 1121 1115 1114 1108 1108 1108 1108 1108 1108 1090 1088 1079 1074 1065 1033 1029  994  986  974  972  967  966  966  964  953  951  949  948  935  933  917  911  909  901  827  813  809  789  787  786  782  782  782  782  782  780  779  778  777  777  777  777  775  775  775  775  774  774  773  773  772  772  771  771  771  770  766  766  765  765  765  765  765  764  764  762  762  762  762  762  761  760  760  759  759  758  758  758  758  758  757  757  757  756  756  756  756  756  755  755  754  754  754  753  753  752  751  751  751  750  750  750  750  749  748  748  748  748  747  746  746  745  745  745  745  744  744  744  743  743  743  743  742  742  742  742  742  742  741  740  740  739  739  738  738  737  737  737  737  736  736  736  735  734  733  733  733  733  733  732  731  731  731  730  729  729  729  729  728  728  728  727  726  726  725  725  724  724  724  723  722  722  722  721  721  720  720  720  720  719  718  718  718  718  717  717  715  715  715  715  713  713  712  712  711  710  709  708  707  707  706  704  704  704  704  704  704  704  703  702  700  699  698  696  696  696  696  696  695  693  693  692  691  691  691  690  688  686  684  684  684  683  683  683  683  683  682  682  680  680  678  678  677  677  677  676  674  674  673  672  672  670  669  668  665  665  665  664  663  661  661  661  660  660  659  659  658  657  656  656  656  655  654  653  653  652  652  652  651  651  650  650  649  648  648  647  647  646  646  645  644  643  641  641  640  639  639  639  639  639  638  638  638  638  638  637  637  634  634  634  634  633  633  630  630  629  629  627  626  625  625  624  624  623  623  623  621  621  619  619  617  617  617  617  616  616  614  614  613  611  610  610  610  609  607  606  606  604  603  602  599  598  595  594  592  590  588  587  587  586 1000;
2366 2267 2265 2265 2251 2249 2237 2218 2072 2063 1991 2032 1956 1945 1958 1919 1875 1860 1852 1908 1849 1807 1808 1792 1839 1792 1795 1778 1781 1759 1833 1803 1782 1759 1757 1736 1692 1802 1684 1732 1646 1644 1695 1636 1637 1628 1629 1621 1641 1615 1612 1647 1605 1608 1595 1601 1598 1596 1586 1586 1582 1583 1580 1577 1551 1607 1565 1585 1502 1558 1568 1523 1544 1546 1522 1487 1490 1482 1482 1477 1466 1469 1448 1462 1462 1462 1462 1462 1442 1443 1427 1431 1429 1367 1387 1338 1350 1324 1320 1289 1317 1314 1311 1302 1299 1295 1288 1286 1275 1266 1249 1265 1248 1177  829  825  833  845  813  667  835  835  835  835  816  696  691  850  850  850  787 1006  844  844 1005  994  994  793  997  829  829  677  802  801  741  971  979  673  783  748  967  979  676  860  679  812  812  975  945  825  956  709  714  770  781  692  692  692  876  890  662  906  942  942  878  841  935  761  970  727  727  774  958  652  842  754  894  825  859  839  723  829  742  972  972  688  979  763  926  804  790  777  958  932  737  708  810  733  834  816  743  700  700  784  938  964  754  897  869  957  941  734  926  960  838  653  747  911  917  681  914  943  964  874  963  806  688  739  698  700  843  802  823  958  931  650  648  925  721  717  658  665  775  915  865  846  882  942  757  811  953  953  849  902  696  817  904  896  672  798  886  945  945  734  917  721  908  835  680  819  892  689  736  812  792  728  705  714  923  685  884  723  932  766  651  780  780  805  737  837  691  851  898  871  923  813  663  661  734  825  857  903  710  755  876  865  735  649  898  908  746  893  799  773  901  681  679  808  671  904  646  880  884  884  841  779  696  752  893  823  877  761  719  855  868  751  749  674  889  787  778  872  652  723  723  770  859  771  746  726  853  778  792  665  684  853  746  844  876  865  870  657  856  822  834  833  731  680  861  792  824  792  766  779  777  863  694  848  874  783  724  724  807  855  800  741  760  760  760  747  704  858  842  834  825  780  857  863  850  669  832  807  779  741  856  759  842  716  833  681  740  740  810  774  728  785  782  837  812  692  737  749  835  698  735  773  726  821  798  701  730  772  718  708  729  712  742  704  729 1000;
2028 1883 1881 1881 1867 1865 1853 1836 1688 1707 1611 1676 1572 1564 1591 1538 1494 1480 1472 1564 1469 1423 1423 1408 1459 1408 1410 1394 1397 1374 1469 1425 1402 1377 1374 1351 1308 1474 1300 1354 1271 1271 1385 1262 1264 1252 1254 1247 1281 1242 1238 1299 1230 1236 1219 1229 1225 1225 1211 1212 1207 1210 1207 1203 1169 1268 1192 1232 1120 1201 1228 1158 1203 1221 1170 1118 1144 1131 1133 1130 1112 1121 1086 1113 1113 1113 1113 1113 1092 1096 1073 1086 1095 1001 1043  981 1015  972  967  918  968  962  957  951  945  940  928  936  918  914  889  923  895  830  552  547  533  534  526  524  528  528  528  528  522  516  515  529  529  529  514  622  525  525  622  612  612  512  614  519  519  510  512  511  504  591  598  503  503  499  587  598  502  524  499  507  507  593  571  510  578  494  493  496  497  493  493  493  528  535  496  543  567  567  527  512  562  492  588  488  488  492  578  493  509  487  534  502  515  507  484  503  484  589  589  483  595  484  552  492  489  485  577  556  479  478  493  477  500  494  478  476  476  484  560  582  478  531  515  575  562  474  550  577  499  475  473  539  543  471  541  562  581  514  579  484  467  468  466  465  497  481  488  575  551  466  466  546  462  462  463  461  469  538  505  495  515  560  463  478  570  570  495  528  454  479  529  523  453  471  515  562  562  454  538  451  530  484  449  476  518  446  450  472  463  447  443  443  541  440  509  441  548  451  439  455  455  464  442  478  433  485  518  498  540  463  430  429  434  468  486  521  428  438  500  491  429  418  516  525  429  511  450  438  518  416  416  453  414  520  411  499  503  503  470  436  411  424  510  457  495  425  410  477  488  418  417  398  505  432  427  490  394  405  405  422  478  421  410  403  473  424  431  388  390  472  408  465  492  483  486  384  475  448  457  456  398  384  478  426  448  425  410  418  416  480  382  466  489  419  391  391  434  472  429  396  404  404  404  398  380  475  460  452  445  413  473  479  467  364  450  429  410  388  472  397  459  375  451  362  385  385  431  404  378  411  409  453  431  360  379  386  451  360  377  400  370  438  418  356  370  396  362  355  366  355  372  350  364 1000;
2042 2087 2087 2086 2087 2070 2067 2009 1891 1771 1775 1741 1771 1731 1692 1707 1661 1641 1638 1600 1633 1639 1637 1641 1621 1632 1631 1616 1614 1599 1562 1579 1563 1565 1561 1559 1551 1473 1536 1510 1410 1402 1349 1398 1395 1396 1393 1382 1364 1374 1375 1350 1371 1366 1365 1360 1360 1350 1353 1351 1351 1347 1341 1340 1351 1297 1327 1298 1310 1279 1261 1261 1240 1220 1234 1241 1194 1196 1191 1184 1183 1178 1184 1173 1173 1173 1173 1173 1156 1152 1149 1136 1119 1114 1091 1069 1043 1045 1043 1055 1035 1037 1037 1024 1024 1024 1026 1005 1009  989  991  974  975  899  943  938  920  919  916  896  913  913  913  913  911  898  896  909  909  909  906  896  907  907  896  896  896  903  895  904  904  889  902  901  896  891  889  883  894  892  890  888  883  896  881  894  894  886  890  893  887  883  883  888  888  879  879  879  889  889  874  888  884  884  888  888  884  884  878  880  880  883  879  869  884  880  882  883  882  882  876  882  877  871  871  870  869  876  874  877  876  875  869  872  872  868  875  870  875  875  871  866  866  873  868  864  870  871  872  863  865  866  866  861  870  856  866  865  865  858  865  860  855  865  855  865  856  861  857  856  863  862  862  851  855  848  847  855  855  854  847  847  857  852  856  856  854  847  854  854  843  843  852  849  846  852  848  849  842  850  847  840  840  846  843  844  843  847  839  845  841  838  841  843  841  838  835  835  831  832  833  833  827  835  826  835  835  835  832  831  825  829  823  825  818  828  820  819  823  824  822  816  820  822  818  817  817  808  809  807  815  809  815  815  807  809  809  812  807  801  802  804  802  802  806  806  803  805  796  803  796  801  799  794  791  797  796  791  785  793  793  786  786  790  790  790  784  789  788  787  782  786  785  780  782  779  784  779  774  776  775  776  774  777  775  775  778  775  770  775  772  772  773  772  771  763  770  765  761  770  770  770  769  763  768  769  766  766  766  766  764  757  756  757  757  760  750  748  749  755  751  753  754  755  746  752  745  751  744  748  749  749  746  747  748  744  744  738  739  742  742  741  733  739  738  737  736  728  730  731  730  725  727  725  722  720  718  719  718 1000]


m = Model(solver=solver);

@variable(m, Trans[i=1:length(ORIG), j=1:length(DEST)] >= 0);

@constraint(m, [i=1:1:length(ORIG)], sum(Trans[i,j] for j=1:length(DEST)) == supply[i]);

@constraint(m, [j = 1:length(DEST)], sum(Trans[i,j] for i=1:length(ORIG)) == demand[j]);

@objective(m, Min, sum(cost[i,j] * Trans[i,j] for i=1:length(ORIG), j=1:length(DEST)));

println("Solving original problem...")
status = solve(m);

if status == :Optimal
	@printf("Optimal!\n");
	@printf("Objective value: %d\n", getobjectivevalue(m));
	@printf("Transpotation:\n");
	for j = 1:length(DEST)
		@printf("\t%s", DEST[j]);
	end
	@printf("\n");
	for i = 1:length(ORIG)
		@printf("%s", ORIG[i]);
		for j = 1:length(DEST)
			@printf("\t%d", getvalue(Trans[i,j]));
		end
		@printf("\n");
	end
else
    @printf("No solution\n");
end
