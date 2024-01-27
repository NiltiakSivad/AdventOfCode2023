# Day 2

## Goal

In addition to solving the Advent of Code problem, I had two additional objectives for day 2:

1. Fake a login process by asking the user for their AoC session token, store it in the iOS Keychain
  - I mistakenly at first thought the Keychain can be accessed by other apps, I decided to store the session token *key* (not the token itself) in a unique identifier that is not guessable by other apps. This was done by utilizing info.plist and creating a local environment file so that the secret is not committed to source control. This would not have been 100% hack safe since it is still stored client side, and could be viewable from the binary; however, I decided it was out of scope to add additional protection like obfuscation. Once I realized that Keychain items have access controls in place by "app groups", I realized that a hard to guess key was unnecessary and removed this additional complexity from the app.
  - I am trying to figure out how to properly use `@Published` and `@ObservedObject` in a clean way to manage and translate from business logic to view state, don't think I am there yet
2. Introduce a network call to retrieve the file data over the network

## Outcome

### Part 1 + 2
I did not particularly enjoy this day's problems. I don't feel like I learned anything from them. It seemed to be another brute force parsing problem. Perhaps solving the problem in a pure functional way would've provided some learnings, but learning pure functional program is out of scope for what I'm hoping to accomplish with this project.
