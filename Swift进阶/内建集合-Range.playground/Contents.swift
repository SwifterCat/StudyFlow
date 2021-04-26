import UIKit

var str = "Hello, playground"

/*
 Range
 范围代表的是两个值的区间，它由上下边界进行定义。你可以通过 ..< 来创建一个不包含上边界
 的半开范围，或者使用 ... 创建同时包含上下边界的闭合范围
 
 半开范围和闭合范围各有所用：
 → 只有半开范围能表达空间隔 (也就是下界和上界相等的情况，比如 5..<5)。
 → 只有闭合范围能包括其元素类型所能表达的最大值 (比如 0...Int.max)。而半开范围则要
 求范围上界是一个比自身所包含的最大值还要大 1 的值。
 */

// 0 到 9, 不包含 10
let singleDigitNumbers = 0..<10
Array(singleDigitNumbers) // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
// 包含 "z"
let lowercaseLetters = Character("a")...Character("z")

// 这些操作符还有一些前缀和后缀的变型版本，用来表示单边的范围：
let fromZero = 0...
let upToZ = ..<Character("z")

// 以检查某个元素是否存在于范围中
singleDigitNumbers.contains(9) // true
lowercaseLetters.overlaps("c"..<"f") // true

/*
可数范围
 CountableRange 和 Range 很相似，只不过它还需要一个附加约束：它的元素类型需要遵守
 Strideable协议 (以整数为步⻓)。Swift将这类功能更强的范围叫做可数范围，这是因为只有这
 类范围可以被迭代。

*/

/*
 部分范围
 部分范围 (partial range) 指的是将 ... 或 ..< 作为前置或者后置运算符来使用时所构造的范围。
 比如，0... 表示一个从 0 开始的范围。这类范围由于缺少一侧的边界，因此被称为部分范围。

*/

let fromA: PartialRangeFrom<Character> = Character("a")...
let throughZ: PartialRangeThrough<Character> = ...Character("z")
let upto10: PartialRangeUpTo<Int> = ..<10
let fromFive: CountablePartialRangeFrom<Int> = 5...

