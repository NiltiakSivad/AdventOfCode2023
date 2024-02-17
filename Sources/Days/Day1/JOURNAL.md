# Day 1

## Context

Even though Advent of Code is not oriented towards user interface problems, I thought I could generate my own user interface problems in service of re-familiarizing myself with iOS development. At the start of this project I had not touched iOS development for approximately 3 years, due to my 2 years of service in management, and 1 year as a backend engineer. Though prior to my time in management, I had exclusively done iOS for approximately 4 years.

## Goal

Given the above context, in addition to solving the basic Advent of Code problem, I had three objectives for day 1:

1. Gain familiarity with the high-level use of Swift UI - hence the very noobish problem of displaying sections in a list and hiding and showing on a user action.
2. Use some separatation of layers of concern to break up the logic processing of the Advent of Code problem into a coherent structure - hence the presence of the `Interactor` and `Presenter`.
3. Read data from a file - hence the `FileProcessor` class and `getFile` method. I thought the naive simple solution was sufficient for this use case because the data is short enough to be loaded into memory all at once. This could be changed later to read the file only line by line in order to conserve memory.

## Outcome

### Part 1
Swift does support mutable and immutable strings (`let` vs `var`), but the Strings API is relatively complex when it comes to indexing into the strings. So to simplify it I opted to convert the string to an array of `Chars`. If `L` = # of lines, and `C` = average # of characters in a specific line, the time complexity is O(L * C).

### Part 2
This one was more complex and got me with the `oneight` use case as I did not notice that characters could be re-used. As a result, I learned about capture groups in Regular Expressions. When a character is "captured" it is removed from the matchable characters. This is why while going down the route of Regular Expressions I thought to create two Regular Expressions and perform the operation twice. If `L` = # of lines, and `C` = average # of characters in a specific line, the time complexity is O(L * C). Even though there are multiple operations occuring for a given line in order to transform it they are of fixed time because the size of the line is fixed, so constants dropped.
