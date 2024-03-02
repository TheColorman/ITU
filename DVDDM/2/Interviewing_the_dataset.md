# Interviewing the Dataset

-   Police brutality dataset: [Police Brutality Dataset - Police Brutality America.tsv](./data/Police%20Brutality%20Dataset%20-%20Police%20Brutality%20in%20America.tsv)

1. _Make a plan/sketch for how you could visualize it by following the steps. You could write down the question you have about the data, include key figures/EDA of the data._
2. _Based on the EDA and the questions you want to answer, make a selection of relevant charts that could be used for visualizing._
3. _Finally, sketch out the different ways you might communicate the message. You are welcome to write down other data sources that could complement the police brutality data._

## Solution

### EDA

Sheet 1:

-   Contains 60 rows of information about police killings in various police departments around the US.
-   The columns contain information about location, city population, police killing rate, violent crime rate and killings by race.
-   The population data is fro 2014, and the victim data is from 2015.

Sheet 2:

-   3485 rows of information about specific police brutality victims.
-   Columns contain personal information on victims such as name, age, gender and race, as well as information about their death, such as location, date, location, cause, description, charge and whether the victim was armed.
-   Dates range from the start of Januray 2013 to the end of December 2015.

### Questions

Has disparity changed over time?  
Is there a correlation between the black population and the total number of victims (regardless of race)?  
What cities/states have a higher rate of police brutality? Both total and black?

### Charts & sketch

#### Has disparity changed over time?

A simple line chart would suffice. Maybe contrast with a line for population/black population. Since they are of different values, percentages would have to be used for the axes. Though there is a high probability that it would not results in anything interesting unless the scales were tampered with, as even if both disparity and population grow, they may not grow at the same rate.  
I realise now that a time series would not be possible as all of the police brutality data is for 2015. It could be possible to calculate a similar metric using the incident level data.  

#### Is there a correlation between the black population and the number of victims (regardless of race)?

Scatter plot. Possibly a histogram or density plot.  
For the scatter plot:  
  The number of victims would go on the y-axis, as it is what we are trying to "predict". Black population on the x-axis.  
For the density plot:  
  Same as for the scatter plot. Populatino goes on the x-axis, and the height of the density is the number of victims.  

#### What cities/states have a higher rate of police brutality?

A map chart would probably work best, though map charts are hard to accurately decode. I therefore think it should be interactive, such as on a website, where hovering over states would reveal information.  

#### Other data

I would love to see a dataset that includes the distribution of police station race. This would allow analysis of whether there is a race disparity between the police officers and the population they are meant to protect.  