//: Playground - noun: a place where people can play

import UIKit


/*
 字典的主要特点是键值集合，表现形式为 key: value
 
 
 */


/*** 初始化 ***/
var dict: [String: Int] = ["width": 78, "height": 99, "age": 28]
var dict1: Dictionary<String, Int> = ["width": 66, "height": 88]
var dict2 = [String: AnyObject]();
var dict3: [String: AnyObject] = [:];

let start = dict.startIndex
let end = dict.endIndex
//dict.indexForKey("height")
dict.index(forKey: "height")


/*** 添加 ***/
dict["weight"] = 65

/*** 删除 ***/
dict.popFirst()
dict
dict.remove(at: start)
//dict.removeValueForKey("height")
dict.removeValue(forKey: "height")


/*** 更新 ***/

dict1.updateValue(768, forKey: "haha")
dict1.updateValue(45, forKey: "height")


/*** 遍历 ***/

for key in dict1.keys {
    print(key)
}

for value in dict1.values {
    print(value)
}

for (key, value) in dict1 {
    print(key)
    print(value)
}

for item in dict1 {
    item.0
    item.1
}

dict1.forEach { (key, value) in
    print("======")
    print(key, value)
}

let resultMap = dict1.map { item in
    return item.value
}

resultMap.forEach { (key) in
    print(key)
}


/****  subScript  ****/

dict1["haha"]

let start1 = dict1.startIndex

// 返回的是一个元组
let result1: (String, Int) =  dict1[start1]
result1.0
result1.1




