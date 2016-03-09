# Test data ----
test.data <- read.csv("hogares.csv")
# test <- read_excel("hogares.xlsx")
# test = as.data.frame(test)
# test <- test[!is.na(test[1]),]
# test$Foto <- NULL

# test.data <- na.omit(test.data)
# test.data$Distrito <- (gsub("(\n)+", " ", test.data$Distrito))
# test.data$Dirección <- (gsub("(\n)+", " ", test.data$Dirección))
#test.data$Dirección[33] <- "Via San Roberto Bellarmino"
#test.data$Foto <- NULL
#test.data$`Tipo de Inmueble` <- gsub("(Mini.)?(A|a)p.+", "1", test.data$`Tipo de Inmueble`) # putting (mini)?apartments as 0
#test.data$`Tipo de Inmueble` <- gsub("Mo.+", "0", test.data$`Tipo de Inmueble`) # putting monolocale as 0
# location <- character()
# location.dir.it <- character()


#for (j in 1:nrow(test.data)){
#  location[j] <- paste(test.data$Distrito[j] , test.data$Dirección[j], sep = " ")
#}
# test.data["location"] <- location


test.data$Piso # Not yet, 'til answered doub


class(test$`Precio Mensual`)
as.factor(test.data$Precio.Mensual)


class(test.data$Precio.Mensual) 


# Test department ----

## descripcion
  test.data$Descripción
  des <- test.data$Descripción
  des <- as.factor(des)
  levels(des)
  # camera (singular)/camere (plural)
  # bango (singular)/ bagni (plural)

  grep("ingr+", levels(des))

## habitaciones
  test.data$`Habitaciones Disponibles`
  hab <- test.data$`Habitaciones Disponibles`
  hab <- as.factor(hab)
  levels(hab)
  index <- grep("singo+", hab)
  index[2]  
  hab[index[3]]

## montly price
  test.data$`Precio Mensual`
  price <- test.data$`Precio Mensual`
  price <- as.factor(price)    
  levels(price)
  
  ### THIS ONE GETS JUST 1 PRICE ###
  integer.prices <- as.numeric(gsub("€", "", gsub("([0-9]+).*$", "\\1", price))) # get numbers from RE
  ##################################
  
   object.in.room <- gsub("€|\n|;| ", "", (gsub("[0-9]+", "\\1", price))) # GET elements in the room

  
  
  

## notes  
  test.data$Notas
  notes <- test.data$Notas
  # test every field have a "ragazzi/e ----
    notes2 <- test.data$Notas
    notes2 <- gsub("ragazzi", "######", notes2) 
    notes2 <- gsub("ragazze", "######", notes2)
    grep("ragazzi", notes)
    grep("ragazze", notes)
  
  
  
  
# Already tested and implemented in 'test.data'
inmueble <- test.data$`Tipo de Inmueble`
class(inmueble)
inmueble <-as.factor(inmueble)
inmueble <- gsub("(Mini.)?(A|a)p.+", "1", inmueble) # putting (mini)?apartments as 0
inmueble <- gsub("Mo.+", "0", inmueble) # putting apartments as 0




# function to test

x <- c('€ 950; spese escluse ')
sub('.*-([0-9]+).*','\\1',x)






prices <- gsub("\\D", " ", test.data$Precio.Mensual) # works!
doppia <- grep("(dop)+.", test.data$Habitaciones.Disponibles) # works
posto <- grep("(posto)+.", test.data$Habitaciones.Disponibles) #works
test <- test.data
test <- test[-doppia,] #works
test <- test[-posto,] #works
prices2 <- gsub("\\D", " ", test$Precio.Mensual)

library(stringr) #
calificacion.inmueble <- integer()
str_count(test$Descripción[1], ',') #
str_count(test.data$Descripción[19], ',') #
any(grep('(TUT|Tut|tut)+', test.data$Precio.Mensual[8])) #



for (i in 1:nrow(test.data)){
 calificacion.inmueble[i] <- str_count(test.data$Descripción[i], ',') + str_count(test.data$Descripción[i], ' e ') + 1
 if (any(grep('(TUT|Tut|tut)+', test.data$Precio.Mensual[i]))){
   calificacion.inmueble[i] <- calificacion.inmueble[i] +5
 }else{
   calificacion.inmueble[i] <- calificacion.inmueble[i] + str_count(test.data$Precio.Mensual[i], ',') + str_count(test.data$Precio.Mensual[i], ' e ') + 1
 }
}  





grep('(tutt)+', test.data$Precio.Mensual[2])


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