
# DefaultsKit

[UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) for iOS, macOS and tvOS.

Usage >> [`instructions`](https://github.com/nmdias/DefaultsKit/blob/master/README.md) <<

## Installation
- [CocoaPods](#cocoapods)
- [Carthage](#carthage)
- [Swift Package Manager](#swift-package-manager)
- [Manually](#manually)

# 

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To give `DefaultsKit` a try with an example project, run the following command: 

```bash
$ pod try DefaultsKit
```

To integrate `DefaultsKit` into your Xcode project, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'DefaultsKit'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a dependency manager that builds your dependencies and provides you with binary frameworks.

To install Carthage with [Homebrew](http://brew.sh/) use the following command:

```bash
$ brew update
$ brew install carthage
```
To integrate DefaultsKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "nmdias/DefaultsKit"
```
Build the framework:

```bash
$ carthage update
```
Then, drag the built `DefaultsKit.framework` into your Xcode project.

### Swift Package Manager

"The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies."

To integrate `DefaultsKit` into your project, specify it in your `Package.swift` file:

```swift
let package = Package(
    name: "MyApp",
    dependencies: [
        .Package(url: "https://github.com/nmdias/DefaultsKit.git")
    ]
)
```

Then run:

```bash
$ swift build
```

Or, alternatively:

```bash
$ swift package generate-xcodeproj
```

### Manually

Drag `DefaultsKit.xcodeproj` into your Xcode project.

 > It should appear nested underneath your application's blue project icon.
 
Click on the `+` button under the "Embedded Binaries" section of your app's target and select the `DefaultsKit.framework` that matches the desired platform.

## Credits
Similarities to [Alamofire](https://github.com/Alamofire/Alamofire)'s impecable setup instructions are not a coincidence :)

## License

DefaultsKit is released under the MIT license. See [LICENSE](https://github.com/nmdias/DefaultsKit/blob/master/LICENSE) for details.



