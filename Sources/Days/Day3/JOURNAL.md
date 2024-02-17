# Day 3

## Goal

In addition to solving the Advent of Code problem, I had two additional objectives for day 3:

1. Setup package management and a linter
2. Write unit tests
 
## Outcome

### Part 1

1. I had two ideas for part one, one was to create a single line as a data structure
// Given
// Line Length: "L"
// Number Length: "N"
// Current iteration position: "I"
// Then for each number encountered would want to check if a symbol exists at:

1. Previous Line
 - Loop: I - L to I - L - N - 1
2. Current Line
 - I
 - I - (N + 1)
3. Next Line
 - Loop I + L to I + L - N - 1
 
 // Add the id to the number sum
 
2. Second idea was to use a 2 dimensional array and treat it like a grid

|....573.613......
|.......*.........
|...........328...
|777....763...*...
|..=...-....710...
------------------

```

[   0    1    2   3    4   5    6
0 [".", ".", ".", "5", "7, "3", "."]
1 [".", ".", ".", ".", ".", ".", "*"]
2 [".", ".", ".", "5", ".", ".", "."]
3 ["7", "7", "7", ".", ".", ".", "."]
4 [".", ".", "=", ".", ".", ".", "."]
]
```

1. Previous Line
 - start(x - 1, y - 1), search through to  end(x + 1, y - 1)
2. Current Line
- findNextNumber(searchStart: (x,y)) -> ((x, y), (x, y))
- searchSymbolCurrentLine() -> Bool
Spot check two locations 
if start - 1 === symbol || end + 1 === symbol return true
3. Next Line
 - start(x - 1, y + 1), search through to end(x + 1, y + 1)

### Part 2
