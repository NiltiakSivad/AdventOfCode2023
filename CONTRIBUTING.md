# Contributing

## Setup

### Step 1: Build Settings

1. Project > Build Settings > Set `ENABLE_USER_SCRIPT_SANDBOXING` to `NO`.

### Step 2: Package management
This project manages and executes local developer command line tools using [Mint](https://github.com/yonaskolb/Mint). 

1. See Mint's' full installation instructions, but get started with Homebrew by running: 
 - `brew install mint`.

2. By default Mint will install packages in `~/.mint/bin` not `/usr/local/bin`. As a result to make sure XCode can find the packages you'll want to add the following to your terminal configuration before running any mint commands, so Mint knows where to create symlinks: 
 - `PATH="~/.mint/bin:$PATH"`
 - `export MINT_LINK_PATH=/usr/local/bin`

3. Finally finish with: `mint bootstrap --link`. This will install the packages declared in the `Mintfile` in the project root.

## Packages

### SwiftLint Linter
This project is managed by [SwiftLint](https://github.com/realm/SwiftLint) to enforce code conventions. The project uses the default rules and makes no modifications.

SwiftLint is automatically executed as build step. 

If you want SwiftLint to auto attempt to fix linting errors run: 
- `swiftlint --fix`

### Sourcery
This project relies on [Sourcery](https://github.com/krzysztofzablocki/Sourcery?tab=readme-ov-file) to automatically generate Mocks. This may not cover all mocking use cases, so you can still create custom mocks if needed. See relevant files in `Tests/Mocks` if any adjustments to Sourcery's configuration is needed. There is a Build Phase that runs to auto generate the mocks on every build. 

To have new files picked up by Sourcery, add the `AutoMockable` protocol to any class/struct.

## Compatability

This project was built targetting iOS Deployment Target of 17.0 and developed with Xcode 15.2.
