# codes département

# urlcodedepinsee <- "https://www.insee.fr/fr/statistiques/fichier/5057840/departement2021-csv.zip"
# 
# download.file(url = urlcodedepinsee,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/departement2021-csv.zip")
# unzip(zipfile="/home/gilles/data/departement2021-csv.zip",
# 			exdir = "~/data")

codedep <- fread("~/data/departement2021.csv")

# codes EPCI

# urlcodeepci2021 <- "https://www.insee.fr/fr/statistiques/fichier/2510634/Intercommunalite_Metropole_au_01-01-2021.zip"

urlcodeepci2020 <- "https://www.insee.fr/fr/statistiques/fichier/2510634/Intercommunalite_Metropole_au_01-01-2020_v1.zip"

# download.file(url = urlcodeepci2020,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/Intercommunalite_Metropole_2020.zip")
# unzip(zipfile="/home/gilles/data/Intercommunalite_Metropole_2020.zip",
# 			exdir = "~/data")

library("readxl")

codeepci <- read_xlsx(path = "~/data/Intercommunalite-Metropole_au_01-01-2020_v1.xlsx",
											sheet = "EPCI",
											skip = 5)

setDT(codeepci)
# codeepci[NATURE_EPCI == "ME"]

# code dep https://code.highcharts.com/mapdata/countries/fr/fr-all-all.geo.json

codehc <- data.table(codeinsee=c(formatC(x=1:19,
																			 digits = 1,
																			 flag = 0),
																 "2A",
																 "2B",
																 formatC(x=21:95,
																			 digits = 1,
																			 flag = 0),
																 "971", "972", "973", "974", "976"),
										 codehc=c("fr-ara-ai",
															"fr-hdf-as",
															"fr-ara-al",
															"fr-pac-ap",
															"fr-pac-ha",
															"fr-pac-am",
															"fr-ara-ah",
															"fr-ges-an",
															"fr-occ-ag",
															"fr-ges-ab",
															"fr-occ-ad",
															"fr-occ-av",
															"fr-pac-bd",
															"fr-nor-cv",
															"fr-ara-cl",
															"fr-naq-ct",
															"fr-naq-cm",
															"fr-cvl-ch",
															"fr-naq-cz",
															"fr-cor-cs",
															"fr-cor-hc",
															"fr-bfc-co",
															"fr-bre-ca",
															"fr-naq-cr",
															"fr-naq-dd",
															"fr-bfc-db",
															"fr-ara-dm",
															"fr-nor-eu",
															"fr-cvl-el",
															"fr-bre-fi",
															"fr-occ-ga",
															"fr-occ-hg",
															"fr-occ-ge",
															"fr-naq-gi",
															"fr-occ-he",
															"fr-bre-iv",
															"fr-cvl-in",
															"fr-cvl-il",
															"fr-ara-is",
															"fr-bfc-ju",
															"fr-naq-ld",
															"fr-cvl-lc",
															"fr-ara-lr",
															"fr-ara-hl",
															"fr-pdl-la",
															"fr-cvl-lt",
															"fr-occ-lo",
															"fr-naq-lg",
															"fr-occ-lz",
															"fr-pdl-ml",
															"fr-nor-mh",
															"fr-ges-mr",
															"fr-ges-hm",
															"fr-pdl-my",
															"fr-ges-mm",
															"fr-ges-ms",
															"fr-bre-mb",
															"fr-ges-mo",
															"fr-bfc-ni",
															"fr-hdf-no",
															"fr-hdf-oi",
															"fr-nor-or",
															"fr-hdf-pc",
															"fr-ara-pd",
															"fr-naq-pa",
															"fr-occ-hp",
															"fr-occ-po",
															"fr-ges-br",
															"fr-ges-hr",
															"fr-ara-rh",
															"fr-bfc-hn",
															"fr-bfc-sl",
															"fr-pdl-st",
															"fr-ara-sv",
															"fr-ara-hs",
															"fr-idf-vp",
															"fr-nor-sm",
															"fr-idf-se",
															"fr-idf-yv",
															"fr-naq-ds",
															"fr-hdf-so",
															"fr-occ-ta",
															"fr-occ-tg",
															"fr-pac-vr",
															"fr-pac-vc",
															"fr-pdl-vd",
															"fr-naq-vn",
															"fr-naq-hv",
															"fr-ges-vg",
															"fr-bfc-yo",
															"fr-bfc-tb",
															"fr-idf-es",
															"fr-idf-hd",
															"fr-idf-ss",
															"fr-idf-vm",
															"fr-idf-vo",
															"fr-gua-gp",
															"fr-mq-mq",
															"fr-gf-gf",
															"fr-lre-re",
															"fr-may-yt"))

