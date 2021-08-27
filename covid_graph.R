# taux d'incidence national
gtincidnat <- ggplot(data=tifrall,
										 aes(x=jour,
												 y=P7j100k)) +
geom_line(color="blue", size=1.5) +
labs(title="Taux d'incidence FR",
		 x="",
		 y="",
		 fill="",
		 subtitle="Nombre de cas par semaine pour 100 000 habitants",
		 caption=paste0("Source : Santé publique France, data.gouv.fr",
										"\n",
										"Mise à jour : ",
										majtifralllast)) +
theme_minimal()

# ggsave(filename = paste0("~/data/, dateISO8601, "_taux_incidence.png"),
#        height = 8,
#        width = 12,
#        dpi = "retina")

# taux d'incidence départemental
mtidepalllast <- merge(tidepalllast, codehc,
											 by.x = "dep",
											 by.y = "codeinsee")

# carte ala covidtracker
mtidepall <- merge(x=frALL,
									 y=tidepalllast,
									 by.x="CODE_DEPT",
									 by.y="dep")

palCovTrack <- c("vert"=rgb(152, 172, 59, maxColorValue = 255),
								 "orange"=rgb(249, 82, 40, maxColorValue = 255),
								 "rouge"=rgb(200, 0, 0, maxColorValue = 255),
								 "noir"=rgb(60, 0, 0, maxColorValue = 255),
								 "violet"=rgb(128, 0, 128, maxColorValue = 255))

gtinciddep <- 
tm_shape(mtidepall) +
tm_polygons(
				col="P7j100k",
				style = "fixed",
				interval.closure = "right",
				breaks = c(0, 50, 150, 250, 400,
									 max(mtidepall$P7j100k, na.rm=TRUE)),
				labels = c("< 50",
									 "< 150",
									 "< 250",
									 "< 400",
									 "> 400"),
				palette = palCovTrack,
				title = "",
				border.col = "white",
				legend.is.portrait = TRUE,
				legend.reverse = TRUE,
				lwd = 0.5,
				textNA = "Données manquantes",
				colorNA = "grey") +
tm_layout(legend.outside = FALSE,
					legend.position = c("RIGHT", "TOP"),
					legend.text.size = 0.5,
					main.title = "Taux d'incidence\n(pour 100k habitants)",
					main.title.size = 1,
					main.title.position = "center",
					bg.color = "white") +
tm_credits(text = paste0("Mise à jour : ", majtifralllast),
					 position = c("RIGHT", "BOTTOM"),
					 size = 0.5)

# taux d'incidence métropoles
gtincidmet <- 
	ggplot(data = tincidmet,
				 mapping = aes(x=sem,
											 y=LIBEPCI,
											 fill=ti)) +
geom_tile() +
geom_text(aes(label = round(ti, 0))) +
scale_fill_gradient(low="pink", high="darkred") +
labs(title = "Taux d'incidence du Covid19 dans les 22 métropoles",
		 x = "",
		 y = "",
		 subtitle = "Tous âges, nb de cas sur 7 jours pour 100k hab.",
		 caption = "Source : Santé publique France") +
scale_x_date(expand = c(0, 0),
						 date_breaks = "1 day",
						 date_labels = "%d %m") +
theme(legend.title = element_blank())

# nb moyen de nouvelles hospit quotidienne
gnmnhq <- ggplot(data = nmnhq,
								 mapping = aes(x = jour,
															 y = nmnhq)) +
geom_line() +
labs(title = "Nb moyen de nouvelles hospitalisations quotidiennes",
		 subtitle = "en moyenne sur 7 jours",
		 caption = "Source : Santé publique France",
		 x = "",
		 y = "")

# carte du nb moyen de nouvelles hospit quotidiennes par département
mnmnhquotdep <- merge(x=frALL, y=nmnhqdeplast,
											by.x="CODE_DEPT",
											by.y="dep")

gnmnhquotdep <- tm_shape(mnmnhquotdep) +
tm_polygons(col="nmnhq",
							style = "cont",
							palette = c("gold", "brown4"),
							title = "",
							legend.is.portrait = FALSE,
							border.col = "white",
							lwd = 2,
							textNA = "Données manquantes",
							colorNA = "grey") +
tm_layout(main.title = "Nb moyen de nouvelles\nhospitalisations quotidiennes",
					main.title.size = 1,
					main.title.position = "center",
					bg.color = "white")


