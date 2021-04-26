import UIKit

var str = "Hello, playground"

/**
 序列 Sequence
 Sequence 协议是集合类型结构中的基础。一个序列 (sequence) 代表的是一系列具有相同类型
 的值，你可以对这些值进行迭代。
 */

struct CountDownItertator: IteratorProtocol {
    let countDown: CountDown
    
    private var times = 0
    
    init(countDown: CountDown) {
        self.countDown = countDown
    }
    
    mutating func next() -> Int? {
        let nextNumber = countDown.start - times
        guard nextNumber > 0 else {
            return nil
        }
        defer {
            times += 1
        }
        return nextNumber
    }
    
}

struct CountDown: Sequence {
    var start = 0
    
    init(start: Int) {
        self.start = 0
    }
    
    func makeIterator() -> CountDownItertator {
        return CountDownItertator(countDown: self)
    }
}

/**
 迭代器
 迭代器是单向结构，只能按照增加的方向前进，不能倒退或者重置。不过我们可以创建一个unlimited interator.
 实现迭代器的时候，我们可以不用显示的指明Element的type,编译器能通过next()的返回值类型来推断出Element的类型。
 */

struct FibsIterator: IteratorProtocol {
    var state = (0,1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

struct FibsSequence: Sequence {
    let state: (Int, Int)
    
    func makeIterator() -> FibsIterator {
        return FibsIterator(state: state)
    }
}

let fibsSequence = FibsSequence(state:( 0, 1))
var fibsIterator = fibsSequence.makeIterator()
// 这将会导致无限循环，最终程序崩溃
//while let fib = fibsIterator.next() {
//    print(fib)
//}

/**
 迭代器和值语义
 我们至今为止所看到的迭代器都具有值语义。如果你复制一份，迭代器的所有状态也都会被复
 制，这两个迭代器将分别在自己的范围内工作，这是我们所期待的。标准库中的大部分迭代器
 也都具有值语义，不过也有例外存在。
 
 */

let seq = stride(from: 0, to: 10, by: 1)
var i1 = seq.makeIterator()
i1.next() // Optional(0)
i1.next() // Optional(1)
//此时i1准备返回2，我们对它进行复制
var i2 = i1
//现在原有的迭代器和新复制的迭代器是分开且独立的了，在下两次 next 时，它们分别都会返回2 和 3：
i1.next() // Optional(2)
i1.next() // Optional(3)
i2.next() // Optional(2)
i2.next() // Optional(3)

var i3 = AnyIterator(i1)
var i4 = i3

/*
 在这种情况下，原来的迭代器和复制后的迭代器并不是独立的，因为实际的迭代器不再是一个
结构体，AnyIterator 并不具有值语义。AnyIterator 中用来存储原来迭代器的盒子对象是一个
类实例，当我们将 i3 赋值给 i4 的时候，只有对这个盒子的引用被复制了。盒子里存储的对象将
被两个迭代器所共享。所以，任何对 i3 或者 i4 进行的调用，都会增加底层那个相同的迭代器的
取值：
 */

i3.next() // Optional(4)
i4.next() // Optional(5)
i3.next() // Optional(6)
i3.next() // Optional(7)


func fibsAnyIterator() -> AnyIterator<Int> {
    var state = (0, 1)
    
    func next() -> Int {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
    return AnyIterator {
        return  next()
    }
}

let fibsSequence2 = sequence(state: (0,1)) { (state:inout(Int, Int)) -> Int? in
    let upcomingNumber = state.0
    state = (state.1, state.0 + state.1)
    return upcomingNumber
}

/**
 sequence(first:next:) 和 sequence(state:next:) 的返回值类型是 UnfoldSequence。
 这个术语来自函数式编程，在函数式编程中，这种操作被称为展开 (unfold)。sequence
 是和 reduce 对应的 (在函数式编程中 reduce 又常被叫做 fold)。reduce 将一个序列
 缩减 (或者说折叠) 为一个单一的返回值，而 sequence 则将一个单一的值展开形成一
 个序列。
 
 */

/**
 sequence 对于 next闭包的使用是被延迟的。
 也就是说，序列的下一个值不会被预先计算，它只在调用者需要的时候生成。
 这使得我们可以使用类似fibsSequence2.preĩx(10) 这样的语句，因为 preĩx(10)只会向序列请求它的前十个元素，然后停止。如果序列是主动计算它的所有值的话，因为序列是无限的，程序将会在有机会执行下一步之前就因为整数溢出的问题而发生崩溃。
 对于序列和集合来说，它们之间的一个重要区别就是序列可以是无限的，而集合则不行。
 */


/**
 Sequence 协议并不关心遵守该协议的类型是否会在迭代后将序列的元素销毁。也就
 是说，请不要假设对一个序列进行多次的 for-in 循环将继续之前的循环迭代或者是从
 头再次开始：
 for element in sequence { if ... some condition { break } }
 for element in sequence { // 未定义⾏为 }
 */


/**
 链表
 */

enum List<Element> {
    case end
    //  indirect 关键字可以告诉编译器这个枚举值 node 应该被看做引用
    indirect case node(Element, next:List<Element>)
}

let emptyList = List<Int>.end
let oneElementList = List.node(1, next:emptyList)

extension List {
    func cons(_ x: Element) -> List  {
        return .node(x, next: self)
    }
}

let list = List<Int>.end.cons(1).cons(2).cons(3)
print("\(list)")

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}
let list2: List = [3,2,1]

extension List {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }
    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
}

var stack: List<Int> = [3,2,1]
var a = stack
var b = stack
a.pop() // Optional(3)
a.pop() // Optional(2)
a.pop() // Optional(1)
stack.pop() // Optional(3)
stack.push(4)
b.pop() // Optional(3)
b.pop() // Optional(2)
b.pop() // Optional(1)
stack.pop() // Optional(4)
stack.pop() // Optional(4)
stack.pop() // Optional(2)
stack.pop() // Optional(1)
