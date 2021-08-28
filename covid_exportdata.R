library("git2rdata")

dummydt <- data.table(x=1:10,
											y=LETTERS[1:10])


repo <- "~/mesgit/covid/"

pull(repo)

write_vc(dummydt, file="data/dummy.csv", root = repo, stage=TRUE)

commit(repo, "test export dummy data")

push(repo)
