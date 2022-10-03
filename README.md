# 120-Years-of-Olympic-History

For this exploratory data analysis project, the dataset is obtained from kaggle which includes every modern Olympic Games from Athens in 1896 through Rio in 2016.
Until 1992, the Winter and Summer Games were held in the same year. Following that, they staggered them such that the Winter Games occur on a four-year cycle beginning in 1994, followed by Summer in 1996, Winter in 1998, and so on.

Link to the dataset: https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results

![This is an image](https://statathlon.com/wp-content/uploads/2018/01/rio-de-janeiro-2016-summer-olympics-e1467812135773.png)

There are two files included as part of data namely athlete_events.csv and noc_regions.csv. The file athlete_events.csv contains 271116 rows and 15 columns. Each row corresponds to an individual athlete competing in an individual Olympic event (athlete-events). The columns are:

* ID - Unique number for each athlete 
* Name - Athlete's name
* Sex - M or F
* Age - Integer
* Height - In centimeters
* Weight - In kilograms
* Team - Team name
* NOC - National Olympic Committee 3-letter code
* Games - Year and season
* Year - Integer
* Season - Summer or Winter
* City - Host city
* Sport - Sport
* Event - Event
* Medal - Gold, Silver, Bronze, or NA

The noc_regions.csv contains 230 rows and 3 columns. The columns are:

* NOC - National Olympic Committee 3-letter code
* Region - Name of countries
* Notes - Notes
