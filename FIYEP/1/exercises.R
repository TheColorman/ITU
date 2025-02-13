radiation_data <- read.csv(file = "data/SolarRadiationSkinCancer.csv")
plot(
  radiation_data$Year, radiation_data$CancerRate, 
  main="Cancer rate over time",
  xlab="Year", ylab="Rate of cancer"
)
