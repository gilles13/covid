# lib -- {{{
library("data.table")
library("sf")
library("tmap")
library("ggplot2")
library("highcharter")
library("dygraphs")
# library("zoo")
# library("htmlwidgets")
# --- }}}

# preparation --- {{{
dateISO8601 <- format(Sys.time(), "%Y%m%d")
source(file = "/media/usb1/covid/covid_url.R", local = TRUE)
# source(file = "/media/usb1/covid/covid_dwl.R", local = TRUE)
source(file = "/media/usb1/covid/covid_codif.R", local = TRUE)
# --- }}}

# import data --- {{{
# spatial data
frALL <- readRDS(file="~/data/frRESHAPE.RDS")
# table des indicateurs
covtindnat <- fread("~/data/table-indicateurs-open-data-france.csv")
covtinddep <- fread("~/data/table-indicateurs-open-data-dep.csv")
# données hospitalières
# covdhdepsex <- fread("~/data/donnes_hosp_dep_sexe.csv")
covdhquot <- fread("~/data/donnes_hosp_quot.csv")
covdhquot$annee <- format(covdhquot$jour, "%Y")
# taux d'incidence
covtinat <- fread("~/data/sp-pe-tb-quot-fra.csv")
covtidep <- fread("~/data/sp-pe-tb-quot-dep.csv")
# vaccination
# covvacfra <- fread("~/data/vacsi12-fra.csv")
# covvacvfr <- fread("~/data/vacsi-v-fra.csv")
# covvacafr <- fread("~/data/vacsi-a-fra.csv")
# covvacsfr <- fread("~/data/vacsi-s-fra.csv")
# covvactotfr <- fread("~/data/vacsi-tot-fra.csv")
# covvactotafr <- fread("~/data/vacsi-tot-a-fra.csv")
# covvactotsfr <- fread("~/data/vacsi-tot-s-fra.csv")
# données métropoles
covsgmetro <- fread("~/data/sg-metro-opendata.csv")
covsgmetro$epci2020 <- as.character(covsgmetro$epci2020)
# tests virologiques
covtestnat <- fread("~/data/sp-pos-quot-fra.csv")
covtestdep <- fread("~/data/sp-pos-quot-dep.csv")
# --- }}}

# Taux d'incidence --- {{{

# niveau national --- {{{

# select only cl_age == 0 (all)
tifrall <- covtinat[cl_age90 == 0, c("jour",
																	 "P",
																	 "pop")]
# rolling sum by 7 days
tifrall[, "P7j" := lapply(.SD, frollsum, n=7, fill=NA, align="right"),
	 .SDcols = "P"]
tifrall[, "P7j100k" := (P7j * 100000) / pop]
tifralllast <- tifrall[, .SD[.N]]
majtifralllast <- tifralllast$jour

# Tx de croissance du taux d'incidence --- {{{
# shift data by 7 days
tifrall[, "P7j100kshift" := shift(tifrall$P7j100k, n = 7, fill = NA)]
# compute evolution rate
tifrall[, "txevotxincid" := (P7j100k - P7j100kshift)/P7j100kshift * 100]

# --- }}}

# --- }}}

# niveau départemental --- {{{
tidepall <- covtidep[cl_age90 == 0]
# rolling sum by 7 days
tidepall[, "P7j" := lapply(.SD, frollsum, n=7, fill=NA, align="right"),
				 by = dep,
				 .SDcols = "P"]
tidepall[, "P7j100k" := (P7j * 100000) / pop, by=dep]
tidepalllast <- tidepall[, .SD[.N], by=dep]

# --- }}}

# niveau métropole --- {{{

tincidmet <- merge(x = covsgmetro,
									 y = codeepci[NATURE_EPCI == "ME"][, c("EPCI", "LIBEPCI")],
									 by.x = "epci2020",
									 by.y = "EPCI")

tincidmet <- tincidmet[clage_65 == 0]
tincidmet <- tincidmet[, sem := substring(text=tincidmet$semaine_glissante,
																					first=12)]
tincidmet$sem <- as.Date(tincidmet$sem, format="%Y-%m-%d")
myorder <- tincidmet[tincidmet$sem == max(tincidmet$sem)][order(ti, decreasing = TRUE)][, LIBEPCI]
tincidmet$LIBEPCI <- factor(tincidmet$LIBEPCI, levels=rev(myorder))
tincidmet <- tincidmet[sem > "2021-07-23"]

# --- }}}

# --- }}}

# Nb moyen de nouvelles hospitalisation quotidienne --- {{{
# Nb quotidien de nouveaux patients hospitalisés atteints de la COVID - moyenne sur 7 jours

# niveau national --- {{{
# group by jour & sum incid_hosp
nmnhq <- covdhquot[, lapply(.SD, sum),
								by = .(jour),
								.SDcols="incid_hosp"]
# apply rolling function (mean) by 7 days
# voir aussi zoo::rollmean (k=7, fill=NA, align="right")
nmnhq[, "nmnhq" := lapply(.SD, frollmean, n=7, fill=NA, align="right"),
	 .SDcols = "incid_hosp"]
### taux de croissance du nb moyen de nouvelles hospit. quot. == tcnmnhq
# shift data by 7 days
tnmnhq$nmnhq
nmnhq[, "nmnhq7jshift" := shift(nmnhq, n = 7, fill = NA)]
# compute evolution rate
nmnhq[, "tnmnhq" := (nmnhq - nmnhq7jshift)/nmnhq7jshift * 100]
# --- }}}

# niveau départemental ---  {{{
nmnhqdep <- copy(covdhquot)
nmnhqdep <- merge(x = nmnhqdep, y=codedep[, c("DEP", "NCC")],
							 by.x = "dep",
							 by.y = "DEP")

nmnhqdep[, "nmnhq" := lapply(.SD, frollmean, n=7, fill=NA, align="right"),
	 by=.(dep, annee),
	 .SDcols = "incid_hosp"]
nmnhqdeplast <- nmnhqdep[, .SD[.N], by=dep]
# --- }}}

# --- }}}

# Nb moyen de décès quotidien à l'hopital --- {{{
nmdcquothop <- copy(covdhquot)
nmdcquothop <- merge(x = nmdcquothop, y=codedep[, c("DEP", "NCC")],
							 by.x = "dep",
							 by.y = "DEP")

nmdcquothop[, "nmdcquot" := lapply(.SD, frollmean, n=7, fill=NA, align="right"),
	 by=.(dep, annee),
	 .SDcols = "incid_dc"]
nmdcquotlast <- nmdcquothop[, .SD[.N], by=dep]
majnmdcquot <- unique(nmdcquotlast$jour)
# --- }}}

# Taux de positivité --- {{{
tpfrall <- covtestnat[cl_age90 == 0, c("jour",
																			 "P",
																			 "T",
																			 "pop")]
## rolling mean by 7 days
tpfrall[, "TP" := (P / T) * 100][, "TP7j" := lapply(.SD, frollmean, n=7, fill=NA, align="right"), .SDcols = "TP"]
tpfralllast <- tpfrall[, .SD[.N]]
majtpfrall <- tpfralllast$jour

## Taux d'évo du taux de positivité
tpfrall[, "TP7jshift" := shift(tpfrall$TP7j, n = 7, fill = NA)][
				, "txevotxpos" := (TP7j - TP7jshift)/TP7jshift * 100]

# --- }}}

# Taux de reproduction --- {{{
# TODO
# --- }}}

# Nb de personnes vaccinées --- {{{
# TODO
# --- }}}
