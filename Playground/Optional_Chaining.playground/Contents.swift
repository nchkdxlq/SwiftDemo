//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class Room {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Persion {
    var residence: Residence?
}

let john = Persion()

// this triggers a runtime error
//let roomCount = john.residence!.numberOfRooms

let roomCount1 = john.residence?.numberOfRooms

if (roomCount1 != nil) {
    
}

if ((john.residence?.numberOfRooms) != nil) {
    
}

/*
 if let roomCount = john.residence?.numberOfRooms { }
 做了两件事情，
 1、把 john.residence?.numberOfRooms 赋值给 roomCount
 2、判断 roomCount 是否为空
 */
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}


// 通过赋给 john.residence 一个 Residence 的实例变量:

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}


// 通过可空链式调用访问属性

let luo = Persion()

if let roomCount = luo.residence?.numberOfRooms {
    print("luo's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}
// 因为 john.residence 为 nil ,所以毫无疑问这个可空链式调用失败。


//通过可空链式调用来设定属性值:
let someAddress = Address()

someAddress.buildingNumber = "29"
someAddress.street = "前进一路"
luo.residence?.address = someAddress

//在这个例子中,通过 luo.residence 来设定 address 属性也是不行的,因为 luo.residence 为 nil 。


// 通过可空链式调用来调用方法
if luo.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

// 可以通过可空链式调用判断给属性赋值是否成功
if (luo.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}


/*
 通过可空链式调用来访问下标
 
 通过可空链式调用,我们可以用下标来对可空值进行读取或写入,并且判断下标调用是否成功
 */

// 为什么这样访问的是 rooms 数组 ????
let room = luo.residence?[0]

// 因为 luo.residence 为 nil, 所以下标调用会失败
if let firstRoomName = luo.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

// 类似的。可以通过下标，用可空链式调用来赋值
luo.residence?[0] = Room(name: "Bathroom")
// 这次赋值同样会失败,因为 residence 目前是 nil 。

// 创建一个Residence实例，添加一些Room实例并赋值给luo.residence,就可以通过可选链和下标来访问数组中的元素

let luoHouse = Residence()
luoHouse.rooms.append(Room(name: "Living Room"))
luoHouse.rooms.append(Room(name: "Kitchen"))
luo.residence = luoHouse

if let firstRoomName = luo.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

/*
 访问可空类型的下标
 如果下标返回可空类型值，比如Swift中的Dictionary的 key 下标。
 可以在下标的比括号放一个问号来链接下标的可空返回值
 */

var testScores = ["Dave":[86, 82, 84], "Bev":[79, 94, 81]]

testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72


/*
 对返回可空值的函数进行链接
 
 上面的例子说明了如何通过可空链式调用来获取可空属性值。
 我们还可以通过可空链式调用来调用返回可空值的方法,并且可以继续对可空值进行链接。
 
 */
if let buildingIdentifier = luo.residence?.address?.buildingIdentifier() {
    print("luo' building indentifier is \(buildingIdentifier)")
}

// 如果要进一步对方法的返回值进行可空链式调用,
//在方法 buildingIdentifier() 的圆括号后面加上问号

if let beginsWithThe = luo.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    
    if beginsWithThe {
        print("luo's building identifier begins with \"The\".")
    } else {
        print("luo's building identifier does not begin with \"The\".")
    }
}


