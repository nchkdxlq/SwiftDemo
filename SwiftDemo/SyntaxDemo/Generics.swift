//
//  Generics.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/27.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


func generics_entry() {
    print("\n--------- generics ---------\n")
    
    test_stringStack()
}


// MARK: - 泛型函数

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tmp = a
    a = b
    b = tmp
}

// MARK: - 泛型类型

// 泛型占位符叫做`类型形式参数`

struct Stack<Element> {
    
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
}

// 扩展泛型类型

extension Stack {
    var topItem: Element? {
        return items.last
    }
}


// MARK: - 泛型约束



// MARK: - 关联类型

/*
 定义一个协议时，有时在协议定义里声明一个或多个关联类型是很有用的。关联类型给协议中用到的类型一个占位符名称。
 直到采纳协议时，才指定用于该关联类型的实际类型。关联类型通过 associatedtype 关键字指定。
 */

// 这里是一个叫做 Container 的示例协议，声明了一个叫做 Item 的关联类型：
protocol Container {
    associatedtype ItemType
    
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType? { get }
}



// MARK: - 泛型 where 分句

/*
 泛型`where`分句，就是给泛型`类型形式参数`添加额外的约束条件，也就是说给`泛型占位符`添加额外的约束条件。
 
 */


// 被检查的两个容器不一定是相同类型的（尽管它们可以是），但是它们的元素类型必须相同。这个要求通过类型约束和泛型 Where 分句一起体现
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        
    // Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // Check each pair of items to see if they are equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // All items match, so return true.
    return true
}



// 1. 带有泛型where分句的扩展


// a) where分语句扩展泛型类型
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        
        return topItem == item
    }
}


struct NotEquatable { }

func test_stringStack() {
    var stringStack = Stack<String>()
    stringStack.push("name")
    stringStack.push("age")
    
    if stringStack.isTop("name") {
        print("top item")
    } else {
        print("not top")
    }
    
    var notEquatableStack = Stack<NotEquatable>()
    let notEquatableValue = NotEquatable()
    notEquatableStack.push(notEquatableValue)
    
//    notEquatableStack.isTop(notEquatableValue) 编译报错
}


// b) where分语句扩展关联类型协议

extension Container where ItemType: Equatable {
    func startWith(_ item: ItemType) -> Bool {
        return count > 0 && self[0] == item
    }
}

// 当item的类型为Double时，给Container添加了average方法
extension Container where ItemType == Double {
    
    func average() -> Double {
        var sum = 0.0
        for i in 0..<count {
            sum += self[i]!
        }
        return sum / Double(count)
    }
    
}
