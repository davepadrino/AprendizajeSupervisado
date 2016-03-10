# Test data ----
test.data <- read.csv("hogares.csv")
# test <- read_excel("hogares.xlsx")
# test = as.data.frame(test)
# test <- test[!is.na(test[1]),]
# test$Foto <- NULL

# test.data <- na.omit(test.data)
# test.data$Distrito <- (gsub("(\n)+", " ", test.data$Distrito))
# test.data$Dirección <- (gsub("(\n)+", " ", test.data$Dirección))
# test.data$Dirección[33] <- "Via San Roberto Bellarmino"
# test.data$Foto <- NULL
# test.data$`Tipo de Inmueble` <- gsub("(Mini.)?(A|a)p.+", "1", test.data$`Tipo de Inmueble`) # putting (mini)?apartments as 0
# test.data$`Tipo de Inmueble` <- gsub("Mo.+", "0", test.data$`Tipo de Inmueble`) # putting monolocale as 0
# location <- character()
# location.dir.it <- character()


#for (j in 1:nrow(test.data)){
#  location[j] <- paste(test.data$Distrito[j] , test.data$Dirección[j], sep = " ")
#}
# test.data["location"] <- location


# To filter only sigle rooms
doppia <- grep("(dop)+.", test.data$Habitaciones.Disponibles) # works
posto <- grep("(posto)+.", test.data$Habitaciones.Disponibles) #works
test <- test.data
test <- test[-doppia,] #works
test <- test[-posto,] #works

# Take smaller value of the arrays ----
prices <- gsub("\\D", "", test$Precio.Mensual)
prices <- as.numeric(prices)
precios <- integer()

for(i in 1:length(prices)){
  if (str_length(prices[i]) > 4){
    len <- str_length(prices[i])
    full.array <- prices[i]
    min.value <- integer()
    while(len >= 3){
      number.of.parts <- 3
      len <- len - number.of.parts
      current.val <- full.array%/%(1*10^len)
      min.value <- c(min.value, current.val)
      full.array <- full.array%%(1*10^len)
    }
    precios[i] <- min(min.value)
  }else{
    precios[i] <- prices[i]
  }
  
}

test['precios.numeros'] <- precios

# separate boys & girls ----
gender <- character()
test.data$Notas
notes <- test.data$Notas
# test every field have a "ragazzi/e ----
grep("ragazzi", notes)
grep("ragazze", notes)
mix <- grep("[ra.]/[ra.]", notes)
index.boys <- setdiff(grep("ragazzi", notes), grep("[a-z]/[a-z]", notes))
index.girls <- setdiff(grep("ragazze", notes), grep("[a-z]/[a-z]", notes))


grep(".[ra]+. / [ra]+.", notes)











# extract number of features to a new column

calificacion.inmueble <- integer()
for (i in 1:nrow(test)){
  calificacion.inmueble[i] <- str_count(test$Descripción[i], ',') + str_count(test$Descripción[i], ' e ') + 1
  if (any(grep('(tut)+', test$Precio.Mensual[i], ignore.case = T))){
    calificacion.inmueble[i] <- calificacion.inmueble[i] +5
  }else{
    calificacion.inmueble[i] <- calificacion.inmueble[i] + str_count(test$Precio.Mensual[i], ',') + str_count(test$Precio.Mensual[i], ' e ') + 1
  }
}  



# function to test

x <- c('€ 950; spese escluse ')
sub('.*-([0-9]+).*','\\1',x)











str_count(test$Descripción[1], ',') #works
str_count(test.data$Descripción[19], ',') #works
any(grep('(tut)+', test.data$Precio.Mensual[8]), ignore.case = T) #works










###########################################
vectore <- c("Via Gregorio VII\nint. 13",
             "Via Federico\nGuarducci",
             "Via Ottaviano", 
             "Via Portuense\n471\nInt. 10", 
             "via Alfieri int. 8",
             "Viale Giulio\nCesare",
             "Via della\nMagliana Nuova\n342")

grep(".?((i|I)nt)+", vectore) # match any "int." or similar xpression in a crolumn

grep("(\n)+", vectore) # match any "\n" or similar xpression in a crolumn
gsub("(\n)+", " ", vectore) # swap any "\n" or similar xpression for " " in a crolumn

vectore <- gsub("(\n)+", " ", vectore) # Overwriting a column

vectore


vectore <- sample(vectore, nrow(test.data2), replace = T)

test.data2 <- test.data
test.data2["Nueva"] <-vectore






dire <- c("Piazza Massa Carrara",
          "Via Gatteschi",
          "Via Gatteschi",           
          "Via Giovanni De Agostini")

dis <- c ("Bologna",
          "Bologna",
          "Bologna",
          "Pigneto")
length(dire)

loc <- character()

for (j in 1:4){
  #if (i != 0){
    print(dis[j])
    print(dire[j])
    loc[j] <- paste(dis[j] , dire[j], sep = " ")
  #}
}
  

test.data2$Dirección["Via San Roberto Bellarimino"]
Via+San+Roberto+Bellarmino







###############################################

head(data.hogar$Distrito)
head(data.hogar$Dirección)

View(tablas)
class(tablas)
colnames(tablas)

class(df)
colnames(df)
names(df)
head(df$Dirección)