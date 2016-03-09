# minable <- read.csv("minable.csv")

plota <- lm(minable$mAprobadas ~ minable$mInscritas, minable) 
plot(minable$mAprobadas, minable$mInscritas)
abline(plota, col="red")