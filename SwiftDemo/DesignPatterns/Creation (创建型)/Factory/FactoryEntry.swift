//
//  FactoryEntry.swift
//  DesignPatterns
//
//  Created by Knox on 2021/12/19.
//  Copyright © 2021 luoquan. All rights reserved.
//

import Foundation

func factoryEntry() {
    
}



class RuleConfig {
    private let configText: String
    init(_ text: String) {
        configText = text
    }
}

protocol IRuleConfigParser {
    func parse(text: String) -> RuleConfig
}

class UndefinedRuleConfifParser: IRuleConfigParser {
    func parse(text: String) -> RuleConfig {
        return RuleConfig(text)
    }
}

class JsonRuleConfigParser: IRuleConfigParser {
    func parse(text: String) -> RuleConfig {
        return RuleConfig(text)
    }
}

class XmlRuleConfigParser: IRuleConfigParser {
    func parse(text: String) -> RuleConfig {
        return RuleConfig(text)
    }
}

class YamlRuleConfigParser: IRuleConfigParser {
    func parse(text: String) -> RuleConfig {
        return RuleConfig(text)
    }
}

class PropertiesRuleConfigParser: IRuleConfigParser {
    func parse(text: String) -> RuleConfig {
        return RuleConfig(text)
    }
}


// 简单工厂
struct SimpleFactory {
    
    class RuleConfigSource {
        
        func load(ruleConfigFilePath: String) -> RuleConfig {
            let fileExtension = getFileExtension(ruleConfigFilePath)
            // let parse = createParse(configFormat: fileExtension)
            // 简单工厂
            let parse = RuleConfigParserFactory.createParse(configFormat: fileExtension)
            let configText = ""
            let ruleConfig = parse.parse(text: configText)
            return ruleConfig
        }
        
        
        func getFileExtension(_ filePath: String) -> String {
            return "json"
        }
        
        // 将功能独立的代码封装成一个函数
        func createParse(configFormat: String) -> IRuleConfigParser {
            let parse: IRuleConfigParser
            if configFormat == "json" {
                parse = JsonRuleConfigParser()
            } else if configFormat == "xml" {
                parse = XmlRuleConfigParser()
            } else if configFormat == "yaml" {
                parse = YamlRuleConfigParser()
            } else if configFormat == "properties" {
                parse = PropertiesRuleConfigParser()
            } else {
                parse = UndefinedRuleConfifParser()
            }
            return parse
        }
    }
    
    /**
     为了让类的职责更加单一、代码更加清晰，把`createParse`剥离到一个独立的类中, 让这个类只负责对象的创建.
     这就是`简单工厂模式`
     
     大部分工厂类都是以`Factory`这个词结尾的，但也不是必须的。
     工厂类中的创建对象方法一般都是`create`开头
     
     优缺点分析:
     如果我们要添加新的 parser，那势必要改动到 RuleConfigParserFactory 的代码，那这是不是违反开闭原则呢？
     实际上，如果不是需要频繁地添加新的 parser，只是偶尔修改一下 RuleConfigParserFactory 代码，
     稍微不符合开闭原则，也是完全可以接受的。
     
     尽管简单工厂模式的代码实现中，有多处 if 分支判断逻辑，违背开闭原则，
     但权衡扩展性和可读性，这样的代码实现在大多数情况下（比如，不需要频繁地添加 parser，也没有太多的 parser）是没有问题的。
     */
    class RuleConfigParserFactory {
        
        static func createParse(configFormat: String) -> IRuleConfigParser {
            let parse: IRuleConfigParser
            if configFormat == "json" {
                parse = JsonRuleConfigParser()
            } else if configFormat == "xml" {
                parse = XmlRuleConfigParser()
            } else if configFormat == "yaml" {
                parse = YamlRuleConfigParser()
            } else if configFormat == "properties" {
                parse = PropertiesRuleConfigParser()
            } else {
                parse = UndefinedRuleConfifParser()
            }
            return parse
        }
    }
}

/**
    工厂方法 (Factory Method)
 */
protocol IRuleConfigParserFactory {
    func createParser() -> IRuleConfigParser
}

/*
 如果我们非得要将 if 分支逻辑去掉，那该怎么办呢？比较经典处理方法就是利用多态。
 按照多态的实现思路，对上面的代码进行重构
 
 */
struct FactoryMethod {
    
    class RuleConfigSource {
        
        func load_v1(ruleConfigFilePath: String) -> RuleConfig {
            let configFormat = getFileExtension(ruleConfigFilePath)
            let factory: IRuleConfigParserFactory
            if configFormat == "json" {
                factory = JsonRuleConfigParserFactory()
            } else if configFormat == "xml" {
                factory = XmlRuleConfigParserFactory()
            } else if configFormat == "yaml" {
                factory = YamlRuleConfigParserFactory()
            } else if configFormat == "properties" {
                factory = PropertiesRuleConfigParserFactory()
            } else {
                factory = UndefinedRuleConfigParserFactory()
            }
            let parse = factory.createParser()
            let configText = ""
            let ruleConfig = parse.parse(text: configText)
            return ruleConfig
        }
        
        /*
         从上面的代码实现来看，工厂类对象的创建逻辑又耦合进了 load() 函数中，
         跟我们最初的代码版本非常相似，引入工厂方法非但没有解决问题，
         反倒让设计变得更加复杂了。那怎么来解决这个问题呢？
         
         我们可以为工厂类再创建一个简单工厂，也就是工厂的工厂，用来创建工厂类对象
         
         */
        func load_v2(ruleConfigFilePath: String) -> RuleConfig {
            let configFormat = getFileExtension(ruleConfigFilePath)
            let factory = RuleConfigParserFactoryMap.getParserFactory(type: configFormat)
            let parse = factory.createParser()
            let configText = ""
            let ruleConfig = parse.parse(text: configText)
            return ruleConfig
        }
        
        
        func getFileExtension(_ filePath: String) -> String {
            return "json"
        }
    }
    
    class UndefinedRuleConfigParserFactory: IRuleConfigParserFactory {
        func createParser() -> IRuleConfigParser {
            return UndefinedRuleConfifParser()
        }
    }
    
    class JsonRuleConfigParserFactory: IRuleConfigParserFactory {
        func createParser() -> IRuleConfigParser {
            return JsonRuleConfigParser()
        }
    }
    
    class XmlRuleConfigParserFactory: IRuleConfigParserFactory {
        func createParser() -> IRuleConfigParser {
            return XmlRuleConfigParser()
        }
    }
    
    class YamlRuleConfigParserFactory: IRuleConfigParserFactory {
        func createParser() -> IRuleConfigParser {
            return YamlRuleConfigParser()
        }
    }
    
    class PropertiesRuleConfigParserFactory: IRuleConfigParserFactory {
        func createParser() -> IRuleConfigParser {
            return PropertiesRuleConfigParser()
        }
    }
    
    class RuleConfigParserFactoryMap {
        
        private static let undefinedFactory = UndefinedRuleConfigParserFactory()
        
        private static let cachedFacotories: [String:IRuleConfigParserFactory] = [
            "json": JsonRuleConfigParserFactory(),
            "xml": XmlRuleConfigParserFactory(),
            "yaml": YamlRuleConfigParserFactory(),
            "properties": PropertiesRuleConfigParserFactory()
        ]
        
        static func getParserFactory(type: String) -> IRuleConfigParserFactory {
            return cachedFacotories[type] ?? undefinedFactory
        }
    }
}

/*
 
 ### 简单工厂、工厂方法使用总结
 
 之所以将某个代码块剥离出来，独立为函数或者类，原因是这个代码块的逻辑过于复杂，剥离之后能让代码更加清晰，更加可读、可维护。
 但是，如果代码块本身并不复杂，就几行代码而已，我们完全没必要将它拆分成单独的函数或者类。
 
 当创建逻辑比较复杂，是一个“大工程”的时候，我们就考虑使用工厂模式，封装对象的创建过程，将对象的创建和使用相分离。
 何为创建逻辑比较复杂呢？我总结了下面两种情况。
 
 第一种情况：类似规则配置解析的例子，代码中存在 if-else 分支判断，动态地根据不同的类型创建不同的对象。
 针对这种情况，我们就考虑使用工厂模式，将这一大坨 if-else 创建对象的代码抽离出来，放到工厂类中。
 
 还有一种情况，尽管我们不需要根据不同的类型创建不同的对象，但是，单个对象本身的创建过程比较复杂，比如前面提到的要组合其他类对象，做各种初始化操作。
 在这种情况下，我们也可以考虑使用工厂模式，将对象的创建过程封装到工厂类中。

 */
