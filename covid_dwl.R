# dwl

## spatial data
# download.file(url = urlFrGEOFLA,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/GEOFLA.7z")
# system('7z e -o"/home/gilles/data/GEOFLA" "/home/gilles/data/GEOFLA.7z"')

# table des indicateurs nationaux
download.file(url = urlcovtabindicfr,
							mode = "wb",
							destfile = "/home/gilles/data/table-indicateurs-open-data-france.csv")

# table des indicateurs departementaux
download.file(url = urlcovtabindicdep,
							mode = "wb",
							destfile = "/home/gilles/data/table-indicateurs-open-data-dep.csv")

# # données hospit par dept & sexe
# download.file(url = urlcovdatashospdepsex,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/donnes_hosp_dep_sexe.csv")

# données hospit donnees quotidienne
download.file(url = urlcovdatashospquot,
							mode = "wb",
							destfile = "/home/gilles/data/donnes_hosp_quot.csv")

# tx d'incid nat
download.file(url = urlcovtinat,
							mode = "wb",
							destfile = "/home/gilles/data/sp-pe-tb-quot-fra.csv")

# tx d'incid dep
download.file(url = urlcovtidep,
							mode = "wb",
							destfile = "/home/gilles/data/sp-pe-tb-quot-dep.csv")

# # vaccination fra
# download.file(url = urlcovvac12fr,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/vacsi12-fra.csv")
# download.file(url = urlcovvacafr,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/vacsi-a-fra.csv")
# download.file(url = urlcovvacsfr,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/vacsi-s-fra.csv")
# download.file(url = urlcovvacvfr,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/vacsi-v-fra.csv")
# download.file(url = urlcovvactotfr,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/vacsi-tot-fra.csv")
# download.file(url = urlcovvactotafr,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/vacsi-tot-a-fra.csv")
# download.file(url = urlcovvactotsfr,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/vacsi-tot-s-fra.csv")

# données métropoles
download.file(url = urlsgmetro,
							mode = "wb",
							destfile = "/home/gilles/data/sg-metro-opendata.csv")

# données tests virologiques
download.file(url = urlcovtestsnat,
							mode = "wb",
							destfile = "/home/gilles/data/sp-pos-quot-fra.csv")

download.file(url = urlcovtestsdep,
							mode = "wb",
							destfile = "/home/gilles/data/sp-pos-quot-dep.csv")
