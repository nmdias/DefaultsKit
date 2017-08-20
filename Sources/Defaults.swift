//
//  Defaults.swift
//
//  Copyright (c) 2017 Nuno Manuel Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/// Represents a `Key` with an associated generic value type conforming to the
/// `Codable` protocol.
///
///     static let someKey = Key<T>("someKey")
public final class Key<ValueType: Codable> {
    fileprivate let _key: String
    public init(_ key: String) {
        self._key = key
    }
}

/// Provides strongly typed values associated with the lifetime
/// of an application. Apropriate for user preferences.
/// - Warning
/// Shoud not be used to store sensitive information that could compromise
/// the application or the user's security.
public final class Defaults {
    
    private var userDefaults: UserDefaults
    
    /// Shared instance of `Settings`, used for ad-hoc settings throughout
    /// the app.
    public static let shared = Defaults()
    
    /// An instance of Settings with the specified `UserDefaults` instance
    ///
    /// - Parameter userDefaults: The UserDefaults
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    /// Deletes the value associated with the specified key, if any.
    ///
    /// - Parameter key: The key.
    public func clear<ValueType>(key: Key<ValueType>) {
        self.userDefaults.set(nil, forKey: key._key)
        self.userDefaults.synchronize()
    }
    
    /// Checks if there is a value associated with the specified key.
    ///
    /// - Parameter key: The key to look for.
    /// - Returns: A boolean value indicating if a value exists for the specified key.
    public func has<ValueType>(key: Key<ValueType>) -> Bool {
        return userDefaults.value(forKey: key._key) != nil
    }
    
    /// Returns the value associated with the specified key.
    ///
    /// - Parameter key: The key.
    /// - Returns: The specified key type T or nil if not found.
    public func get<ValueType>(for key: Key<ValueType>) -> ValueType? {
        if isPrimitive(type: ValueType.self) {
            return self.userDefaults.value(forKey: key._key) as? ValueType
        }
        
        guard let data = self.userDefaults.data(forKey: key._key) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(ValueType.self, from: data)
            return decoded
        } catch {
            #if DEGBUG
                print(error)
            #endif
        }

        return nil
        
    }
    
    /// Sets a value associated with the specified key.
    ///
    /// - Parameters:
    ///   - some: The value to set.
    ///   - key: The associated `Key`.
    public func set<ValueType>(_ some: ValueType, for key: Key<ValueType>) {
        if isPrimitive(type: ValueType.self) {
            self.userDefaults.set(some, forKey: key._key)
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(some)
            self.userDefaults.set(encoded, forKey: key._key)
            self.userDefaults.synchronize()
        } catch {
            #if DEGBUG
                print(error)
            #endif
        }
    }
    
    /// Checks if a give type is primitive
    ///
    /// - Parameter type: The type
    /// - Returns: A boolean value indicating if the type is primitive
    private func isPrimitive<ValueType>(type: ValueType.Type) -> Bool {
        switch type {
        case is String.Type, is Bool.Type, is Int.Type, is Float.Type, is Double.Type:
            return true
        default:
            return false
        }
    }
    
}

