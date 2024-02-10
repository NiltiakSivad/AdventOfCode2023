# Contributing

## Setup

### Step 1: Build Settings

1. Project > Build Settings > Set `ENABLE_USER_SCRIPT_SANDBOXING` to `NO`.

### Step 2: Package management
This project manages and executes local developer command line tools using [Mint](https://github.com/yonaskolb/Mint). 

1. See Mint's' full installation instructions, but get started with Homebrew by running: 
 - `brew install mint`.

2. By default Mint will install packages in `.~/mint/bin` not `/usr/local/bin`. As a result to make sure XCode can find the packages you'll want to add the following to your terminal configuration before running any mint commands, so Mint knows where to create symlinks: 
 - `PATH="~/.mint/bin:$PATH"`
 - `export MINT_LINK_PATH=/usr/local/bin`

3. Finally finish with: `mint bootstrap --link`. This will install the packages declared in the `Mintfile` in the project root.

### Step 3: Linter
This project is managed by [SwiftLint](https://github.com/realm/SwiftLint) to enforce code conventions. The project uses the default rules and makes no modifications.

SwiftLint is automatically executed as build step. 

If you want SwiftLint to auto attempt to fix linting errors run: 
- `swiftlint --fix`

## Compatability

This project was built targetting iOS Deployment Target of 17.0 and developed with Xcode 15.2.
