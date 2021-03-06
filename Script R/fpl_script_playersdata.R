library(jsonlite)

url <- "http://fantasy.premierleague.com/web/api/elements/"
names(fromJSON(paste0(url,1))) # Concatenate URL and player id to fetch player data

url <- "http://fantasy.premierleague.com/web/api/elements/"
 
## Both paste commands produce same output
paste(url, 1, sep = "")
paste0(url, 1)

url <- "http://fantasy.premierleague.com/web/api/elements/"
toJSON(fromJSON(paste0(url, 1)), pretty = TRUE)

## List of relevant fields we are interested in
 
relevantFields <- c("points_per_game","total_points","type_name",
 "team_name","team_code","team_id",
 "id","status","first_name","second_name",
 "now_cost","value_form","team",
 "ep_next","minutes","goals_scored",
 "assists","clean_sheets","goals_conceded",
 "own_goals","penalties_saved","penalties_missed",
 "yellow_cards","red_cards","saves",
 "bonus","bps","ea_index",
 "value_form","value_season","selected_by")
 
numCols = length(relevantFields) # Length of relevant string vector
# Initializing an empty dataframe
allplayerdata <- data.frame(matrix(NA,nrow=1,ncol=numCols))
allplayerdata <- allplayerdata[-1,]
 
fetchData <- function(i) {
 
 res <- try(jsondata <- fromJSON(paste0(url,i)))
 
 if(!inherits(res, "try-error")) {
 
      jsondata <- jsondata[which(names(jsondata) %in% relevantFields)]
 }
}
 
allplayerdata <- lapply(1:716, fetchData)
allplayerdata <- do.call(rbind, lapply(allplayerdata,
                                           data.frame,
                                           stringsAsFactors=FALSE))