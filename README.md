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

TODOs:

- preparation
- [x] static analysis cleanup 
- [x] CI github actions pipeline
- [x] dockerize
- This f****** system doesn't even load some leaderboards!
- [X] setup easier reproduction env (seeds, factories, etc.)
- [X] investigate issue
- [X] prepare test for investigated issue
- [ ] introduce fix
- [ ] verify fix with additional preparation of verification steps
- Last night I lost my score. I had 10 points, ...
- [ ] setup easier reproduction env (seeds, factories, etc.)
- [ ] investigate issue
- [ ] prepare test for investigated issue
- [ ] introduce fix
- [ ] verify fix with additional preparation of verification steps
- I want to be able to see see all scores added ...

NiceToHaves:
- [ ] CI with dockerization
- [ ] brakeman integration
- [ ] SonarCloud integration

> :warning: **I will extend it later on, probably will di vide feature to smaller chunks.
