library(maptools)


#set the working directory to where the files are stored - !CHANGE THIS TO YOUR OWN DIRECTORY!
#setwd("~/Documents/AidData/Git Repos/kfw2_amazon_conflict")
#setwd("/home/aiddata/Desktop/Github/kfw2_amazon_conflict/")
setwd("C:/Users/jflak/OneDrive/GitHub/kfw2_amazon_conflict/")

#clear variables and values
rm(list = ls())


#loads the shape file
shpfile = "Raw_and_Original_Data/kfw_analysis_inputs.shp"
shpfile_working = readShapePoly(shpfile)

#makes a dataframe of the shapefile data
df_shpfile <- as.data.frame(shpfile_working)

#load saved data
load("Interim_Data/Land_Violence_Data.Rda")
load("Interim_Data/Individual_Violence_Data.Rda")
load("Interim_Data/Demarcation_Date_Data.Rda")
load("Interim_Data/Land_Violence_Overlap.Rda")
load("Interim_Data/Individual_Violence_Overlap.Rda")

#reads the population and nighttime lights data from file
data_pop_nlights <- read.csv(file = "Raw_and_Original_Data/merge_terra_indigenaPolygon_id_thin.csv", header=TRUE, sep = ',')
#dflc (dist logging center); dcfu (dist federal conservation unit); dcsu (dist state conservation unit); dfrw (dist from railways)

##EXAMPLE for counting frequency of violence - from Preliminary_Delimitation_and_Conflict_Data_Analysis.R
##counts frequency of each id_ad in the data (number of incidences of violence per unit)
#iviolence_overlap$freq <- table(data_iviolence$id_ad)
#lviolence_overlap$freq <- table(data_lviolence$id_ad)


#renames data_iviolence$ad_id to id_ad
names(data_iviolence)[names(data_iviolence)=="ad_id"] <- "id_ad"
#renames lviolence_uniqueid to ad_id so the the id names match
names(data_lviolence)[names(data_lviolence)=="ad_id"] <- "id_ad"

#changes the year variables in data_iviolence and data_lviolence from factors to integers
data_iviolence$year <- as.integer(as.character(data_iviolence$year))
data_lviolence$year <- as.integer(as.character(data_lviolence$year))


##TEST for counting violence incidents for one year - not necessary final code
#iviolence_count2003 <- table(data_iviolence$id_ad[data_iviolence$year == 2003])


#Creates new dataframes with iviolence and lviolence data and appropriately renames "freq" variable in each
data_cross_i <- subset(iviolence_overlap, select = c("id_ad", "freq"))
data_cross_l <- subset(lviolence_overlap, select = c("id_ad", "freq"))
names(data_cross_i)[names(data_cross_i)=="freq"] <- "ifreq_total"
names(data_cross_l)[names(data_cross_l)=="freq"] <- "lfreq_total"


##TEST for creating new columns with violence counts - not necessary final code
#data_cross_i$ifreq2003[data_cross_i$id_ad >= 5100] <- 1
#data_cross_i$ifreq2003[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2003])] <- 1


#Counts the number of incidences of violence for each community in each year, and makes new columns for each year
data_cross_i$ifreq2003[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2003])] <- table(data_iviolence$id_ad[data_iviolence$year == 2003])
data_cross_i$ifreq2004[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2004])] <- table(data_iviolence$id_ad[data_iviolence$year == 2004])
data_cross_i$ifreq2005[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2005])] <- table(data_iviolence$id_ad[data_iviolence$year == 2005])
data_cross_i$ifreq2006[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2006])] <- table(data_iviolence$id_ad[data_iviolence$year == 2006])
data_cross_i$ifreq2007[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2007])] <- table(data_iviolence$id_ad[data_iviolence$year == 2007])
data_cross_i$ifreq2008[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2008])] <- table(data_iviolence$id_ad[data_iviolence$year == 2008])
data_cross_i$ifreq2009[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2009])] <- table(data_iviolence$id_ad[data_iviolence$year == 2009])
data_cross_i$ifreq2010[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2010])] <- table(data_iviolence$id_ad[data_iviolence$year == 2010])
data_cross_i$ifreq2011[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2011])] <- table(data_iviolence$id_ad[data_iviolence$year == 2011])
data_cross_i$ifreq2012[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2012])] <- table(data_iviolence$id_ad[data_iviolence$year == 2012])
data_cross_i$ifreq2013[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2013])] <- table(data_iviolence$id_ad[data_iviolence$year == 2013])
data_cross_i$ifreq2014[is.element(data_cross_i$id_ad, data_iviolence$id_ad[data_iviolence$year == 2014])] <- table(data_iviolence$id_ad[data_iviolence$year == 2014])

data_cross_l$lfreq2003[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2003])] <- table(data_lviolence$id_ad[data_lviolence$year == 2003])
data_cross_l$lfreq2004[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2004])] <- table(data_lviolence$id_ad[data_lviolence$year == 2004])
data_cross_l$lfreq2005[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2005])] <- table(data_lviolence$id_ad[data_lviolence$year == 2005])
data_cross_l$lfreq2006[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2006])] <- table(data_lviolence$id_ad[data_lviolence$year == 2006])
data_cross_l$lfreq2007[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2007])] <- table(data_lviolence$id_ad[data_lviolence$year == 2007])
data_cross_l$lfreq2008[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2008])] <- table(data_lviolence$id_ad[data_lviolence$year == 2008])
data_cross_l$lfreq2009[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2009])] <- table(data_lviolence$id_ad[data_lviolence$year == 2009])
data_cross_l$lfreq2010[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2010])] <- table(data_lviolence$id_ad[data_lviolence$year == 2010])
data_cross_l$lfreq2011[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2011])] <- table(data_lviolence$id_ad[data_lviolence$year == 2011])
data_cross_l$lfreq2012[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2012])] <- table(data_lviolence$id_ad[data_lviolence$year == 2012])
data_cross_l$lfreq2013[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2013])] <- table(data_lviolence$id_ad[data_lviolence$year == 2013])
data_cross_l$lfreq2014[is.element(data_cross_l$id_ad, data_lviolence$id_ad[data_lviolence$year == 2014])] <- table(data_lviolence$id_ad[data_lviolence$year == 2014])


#Creates a merged dataset with the individual and land data, as well as the demarcation dates
data_cross_merged <- merge.data.frame(data_cross_i, data_cross_l, by = "id_ad", all = TRUE)
data_cross_merged <- merge.data.frame(data_cross_merged, data_demdates, by = "id_ad", all = TRUE)


#Renames data_pop_nlights$id to data_pop_nlights$id_587 so that it matches previously merged dataset
names(data_pop_nlights)[names(data_pop_nlights)=="id"] <- "id_587"

#Merges previous merged dataset with data_pop_nlights
data_cross_merged <- merge.data.frame(data_cross_merged, data_pop_nlights, by = "id_587")

#NOTE: I use '*' in my comments here to refer to 0 or more characters (* is used for that in Stata), but that is not how the syntax works in the code in R;
#Renames gpw4_* to Pop_* (in data_cross_merged)
names(data_cross_merged) <- gsub("gpw4_", "Pop_", names(data_cross_merged))
#Removes the "e" from the end of the Pop variables
names(data_cross_merged) <- gsub("(Pop_....)e", "\\1", names(data_cross_merged))
#Renames ncc4_* to ntl_* (in data_cross_merged)
names(data_cross_merged) <- gsub("ncc4_", "ntl_", names(data_cross_merged))
#Removes the "e" from the end of the ntl variables
names(data_cross_merged) <- gsub("(ntl_....)e", "\\1", names(data_cross_merged))

#Renames data_cross_merged$id_587 to data_cross_merged$id to match the shapefile
names(data_cross_merged)[names(data_cross_merged)=="id_587"] <- "id"

#deletes SP_ID column from data_cross_merged
data_cross_merged$SP_ID <- NULL


#Beginning of renaming all of the variables longer than 10 characters so that
#they don't get cut off when put into a shapefile

names(data_cross_merged)[names(data_cross_merged)=="terrai_nome"] <- "ter_nome"

names(data_cross_merged) <- gsub("identificada", "id", names(data_cross_merged))
names(data_cross_merged) <- gsub("delimitada", "del", names(data_cross_merged))
names(data_cross_merged) <- gsub("declarada", "dem", names(data_cross_merged))
names(data_cross_merged) <- gsub("homologada", "appr", names(data_cross_merged))
names(data_cross_merged) <- gsub("regularizada", "reg", names(data_cross_merged))

names(data_cross_merged) <- gsub("2011$", "11", names(data_cross_merged))
names(data_cross_merged) <- gsub("2016$", "16", names(data_cross_merged))

names(data_cross_merged) <- gsub("day", "d", names(data_cross_merged))
names(data_cross_merged) <- gsub("month", "m", names(data_cross_merged))
names(data_cross_merged) <- gsub("year", "y", names(data_cross_merged))

names(data_cross_merged) <- gsub("(.+)_extra(.+)", "ex\\1\\2", names(data_cross_merged))


#fixes a few mistakes in variable names
names(data_cross_merged)[names(data_cross_merged)=="ifreq11"] <- "ifreq2011"
names(data_cross_merged)[names(data_cross_merged)=="lfreq11"] <- "lfreq2011"
names(data_cross_merged)[names(data_cross_merged)=="ntl_11"] <- "ntl_2011"


#Merges previous merged dataset with the shapefile dataframe
data_cross_merged_shp <- merge(shpfile_working, data_cross_merged, by = "id")

#Coerces merged shapefile to a dataframe so it can be viewed in RStudio
df_merged_shp <- as.data.frame(data_cross_merged_shp)


##renames variable with accent that was causing problems from data_demdates, and saves the 
##file with that variable renamed - NOTE: this is done now, no need to run this code again
#colnames(data_demdates)[11] <- "Situa"
#save(data_demdates, file = "Demarcation_Date_Data.Rda")


##saves the merged shape file - NOTE: this is done now, no need to run this code again
#data_cross_merged_shp@data[] <- lapply(data_cross_merged_shp@data, unclass)
#writePolyShape(data_cross_merged_shp, "shpfilecross", factor2char = TRUE, max_nchar = 254)


##Views relevant dataframes
#View(data_cross_merged)
#View(data_cross_merged[101:132])
#View(df_shpfile)
View(df_merged_shp[1:100])
View(df_merged_shp[101:200])
View(df_merged_shp[201:300])
View(df_merged_shp[301:400])
View(df_merged_shp[401:469])
