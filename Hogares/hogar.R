# install.packages("readxl") ----
# https://maps.googleapis.com/maps/api/distancematrix/json?origins=Via+Paolo+Emilio|Vancouver+BC|Seattle&destinations=Piazzale+Aldo+Moro|San+Francisco|Victoria+BC&key=AIzaSyDfuJjIpDfqug_x8A1p8eo6S0Z13L8XfrE
# https://maps.googleapis.com/maps/api/distancematrix/json?origins=Via+Paolo+Emilio|Vancouver+BC|Seattle&destinations=Sapienza+Universidad+de+Roma&key=AIzaSyDfuJjIpDfqug_x8A1p8eo6S0Z13L8XfrE
library("readxl")

# Preparing data ----
tablas = read_excel("hogares.xlsx")
data.hogar = as.data.frame(tablas)
data.hogar <- na.omit(data.hogar)
data.hogar$Foto <- NULL
data.hogar$Dirección <- (gsub("(\n)+", " ", data.hogar$Dirección))
data.hoga$`Tipo de Inmueble` <- gsub("(Mini.)?(A|a)p.+", "1", data.hoga$`Tipo de Inmueble`) # putting (mini)?apartments as 0
data.hoga$`Tipo de Inmueble` <- gsub("Mo.+", "0", data.hoga$`Tipo de Inmueble`) # putting monolocale as 0




# Via+San+Roberto+Bellarimino
# Vía Monte Verde, Boynton Beach, FL 33436, EE. UU."
# "Condado de Gallia, Ohio, EE. UU." 


















