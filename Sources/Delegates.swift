//
//  Delegates.swift
//  ┌─┐      ┌───────┐ ┌───────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ │      │ └─────┐ │ └─────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ └─────┐│ └─────┐ │ └─────┐
//  └───────┘└───────┘ └───────┘
//
//  Created by lee on 2019/4/20.
//  Copyright © 2018年 lee. All rights reserved.
//

import Foundation

public class Delegates<T> {
    
    typealias HashTable = NSHashTable<AnyObject>
    
    private let delegates: HashTable
    
    public var isEmpty: Bool {
        return delegates.allObjects.isEmpty
    }
    
    public init(_ strong: Bool = false) {
        delegates = strong ? HashTable() : HashTable.weakObjects()
    }
    
    public init(options: NSPointerFunctions.Options) {
        delegates = HashTable(options: options, capacity: 0)
    }
    
    /// 添加
    ///
    /// - Parameter delegate: 委托对象
    public func add(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    /// 移除
    ///
    /// - Parameter delegate: 委托对象
    public func remove(_ delegate: T) {
        delegates.remove(delegate as AnyObject)
    }
    
    /// 调用
    ///
    /// - Parameter closure: 委托对象
    public func invoke(_ closure: (T) -> Void) {
        for delegate in delegates.allObjects {
            guard let delegate = delegate as? T else { continue }
            closure(delegate)
        }
    }
    
    /// 包含
    ///
    /// - Parameter delegate: 委托对象
    /// - Returns: 包含返回 true 不包含返回false
    public func contains(_ delegate: T) -> Bool {
        return delegates.contains(delegate as AnyObject)
    }
}

public func +=<T>(lhs: Delegates<T>, rhs: T) {
    lhs.add(rhs)
}

public func -=<T>(lhs: Delegates<T>, rhs: T) {
    lhs.remove(rhs)
}
