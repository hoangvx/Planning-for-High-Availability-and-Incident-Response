## Availability SLI
### The percentage of successful requests over the last 5m
sum (rate(apiserver_request_total{job="apiserver",code!~"5.."}[5m])) / sum (rate(apiserver_request_total{job="apiserver"}[5m]))

## Latency SLI
### 90% of requests finish in these times
1 - ((1 - (sum(increase(apiserver_request_total{job="apiserver", code="200"}[7d])) by (verb)) / sum(increase(apiserver_request_total{job="apiserver"}[7d])) by (verb)) / (1 - .80))

## Throughput
### Successful requests per second
sum(rate(flask_http_request_total{job="ec2",status=~"2.."}[5m]))

## Error Budget - Remaining Error Budget
### The error budget is 20%
1 - ((1 - (sum(increase(flask_http_request_total{job="ec2", status!~"5.."}[5m])) by(verb)) / sum(increase(flask_http_request_total{job="ec2"}[5m])) by (verb)) / (1 - .80))
