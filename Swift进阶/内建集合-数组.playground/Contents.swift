import UIKit

var str = "Hello, playground"

/**
 数组和可变性
 数组是具有值语义的，当对它进行赋值的时候，只是对另一个数组的内容进行复制，原数组不受被赋值数组的影响，当然在函数中传递数组也是一样的道理。这相对OC是有区别的。
 数组复制使用了"写时复制"技术，只有在有必要的时候才对数据进行赋值，不然都将共享内部的存储。
 */

/************** Quize 1**************/
var x = [1, 2, 3]
var y = x
y.append(4)
//y [1, 2, 3, 4]
//x [1, 2, 3]

/************** Quize 2**************/
let a = NSMutableArray(array: [1, 2, 3])
// 我们不想让 b 发⽣改变
let b: NSArray = a
// 但是事实上它依然能够被 a 影响并改变
a.insert(4, at: 3)
//b  ( 1, 2, 3, 4)
//正确的方式
let c = NSMutableArray(array: [1,2,3])
// 我们不想让 d 发⽣改变
let d = c.copy() as! NSArray
c.insert(4, at: 3)
//d ( 1, 2, 3 )

/**
数组和可选值
swift3 移除了传统的for循环检索元素。
swift数组没有给定可选值的选项，因为没有必要，也防止开发者做强制解包形成习惯。
无效的下标操作会造成可控的崩溃，有时候这种行为可能会被叫做不安全，但是这只
是安全性的一个方面。下标操作在内存安全的意义上是完全安全的，标准库中的集合
总是会执行边界检查，并禁止那些越界索引对内存的访问。
*/

/**
数组变形
*/

/************** Quize 3**************/
let fibs = [0, 1, 1, 2, 3, 5]
let squares = fibs.map { $0*$0 }
//squares [0, 1, 1, 4, 9, 25]

extension Array {
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

/**
使用函数将行为参数化
map 可以将模板代码分离出来，这些模板代码并不会随着每次调用发生变动，发生变动的是那
些功能代码，也就是如何变换每个元素的逻辑代码。map 函数通过接受调用者所提供的变换函
数作为参数来做到这一点。
行为进行参数化的设计模式
*/

extension Sequence {
    func last(where predicate: (Element) -> Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

/**
可变和带有状态的闭包
闭包是指那些可以捕获自身作用域之外的变量的函数
 
*/
extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map {
            next in running = nextPartialResult(running, next)
            return running
        }
    }
}

[1,2,3,4].accumulate(0, +) // [1, 3, 6, 10]
//filter的内部实现
extension Array {
    func filter(_ isIncluded:(Element)->Bool) -> [Element] {
        var result:[Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
    }
}

extension Sequence {
    func all(matching predicte:(Element)->Bool) -> Bool {
        return !contains{!predicte($0)}
    }
}

//reduce 内部实现
let sum = fibs.reduce(0, +)

extension Array {
    func reduce<Result>(_ initialResult: Result, _ nextParticalResult:(Result, Element)->Result) -> Result {
        var result = initialResult
        for x in self {
            result = nextParticalResult(result,x)
        }
        return result
    }
}
//使用reduce实现map和fileter
extension Array {
    func map2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([]) { $0 + [transform($1)]
        }
    }
    
    func flter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) { isIncluded($1) ? $0 + [$1] : $0 }
    }
}

extension Array {
    func flter3(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce(into: []) { result, element in if isIncluded(element) {}}
    }
}

//filter map
extension Array {
    func fatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for x in self { result.append(contentsOf: transform(x)) }
        return result
    }
}

//此时会将所有的数据都打印出来，因为return语句只是从闭包中返回出来，而不是中止循环
(1..<10).forEach {
    print("\($0)")
    if $0 > 2 {return}
}

/*数组类型
 切片:
 我们使用切片方式,原数组将返回一个切片 (slice)，其中包含了原数组中从第二个元素开始的所有部分。得到的
 结果的类型是 ArraySlice，而不是 Array。切片类型只是数组的一种表示方式,它背后的数据仍
 然是原来的数组，二者共用共同的内存数组, 只不过是用切片的方式来进行表示。
 
 桥接:
 因为 NSArray 只能持有对象，所以对 Swift 数组进行桥接转换时，编译器和
 运行时会自动把不兼容的值 (比如 Swift 的枚举) 用一个不透明的 box 对象包装起来。不少值类
 型 (比如 Int，Bool 和 String，甚至 Dictionary 和 Set) 将被自动桥接到它们在 Objctive-C 中所
 对应的类型。
 
 */

let slice = fibs[1...]
slice // [1, 1, 2, 3, 5]
type(of: slice) // ArraySlice<Int>

// 切片转换为数组
let newArray = Array(slice)
type(of: newArray) // Array<Int>
