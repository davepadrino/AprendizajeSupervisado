# Test data ----
library("readxl")
library("stringr") 
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

# Take smaller value of the prices arrays ----
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
test$Notas
notes <- test$Notas
# test every field have a "ragazzi/e ----
mix <- grep("(r)+.+[ ]*/[ ]*(r)*.+", notes)
index.boys <- setdiff(grep("ragazzi", notes), grep("(r)+.+[ ]*/[ ]*(r)*.+", notes))
index.girls <- setdiff(grep("ragazze", notes), grep("(r)+.+[ ]*/[ ]*(r)*.+", notes))
gender[mix] <- 2
gender[index.boys] <- 1
gender[index.girls] <- 0
nas <- which(is.na(gender))
gender[nas] <- 2
test['generos'] <- gender


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

test["calificacion.inmueble"] <- calificacion.inmueble

### Sub-DataFrame para chicos ----
mboys <- test[test$generos == 1 | test$generos == 2, ] # mixto y chicos
## Modelo precios vs tipo.de.inmueble
modelo1 <- lm(mboys$precios.numeros ~ mboys$Tipo.de.Inmueble)
# Dibujo del diagrama de dispersion
plot(mboys$Tipo.de.Inmueble, mboys$precios.numeros) # 0 <- estudio, 1 <- apartamento
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo1)
# Muestra la descripcion del modelo lineal
summary(modelo1)


## Modelo precios vs tiempo de manejo (convertido a horas)
horas.manejo.chico <- mboys$tiempo.manejo/3600
modelo1.1 <- lm(mboys$precios.numeros ~ horas.manejo.chico)
# Dibujo del diagrama de dispersion
plot(horas.manejo.chico, mboys$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo1.1)
# Muestra la descripcion del modelo lineal
summary(modelo1.1)


## Modelo precios vs metros de manejo (convertido a km)
kms.manejo.chico <- mboys$metros.manejo/1000
modelo1.2 <- lm(mboys$precios.numeros ~ kms.manejo.chico)
# Dibujo del diagrama de dispersion
plot(kms.manejo.chico, mboys$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo1.2)
# Muestra la descripcion del modelo lineal
summary(modelo1.2)


## Modelo precios vs tiempo de caminata (convertido a horas)
horas.caminar.chico <- mboys$tiempo.caminata/3600
modelo1.3 <- lm(mboys$precios.numeros ~ horas.caminar.chico)
# Dibujo del diagrama de dispersion
plot(horas.caminar.chico, mboys$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo1.3)
# Muestra la descripcion del modelo lineal
summary(modelo1.3)


## Modelo precios vs metros de caminata (convertido a km)
kms.caminar.chico <- mboys$metros.caminata/1000
modelo1.4 <- lm(mboys$precios.numeros ~ kms.caminar.chico)
# Dibujo del diagrama de dispersion
plot(kms.caminar.chico, mboys$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo1.4)
# Muestra la descripcion del modelo lineal
summary(modelo1.4)

## Modelo precios vs clasificacion inmueble 
modelo1.5 <- lm(mboys$precios.numeros ~ mboys$calificacion.inmueble)
# Dibujo del diagrama de dispersion
plot(mboys$calificacion.inmueble, mboys$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo1.5)
# Muestra la descripcion del modelo lineal
summary(modelo1.5)




### Sub-DataFrame para chicas ----
mgirls <- test[test$generos == 0 | test$generos == 2, ]

## Modelo precios vs tipo.de.inmueble
modelo2 <- lm(mgirls$precios.numeros ~ mgirls$Tipo.de.Inmueble)
# Dibujo del diagrama de dispersion
plot(mgirls$Tipo.de.Inmueble, mgirls$precios.numeros) # 0 <- estudio, 1 <- apartamento
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo2)
# Muestra la descripcion del modelo lineal
summary(modelo2)


## Modelo precios vs tiempo de manejo (convertido a horas)
horas.manejo.chica <- mgirls$tiempo.manejo/3600
modelo2.1 <- lm(mgirls$precios.numeros ~ horas.manejo.chica)
# Dibujo del diagrama de dispersion
plot(horas.manejo.chica, mgirls$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo2.1)
# Muestra la descripcion del modelo lineal
summary(modelo2.1)


## Modelo precios vs metros de manejo (convertido a km)
kms.manejo.chica <- mgirls$metros.manejo/1000
modelo2.2 <- lm(mgirls$precios.numeros ~ kms.manejo.chica)
# Dibujo del diagrama de dispersion
plot(kms.manejo.chica, mgirls$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo2.2)
# Muestra la descripcion del modelo lineal
summary(modelo2.2)


## Modelo precios vs tiempo de caminata (convertido a horas)
horas.caminar.chica <- mgirls$tiempo.caminata/3600
modelo2.3 <- lm(mgirls$precios.numeros ~ horas.caminar.chica)
# Dibujo del diagrama de dispersion
plot(horas.caminar.chica, mgirls$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo2.3)
# Muestra la descripcion del modelo lineal
summary(modelo2.3)


## Modelo precios vs metros de caminata (convertido a km)
kms.caminar.chica <- mgirls$metros.caminata/1000
modelo2.4 <- lm(mgirls$precios.numeros ~ kms.caminar.chica)
# Dibujo del diagrama de dispersion
plot(kms.caminar.chica, mgirls$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo2.4)
# Muestra la descripcion del modelo lineal
summary(modelo2.4)


## Modelo precios vs clasificacion inmueble 
modelo2.5 <- lm(mgirls$precios.numeros ~ mgirls$calificacion.inmueble)
# Dibujo del diagrama de dispersion
plot(mgirls$calificacion.inmueble, mgirls$precios.numeros) 
# Agrega la recta de regresión lineal resultande del modelo lineal
abline(modelo2.5)
# Muestra la descripcion del modelo lineal
summary(modelo2.5)




