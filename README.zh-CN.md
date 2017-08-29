
![DefaultsKit](/DefaultsKit.png?raw=true)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/DefaultsKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![language](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![swift](https://img.shields.io/badge/swift-4.0+-orange.svg)](https://github.com/nmdias/DefaultsKit/releases)

[English](README.md)

如何安装 >> [`指南`](https://github.com/nmdias/DefaultsKit/blob/master/INSTALL.md) <<

DefaultsKit 是一个利用 Swift4 强大的 Codable，在 UserDefaults 基础上提供一层简单且强大的封装。它仅使用少于 70 行代码来实现这些功能。

## 使用说明

第一步: 实例化或者从 `Defaults` 获取一个 `shared` 实例

```swift
let defaults = Defaults() // 或者使用 let defaults = Defaults.shared
```

第二步:

```swift
// 定义一个键 (key)
let key = Key<String>("someKey")

// 设置值 (value)
defaults.set("Codable FTW 😃", for: key)

// 通过设置的 key 来查看返回的 value 结果值
defaults.get(for: key) // 输出: Codable FTW 😃
```

## 判断某个键是否含有某个值

```swift
if defaults.has(key) { 
    // 书写你自己的代码
}
```

> 如果你只需要知道该键值对 (key,value) 是否存在，而不需要使用该 key 使用的返回值 (value)，你可以使用 `has()`这个方法代替可选的 `get(for:key)` 方法。对于一些复杂的对象，它可以减少避免一些不必要的反序列化。


### 复杂的对象存储

存储一个遵循 [Codable](https://developer.apple.com/documentation/swift/codable) 协议的复杂对象：

```swift
struct Person: Codable {
    let name: String
    let age: Int
}

// 然后创建一个键
let key = Key<Person>("personKey")

// 获取一个遵循 Codable 协议的枚举，结构体或者类的实例
let person = Person(name: "Bonnie Greenwell", age: 80)

// 赋值
defaults.set(person, for: key)

// 最后查看 key 返回值的 value
let person = defaults.get(for: key)
person?.name // Bonnie Greenwell
person?.age  // 80
```
### 嵌套对象的存储

只要是遵循 Codable 协议的对象，你都可以嵌套地使用它们。

```swift
enum Pet: String, Codable {
    case cat
    case dog
}

struct Person: Codable {
    let name: String
    let pets: [Pet]
}

// 获取一个遵循 Codable 协议的实例
let person = Person(name: "Claire", pets: [.cat])

// 赋值
defaults.set(person, for: key)

// 查看 key 返回值的 value
let person = defaults.get(for: key)
person?.name        // Claire
person?.pets.first  // cat
```

## 开源协议

DefaultsKit 使用 MIT 协议，更多内容可以查看 [LICENSE](https://github.com/nmdias/DefaultsKit/blob/master/LICENSE)。

### 寻求帮助
#### [Review/Translate this file to Chinese](https://github.com/nmdias/DefaultsKit/issues/1)

汉语是世界上使用人数最多的语言，我希望 DefaultsKit 能被更多的人使用，但是我不会说汉语。如果你会汉语，而且愿意帮忙，请看看 [issue #1](https://github.com/nmdias/DefaultsKit/issues/1)。

谢谢 🙏
