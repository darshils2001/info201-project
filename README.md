# Project Proposal


## Domain of Interest
**Topics of Interest**
1. Relevant to everyone, affecting all of us.
2. Interested to know the scope of such a global recession, and how it affects small business owners.
3. The federal response has been highly politicized, with White House aides openly sharing their discontent for “Blue” states; interested to see if there be a difference in business closings that relate to the 2016 electoral college map.

**Related Projects/Studies**
1. [PNAS](https://www.pnas.org/content/117/30/17656) economic impact study on over 5,800 small businesses in the United States
2. [Washington Post](https://www.washingtonpost.com/business/2020/05/12/small-business-used-define-americas-economy-pandemic-could-end-that-forever/) article detailing permanent closures of small businesses due to COVID-19 (as of May 12th)
3. [McKinsey & Co.](https://www.mckinsey.com/~/media/McKinsey/Featured%20Insights/Americas/Which%20small%20businesses%20are%20most%20vulnerable%20to%20COVID%2019%20and%20when/Which-small-businesses-are-most-vulnerable-to-COVID-19-and-when-final.pdf) consulting firm paper on which small businesses are most vulnerable to COVID-19/the subsequent recession.

**Data-Driven Questions**
1. How many businesses have closed across the US during the pandemic, where are they clustered/located?
2. What was the average income of businesses that closed during the pandemic? (How much profit did these businesses need to be making to stay afloat?)
3. How many people were on payroll of businesses that closed vs. stayed open?
4. Was there a peak during a specific date for unemployment claims? Or have they remained about the same throughout the pandemic.

## Identified Datasets

1. [Department of Labor](https://oui.doleta.gov/unemploy/wkclaims/report.asp) weekly unemployment claims.
  - Collected by US DOL
  - Our data has 2808 rows, one observation per week since January 7th, 1967
  - 11 features broken up between _Initial Claims_ and _Continued Claims_ with sub-headings of Not Seasonally Adjusted (NSA), Seasonal Factors (SF), Seasonally Adjusted (SA), and 4 Week Seasonally Adjusted (SA 4-Week)
  - This dataset will let us answer if there was a peak in unemployment claims during the pandemic, and when that peak occurred.

2. [Layoffs.fyi](https://layoffs.fyi/tracker/) provides live tracking of layoffs in tech startups across the globe during the pandemic.
  - Collected from multiple sources, with each individual observation cited from a different, but reputable source.
  - This dataset has 614 rows since March 11th 2020
  - 13 features of Company, Location, Number of those laid off, Date, Percent of workforce laid off, Industry the company served/serves, Source for data, List of employees laid off, Stage, Money Raised, Country, Date added, and reference
  - This dataset can give some global context to areas hit hard (in the tech industry) by the pandemic. We can also see if there is a tech business that is essentially "too small" to survive in this recession.

  
