# misc --- {{{

# 975 : Saint-Pierre-et-Miquelon
# 977 : Saint-Barthélemy
# 978 : Saint-Martin

library("sf")

select_pt <- function() {
	return(unlist(locator(1)))
}

findCent <- function(x) {
	return(unlist(st_centroid(st_geometry(x))))
}

findPointToPlace <- function(x, point=1) {
	a <- st_coordinates(mydf[point, ])[1] - findCent(x)[1]
	b <- st_coordinates(mydf[point, ])[2] - findCent(x)[2]
	return(c(a, b))
}

# --- }}}

# départements métropole --- {{{
frDEPT <- st_read("~/data/GEOFLA/DEPARTEMENT.shp",
									stringsAsFactors=FALSE,
									quiet = TRUE)

# str(frDEPT)
# st_crs(frDEPT)
# str(st_drop_geometry(frDEPT))
# frDEPT <- st_buffer(frDEPT, 0)
plot(st_geometry(frDEPT))

# mygrid <- st_make_grid(frDEPT, n=10)
mygrid <- st_make_grid(frALL, n=10)
# mygrid2 <- mygrid[c(1, 11, 21, 31, 41, 91)]
plot(st_geometry(mygrid), add=TRUE)
# plot(st_geometry(mygrid2), add=TRUE)
mydfcentroid <- st_centroid(mygrid)
mydf <- data.frame(mydfcentroid)

# --- }}}

# IDF --- {{{
paris <- frDEPT[frDEPT$CODE_DEPT %in% c("75",
																				"92",
																				"93",
																				"94"), ]
st_crs(paris) <- NA
st_crs(paris) <- 2154
paris$geometry <- paris$geometry * 2.5
st_crs(paris) <- 2154
parisun <- st_union(paris)
modif <- findPointToPlace(parisun, point=91)
paris$geometry <- paris$geometry + c(modif[1], modif[2])
st_crs(paris) <- 2154
frALL <- rbind(frDEPT,
							 paris)
plot(st_geometry(frALL))
plot(st_geometry(mygrid), add=TRUE)

# --- }}}

# guadeloupe (971) --- {{{
urlGuad <- "ftp://Admin_Express_ext:Dahnoh0eigheeFok@ftp3.ign.fr/GEOFLA_2-2_DEPARTEMENT_SHP_UTM20W84GUAD_D971_2016-06-28.7z"
download.file(url = urlGuad,
							mode = "wb",
							destfile = "/home/gilles/data/GUAD.7z")
system('7z e -o"/home/gilles/data/GUAD" "/home/gilles/data/GUAD.7z"')

guadeloupe <- st_read("~/data/GUAD/DEPARTEMENT.shp",
									stringsAsFactors=FALSE,
									quiet = TRUE)
# str(guadeloupe)
# str(st_drop_geometry(guadeloupe))
# st_crs(guadeloupe)
# st_crs(guadeloupe) <- 2154
# plot(st_geometry(guadeloupe))
guad_5490 <- st_transform(guadeloupe, crs = 5490)
st_crs(guad_5490) <- NA
st_crs(guad_5490) <- 2154
guad_5490$geometry <- guad_5490$geometry * 1.1
st_crs(guad_5490) <- 2154
modif <- findPointToPlace(guad_5490, point=41)
guad_5490$geometry <- guad_5490$geometry + c(modif[1], modif[2])
st_crs(guad_5490) <- 2154
guad_5490[, "CODE_DEPT"] <- "971"
guad_5490[, "ID_GEOFLA"] <- "DEPARTEM0000000000000097"
metroGuad <- rbind(frALL,
									 guad_5490)
plot(st_geometry(metroGuad))
# st_drop_geometry(metroGuad)
# str(st_drop_geometry(metroGuad))
# --- }}}

# martinique (972) --- {{{
urlMart <- "ftp://Admin_Express_ext:Dahnoh0eigheeFok@ftp3.ign.fr/GEOFLA_2-2_DEPARTEMENT_SHP_UTM20W84MART_D972_2016-06-28.7z"
download.file(url = urlMart,
							mode = "wb",
							destfile = "/home/gilles/data/MART.7z")
system('7z e -o"/home/gilles/data/MART" "/home/gilles/data/MART.7z"')

martinique <- st_read("~/data/MART/DEPARTEMENT.shp",
											stringsAsFactors=FALSE,
											quiet = TRUE)
# plot(st_geometry(martinique))
# st_crs(martinique)
# st_crs(martinique) <- 2154
martinique_5490 <- st_transform(martinique, crs = 5490)
st_crs(martinique_5490) <- NA
st_crs(martinique_5490) <- 2154
martinique_5490$geometry <- martinique_5490$geometry * 1.2
modif <- findPointToPlace(martinique_5490, point=31)
martinique_5490$geometry <- martinique_5490$geometry + c(modif[1], modif[2])
st_crs(martinique_5490) <- 2154
martinique_5490[, "CODE_DEPT"] <- "972"
martinique_5490[, "ID_GEOFLA"] <- "DEPARTEM0000000000000098"
metro2 <- rbind(frALL,
								guad_5490,
								martinique_5490)
plot(st_geometry(metro2))
# st_drop_geometry(metro2)
# --- }}}

# guyane (973) --- {{{
urlGuy <- "ftp://Admin_Express_ext:Dahnoh0eigheeFok@ftp3.ign.fr/GEOFLA_2-2_DEPARTEMENT_SHP_UTM22RGFG95_D973_2016-06-28.7z"
download.file(url = urlGuy,
							mode = "wb",
							destfile = "/home/gilles/data/GUY.7z")
system('7z e -o"/home/gilles/data/GUY" "/home/gilles/data/GUY.7z"')

guyane <- st_read("~/data/GUY/DEPARTEMENT.shp",
									stringsAsFactors=FALSE,
									quiet = TRUE)
# plot(st_geometry(guyane))
# st_crs(guyane)
# st_crs(guyane) <- 2154
guya_2972 <- st_transform(guyane, crs = 2972)
st_crs(guya_2972) <- NA
st_crs(guya_2972) <- 2154
guya_2972$geometry <- guya_2972$geometry *.15
modif <- findPointToPlace(guya_2972, point=21)
guya_2972$geometry <- guya_2972$geometry + c(modif[1], modif[2])
st_crs(guya_2972) <- 2154
guya_2972[, "CODE_DEPT"] <- "973"
guya_2972[, "ID_GEOFLA"] <- "DEPARTEM0000000000000099"
metro3 <- rbind(frALL,
								guad_5490,
								martinique_5490,
								guya_2972)
plot(st_geometry(metro3))

# --- }}}

# la réunion (974) --- {{{
urlReu <- "ftp://Admin_Express_ext:Dahnoh0eigheeFok@ftp3.ign.fr/GEOFLA_2-2_DEPARTEMENT_SHP_RGR92UTM40S_D974_2016-06-28.7z"
download.file(url = urlReu,
							mode = "wb",
							destfile = "/home/gilles/data/REU.7z")
system('7z e -o"/home/gilles/data/REU" "/home/gilles/data/REU.7z"')

lareunion <- st_read("~/data/REU/DEPARTEMENT.shp",
										 stringsAsFactors=FALSE,
										 quiet = TRUE)
# plot(st_geometry(lareunion))
# st_crs(lareunion)
# st_crs(lareunion) <- 2154
reunion_2975 <- st_transform(lareunion, crs = 2975)
st_crs(reunion_2975) <- NA
st_crs(reunion_2975) <- 2154
reunion_2975$geometry <- reunion_2975$geometry * 0.9
modif <- findPointToPlace(reunion_2975, point=11)
reunion_2975$geometry <- reunion_2975$geometry + c(modif[1], modif[2])
st_crs(reunion_2975) <- 2154
reunion_2975[, "CODE_DEPT"] <- "974"
reunion_2975[, "ID_GEOFLA"] <- "DEPARTEM0000000000000100"
metro4 <- rbind(frALL,
								guad_5490,
								martinique_5490,
								guya_2972,
								reunion_2975)
plot(st_geometry(metro4))
# --- }}}

# mayotte (976) --- {{{
urlMay <- "ftp://Admin_Express_ext:Dahnoh0eigheeFok@ftp3.ign.fr/GEOFLA_2-2_DEPARTEMENT_SHP_RGM04UTM38S_D976_2016-06-28.7z"
download.file(url = urlMay,
							mode = "wb",
							destfile = "/home/gilles/data/MAY.7z")
system('7z e -o"/home/gilles/data/MAY" "/home/gilles/data/MAY.7z"')

mayotte <- st_read("~/data/MAY/DEPARTEMENT.shp",
									 stringsAsFactors=FALSE,
									 quiet = TRUE)
# plot(st_geometry(mayotte))
# st_crs(mayotte)
# st_crs(mayotte) <- 2154
mayotte_4471 <- st_transform(mayotte, crs = 4471)
st_crs(mayotte_4471) <- NA
st_crs(mayotte_4471) <- 2154
mayotte_4471$geometry <- mayotte_4471$geometry * 2.3
modif <- findPointToPlace(mayotte_4471, point=1)
mayotte_4471$geometry <- mayotte_4471$geometry + c(modif[1], modif[2])
st_crs(mayotte_4471) <- 2154
mayotte_4471[, "CODE_DEPT"] <- "976"
mayotte_4471[, "ID_GEOFLA"] <- "DEPARTEM0000000000000101"
metro5 <- rbind(frALL,
								guad_5490,
								martinique_5490,
								guya_2972,
								reunion_2975,
								mayotte_4471)
plot(st_geometry(metro5))
# --- }}}

# multiplexage geom --- {{{

frFinal <- rbind(frALL,
								 guad_5490,
								 martinique_5490,
								 guya_2972,
								 reunion_2975,
								 mayotte_4471)

plot(st_geometry(frFinal))

# save
saveRDS(frFinal, file = "~/data/frRESHAPE.RDS")

# read
frALL <- readRDS(file="~/data/frRESHAPE.RDS")

# misc
pt_guad_sfg <- st_point(x = c(156000, 6580000))
pt_guad_sfc <- st_sfc(pt_guad_sfg, crs=2154)
pt_guad_df <- data.frame(id=1,
												 label="Guadeloupe")
pt_guad_sf <- st_sf(pt_guad_df, geometry = pt_guad_sfc)

pt_mart_sfg <- st_point(x = c(156000, 6470000))
pt_mart_sfc <- st_sfc(pt_mart_sfg, crs=2154)
pt_mart_df <- data.frame(id=1,
												 label="Martinique")
pt_mart_sf <- st_sf(pt_mart_df, geometry = pt_mart_sfc)

pt_guy_sfg <- st_point(x = c(156000, 6360000))
pt_guy_sfc <- st_sfc(pt_guy_sfg, crs=2154)
pt_guy_df <- data.frame(id=1,
												 label="Guyane")
pt_guy_sf <- st_sf(pt_guy_df, geometry = pt_guy_sfc)

pt_reu_sfg <- st_point(x = c(156000, 6250000))
pt_reu_sfc <- st_sfc(pt_reu_sfg, crs=2154)
pt_reu_df <- data.frame(id=1,
												 label="La réunion")
pt_reu_sf <- st_sf(pt_reu_df, geometry = pt_reu_sfc)

pt_may_sfg <- st_point(x = c(156000, 6150000))
pt_may_sfc <- st_sfc(pt_may_sfg, crs=2154)
pt_may_df <- data.frame(id=1,
												 label="Mayotte")
pt_may_sf <- st_sf(pt_may_df, geometry = pt_may_sfc)

# --- }}}
