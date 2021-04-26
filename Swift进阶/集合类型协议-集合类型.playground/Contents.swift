import UIKit

var str = "Hello, playground"

/**
 集合类型：
 指的是那些稳定的序列，它们能够被多次遍历且保持一致。除了线性遍
 历以外，集合中的元素也可以通过下标索引的方式被获取到。
 
 */

/**
 自定义的集合类型
 */

/// ⼀个能够将元素⼊队和出队的类型
protocol Queue {
    /// 在 `self` 中所持有的元素的类型
    associatedtype Element
    /// 将 `newElement` ⼊队到 `self`
    mutating func enqueue(_ newElement: Element)
    /// 从 `self` 出队⼀个元素
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>: Queue {
    private var left:[Element] = []
    private var right:[Element] = []
    
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.last
    }
}

extension FIFOQueue: Collection {
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }
    
    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    public subscript(position: Int) -> Element { precondition((0..<endIndex).contains(position), "Index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
}

var q = FIFOQueue<String>()
for x in ["1", "2", "foo", "3"] {
    q.enqueue(x)
}

for s in q {
    print(s, terminator: " ")
}

//调用sequence的扩展方法和属性
q.map { $0.uppercased()}
q.filter { $0.count > 1 }

//调用collection的扩展方法和属性
q.isEmpty
q.count
q.first

let queue: FIFOQueue = [1, 2, 3]

/**
 遵守 ExpressibleByArrayLiteral 协议
 当实现一个类似队列这样的集合类型时，最好也去实现一下 ExpressibleByArrayLiteral。这可
 以让用户能够以他们所熟知的 [value1, value2, etc] 语法创建一个队列
 
 */

extension FIFOQueue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }
}

/**
 字面量
 字面量和类型是由区别的，例如let arr = [1, 2, 3],这是一个数组字面量，而其元素类型为Int.
 */


/**
 索引
 索引表示了集合中的位置。每个集合都有两个特殊的索引值，startIndex 和 endIndex。
 startIndex 指定集合中第一个元素，endIndex 是集合中最后一个元素之后的位置。
 */


/**
 索引失效:
 1. 索引存在，但指向另一个引用
 2. 索引不存在
 */

/**
 切片
 所有的集合类型都有切片操作的默认实现，并且有一个接受 Range<Index> 作为参数的下标方
 法。
 
 */

/**
 切片与原集合共享索引
 集合类型和它的切片拥有相同的索引。只要集合和它的切片在切片被创建后没有改变，
 切片中某个索引位置上的元素，应当也存在于原集合中同样的索引位置上。
 */

let cities = ["New York", "Rio", "London", "Berlin", "Rome", "Beijing", "Tokyo", "Sydney"]
let slice = cities[2...4]
cities.startIndex // 0
cities.endIndex // 8
slice.startIndex // 2
slice.endIndex // 5

struct PrefxIterator<Base: Collection>: IteratorProtocol, Sequence {
    let base: Base
    var offset: Base.Index
    init(_ base: Base) {
        self.base = base
        self.offset = base.startIndex
    }
    mutating func next() -> Base.SubSequence? {
        guard offset != base.endIndex else { return nil }
        base.formIndex(after: &offset)
        return base.prefix(upTo: offset)
    }
}

/**
 专⻔的集合类型
 → BidirectionalCollection — “一个既支持前向又支持后向遍历的集合。”
 → RandomAccessCollection — “一个支持高效随机存取索引遍历的集合。”
 → MutableCollection — “一个支持下标赋值的集合。”
 → RangeReplaceableCollection — “一个支持将任意子范围的元素用别的集合中的元素
 进行替换的集合。”
 
 */

extension BidirectionalCollection {
    /// 集合中的最后⼀个元素。
 public var last: Element? {
    return isEmpty ? nil : self[index(before: endIndex)]
 }
}
