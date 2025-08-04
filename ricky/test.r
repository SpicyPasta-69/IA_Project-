### load libraries ###

install.packages("ggplot2")
install.packages("dplyr")
install.packages("lubridate")

require(rtools64);
require(ggplot2);
require(dplyr);
require(lubridate);




### load data ###

csv = read.csv("../Final.csv");

csv$DATE.OCC = as.Date(csv$DATE.OCC);
csv$Date.Rptd = as.Date(csv$Date.Rptd);


# Create the plot
csvSummary = csv %>%
  mutate(Week = floor_date(DATE.OCC, unit = "30 days")) %>%
  group_by(DATE.OCC) %>%
  summarise(Count = n());

ggplot(csvSummary, aes(x = DATE.OCC, y = Count)) +
  geom_col(fill = "steelblue") +
  labs(title = "Frequency of Dates", x = "Date", y = "Count") +
  theme_minimal();

