
![DefaultsKit](/DefaultsKit.png?raw=true)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/DefaultsKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![language](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![swift](https://img.shields.io/badge/swift-4.0+-orange.svg)](https://github.com/nmdias/DefaultsKit/releases)

[简体中文](README.zh-CN.md)

DefaultsKit leverages **Swift 4**'s powerful [Codable](https://developer.apple.com/documentation/swift/codable) capabilities to provide a **Simple** and **Strongly Typed** wrapper on top of [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults). It uses less than 70 lines of code to acomplish this.

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


### Auto Property
Make your pre-defined custom properties for your project with Defaults.

An example to use with basic Codable types:
```swift
extension Defaults: DefaultsAutoProperty {
    public var autoStringProperty: String? {
        set(newValue){ set(newValue) } get{ return get() }
    }
    public var autoDateProperty: Date? {
        set(newValue){ set(newValue) } get{ return get() }
    }
}
```

So you can use Defaults like this:
```swift
Defaults.shared.autoStringProperty = "new value will persist"
```

And also can use like this together with the default value with various codable types and CustomValueType:
```swift
public struct CustomValueType: Codable{
    var key:String = "value"
}
extension Defaults: DefaultsAutoProperty {
    // default value with 'or'
    public var autoStringPropertyWithDefaultValue: String? {
        set(newValue){ set(newValue) } get{ return get(or:"default string value") }
    }
    // non-optional - must define the default value with the keyword 'or'
    public var autoCustomNonOptionalProperty: CustomValueType {
        set(newValue){ set(newValue) } get{ return get(or: CustomValueType()) }
    }
    // optional with/without setter default value
    public var autoCustomOptionalProperty: CustomValueType? {
        set(newValue){ set(newValue) } get{ return get() }
    }
    public var autoCustomOptionalPropertySetterDefaultValue: CustomValueType? {
        set(newValue){ set(newValue, or: CustomValueType()) } get{ return get() }
    }
}
```

## License

DefaultsKit is released under the MIT license. See [LICENSE](https://github.com/nmdias/DefaultsKit/blob/master/LICENSE) for details.

### Help Wanted
#### Review/Translate [README.zh-CN.md](README.zh-CN.md) to Chinese
Chinese is the #1 spoken language in the world and I'd love to have DefaultsKit be more inclusive, unfortunately I don't speak Chinese. If you know chinese, and would like to help out, please see [issue #1](https://github.com/nmdias/DefaultsKit/issues/1)

Thank you 🙏
