//
//  Double+Extension.swift
//  Journal
//
//  Created by Jill Allan on 13/10/2023.
//

import Foundation

extension Double {
    static func midRange(of doubles: [Double]) -> Double? {
        let min = doubles.min()
        let max = doubles.max()
        
        if let min,
            let max {
            return (min + max) / 2
        } else {
            return nil
        }
    }
    
    static func range(of doubles: [Double]) -> Double? {
        let min = doubles.min()
        let max = doubles.max()
        
        if let min,
            let max {
            return max - min
        } else {
            return nil
        }
    }
}
