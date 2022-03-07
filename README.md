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

I have worked with ruby 2.5.8 version. It seems to be compatible with gems but in addition, it is supported by rubocop
that I wanted to have here badly :)

TODOs:

- preparation
- [x] static analysis cleanup 
- [x] CI github actions pipeline
- [ ] dockerize
- This f****** system doesn't even load some leaderboards!
- [ ] setup easier reproduction env (seeds, factories, etc.)
- [ ] investigate issue
- [ ] prepare test for investigated issue
- [ ] introduce fix
- [ ] verify fix with additional preparation of verification steps
- Last night I lost my score. I had 10 points, ...
- [ ] setup easier reproduction env (seeds, factories, etc.)
- [ ] investigate issue
- [ ] prepare test for investigated issue
- [ ] introduce fix
- [ ] verify fix with additional preparation of verification steps
- I want to be able to see see all scores added ...

> :warning: **I will extend it later on, probably will di vide feature to smaller chunks.
