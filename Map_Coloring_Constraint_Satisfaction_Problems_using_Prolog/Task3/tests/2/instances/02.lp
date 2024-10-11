
share_border(C1, C2) :- country(C1), country(C2), border_datum(_, C1, _, C2), C2 != "".
country(C) :- border_datum(_, C, _, _).

border_datum("AR", "Argentina", "BO", "Bolivia (Plurinational State Of)").
border_datum("AR", "Argentina", "BR", "Brazil").
border_datum("AR", "Argentina", "CL", "Chile"). 
border_datum("AR", "Argentina", "PY", "Paraguay").
border_datum("AR", "Argentina", "UY", "Uruguay").
border_datum("BO", "Bolivia (Plurinational State Of)", "AR", "Argentina").
border_datum("BO", "Bolivia (Plurinational State Of)", "BR", "Brazil").
border_datum("BO", "Bolivia (Plurinational State Of)", "CL", "Chile").
border_datum("BO", "Bolivia (Plurinational State Of)", "PY", "Paraguay").
border_datum("BO", "Bolivia (Plurinational State Of)", "PE", "Peru").
border_datum("BR", "Brazil", "AR", "Argentina").
border_datum("BR", "Brazil", "BO", "Bolivia (Plurinational State Of)").
border_datum("BR", "Brazil", "CO", "Colombia").
border_datum("BR", "Brazil", "GF", "French Guiana").
border_datum("BR", "Brazil", "GY", "Guyana").
border_datum("BR", "Brazil", "PY", "Paraguay").
border_datum("BR", "Brazil", "PE", "Peru").
border_datum("BR", "Brazil", "SR", "Suriname").
border_datum("BR", "Brazil", "UY", "Uruguay").
border_datum("BR", "Brazil", "VE", "Venezuela (Bolivarian Republic of)").
border_datum("CL", "Chile", "AR", "Argentina").
border_datum("CL", "Chile", "BO", "Bolivia (Plurinational State Of)").
border_datum("CL", "Chile", "PE", "Peru").
border_datum("CO", "Colombia", "BR", "Brazil").
border_datum("CO", "Colombia", "EC", "Ecuador").
border_datum("CO", "Colombia", "PE", "Peru").
border_datum("CO", "Colombia", "VE", "Venezuela (Bolivarian Republic of)").
border_datum("EC", "Ecuador", "CO", "Colombia").
border_datum("EC", "Ecuador", "PE", "Peru").
border_datum("FK", "Falkland Islands (Malvinas)", "", "").
border_datum("GF", "French Guiana", "BR", "Brazil").
border_datum("GF", "French Guiana", "SR", "Suriname").
border_datum("GS", "South Georgia and the South Sandwich Islands", "", "").
border_datum("GY", "Guyana", "BR", "Brazil").
border_datum("GY", "Guyana", "SR", "Suriname").
border_datum("GY", "Guyana", "VE", "Venezuela (Bolivarian Republic of)").
border_datum("PE", "Peru", "BO", "Bolivia (Plurinational State Of)").
border_datum("PE", "Peru", "BR", "Brazil").
border_datum("PE", "Peru", "CL", "Chile").
border_datum("PE", "Peru", "CO", "Colombia").
border_datum("PE", "Peru", "EC", "Ecuador").
border_datum("PY", "Paraguay", "AR", "Argentina").
border_datum("PY", "Paraguay", "BO", "Bolivia (Plurinational State Of)").
border_datum("PY", "Paraguay", "BR", "Brazil").
border_datum("SR", "Suriname", "BR", "Brazil").
border_datum("SR", "Suriname", "GF", "French Guiana").
border_datum("SR", "Suriname", "GY", "Guyana").
border_datum("UY", "Uruguay", "AR", "Argentina").
border_datum("UY", "Uruguay", "BR", "Brazil").
border_datum("VE", "Venezuela (Bolivarian Republic of)", "BR", "Brazil").
border_datum("VE", "Venezuela (Bolivarian Republic of)", "CO", "Colombia").
border_datum("VE", "Venezuela (Bolivarian Republic of)", "GY", "Guyana").


group_datum("Mercosur", "Southern Common Market", "AR").
group_datum("Mercosur", "Southern Common Market", "BO").
group_datum("Mercosur", "Southern Common Market", "BR").
group_datum("Mercosur", "Southern Common Market", "CL").
group_datum("Mercosur", "Southern Common Market", "CO").
group_datum("Mercosur", "Southern Common Market", "EC").
group_datum("Mercosur", "Southern Common Market", "GY").
group_datum("Mercosur", "Southern Common Market", "PE").
group_datum("Mercosur", "Southern Common Market", "PY").
group_datum("Mercosur", "Southern Common Market", "SR").
group_datum("Mercosur", "Southern Common Market", "UY").

group("Mercosur").

color(1..3).