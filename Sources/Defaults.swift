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
///     static let someKey = Key<ValueType>("someKey")
public final class Key<ValueType: Codable> {
    fileprivate let _key: String
    public init(_ key: String) {
        _key = key
    }
}

/// Provides strongly typed values associated with the lifetime
/// of an application. Apropriate for user preferences.
/// - Warning
/// These should not be used to store sensitive information that could compromise
/// the application or the user's security and privacy.
public final class Defaults {
    
    private var userDefaults: UserDefaults
    
    /// Shared instance of `Defaults`, used for ad-hoc access to the user's
    /// defaults database throughout the app.
    public static let shared = Defaults()
    
    /// An instance of `Defaults` with the specified `UserDefaults` instance.
    ///
    /// - Parameter userDefaults: The UserDefaults.
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    /// Deletes the value associated with the specified key, if any.
    ///
    /// - Parameter key: The key.
    public func clear<ValueType>(_ key: Key<ValueType>) {
        userDefaults.set(nil, forKey: key._key)
        userDefaults.synchronize()
    }
    
    /// Checks if there is a value associated with the specified key.
    ///
    /// - Parameter key: The key to look for.
    /// - Returns: A boolean value indicating if a value exists for the specified key.
    public func has<ValueType>(_ key: Key<ValueType>) -> Bool {
        return userDefaults.value(forKey: key._key) != nil
    }
    
    /// Returns the value associated with the specified key.
    ///
    /// - Parameter key: The key.
    /// - Returns: A `ValueType` or nil if the key was not found.
    public func get<ValueType>(for key: Key<ValueType>) -> ValueType? {
        if isSwiftCodableType(ValueType.self) || isFoundationCodableType(ValueType.self) {
            return userDefaults.value(forKey: key._key) as? ValueType
        }
        
        guard let data = userDefaults.data(forKey: key._key) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(ValueType.self, from: data)
            return decoded
        } catch {
            #if DEBUG
                print(error)
            #endif
        }

        return nil
        
    }
    
    /// Sets a value associated with the specified key.
    ///
    /// - Parameters:
    ///   - some: The value to set.
    ///   - key: The associated `Key<ValueType>`.
    public func set<ValueType>(_ value: ValueType, for key: Key<ValueType>) {
        if isSwiftCodableType(ValueType.self) || isFoundationCodableType(ValueType.self) {
            userDefaults.set(value, forKey: key._key)
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(value)
            userDefaults.set(encoded, forKey: key._key)
            userDefaults.synchronize()
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
    }
    
    /// Checks if the specified type is a Codable from the Swift standard library.
    ///
    /// - Parameter type: The type.
    /// - Returns: A boolean value.
    private func isSwiftCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is String.Type, is Bool.Type, is Int.Type, is Float.Type, is Double.Type:
            return true
        default:
            return false
        }
    }
    
    /// Checks if the specified type is a Codable, from the Swift's core libraries
    /// Foundation framework.
    ///
    /// - Parameter type: The type.
    /// - Returns: A boolean value.
    private func isFoundationCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is Date.Type:
            return true
        default:
            return false
        }
    }
    
}


/*
    DefaultsAutoProperty protocol extension
    - Contributed by Taeho Lee (github.com/metasmile)
*/
public protocol DefaultsAutoProperty {}
public extension DefaultsAutoProperty where Self:Defaults{

    /// Sets a newValue automatically associated with the current function(key) name.
    /// If newValue is nil, the key in UserDefaults will be deleted.
    ///
    /// - Parameters:
    ///   - newValue: The value to set.
    ///   - or: default value. Non-Optional.
    ///   - key: private key name. it will set automatically via #function macro.
    func set<ValueType:Codable>(_ newValue:ValueType?=nil, or:ValueType, key:String=#function){
        set(newValue ?? or, key: key)
    }
    // Alias set function:
    func set<ValueType:Codable>(_ newValue:ValueType?=nil, key:String=#function){
        if let newValue = newValue{
            set(newValue, for: Key<ValueType>(key))
        }else{
            clear(Key<ValueType>(key))
        }
    }

    /// Returns the value or default value associated with the specified key.
    ///
    /// - Parameter
    ///   - or: default value.
    ///   - key: private key name. it will set automatically via #function macro.
    /// - Returns: A `ValueType` or nil if the key was not found.
    func get<ValueType:Codable>(or:ValueType?=nil, key:String=#function) -> ValueType?{
        // value is available
        if let gotValue = get(for: Key<ValueType>(key)){
            return gotValue
        }
        // persists default value
        if let gotOr = or{
            set(nil, or:gotOr, key: key) // set to guarantee
            return gotOr
        }
        // no value + no pre-defined default value
        return nil
    }
    func get<ValueType:Codable>(or:ValueType, key:String=#function) -> ValueType{
        if let _or = get(or:Optional<ValueType>(or), key: key){
            return _or
        }
        assert(false, "the default value \(String(describing:or)) of 'or' was not persisted.")
        return or
    }
}
