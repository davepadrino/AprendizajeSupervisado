source("../Hogares/google_api.R")
install("rpart")
install("caret")
install("rpart.plot")
install("class")
install('pROC')
install("caret")
install("dplyr")
install("RWeka")

minable <- read.csv("minable.csv", stringsAsFactors = FALSE)
names(minable)

minable$jReprobadas <- NULL
minable$dHabitacion <- NULL
minable$sugerencias <- NULL
minable$aEconomica <- NULL
minable$cDireccion <- NULL
minable$oSolicitudes <- NULL
minable$pReside <- NULL
minable$cIdentidad <- NULL
minable$rating <- NULL
minable$grOdontologicos[grep("[a-z]", minable$grOdontologicos)] <- 0
minable$grOdontologicos <-as.numeric(minable$grOdontologicos)
minable$mIngreso <- as.factor(minable$mIngreso)

# Preparacion de datos/ Selección de columnas
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) 
}

## Calcular edades en base a fecha de nacimiento
maxDate <- as.Date("11/03/2016",format="%d/%m/%Y")
a <- rep(as.Date("01/01/1900",format="%d/%m/%Y"),length(minable$fNacimiento))
edad <- integer()
for(i in 1:length(minable$fNacimiento)){
  a[i] <- as.Date(minable$fNacimiento[i],format="%d/%m/%Y")
  edad[i] <- as.integer(maxDate-a[i]) %/% 365
}
minable$fNacimiento <- NULL
minable["edad"] <- edad




# K-Vecinos
## normalizando los elementos numéricos del Dataset
minable.normalizada <- as.data.frame(lapply(minable[-5], normalize))

## Creando data de entrenamiento y de prueba
minable.train <- minable.normalizada[1:130,]
minable.test <- minable.normalizada[131:190,]

## Generación de la clase objetivo como etiqueta
minable_train_labels <- minable[1:130, 5]
minable_test_labels <- minable[131:190, 5]

## Generación del algoritmo K-Vecinos mas cercanos
minable_test_predicted <- knn(train = minable.train, test = minable.test, cl = minable_train_labels, k=10)

## matriz de confusión
confusion.Matrix.knn <- table(minable_test_labels, minable_test_predicted)

accuracy.confusion.Matrix.knn <- sum(diag(confusion.Matrix.knn))/sum(confusion.Matrix.knn)


##############################################################################

# Árboles de Decisión
tree.training <- sample_n(minable,133)
tree.testing <- sample_n(minable,67)

tree <- rpart(mIngreso ~ ., tree.training, method = "class", control = rpart.control(minsplit = 15, cp = 0.01))
rpart.plot(tree)



# matriz de confusion
confusion.Matrix.tree <- table(tree.testing$mIngreso, predict(tree, newdata = tree.testing,type = "class"))

accuracy.confusion.Matrix.tree <- sum(diag(confusion.Matrix.tree))/sum(confusion.Matrix.tree)


##############################################################################


# Reglas de Clasificacion
rules = OneR(formula = mIngreso ~ ., data = tree.training)


# Matriz de Confusión
confusionMatrix.clasif = table(tree.testing$mIngreso, predict(rules, newdata = tree.testing,type = "class"))
accuracy.confusion.Matrix.oneR <- sum(diag(confusionMatrix.clasif))/sum(confusionMatrix.clasif)


# Matriz de Confusión