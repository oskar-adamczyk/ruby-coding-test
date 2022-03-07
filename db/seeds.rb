# frozen_string_literal: true

l = Leaderboard.create(name: "My Leaderboard")
l.entries.create(username: "Jack", score: 10)
l.entries.create(username: "John", score: 9)
l.entries.create(username: "Jane", score: 3)
l.entries.create(username: "June")
