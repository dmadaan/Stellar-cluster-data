#cannot use this because you need observed values for the dependent variable to use this package!
#this sucks :( 

getwd()
library(likelihood)
## Use the mass dataset
mass = scan('NGC.dat')

## Create our model function - frequncy is a non-linear function of mass
model <- function(mass,a,b,c){
  (a*0.5)*exp((a*b)+((a*c)^2*0.5))*mass^(-a)*erfc(((a*c)-((log(mass)-b)/c))/sqrt(2))
}
## Create our parameters list and set values for a for alpha, b for mean, and c for sd. Also the initial parameters
par <- list(a = 1, b = -2, c = 1)

model <- function (a, b) {a + b * crown_rad$DBH}
var <- list(x = "Radius",
            mean = "predicted",
            sd = 0.815585,
            log = TRUE)
result <- likeli(model, par, var, mass, dnorm)