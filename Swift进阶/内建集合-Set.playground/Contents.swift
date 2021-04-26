import UIKit

var str = "Hello, playground"

let naturals: Set = [1, 2, 3, 2]
naturals // [2, 3, 1]
naturals.contains(3) // true
naturals.contains(0) // false

/**
 集合代数
 集合 Set 和数学概念上的集合有着紧密关系；Set 也支持你在高中数学中学到的那
 些基本集合操作。
 */

let iPods: Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffe", "iPod Classic"]
let discontinuedIPods: Set = ["iPod mini", "iPod Classic", "iPod nano", "iPod shuffe"]

//补集
let currentIPods = iPods.subtracting(discontinuedIPods)

//交集
let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
let iPodsWithTouch = iPods.intersection(touchscreen)

//并集
var discontinued: Set = ["iBook", "Powerbook", "Power Mac"]
discontinued.formUnion(discontinuedIPods)

var indices = IndexSet()
indices.insert(integersIn: 1..<5)
indices.insert(integersIn: 11..<15)
let evenIndices = indices.filter {$0 % 2 == 0 }
evenIndices

extension Sequence where Element:Hashable {
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}

[1,2,3,12,1,3,4,5,6,4,6].unique() // [1, 2, 3, 12, 4, 5, 6]
