//
//  Array+find.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/15/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

public extension Array {
    func find(block:Element->Bool) -> (data: Element?, index:Int) {
        let length = self.count
        let idx = -1;
        
        for (var i = 0; i < length; i++) {
            if block(self[i]) {
                return (data: self[i], index: i)
            }
        }
        
        return (data: nil, index:idx)
    }
}
