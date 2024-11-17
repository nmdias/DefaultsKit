![DefaultsKit](/DefaultsKit.png?raw=true)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fnmdias%2FDefaultsKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/nmdias/DefaultsKit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fnmdias%2FDefaultsKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/nmdias/DefaultsKit)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/DefaultsKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)

[简体中文](README.zh-CN.md)

DefaultsKit is a lightweight Swift library that builds on [Codable](https://developer.apple.com/documentation/swift/codable) to offer a **Simple**, **Strongly Typed** and compact wrapper for [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults). With fewer than 100 lines of code, it’s both easy to use and highly efficient.

Installation >> [`instructions`](https://github.com/nmdias/DefaultsKit/blob/master/INSTALL.md) <<

## Usage

Instantiate, or get a `shared` instance of `Defaults`

```swift
let defaults = Defaults() // or Defaults.shared
```

Then:

```swift
// Define a key
let key = Key<String>("someKey")

// Set a value
defaults.set("Codable FTW 😃", for: key)

// Read the value back
defaults.get(for: key) // Output: Codable FTW 😃
```

### Check if a key has a value:

```swift
if defaults.has(key) {
    // Do your thing
}
```

> If you just need to know that a key/value pair exists, **without actually using the value**, use the `has()` method instead of the optional `get(for:key)`. For complex objects it will prevent any unnecessary deserialization.

### Implicit Member Expression

You can find a convenience wrapper for your keys by extending `DefaultsKey`. This allows you use [Implicit Member Expression](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#//appleref/swift/grammar/implicit-member-expression):

```swift
// Extend with a custom key
extension DefaultsKey {
    static var someKey: Key<Int> { Key("someKey") }
}

// Then use it like this
defaults.set("Some key", for: .someKey)
defaults.get(for: .someKey) // Output: Some key
```

### Complex objects

To store a complex object just conform to the [Codable](https://developer.apple.com/documentation/swift/codable) protocol:

```swift
struct Person: Codable {
    let name: String
    let age: Int
}
```

Then:

```swift
// Create a key
let key = Key<Person>("personKey")

// Get an instance of your Codable conforming enum, struct or class
let person = Person(name: "Bonnie Greenwell", age: 80)

// Set the value
defaults.set(person, for: key)
```

And finally:

```swift
// Read it back
let person = defaults.get(for: key)
person?.name // Bonnie Greenwell
person?.age  // 80
```

### Nested Objects

You can also use nested objects as long as they conform to the `Codable` protocol:

```swift
enum Pet: String, Codable {
    case cat
    case dog
}

struct Person: Codable {
    let name: String
    let pets: [Pet]
}

// Get a Codable conforming instante
let person = Person(name: "Claire", pets: [.cat])

// Set the value
defaults.set(person, for: key)

// And read it back
let person = defaults.get(for: key)
person?.name        // Claire
person?.pets.first  // cat
```

## License

DefaultsKit is released under the MIT license. See [LICENSE](https://github.com/nmdias/DefaultsKit/blob/master/LICENSE) for details.

### Help Wanted

#### Review/Translate [README.zh-CN.md](README.zh-CN.md) to Chinese

Chinese is the #1 spoken language in the world and I'd love to have DefaultsKit be more inclusive, unfortunately I don't speak Chinese. If you know chinese, and would like to help out, please see [issue #1](https://github.com/nmdias/DefaultsKit/issues/1)

Thank you 🙏
