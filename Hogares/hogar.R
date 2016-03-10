# install.packages("readxl") ----
library("readxl")
library(stringr) 
# Preparing data ----
tablas = read_excel("hogares.xlsx")
data.hogar = as.data.frame(tablas)
data.hogar <- na.omit(data.hogar)
data.hogar$Foto <- NULL
data.hogar$Dirección <- (gsub("(\n)+", " ", data.hogar$Dirección))
data.hoga$`Tipo de Inmueble` <- gsub("(Mini.)?(A|a)p.+", "1", data.hoga$`Tipo de Inmueble`) # putting (mini)?apartments as 0
data.hoga$`Tipo de Inmueble` <- gsub("Mo.+", "0", data.hoga$`Tipo de Inmueble`) # putting monolocale as 0


















