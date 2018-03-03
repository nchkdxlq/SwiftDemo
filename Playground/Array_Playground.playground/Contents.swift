//: Playground - noun: a place where people can play

import UIKit

/********************* Arrar的基本操作 ***********************/

/****** 初始化数组 ******/
var arr = [3, 6, 9]
arr[0] = 1
var doubleArr: Array<Double> = []
var doubleArr1: [Double] = []
var doubleArr2 = [Double]()
var strArr: [String] = ["luoquan", "cookie", "iOS"]
var intArr = Array(repeating: 6, count: 2)

// init an empty array,
/*
 初始化数组是一定要指定数组的类型，也就是指定数组元素的类型
 
 */
var emptyArr: [String] = Array()
var emptyArr1 = [String]()

if emptyArr.isEmpty {
    print("is Empty")
}

/***** 数组追加 ******/


// append

var nameArr = [String]()
nameArr.append("luoquan")
nameArr.append("小明")


// 运算符 +

var boys = ["Kang", "David"]
var girls = ["ilas", "rose"]

var boysGirls = boys + girls


// 预运算符 +=

nameArr += boys
nameArr += girls


// insert 

// 插入单个元素
girls.insert("小芳", at: 0)

// 插入一个数组
boys.insert(contentsOf: ["小三", "李四"], at: 0)


/******** 删除数组 (返回删除的元素)*********/

nameArr
nameArr.removeLast()
nameArr.removeFirst()
nameArr.remove(at: 0)
//nameArr.removeLast(<#T##n: Int##Int#>)
//nameArr.removeLast(<#T##n: Int##Int#>)
nameArr
nameArr.popLast()
nameArr.removeSubrange(0..<2)
//nameArr.removeAll()
nameArr.removeAll(keepingCapacity: true)

/******* 修改数组 *******/

girls
girls[0] = "美眉"
girls.replaceSubrange(1..<3, with: ["女神", "妹纸"])


/******** 遍历数组 ********/

nameArr += boys
nameArr += girls

for name in nameArr {
    print(name)
}

for (index, name) in nameArr.enumerated() {
    print("第 \(index) 位同学的名字是：\(name)")
}

nameArr.forEach { (name) in
    print("name = \(name)")
}

nameArr
// 什么东西 不懂 ？？？？？？？
var gene = nameArr.makeIterator()
gene.next()

var enume = nameArr.enumerated()
var enumeGene = enume.makeIterator()
enumeGene.next()

/******* 数组的高阶函数 *********/

var upStr = nameArr.map { (name) -> String in
    name.uppercased()
}

var countArr = nameArr.map { $0.characters.count }
print(countArr)

var countGrate2 = countArr.filter { (num) -> Bool in
    return num > 2
}
print(countGrate2)

countGrate2 = countArr.filter {$0 > 2}
print(countGrate2)


let range = 0..<4
let range1 = 0...4



