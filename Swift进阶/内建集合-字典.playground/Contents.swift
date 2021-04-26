import UIKit

var str = "Hello, playground"

/**
 字典
 字典是无序的，当我们循环遍历字典的时候，顺序是不确定的。
 */

enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

//从下面我们可以看到，当使用下标方式来得到某个值得时候，返回的是可选值，当不存在的是将返回nil。
let defaultSettings: [String:Setting] = [ "Airplane Mode": .bool(false), "Name": .text("My iPhone")]
defaultSettings["Name"] // Optional(Setting.text("My iPhone"))


//可变性
var userSettings = defaultSettings
userSettings["Name"] = .text("Jared's iPhone")
userSettings["Do Not Disturb"] = .bool(true)

let nameValue = userSettings.removeValue(forKey: "Name")

let oldValue = userSettings.updateValue(.text("zhangyao"), forKey: "Do Not Disturb")

//有用的字典方法 使用merge方式合并两个字典中的相同key
var settings = defaultSettings
let overriddenSettings: [String:Setting] = ["Name": .text("Jane's iPhone")]
settings.merge(overriddenSettings, uniquingKeysWith: { $1 })
settings

extension Sequence where Element: Hashable {
    var frequencies: [Element:Int] {
        let frequencyPairs = self.map { ($0, 1) }
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}

let frequencies = "hello".frequencies // ["e": 1, "o": 1, "l": 2, "h": 1]
frequencies.filter { $0.value > 1 } // ["l": 2]

