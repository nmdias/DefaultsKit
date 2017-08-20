
![DefaultsKit](/DefaultsKit.png?raw=true)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/DefaultsKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![language](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![swift](https://img.shields.io/badge/swift-4.0+-orange.svg)](https://github.com/nmdias/DefaultsKit/releases)

DefaultsKit leverages **Swift 4's** powerful [Codable](https://developer.apple.com/documentation/swift/codable) capabilities to provide a **Simple** and **Strongly Typed** wrapper on top of [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults). It uses less than 70 lines of code to acomplish this.

Installation >> [`instructions`](https://github.com/nmdias/DefaultsKit/blob/master/INSTALL.md) <<

## Usage

Instantiate, or get a `shared` instance of `Defaults`
```swift
let defaults = Defaults() // or Defaults.shared
```

Then use `set(for:)` and `get(for:)`:

```swift
// Define a key
let key = Key<String>("someKey")

// Set a value
defaults.set("Codable FTW \e/", for: key)

// Read the value back
defaults.get(for: key) // Outputs: Codable FTW \e/
```

### Check if key has a value:

```swift
if defaults.has(for: key) { 
    // Do your thing
}
```

## Complex objects

To persist more complex objects just conform to the [Codable](https://developer.apple.com/documentation/swift/codable) protocol.

```swift
struct Person: Codable {
    let name: String
    let age: Int
    let children: [Person]
}
```

Create a `Key<ValueType>`, then an instance of a `Codable` and call `set(for:)`.

```swift
let key = Key<Person>("personKey")
let person = Person(name: "Bonnie Greenwell", age: 80, children: [])

defaults.set(person, for: key)
```

To read the object back call `get(for:)`:

```swift
let person = defaults.get(for: key)
person?.name // Bonnie Greenwell
person?.age  // 80
```

## License

DefaultsKit is released under the MIT license. See [LICENSE](https://github.com/nmdias/DefaultsKit/blob/master/LICENSE) for details.



