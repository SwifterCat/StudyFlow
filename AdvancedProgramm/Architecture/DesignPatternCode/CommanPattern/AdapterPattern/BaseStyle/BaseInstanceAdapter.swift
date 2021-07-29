//
//  BaseAdapter.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/28.
//

import Foundation

// 这种方式对象适配器，我们保留了一个被适配者的引用

class BaseInstanceAdapter: NSObject, BaseAdapterProtocol {
    
    let adaptee: BaseAdaptee = BaseAdaptee()
    
    func getRMB() -> Float {
        adaptee.getUSA() * 6.5
    }
    
}
