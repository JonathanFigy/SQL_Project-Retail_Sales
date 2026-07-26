# SQL Project - Retail Sales Analysis

This project focuses on analyzing a retail sales dataset using SQL to uncover actionable business insights related to customer purchasing patterns, product performance, sales trends, and revenue generation.

The objective of this project was to answer real-world business questions through structured SQL queries. The analysis involved data exploration, aggregation, filtering, customer segmentation, and time-based sales analysis to identify trends and support data-driven decision-making.

Throughout this project, I applied the following SQL concepts:

* GROUP BY and aggregate functions
* CASE WHEN statements
* Subqueries and Common Table Expressions (CTEs)
* Date and time analysis
* Customer and product segmentation
* Revenue and sales trend analysis


## Business Insights
1. **Evening Hours Recorded the Highest Sales Activity**

Time-of-day analysis shows that the Evening period (after 17:00) generated the highest order volume with 1,062 orders (~53.2%), making it the dominant sales window. The Morning period (before 12:00) accounted for 558 orders (~27.9%), while the Afternoon period (12:00–17:00) recorded 377 orders (~18.9%), the lowest among all time segments.

2. **Quarterly sales analysis revealed a significant upward trend in sales performance across both 2022 and 2023**

In 2022, quarterly sales increased from 63,250 in Q1 to 210,030 in Q4, representing a 232% increase over the year. The strongest quarter-on-quarter growth occurred in Q4 2022, when sales increased by 99.72% compared with Q3.

In 2023, sales increased from 69,490 in Q1 to 184,160 in Q4, representing a 165% increase across the year. The strongest quarter-on-quarter growth occurred in Q3 2023, with sales increasing by 79.28% compared with Q2.

| **Metric**   | **2022** | **2023** |
|--------------|----------|----------|
| Q1 Sales     | 63,250   | 69,490   |
| Q2 Sales     | 74,385   | 73,490   |
| Q3 Sales     | 105,160  | 131,755  |
| Q4 Sales     | 210,030  | 184,160  |
| Annual Total | 452,825  | 458,895  |


Comparing year-on-year performance, Q4 2023 sales of 184,160 were approximately 12.3% lower than Q4 2022 sales of 210,030. However, the overall 2023 sales performance remained strong, with total annual sales of 458,895, compared with 452,825 in 2022, representing an overall increase of approximately 1.34%.

3. **Monthly Sales Analysis Revealed Seasonal Patterns**
In 2022, monthly sales reached their highest point in December at 72,880, while the lowest sales were recorded in February at 16,110. The most significant month-on-month increase occurred in September 2022, when sales rose by 191.44%, increasing from 21,195 in August to 61,770.

In 2023, the highest monthly sales were recorded in December at 69,145 while the lowest sales occurred in March at 20,530. The largest month-on-month increase occurred in September 2023, when sales increased by 138.98%, rising from 28,270 in August to 67,560.

A particularly important pattern is the strong increase in sales during September in both years, suggesting a potential recurring seasonal demand pattern. September sales increased from 61,770 in 2022 to 67,560 in 2023, representing a 9.37% year-on-year increase.


## Recommendations
1. **Time-of-Day Sales Optimization**
   Given that over 53% of total orders occur during the Evening period (after 17:00), business operations should be strategically aligned to match this peak demand window.

It is recommended to:

* Allocate higher staffing levels during evening hours to reduce wait times and improve customer service efficiency
* Focus promotional activity and in-store engagement strategies in the evening window, where customer traffic is highest
* Consider reviewing morning and afternoon resource allocation, as these periods collectively account for less than 50% of total orders
