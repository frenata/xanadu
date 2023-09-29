## Design

Have a simple three-server architecture:
  * database (postgres, to hold state)
  * application (go)
  * proxy (nginx)

Deploy each as a FreeBSD jail, using [Bastillefile](github.com/BastilleBSD/bastille)s to describe-in-code not just the acode itself but the networking and setup.

## Requirements

  * FreeBSD as the host!
  * `bastille`
  * `curl` I guess?

## Traps

The host needs a proper `pf.conf` -- the Bastille docs give a good one, but in order for the *jails to speak to each other* the relevant ports (80, 8000, 5432) need to be opened on the hosts `pf.conf`. This file isn't currently included in this repo.

Building the servers takes a while, mostly the postgresql server which has a lot of packages to download. Destroying/recreating loses all this data -- I was surprised that with a thin jail that the package data isn't cached somewhere on the host.

Getting postgres to work in a jail requires turning on shared memory -- which apparently destroys most of the security guarantees of jails! So anything real-ish using these techniques probably needs to use another database engine or just run postgres on the host.

## Extensions?

  * Can `nomad` (or a similar generic orchestration tool) be used to distribute jails over a cluster of servers?
  * Can the IPs be auto-assigned rather than hardcoded?
  * Can box start-up be ordered? There's an open issue on the bastille repo.
  * Can the *host* be controlled? Via `rocinante` or nested jails?

## Output

For all that effort, I have acheived a server that tracks how many requests have been made against it. So probably a handful of lines of perl.

```
$ curl 10.0.10.1
Hello, there have been 18 requests made to this server!
```
