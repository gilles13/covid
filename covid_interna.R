# international data --- {{{

## dwl
# download.file(url = urlcovint,
# 							mode = "wb",
# 							destfile = "/home/gilles/data/owid-covid-data.csv")

covdata <- fread("~/data/owid-covid-data.csv")
# str(covdata)
# min(covdata$date)
# max(covdata$date)

covsel <- covdata[iso_code %in% c("FRA",
																	"ESP",
																	"GBR") &
									date %between% c("2020-01-29",
																	 as.character(max(covdata$date)))]

# remove spain new_case_smoothed data between 2021-03-02 and 2021-03-08
covsel[iso_code == "ESP"][396:402]
covsel[iso_code == "ESP"][396:402, "new_cases_smoothed_per_million"] <- NA

g1 <- ggplot(data = covsel,
						 mapping = aes(x = date,
													 y = new_cases_smoothed_per_million,
													 color = iso_code,
													 group = iso_code)) +
geom_line(show.legend = TRUE,
					size = 1.5) +
labs(title = "Daily new confirmed COVID-19 cases per million people",
		 subtitle = "Shown is the rolling 7-day average. \nThe number of confirmed cases is lower than the number of actual cases; the main reason for that is limited testing.",
		 caption = "Source: Johns Hopkins University CSSE COVID-19 Data",
		 color = "",
		 x = "",
		 y = "") +
theme(legend.position = "top")
# g1

# g1 + scale_x_date(expand = c(0, 0),
# 									date_breaks = "10 days",
# 									date_labels = "%d %b")

## dt to ts
tab1 <- copy(covsel)
tab2 <- dcast(data = tab1[, c("iso_code","date","new_cases_smoothed_per_million")],
							formula = date ~ iso_code,
							value.var = "new_cases_smoothed_per_million")

z <- zoo::read.zoo(tab2, format = "%Y-%m-%d")
# library(xts)
# z <- xts(tab3[, -1], order.by=as.Date(tab3$date))

# # highcharter
# hchart(tab2,
# 			 "line",
# 			 hcaes(x=date,
# 						 y=new_cases_smoothed_per_million,
# 						 group=iso_code))

# # dygraphs
# dygraph(data = z)
# library("dygraphs")
# dyRangeSelector(dygraph(data = z,
# 												main = "Title",
# 												xlab = "Source: Johns Hopkins University CSSE COVID-19 Data"))


# --- }}}
