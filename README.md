# Benchmarking Phoenix vs Rails (WIP)


## Running Phoenix

```bash
$ mix do deps.get, compile
$ MIX_ENV=prod mix compile.protocols
$ MIX_ENV=prod elixir -pa _build/prod/consolidated -S mix phoenix.start
Running Elixir.Benchmarker.Router with Cowboy on port 4000

$ wrk -t4 -c100 -d30S --timeout 2000 "http://127.0.0.1:4000/showdown"
Running 10s test @ http://127.0.0.1:4000/showdown
  4 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     8.31ms    3.53ms  43.30ms   79.38%
    Req/Sec     3.11k   376.89     4.73k    79.83%
  121202 requests in 10.00s, 254.29MB read
Requests/sec:  12120.94
Transfer/sec:     25.43MB
```

## Benchmarking Rails

```bash
$ bundle
$ RACK_ENV=production bundle exec puma -w 4
[13057] Puma starting in cluster mode...
[13057] * Version 2.8.2 (ruby 2.1.0-p0), codename: Sir Edmund Percival Hillary
[13057] * Min threads: 0, max threads: 16
[13057] * Environment: production
[13057] * Process workers: 4
[13057] * Phased restart available
Running Elixir.Benchmarker.Router with Cowboy on port 4000

$ wrk -t4 -c100 -d30S --timeout 2000 "http://127.0.0.1:9292/showdown"
Running 10s test @ http://127.0.0.1:9292/showdown
  4 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    21.67ms   18.96ms 159.43ms   85.53%
    Req/Sec   449.74    413.36     1.10k    63.82%
  11414 requests in 10.01s, 25.50MB read
Requests/sec:   1140.53
Transfer/sec:      2.55MB
```

# Phoenix cold
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d30S --timeout 2000 "http://tranquil-brushlands-6459.herokuapp.com/showdown"
Running 30s test @ http://tranquil-brushlands-6459.herokuapp.com/showdown
  12 threads and 800 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   295.45ms   95.68ms   1.36s    82.17%
    Req/Sec   232.89     46.42   318.00     70.39%
  83019 requests in 30.01s, 174.18MB read
  Socket errors: connect 0, read 3, write 0, timeout 0
Requests/sec:   2766.50
Transfer/sec:      5.80MB

# Phoenix hot
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d30S --timeout 2000 "http://tranquil-brushlands-6459.herokuapp.com/showdown"
Running 30s test @ http://tranquil-brushlands-6459.herokuapp.com/showdown
  12 threads and 800 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   271.81ms  141.38ms   1.16s    88.48%
    Req/Sec   268.97     65.16   355.00     79.82%
  95893 requests in 30.02s, 201.19MB read
  Socket errors: connect 0, read 1, write 0, timeout 0
Requests/sec:   3194.04
Transfer/sec:      6.70MB

# Phoenix Load
source=web.1 dyno=heroku.27093979.2f996da9-40c0-47e8-8bf9-7b97d4d9a780 sample#load_avg_1m=2.03 sample#load_avg_5m=0.99 sample#load_avg_15m=1.32


# Rails cold
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d30S --timeout 2000 "http://dry-ocean-9525.herokuapp.com/showdown"
Running 30s test @ http://dry-ocean-9525.herokuapp.com/showdown
  12 threads and 800 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.17s     1.87s    6.82s    62.71%
    Req/Sec    21.43      8.18    44.00     70.28%
  7834 requests in 30.03s, 17.70MB read
Requests/sec:    260.89
Transfer/sec:    603.53KB

# Rails hot
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d30S --timeout 2000 "http://dry-ocean-9525.herokuapp.com/showdown"
Running 30s test @ http://dry-ocean-9525.herokuapp.com/showdown
  12 threads and 800 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.03s     1.88s    6.29s    55.16%
    Req/Sec    24.21     10.61    68.00     71.22%
  8772 requests in 30.03s, 19.81MB read
  Socket errors: connect 0, read 1, write 0, timeout 0
Requests/sec:    292.15
Transfer/sec:    675.55KB
root@li216-163:~/packages/wrk#

# Rails Load
ource=web.1 dyno=heroku.27094264.aded1db7-f37a-42f2-b650-b97311091625 sample#load_avg_1m=5.94 sample#load_avg_5m=2.68 sample#load_avg_15m=1.74
2014-07-07T21:56:47.987946+00:00 heroku[web.1]: source=web.1 dyno=heroku.27094264.aded1db7-f37a-42f2-b650-b97311091625 sample#memory_total=228.73MB sample#memory_rss=228.71MB sample#memory_cache=0.02MB sample#memory_swap=0.00MB sample#memory_pgpgin=63800pages sample#memory_pgpgout=5245pages



# Round 2

## Phoenix

### Cold
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d30S --timeout 2000 "http://tranquil-brushlands-6459.herokuapp.com/showdown"
Running 30s test @ http://tranquil-brushlands-6459.herokuapp.com/showdown
  12 threads and 800 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   317.15ms  139.55ms 970.43ms   81.12%
    Req/Sec   231.43     66.07   382.00     63.92%
  83240 requests in 30.00s, 174.65MB read
  Socket errors: connect 0, read 1, write 0, timeout 0
Requests/sec:   2774.59
Transfer/sec:      5.82MB

## Warm
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d180S --timeout 2000 "http://tranquil-brushlands-6459.herokuapp.com/showdown"
Running 3m test @ http://tranquil-brushlands-6459.herokuapp.com/showdown
  12 threads and 800 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   318.52ms  139.92ms   1.39s    82.03%
    Req/Sec   224.42     57.23   368.00     68.50%
  484444 requests in 3.00m, 0.99GB read
  Socket errors: connect 0, read 9, write 0, timeout 0
Requests/sec:   2691.03
Transfer/sec:      5.65MB

# Load
source=web.1 dyno=heroku.27093979.2f996da9-40c0-47e8-8bf9-7b97d4d9a780 sample#load_avg_1m=2.78 sample#load_avg_5m=3.08 sample#load_avg_15m=2.46
source=web.1 dyno=heroku.27093979.2f996da9-40c0-47e8-8bf9-7b97d4d9a780 sample#memory_total=34.69MB sample#memory_rss=33.57MB sample#memory_cache=0.09MB sample#memory_swap=1.03MB sample#memory_pgpgin=204996pages sample#memory_pgpgout=196379pages



## Rails

### Cold
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d30S --timeout 2000 "http://dry-ocean-9525.herokuapp.com/showdown"
Running 30s test @ http://dry-ocean-9525.herokuapp.com/showdown
  12 threads and 800 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.85s     1.33s    5.75s    65.73%
    Req/Sec    22.68      7.18    61.00     69.71%
  8276 requests in 30.03s, 18.70MB read
Requests/sec:    275.64
Transfer/sec:    637.86KB

### Warm
root@li216-163:~/packages/wrk# ./wrk -t12 -c800 -d180S --timeout 2000 "http://dry-ocean-9525.herokuapp.com/showdown"
Running 3m test @ http://dry-ocean-9525.herokuapp.com/showdown
  12 threads and 800 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.07s     2.06s    8.36s    70.39%
    Req/Sec    24.65      9.97    63.00     67.10%
  54256 requests in 3.00m, 122.50MB read
  Socket errors: connect 0, read 1, write 0, timeout 0
Requests/sec:    301.36
Transfer/sec:    696.77KB

### Load
source=web.1 dyno=heroku.27094264.aded1db7-f37a-42f2-b650-b97311091625 sample#load_avg_1m=10.40 sample#load_avg_5m=9.76 sample#load_avg_15m=5.19
source=web.1 dyno=heroku.27094264.aded1db7-f37a-42f2-b650-b97311091625 sample#memory_total=235.37MB sample#memory_rss=235.35MB sample#memory_cache=0.02MB sample#memory_swap=0.00MB sample#memory_pgpgin=66703pages sample#memory_pgpgout=6449pages
