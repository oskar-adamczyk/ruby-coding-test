# Leaderboards Tracking System

## The test

This is a very small system that helps users track leaderboards

The system is currently broken, we've received the following bug report:

```
From: Gavin Belson

This f****** system doesn't even load some leaderboards!
You're all fired if you don't fix this in 2 seconds!
```

Obviously we need to fix the system ASAP or some heads will roll...

In addition to that, we seem to have a weird bug when the system is overloaded. Here's the bug report:

```
From: Jack Wilshere

Last night I lost my score. I had 10 points, added another 10 and then added another 10 but my score shows 20!
Your system is crap, I bet it was because I did it on two tabs, real quickly and you couldn't even handle that!
```

I contacted the original developer and he ensured me that it works on his machine and we even have tests that ensure that.
In all fairness I also couldn't reproduce the problem.
Maybe the user is lying?

Another thing that is currently being reported is an unusual slowness when showing the leaderboards.
I'm pretty sure it's just the user's stupid slow internet.

Finally, we have a story to improve our system:

```
From: Leeroy Jenkins

I want to be able to see see all scores added to a leaderboard. Also would like
to be able to remove a score from the past and have the leaderboard updated
with the new score.

Ah yes, I also wanted to know the changes on the positions! Like, when I add
my score, I want to see how many positions I gained on the other losers
```

Damnit Leeroy! This guy always has the craziest ideas, but I think this one is actually good.

## Setup instructions

```
bundle install
rails db:setup
```

That's it!

## How to approach this

* Treat this as you would any issue/story on your day job.
* Assume the system receives a huge amount of traffic in production.
* Assume that this is a successful company. This means this software **WILL GROW**. Keep that in mind when fixing/adding features.
* We will evaluate solutions to the problems on several aspects like: design, complexity, attention to detail, correctness, performance, etc.

## Solution

### Made assumptions

1. I have worked with ruby 2.5.8 version. It seems to be compatible with gems but in addition, it is supported by rubocop
that I wanted to have here badly :)
2. I have introduced docker-compose. It may be a bit over exaggeration, but considering successful company, we would most likely
at some point of time need more reliable persistence layer. That's why I decided to introduce dockerization with psql
service defined in docker-compose. It would allow us not only deploy application on cloud solution (e.g. k8s cluster)
but with easier test setup (already exsiting test instance of database) we can perform tests on CI pipeline easily.
3. Dockerization itself is best way to avoid SOA1 incidents and it is way easier to setup local env this way, at least
from my perspective :)
4. Selected psql because a) Personally, I feel comfortable with this sql engine b) Flexibility and power is quite high
comparing to downside of a bit higher entry threshold :)
5. I assumed that we always (by default) want to order entries by score (from SQL perspective considering
NULL values). Maybe it is too bold, but I thought about it as something quite natural to
order entries this way - as well from business perspective. I would ofc ask about that in real life environment ;)
I assumed as well that for some reason it is possible to have NULL score (e.g. initializing entry). Again, normally
I would ask if this should be possible and if not - then constrain it via validation on model + NOT NULL on DB
6. Attached Simplecov to calculate code coverage. It is quite low but I left it as it is - I would love
to improve it in future, but not waste time on that when I have some crucial hotfixes and feature to deliver.
If I would use SonarCloud, we could setup additional, separate coverage threshold only for new / touched code.
7. Updated some dependencies according to brakeman results.
8. I assumed that this action will not be the most performance reliant. If it will be we can to some extend increase threads
and pools but if we want to be prepared for the actual load, we should consider delegating
this responsibility to some kind of background processing job. Endpoint would only accept request for adding score,
actual calculation would be done immediately in background. I assumed that data consistency here is more important than
performance, ofc., it should be discussed and (I would say even more important) introduced to app and measured afterwards.
With measures it would be possible to decide about proper approach.
9. I assumed that it is better idea to move concurrent test from request layer (integration-e2e-ish) to unit, directly
on service object. Faster execution + more precise control. 

TODOs:

- preparation
- [X] static analysis cleanup 
- [X] CI github actions pipeline
- [X] dockerize
- This f****** system doesn't even load some leaderboards!
- [X] setup easier reproduction env (seeds, factories, etc.)
- [X] investigate issue
- [X] prepare test for investigated issue
- [X] introduce fix
- [X] verify fix with additional preparation of verification steps (already done by seeds including one NULL entry)
- Last night I lost my score. I had 10 points, ...
- [X] setup easier reproduction env (seeds, factories, etc.) (won't be done)
- [X] investigate issue
- [X] prepare test for investigated issue
- [X] introduce fix
- [X] verify fix with additional preparation of verification steps (won't be done, not so easy, would be easier
with -again- API :c jmeter or even xargs with concurrent cURLs)
- I want to be able to see see all scores added ...
- [ ] introduce listing of _subscores_
- [X] introduce adding _subscore_
- [ ] introduce removing _subscore_
- [ ] introduce leaderboard progress communication
- [ ] add index with ORDER DESC and NULLS LAST to score
- [X] refactor add score - delegate to service object

NiceToHaves:
- [X] CI with dockerization
- [X] brakeman integration
- [ ] SonarCloud integration
