//
//  Protocol.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/25.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


/*
 
 

 ## What
 1. 协议的定义，什么是协议
 2. 协议的种类
 3. 协议的作用
 
 ## Why
 
 
 ## How
 
 */


func protocol_entry() {
    print("\n--------- protocol ---------\n")
    
    test_diceGame()
    
    test_protocol_combined()
    
    test_optional_protocol()
    
    test_protocol_extension()
} 

/**
 ### 对属性的要求
 
 
 需要明确属性的`名称和类型`，但不需要说明属性是`存储属性`还是`计算属性`；同时需要明确属性的`读写权限`;
 可区分是实例属性还是类型属性，类型属性需要在前面加上`static`关键字
 */

protocol SomeProtocol {
    
    var mustBeSettable: Int { get set }
    
    var doseNotNeedToSettable: Int { get }
}


// 类型属性
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}


protocol FullyNamed {
    var fullName: String { get }
}


struct Person: FullyNamed {
    var fullName: String
}

func test_person() {
    let john = Person(fullName: "John Appleseed")
    print(john)
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        guard let prefix = prefix else {
            return name
        }
        return prefix + " " + name
    }
}


func test_starship() {
    let starship = Starship(name: "Enterprise", prefix: "USS")
    print(starship)
    
//    starship.fullName = "test"  // read only
}


/**
 
 ## 方法的要求
 
 协议可以要求采纳的类型实现指定的实例方法和类方法。属性方式和普通的类方法和实例方法类似，但不需要些{}和函数体，
 但在协议的定义中，方法参数不能定义默认值
 
 */

protocol RandomNumberGenerator {
    func random() -> Double
}


class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a) + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}


/**
 ## 异变方法要求
 
 有时一个方法需要改变所属的实例。例如值类型的实例方法(结构体或枚举)，在方法的`func`关键字之前使用`mutating`
 关键字，来表示在该方法可以改变其所属实例，以及该实例的所有属性。
 
 
 注意：如果你在协议中标记实例方法需求为 mutating ，在为类实现该方法的时候不需要写 mutating 关键字。 mutating 关键字只在结构体和枚举类型中需要书写。
 
 */


protocol Togglable {
    mutating func toggle()
}


enum OnOffSwitch: Togglable {
    case off, on
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}


/**
 ## 初始化器要求
 
 协议可以要求遵循协议的类型实现指定的初始化器。
 
 */


protocol SomeInitProtocol {
    init(someParameter: Int)
}

class SomeClass: SomeInitProtocol {
    required init(someParameter: Int) {
        // initializer implementation gose here
    }
}

final class SomeFinalClass: SomeInitProtocol {
    // 因为是final class，所有初始化器不需要`required`关键字
    init(someParameter: Int) {
        // initializer
    }
}
/*
 在遵循协议类的所有子类中，`required`修饰的使用保证了你为协议初始化器要求提供一个明确的继承实现。
 
 注意：由于`final`的类不会有子类，如果协议初始化器实现的类使用了`final`标记，你就不会使用`required`来修饰了。
 因为这样的类不能被继承子类。
 
 */


class SomeSuperClass {
    init(someParameter: Int) {
        
    }
}


class SomeSubClass: SomeSuperClass, SomeInitProtocol {
    // `required` from Someprotocol conformance; `override` from SomeSuperClass
    required override init(someParameter: Int) {
        super.init(someParameter: someParameter)
    }
}



// MAKR: - 将协议作为类型

/**
 实际上协议自身并不实现功能。不过协议可以作为一个功能完备的类型在代码中使用。
 */

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides))
    }
}


// MARK: - 委托

/*
 委托是允许类或者结构体委托它们自身的某些自认给另外类型实例的设计模式。
 定义了一个封装了委托责任的协议来实现。遵循协议的类型来保证提供被委托的功能。
 */

protocol DiceGame {
    var dice: Dice { get }
    func play()
}


protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08
        board[06] = +11
        board[09] = +09
        board[10] = +02
        board[14] = -10
        board[19] = -11
        board[22] = -02
        board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        
        // 这是什么语法？？？？
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}


class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}


func test_diceGame() {
    let tracker = DiceGameTracker()
    let game = SnakesAndLadders()
    game.delegate = tracker
    game.play()
}

// MARK: - 在扩展里添加协议遵循
/*
 可以扩展一个已经存在的类型来遵循一个新的协议，就算是你无法访问现有类型的源代码也可以。
 扩展可以添加新的属性、方法、和下标都已经存在的类型。
 */



protocol TextRepresentable {
    var textualDescription: String { get }
}


extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}


extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}


// 有条件的遵循协议


extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}



// MARK: - 协议继承

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition gose here
}


protocol PrettyTextRepresentable {
    var prettyTextualDescription: String { get }
}


extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        
        return output
    }
}


// MARK: - 类专用的协议

/*
 通过添加 `AnyObject` 关键字到协议的继承列表，就可以限制协议只能被类类型遵循
 */

protocol SomeClassOnlyProtocol: AnyObject, TextRepresentable {
    
}



// MARK: - 协议组合


protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}


// 同时遵循 Named / Aged协议
struct Student: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthdat, \(celebrator.name), you’re \(celebrator.age)!")
}


class Location {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}


func beginconcert(in location: Location & Named) {
    print("Hello, \(location.name)")
}

func test_protocol_combined() {
    let stu = Student(name: "Malcolm", age: 21)
    wishHappyBirthday(to: stu)
    
    let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
    beginconcert(in: seattle)
}


// MARK: - 可选协议要求

/*
 
 可以给协议定义可选要求，这要求不需要强制遵循协议的类型实现。可选协议使用`optional`修饰符
 作为前缀放在协议的定义中。可选要求允许你的代码与OC操作。协议和可选要求必须使用`@objc`标志标记。
 注意`@objc`协议只能被继承OC类或者其他`@objc`类采纳。不能被结构体或者枚举采纳。
 
 注意：
 
 */

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}


class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}


// 普通的class就可以遵循 可选协议？？？？，可选协议定义时说需要继承NSObject类或者 `@objc`标志的类
class FourSource: CounterDataSource {
    let fixedIncrement = 4
    func increment(forCount count: Int) -> Int {
        return 4
    }
}



class TowardsZeroSource: CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

func test_optional_protocol() {
    let counter = Counter()
    
    print("==== ThreeSource ====")
    counter.dataSource = ThreeSource()
    for _ in 1...4 {
        counter.increment()
        print(counter.count)
    }
    
    counter.count = 4
    print("==== TowardsZeroSource ====")
    counter.dataSource = TowardsZeroSource()
    for _ in 1...5 {
        counter.increment()
        print(counter.count)
    }
}


// MARK: - 协议扩展

/*
 通过给协议创建扩展，所有遵循协议的类型自动获得这个方法的实现而不需要额外的修改。
 */

extension RandomNumberGenerator {
    func randomBool()-> Bool {
        return random() > 0.5
    }
}

func test_protocol_extension() {
    print("==== protocol_extension ====")
    
    let generator = LinearCongruentialGenerator()
    print("Here'is a random number: \(generator.random())")
    
    print("And here's a random Boolean: \(generator.randomBool())")
}




extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}


