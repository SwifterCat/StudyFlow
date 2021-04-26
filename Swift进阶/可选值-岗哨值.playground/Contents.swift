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



