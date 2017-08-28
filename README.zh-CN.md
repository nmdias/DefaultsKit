
![DefaultsKit](/DefaultsKit.png?raw=true)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/DefaultsKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![language](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![swift](https://img.shields.io/badge/swift-4.0+-orange.svg)](https://github.com/nmdias/DefaultsKit/releases)

[English](README.md)

DefaultsKit 是利用Swift4强大的Codable,在UserDefaults基础上提供一层简单且强大的封装。它仅使用少于70行代码来实现这些功能。

使用说明
第一步:
实例化或者使用单例来初始化

```swift
let defaults = Defaults() // 或者使用 let defaults = Defaults.shared
```
第二步:

```swift
// 定义一个键(key)
let key = Key<String>("someKey")

// 设置值(value)
defaults.set("Codable FTW 😃", for: key)

// 通过设置的key来查看返回的value结果值
defaults.get(for: key) // 输出: Codable FTW 😃
```

判断某个键(key)是否含有某个值(value)
```swift
if defaults.has(key) { 
    // 书写你自己的代码
}
```

> 如果你只需要知道该键值队(key,value)是否存在,而不需要使用该key使用的返回值(value),使用has()这个方法代替这个可选的get(for:key)方法。对于一些复杂的对象,它可以减少避免一些不必要的转换


复杂的对象存储
一个遵循Codable协议的复杂对象需要存储

```swift
struct Person: Codable {
    let name: String
    let age: Int
}

// 然后创建一个键(key)
let key = Key<Person>("personKey")

// 获取一个实例符合Codable协议的枚举,结构体或者类
let person = Person(name: "Bonnie Greenwell", age: 80)

// 赋值
defaults.set(person, for: key)

// 最后查看key返回值的value
let person = defaults.get(for: key)
person?.name // Bonnie Greenwell
person?.age  // 80
```
嵌套对象的存储
只要是遵循Codable协议,你也可以使用嵌套对象

```swift
enum Pet: String, Codable {
    case cat
    case dog
}

struct Person: Codable {
    let name: String
    let pets: [Pet]
}

// 获取一个遵循Codable协议的实例
let person = Person(name: "Claire", pets: [.cat])

// 赋值
defaults.set(person, for: key)

// 查看key返回值的value
let person = defaults.get(for: key)
person?.name        // Claire
person?.pets.first  // cat
```


## License

DefaultsKit is released under the MIT license. See [LICENSE](https://github.com/nmdias/DefaultsKit/blob/master/LICENSE) for details.

### Help Wanted
#### [Review/Translate this file to Chinese](https://github.com/nmdias/DefaultsKit/issues/1)
Chinese is the #1 spoken language in the world and I'd love to have DefaultsKit be more inclusive, unfortunately I don't speak Chinese. If you know chinese, and would like to help out, please see [issue #1](https://github.com/nmdias/DefaultsKit/issues/1).

Thank you 🙏
