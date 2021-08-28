# retrieve remote files headers

searchInHeaders <- function(url, pattern) {
	tmp <- curlGetHeaders(url)
	idx <- grep(pattern, tmp, ignore.case = TRUE)
	resp <- tmp[idx]
	resu <- gsub(pattern=("Last-Modified: |\\r\\n"), replacement="", x=resp)
	return(resu)
}

myresult <- searchInHeaders(urlcovdatashospquot, "Last-Modified")
allurlobj <- ls(pattern="^urlcov")
get(allurlobj)
get(allurlobj[1])
allurlobj[-3]
lapply(X=allurlobj, FUN=function(x) get(x))
lapply(X=allurlobj, FUN=function(x) searchInHeaders(get(x), pattern="Last-Modified"))

searchInHeaders(get(allurlobj[3]), "Last-Modified")
curlGetHeaders(get(allurlobj[3]))
