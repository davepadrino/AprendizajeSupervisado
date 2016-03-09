# Seleccionar google_api.R en su sistema de archivos
# source(file.choose())
source("google_api.R")

# origen = c("Via Paolo Emilio", "Vancouver BC", "Seattle")
# destino =c("Piazzale Aldo Moro", "San Francisco", "Victoria BC")
origen = test.data$Dirección
# origen <- as.factor(origen)
destino = c("Sapienza Universidad de Roma")

# Colocar su API Key 
api_key = "AIzaSyDfuJjIpDfqug_x8A1p8eo6S0Z13L8XfrE"

api_url = get_url(origen, destino, api_key)

datos = get_data(api_url)


distance.in.text <- character()
distance.in.value <- character()
duration.in.text <- character()
duration.in.value <- character()

for (i in 1:nrow(test.data)){
  if (i != 0)
  {    
    if (i == 56 || i ==73)
    {
      api_url = get_url(origen[i], destino, api_key)
      datos = get_data(api_url)
      array.info <- parse_data(datos)
    }else{
      api_url = get_url(location[i], destino, api_key)
      datos = get_data(api_url)
      array.info <- parse_data(datos)
      if (is.null(array.info)){
        api_url = get_url(origen[i], destino, api_key)
        datos = get_data(api_url)
        array.info <- parse_data(datos)
        
      }
      distance.in.text[i] <- array.info[1]
      distance.in.value[i] <- array.info[2]
      duration.in.text[i] <- array.info[3]
      duration.in.value[i] <- array.info[4]
    }
  }
}



# datos$rows$elements[[1]]$distance["value"][[1]][[1]]









