### Include libraries ###

install.packages("ggplot2")
install.packages("dplyr")
install.packages("lubridate")

require(rtools64);
require(ggplot2);
require(dplyr);
require(lubridate);


### Constants ###

CSV_PATH = "Group3_Crime_Data.csv";






### load data ###

csv = read.csv(CSV_PATH);

csv$DATE.OCC = as.Date(csv$DATE.OCC);
csv$Date.Rptd = as.Date(csv$Date.Rptd);



### mandatory 1 ###

fcmSummary = csv %>%
  mutate(Month = floor_date(Date.Rptd, unit = "month")) %>%
  group_by(Month) %>%
  summarise(Count = n()) %>%
  arrange(Month);

plot(fcmSummary$Month, fcmSummary$Count, type = "l", col = "blue", main = "Frequency Crime of Month")


### madatory 2 ###

labels = c(F = "Female", H = "Hybrid", M = "Male", N = "No tell");

genderSummary = csv %>%
  mutate(label = ifelse(is.na(labels[Vict.Sex]), "unknown", labels[Vict.Sex])) %>%
  group_by(label) %>%
  summarise(Count = n());

pie(genderSummary$Count, labels = genderSummary$label, main = "Gender Proportion", col = rainbow(length(genderSummary$Count)));

