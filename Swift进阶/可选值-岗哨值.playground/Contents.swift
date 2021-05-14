import UIKit

var str = "Hello, playground"

/**
 岗哨值
 函数返回一个魔法数来表示并没有返回真实的值。
 */

/**
 通过枚举解决魔法数的问题
 */

//enum Optional<Wrapped> {
//    case none
//    case some(Wrapped)
//}


extension Collection where Element: Equatable {
    
    func index(of element: Element) -> Optional<Index> {
        var idx = startIndex
        while idx != endIndex {
            if self[idx] == element {
                return .some(idx)
            }
            formIndex(after: &idx)
        }
        return .none
    }
}

var array = ["one", "two", "three"]
let index = array.index(of: "one")
// 编译错误：remove(at:) 接受 Int，⽽不是 Optional<Int>
//array.remove(at: index)

switch index {
case .some(let idx):
    array.remove(at: idx)
case .none:
    break
}

/**
 可选值概览
 if let 用法
 使用if let 方法来解包，condition是一个bool值，我们可以关联多个condition,后面的condition可以基于前面的condition
 在if let绑定之前需要执行某个检查的话，可以为if提供一个前置条件。
 
 开发者可以在同一个if中将可选值绑定，布尔语句和case let混合并匹配起来使用。
 
 while let
 与if let非常相似，终止条件为nil. 而且也可以在可选绑定之后添加一个布尔值语句。
 */

if let idx = array.index(of: "one") {
    array.remove(at: idx)
}

while let line = readLine() {
    print(line)
}

var functions:[()->Int] = []
for i in 1...3 {
    functions.append {i}
}

for f in functions {
    print("\(f())")
}


/**
 双重可选值
 一个可选值本身也可以被另一个可选值包装起来，这就是我们说的双重可选值。
 
 */
let stringNumber = ["1", "2", "three"]
let maybeInts = stringNumber.map { Int($0) }

for maybeInt in maybeInts {
    print("\(maybeInt)")
}

for case let i? in maybeInts {
    print("\(i)")
}

for case let .some(i) in maybeInts {
    print("\(i)")
}

struct Pattern {
    let s: String
    init(_ s:String) {self.s = s}
}

func ~=(pattern: Pattern, value: String) -> Bool {
    return value.range(of: pattern.s) != nil
}

let s = "Taylor Swift"
if case Pattern("Swift") = s{
    print("\(String(reflecting: s)) contains Swift")
}

/**
 if var and while var
 使用var我们可以在语句块中改变变量了
 此时的变量是本地复制出来的，不会影响到原来的可选值。
 */
let number = "1"
if var i = Int(number) {
    i += 1
    print("\(i)")
}

/**
 解包后可选值的作用域
 我们只能在解包之后的语法块中使用被解包的变量。
 
 此时我们会使用gurad let来解决这个问题
 
 */

/**
 可选链
 在OC中，对nil发消息什么都不会发生。Swift中使用可选链能达到同样的效果。
 */

/**
 nil合并运算符
 如果可选值是nil的时候，我们可以使用一个默认的值来代替它。
 
 因为可选值是链接的，如果你要处理的是双重嵌套的可选值，并且想要使用 ?? 操作符的话，你
 需要特别小心 a ?? b ?? c 和 (a ?? b) ?? c 的区别。前者是合并操作的链接，而后者是先解包括
 号内的内容，然后再处理外层：
 
 let s1: String?? = nil // nil
 (s1 ?? "inner") ?? "outer" // inner
 let s2: String?? = .some(nil) // Optional(nil)
 (s2 ?? "inner") ?? "outer" // outer
 */

/**
 可选值不是指针！！！
 */


/**
 在字符串插值中使用可选值
 此时我们会受到来自编译器的警告，它是为了避免我们将Optional(...)显示到UI上。
 */

/**
 可选值map
 
 可选值flatMap
 
 */



