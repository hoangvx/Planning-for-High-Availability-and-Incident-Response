# API Service

| Category     | SLI | SLO                                                                                                         |
|--------------|-----|-------------------------------------------------------------------------------------------------------------|
| Availability | total number of successful requests / total number of requests                          | 99%                                                 |
| Latency      | total number of request that have response time below 100ms / total number of request   | 90% of requests below 100ms                         |
| Error Budget | total number of error requests / total number of requests                               | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | total of successful requests / second                                                   | 5 RPS indicates the application is functioning                             |
