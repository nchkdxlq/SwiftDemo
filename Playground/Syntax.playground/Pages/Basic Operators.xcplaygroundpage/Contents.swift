//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)



// Range 区间运算符


/** Closed Range Operator
    ... 闭区间运算符 ClosedRange<bound>
 
 */

let range1 = 0...5 // range1的类型为 ClosedRange<Int>

for item in range1 {
    print(item)
}


/**
    Half-Open Range Operator
    ..<  半开区间运算符 Range<bound>
 */

let range2 = 0..<5  // range2的类型  Range<Int> 不包含 5
for item in range2 {
    print(item)
}

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}


// 单个字符使用双引号时，可以表示string类型，也可以表示Character类型，默认情况是string类型，如果需要定义为Character类型时，需要显示的指定类型
let rang3 = "a"..<"f" //ClosedRange<String>
let rang4: Range<Character> = "a"..<"f" // Range<Character>


/**
    One-Sided Ranges (单侧运算符)
    可以让区间只有一侧有值，另一次不指定值，在合法的范围内尽可能的大或者最可能的小
 */

for name in names[2...] {
    print(name)
}
// Brian
// Jack

for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian


