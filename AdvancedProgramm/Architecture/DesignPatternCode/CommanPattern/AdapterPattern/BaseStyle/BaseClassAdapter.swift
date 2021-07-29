//
//  BaseClassAdapter.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/28.
//

import Cocoa

class BaseClassAdapter: BaseAdaptee, BaseAdapterProtocol {

    func getRMB() -> Float {
        self.getUSA() * 6.5
    }
    
}
