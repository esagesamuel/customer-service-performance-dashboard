# Customer Service Performance Dashboard

## Project overview

This end-to-end Business Intelligence project analyses 8,469 synthetic customer-support tickets to evaluate ticket volume, resolution performance, customer satisfaction, operational handling time, contact channels, priorities, issue types and product-support outcomes.

The project demonstrates a complete analytics workflow using Excel and Power Query for data preparation, PostgreSQL and SQL for validation and exploratory analysis, and Power BI for dimensional modelling, DAX measures and interactive dashboards.

## Business objectives

The analysis addresses the following questions:

- How many support tickets are open, pending or resolved?
- Which ticket types and subjects generate the most demand?
- Which channels and priorities have stronger resolution performance?
- How are customer-satisfaction ratings distributed?
- Which products have high ticket volumes, weak resolution rates or low CSAT?
- How long do valid cases take from first response to resolution?
- Where should customer-service managers focus improvement efforts?

## Tools used

- **Microsoft Excel and Power Query:** data profiling, cleaning, transformation and feature creation
- **PostgreSQL:** relational storage and analytical querying
- **SQL:** validation, aggregation, segmentation and performance analysis
- **Power BI:** star-schema modelling, DAX measures and dashboard development
- **Git and GitHub:** version control and portfolio presentation

## Dataset

The project uses the [Customer Support Ticket Dataset](https://www.kaggle.com/datasets/suraj520/customer-support-ticket-dataset), a synthetic collection of technology-product support tickets.

The source data includes:

- Ticket identifiers and statuses
- Customer demographics
- Products purchased
- Ticket types and subjects
- Priority levels and support channels
- First-response and resolution timestamps
- Customer-satisfaction ratings

### Dataset profile

| Measure | Result |
|---|---:|
| Total tickets | 8,469 |
| Resolved tickets | 2,769 |
| Unresolved tickets | 5,700 |
| Tickets with response timestamps | 5,650 |
| Rated tickets | 2,769 |
| Tickets with valid duration sequences | 1,404 |

The raw and processed data files are available under [`data`](data/).

## Data preparation

The Power Query workflow included:

1. Standardising column names and data types.
2. Cleaning categorical text fields.
3. Validating unique ticket identifiers.
4. Preserving legitimate nulls in resolution and satisfaction fields.
5. Checking whether resolution timestamps occurred after first-response timestamps.
6. Classifying timestamp sequences as Valid, Invalid or Missing.
7. Calculating post-response resolution duration only for valid sequences.
8. Creating resolution flags, CSAT bands, age groups and response-time bands.
9. Creating response-date, hour, month and weekday fields.
10. Removing unnecessary personal and free-text fields from the analytical dataset.

The cleaned dataset is available at [`data/processed/cleaned-customer-support-tickets.csv`](data/processed/cleaned-customer-support-tickets.csv).

## Data model

The Power BI model uses a star-schema design with `FactTickets` at the centre:

```text
                         DimDate
                            |
                            |
DimProduct ─────────── FactTickets ─────────── DimChannel
                        /   |   \
                       /    |    \
            DimPriority  DimTicketType  DimSubject
```

All relationships use one-to-many cardinality with single-direction filtering from the dimension table to `FactTickets`.

The Date dimension is related to the first-response date. Therefore, date filtering represents response activity rather than incoming-ticket volume.

## Key DAX measures

The semantic model includes measures for:

- Total, resolved, unresolved, open and pending tickets
- Resolution rate
- Responded tickets and response timestamp coverage
- Rated tickets and rating coverage
- Average CSAT
- Low- and high-CSAT counts and rates
- Valid-duration tickets and coverage
- Average, median and 90th-percentile post-response handling time

## Dashboard pages

### 1. Customer Service Overview

The executive page presents headline ticket KPIs, status distribution, ticket types, channel performance and resolution rate by priority.

![Customer Service Overview](screenshots/Screenshot%20%28173%29.png)

### 2. Ticket Operations

The operations page examines unresolved work, ticket status by type, weak subject-level resolution rates, priority and channel combinations, handling duration and recorded response activity by hour.

![Ticket Operations and Resolution Performance](screenshots/Screenshot%20%28176%29.png)

### 3. Customer Satisfaction and Product Support

The satisfaction page analyses CSAT coverage and distribution, channel and subject performance, leading products by ticket volume and detailed product-support outcomes.

![Customer Satisfaction and Product Support](screenshots/Screenshot%20%28178%29.png)

## Headline results

| KPI | Result |
|---|---:|
| Total tickets | 8,469 |
| Resolved tickets | 2,769 |
| Unresolved tickets | 5,700 |
| Resolution rate | 32.70% |
| Open tickets | 2,819 |
| Pending customer response | 2,881 |
| Response timestamp coverage | 66.71% |
| Average CSAT | 2.99/5 |
| Rating coverage | 32.70% |
| Low-CSAT rate | 39.80% |
| High-CSAT rate | 39.26% |
| Valid-duration coverage | 16.58% |
| Average post-response handling time | 7.58 hours |
| Median post-response handling time | 6.35 hours |
| 90th-percentile handling time | 16.00 hours |

## Key findings

### Ticket status

- Pending Customer Response is the largest status group with 2,881 tickets, or 34.02%.
- Open tickets account for 2,819 records, or 33.29%.
- Closed tickets account for 2,769 records, producing an overall resolution rate of 32.70%.
- Open and pending tickets collectively represent 67.30% of the dataset.

### Channel and priority performance

- Email has the highest channel resolution rate at 33.60%.
- Chat has the highest average channel CSAT at 3.08.
- Phone has the shortest average valid handling time at 7.26 hours.
- Critical tickets have the highest priority-level resolution rate at 34.10%.
- High-priority tickets have the longest average valid handling time at 8.07 hours.
- Channel and priority differences are relatively small and should not be overstated.

### Ticket types and subjects

- Refund requests are the largest ticket type with 1,752 tickets and have the longest average valid handling time at 8.12 hours.
- Cancellation requests have the lowest ticket-type resolution rate at 30.44%.
- Payment issues, Installation support and Data loss each have subject-level resolution rates below 30%.
- Delivery problems have the lowest subject-level average CSAT at 2.80.

### Customer satisfaction

- Average CSAT is 2.99 out of 5.
- Low Satisfaction accounts for 1,102 ratings, or 39.80% of rated tickets.
- High Satisfaction accounts for 1,087 ratings, or 39.26%.
- Rating scores are distributed almost evenly from 1 to 5, suggesting synthetic generation rather than strong natural variation.
- Only closed tickets contain CSAT ratings, so resolved and unresolved satisfaction cannot be compared.

### Product support

- Canon EOS has the highest ticket volume with 240 tickets.
- Microsoft Office has the highest product resolution rate at 40.00%.
- Nintendo Switch Pro Controller has the lowest product resolution rate at 24.14%.
- Lenovo ThinkPad and Dell XPS also have resolution rates below 26%.
- Fitbit Versa Smartwatch has the lowest average product CSAT at 2.54.
- Ticket counts cannot be interpreted as product failure rates because total product-sales volumes are unavailable.

### Handling duration

- Only 1,404 tickets have valid first-response-to-resolution sequences.
- Median post-response handling time is 6.35 hours.
- Average post-response handling time is 7.58 hours.
- Ninety percent of valid cases were resolved within 16 hours after the first response.
- Every valid duration is below 24 hours.

## Business recommendations

1. **Segment unresolved work.** Manage the 2,819 open tickets separately from the 2,881 tickets awaiting customer responses, with distinct ownership and follow-up procedures.
2. **Improve cancellation handling.** Review escalation paths and resolution guidance for cancellation requests, which have the weakest ticket-type resolution rate.
3. **Review refund workflows.** Refund requests combine the highest volume with the longest average valid handling duration.
4. **Target weak subjects.** Prioritise process reviews for Payment issues, Installation support, Data loss and Delivery problems.
5. **Improve product-support content.** Review knowledge articles and escalation procedures for Nintendo Switch Pro Controller, Lenovo ThinkPad, Dell XPS and Fitbit Versa Smartwatch.
6. **Strengthen timestamp capture.** Record ticket creation, first response, resolution and closure as validated sequential timestamps.
7. **Expand feedback collection.** Collect satisfaction feedback beyond closed tickets to reduce outcome bias.
8. **Add product exposure data.** Combine ticket counts with units sold or active customers before comparing product complaint rates.

## Data limitations

- The dataset is synthetic and does not represent a real company.
- A reliable ticket-created timestamp is unavailable.
- Handling duration measures first response to resolution, not creation to resolution.
- Only 16.58% of tickets have valid duration sequences.
- CSAT is available only for closed tickets.
- Product-sales volumes are unavailable.
- Response dates are concentrated in May and June 2023.
- Almost all recorded responses occur on Thursday, indicating a likely timestamp-generation artefact.
- Rating values and several business categories are unusually balanced.

These limitations are documented to prevent unsupported operational or causal conclusions.

## Repository structure

```text
customer-service-performance-dashboard/
├── README.md
├── analysis-results/
│   ├── channel_performance.csv
│   ├── csat_band_analysis.csv
│   ├── csat_distribution.csv
│   ├── duration-summary.csv
│   ├── handling-time-csat-analysis.csv
│   ├── headline-kpis.csv
│   ├── hourly_response_activity.csv
│   ├── monthly_response_activity.csv
│   ├── priority_performance.csv
│   ├── product_performance.csv
│   ├── resolution-csat-analysis.csv
│   ├── status_performance.csv
│   ├── subject_performance.csv
│   ├── ticket_type_performance.csv
│   └── weekday_response_activity.csv
├── data/
│   ├── raw/
│   │   └── customer-support-tickets-raw.csv
│   └── processed/
│       └── cleaned-customer-support-tickets.csv
├── documentation/
│   └── analysis-summary.md
├── excel/
│   └── customer-service-analysis-working.xlsx
├── power-bi/
│   ├── customer-service-performance-dashboard.pbix
│   └── customer-service-performance-dashboard.pdf
├── screenshots/
│   ├── Screenshot (173).png
│   ├── Screenshot (176).png
│   └── Screenshot (178).png
└── sql/
    ├── 01_data_validation.sql
    ├── 02_ticket_performance_analysis.sql
    └── 03_customer_satisfaction_analysis.sql
```

## How to use the project

1. Clone or download the repository.
2. Review the raw and processed data under `data`.
3. Open [`excel/customer-service-analysis-working.xlsx`](excel/customer-service-analysis-working.xlsx) to review the Power Query preparation workflow.
4. Create a PostgreSQL database and load the cleaned CSV into a `support.tickets` table.
5. Run the scripts in [`sql`](sql/) in numerical order.
6. Review the exported SQL results under [`analysis-results`](analysis-results/).
7. Open [`power-bi/customer-service-performance-dashboard.pbix`](power-bi/customer-service-performance-dashboard.pbix) in Power BI Desktop.
8. Use the Channel, Priority, Ticket Type, Status and Product slicers to explore the dashboard.

The PostgreSQL server name, username and password are environment-specific and are intentionally not included in the repository.

## Supporting documentation

- [Detailed analysis summary](documentation/analysis-summary.md)
- [Data-validation SQL](sql/01_data_validation.sql)
- [Ticket-performance SQL](sql/02_ticket_performance_analysis.sql)
- [Customer-satisfaction SQL](sql/03_customer_satisfaction_analysis.sql)
- [Dashboard PDF](power-bi/customer-service-performance-dashboard.pdf)

## Author

**Sage Edgar Samuel**  
Data Analyst | Business Intelligence Analyst
