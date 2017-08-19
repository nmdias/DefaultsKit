
![DefaultsKit](/DefaultsKit.png?raw=true)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/DefaultsKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![language](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![swift](https://img.shields.io/badge/swift-4.0+-orange.svg)](https://github.com/nmdias/DefaultsKit/releases)

DefaultsKit leverages `Swift 4`'s powerful [Codable](https://developer.apple.com/documentation/swift/codable) capabilities and uses  70≈ or so lines of code to acomplish this.

Installation >> [`instructions`](https://github.com/nmdias/DefaultsKit/blob/master/INSTALL.md) <<

## Usage
Here's a simple `get` example, with type inference on a complex object:

```swift
let person: Person = defaults.get(for: key)!
```

## From the beginning...

Extend `Keys` with your own keys and associated value type:
```swift
extension Keys {
    static let nameKey = Key<String>("nameKey")
}
```

Instantiate, or get a `shared` instance of `Defaults`
```swift
let defaults = Defaults() // or Defaults.shared
```

Then `get`, `set` or `has` the desired key.

```swift
defaults.get(for: keys.nameKey) // Reads the `String` value
defaults.has(for: keys.nameKey) // Check if the `String` value exists
defaults.set("foo", for: keys.nameKey) // Sets a `String` value
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

Create a `Key<T>`, then an instance of a `Codable` and call `set`.

```swift
let key = Key<Person>("personKey")
let person = Person(name: "Bonnie Greenwell", age: 80, children: [])

defaults.set(person, for: key)
```

To get the saved object:

```swift
let person = defaults.get(for: key)
person?.name // Bonnie Greenwell
person?.age  // 80
```


## Credits
[SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults) for the inspiration on Keys with an associated generic type.

## License

DefaultsKit is released under the MIT license. See [LICENSE](https://github.com/nmdias/DefaultsKit/blob/master/LICENSE) for details.



