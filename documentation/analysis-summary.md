# Customer Service Performance Analysis

## Project overview

This analysis examines 8,469 synthetic customer-support tickets to evaluate ticket status, resolution performance, customer satisfaction, contact channels, priorities, issue types, products and post-response handling time.

The analysis was completed using PostgreSQL. The findings below are based on the CSV results exported from the SQL queries in the `analysis-results` directory.

## Headline performance

| KPI | Result |
|---|---:|
| Total tickets | 8,469 |
| Resolved tickets | 2,769 |
| Unresolved tickets | 5,700 |
| Resolution rate | 32.70% |
| Tickets with a response timestamp | 5,650 |
| Response timestamp coverage | 66.71% |
| Rated tickets | 2,769 |
| Average CSAT | 2.99/5 |
| Average valid post-response handling time | 7.58 hours |

Open and pending tickets account for 67.30% of the dataset. Only closed tickets contain customer-satisfaction ratings, so CSAT cannot be used to compare resolved and unresolved tickets.

## Ticket status

| Status | Tickets | Share of tickets |
|---|---:|---:|
| Pending Customer Response | 2,881 | 34.02% |
| Open | 2,819 | 33.29% |
| Closed | 2,769 | 32.70% |

Pending Customer Response is the largest status group. The combined open and pending population contains 5,700 tickets.

Because the dataset is synthetic and represents a snapshot, the unresolved population should not automatically be described as an operational backlog without additional ticket-age information.

## Customer satisfaction

### Satisfaction bands

| CSAT band | Rated tickets | Share of rated tickets |
|---|---:|---:|
| Low Satisfaction | 1,102 | 39.80% |
| Neutral | 580 | 20.95% |
| High Satisfaction | 1,087 | 39.26% |

The average satisfaction rating is 2.99 out of 5. Low-satisfaction ratings slightly exceed high-satisfaction ratings by 15 tickets.

### Rating distribution

| Rating | Tickets | Share of ratings |
|---:|---:|---:|
| 1 | 553 | 19.97% |
| 2 | 549 | 19.83% |
| 3 | 580 | 20.95% |
| 4 | 543 | 19.61% |
| 5 | 544 | 19.65% |

The rating distribution is unusually even, with each score representing approximately 20% of rated tickets. This pattern suggests synthetic generation and limits the strength of conclusions about satisfaction drivers.

## Resolution and satisfaction

| Resolution status | Total tickets | Rated tickets | Unrated tickets | Average CSAT | Low-CSAT rate | High-CSAT rate |
|---|---:|---:|---:|---:|---:|---:|
| Resolved | 2,769 | 2,769 | 0 | 2.99 | 39.80% | 39.26% |
| Unresolved | 5,700 | 0 | 5,700 | Not available | Not available | Not available |

All ratings belong to resolved tickets. The dataset therefore cannot establish whether resolution improves satisfaction or whether unresolved customers are less satisfied.

## Channel performance

| Channel | Tickets | Resolved tickets | Resolution rate | Rated tickets | Average CSAT | Average valid hours |
|---|---:|---:|---:|---:|---:|---:|
| Email | 2,143 | 720 | 33.60% | 720 | 2.96 | 7.62 |
| Phone | 2,132 | 691 | 32.41% | 691 | 2.95 | 7.26 |
| Social media | 2,121 | 684 | 32.25% | 684 | 2.97 | 7.91 |
| Chat | 2,073 | 674 | 32.51% | 674 | 3.08 | 7.50 |

Channel performance is relatively similar. Email has the highest resolution rate at 33.60%, Chat has the highest average CSAT at 3.08, Phone has the shortest average valid handling time at 7.26 hours and Social media has the longest at 7.91 hours. The differences are small and should not be overstated.

## Priority performance

| Priority | Tickets | Resolved tickets | Resolution rate | Rated tickets | Average CSAT | Average valid hours |
|---|---:|---:|---:|---:|---:|---:|
| Medium | 2,192 | 694 | 31.66% | 694 | 2.98 | 7.17 |
| Critical | 2,129 | 726 | 34.10% | 726 | 2.96 | 7.15 |
| High | 2,085 | 705 | 33.81% | 705 | 2.98 | 8.07 |
| Low | 2,063 | 644 | 31.22% | 644 | 3.05 | 7.95 |

Critical tickets have the highest resolution rate and shortest average valid handling time. High-priority tickets have the longest average handling time. The four priority groups have similar ticket volumes, which is another indication of balanced synthetic data.

## Ticket-type performance

| Ticket type | Tickets | Resolved tickets | Resolution rate | Average CSAT | Average valid hours |
|---|---:|---:|---:|---:|---:|
| Refund request | 1,752 | 596 | 34.02% | 2.93 | 8.12 |
| Technical issue | 1,747 | 580 | 33.20% | 2.96 | 7.37 |
| Cancellation request | 1,695 | 516 | 30.44% | 3.03 | 7.69 |
| Product inquiry | 1,641 | 533 | 32.48% | 3.02 | 7.68 |
| Billing inquiry | 1,634 | 544 | 33.29% | 3.03 | 7.01 |

Refund requests have the highest volume and longest average valid handling duration. Cancellation requests have the lowest resolution rate, while billing inquiries have the shortest average valid handling time.

## Ticket-subject performance

The five highest-volume subjects are:

| Subject | Tickets | Resolution rate | Average CSAT |
|---|---:|---:|---:|
| Refund request | 576 | 30.90% | 3.07 |
| Software bug | 574 | 34.67% | 3.05 |
| Product compatibility | 567 | 34.39% | 2.96 |
| Delivery problem | 561 | 31.73% | 2.80 |
| Hardware issue | 547 | 33.46% | 3.00 |

The weakest subject-level resolution rates are Payment issue at 29.66%, Installation support at 29.81% and Data loss at 29.94%. Delivery problems have the lowest average CSAT at 2.80, followed by Network problems at 2.88.

## Product performance

Ticket volume alone does not measure a product's failure rate because the dataset does not contain the total number of units sold for each product.

Notable results include:

- Canon EOS has the highest ticket volume with 240 tickets.
- Microsoft Office has the highest resolution rate at 40.00%.
- Nintendo Switch Pro Controller has the lowest resolution rate at 24.14%.
- Lenovo ThinkPad has a resolution rate of 25.68%.
- Dell XPS has a resolution rate of 25.95%.
- Fitbit Versa Smartwatch has the lowest average CSAT at 2.54.
- Sony Xperia has an average CSAT of 2.69.
- Google Pixel and Dyson Vacuum Cleaner have the highest displayed average CSAT at 3.22.

## Post-response handling duration

Only tickets with a valid timestamp sequence are included in the duration analysis.

| Measure | Result |
|---|---:|
| Valid duration tickets | 1,404 |
| Share of all tickets | 16.58% |
| Minimum | 0.00 hours |
| Average | 7.58 hours |
| Median | 6.35 hours |
| 75th percentile | 11.36 hours |
| 90th percentile | 16.00 hours |
| 95th percentile | 18.52 hours |
| Maximum | 23.47 hours |

Half of valid cases were resolved within 6.35 hours after the first response, and 90% were resolved within 16 hours. The average exceeds the median, indicating that longer cases slightly increase the mean.

All 1,404 valid durations are below 24 hours, so the handling-time band analysis contains only an Under 24 hours group. That group has an average CSAT of 3.03 and a low-CSAT rate of 38.53%.

These values measure the interval from first response to resolution. They do not measure the complete duration from ticket creation because the dataset has no reliable ticket-created timestamp.

## Response activity

The dataset contains 5,650 first-response timestamps. Response activity is concentrated in May and June 2023:

| Month | Responses | Resolved tickets | Average CSAT |
|---|---:|---:|---:|
| May 2023 | 175 | 80 | 3.04 |
| June 2023 | 5,475 | 2,689 | 2.99 |

Weekday activity is also highly concentrated:

| Weekday | Responses |
|---|---:|
| Wednesday | 175 |
| Thursday | 5,437 |
| Friday | 38 |

The hour with the most recorded responses is 19:00, with 292 responses. However, because almost all response dates fall on a single Thursday and the data spans only parts of two months, the time patterns should not be used to make staffing recommendations.

## Data-quality limitations

1. The dataset is synthetic and should not be presented as the performance of a real company.
2. A reliable ticket-created timestamp is unavailable.
3. The calculated duration measures time from first response to resolution, not total ticket-resolution time.
4. Only 1,404 tickets, or 16.58% of all tickets, have valid duration sequences.
5. Satisfaction ratings exist only for the 2,769 closed tickets.
6. Product-sales volumes are unavailable, so ticket counts cannot be converted into product complaint rates.
7. Response dates are concentrated in May and June 2023.
8. Almost all recorded responses occur on Thursday, suggesting a timestamp-generation artefact.
9. Satisfaction ratings are distributed almost evenly from 1 to 5.
10. Channel, priority and ticket-type results are unusually balanced, so small differences should be interpreted cautiously.

## Business recommendations

1. **Review unresolved tickets.** Separate the 2,819 open tickets from the 2,881 tickets awaiting customer responses and define different follow-up procedures for each group.
2. **Improve cancellation handling.** Cancellation requests have the lowest ticket-type resolution rate at 30.44%.
3. **Review refund workflows.** Refund requests have the highest volume and longest average valid handling time at 8.12 hours.
4. **Investigate weak subject areas.** Payment issues, installation support and data-loss tickets all have resolution rates below 30%.
5. **Address delivery-related dissatisfaction.** Delivery problems have the lowest subject-level average CSAT at 2.80.
6. **Review low-performing product support.** Investigate the support content, escalation paths and agent guidance for Nintendo Switch Pro Controller, Lenovo ThinkPad, Dell XPS and Fitbit Versa Smartwatch.
7. **Improve timestamp capture.** Record ticket creation, first response, resolution and closure as validated sequential timestamps.
8. **Expand feedback collection.** Collect feedback for unresolved and abandoned interactions so that satisfaction can be compared across outcomes.
9. **Add exposure measures.** Combine support tickets with units sold or active-customer counts before comparing product complaint rates.

## Dashboard guidance

The Power BI dashboard should emphasize:

- Total, resolved, open and pending tickets
- Resolution rate
- Average CSAT and rated-ticket count
- Priority, channel, type, subject and product comparisons
- Median and 90th-percentile post-response handling time
- Clear data-quality notes

Monthly and weekday visuals should be labelled as response activity rather than incoming ticket volume. They should be treated as data-quality context, not evidence for staffing decisions.
