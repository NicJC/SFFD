## San Francisco Fire Dept


library(tidyverse)
library(cowplot)
library(gridExtra)



fires<-read_csv("https://data.sfgov.org/api/views/nuek-vuh3/rows.csv?accessType=DOWNLOAD",show_col_types = FALSE)




SFFD <- fires %>% select(c(4,5,11,16,17,18,19,24,28,32))
SFFD

df<- SFFD %>% rename(Zipcode = 'Zipcode of Incident',Response_Time = 'On Scene DtTm', Neighborhood = 'Neighborhooods - Analysis Boundaries', Priority = 'Final Priority') %>%
  mutate(Year = substring(SFFD$`Call Date`,7,10),Month = substring(SFFD$`Call Date`,1,2), Day = substring(SFFD$`Call Date`,4,5) ) %>%
  arrange(desc(Year), desc(Month), desc(Day)) %>%
  filter(Year > 2021)

write.csv( df,"San Francisco Fire Dept.csv",row.names=FALSE)

ggplot(df, aes(y = Neighborhood ,  x = Battalion, color = Priority)) + geom_point()  + labs(title = "San Francisco Fire Dept")

ggsave("San Francisco Fire Dept.png", width = 8, height = 8)


