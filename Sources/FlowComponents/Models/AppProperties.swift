//
//  AppProperties.swift
//
//
//  Created by BoiseITGuru on 12/2/23.
//

import Foundation
import Observation

@Observable
public class AppProperties {
    public var isLandscape: Bool
    public var isiPad: Bool
    public var isSplit: Bool
    public var isMaxSplit: Bool
    public var size: CGSize
    
    public init(isLandscape: Bool, isiPad: Bool, isSplit: Bool, isMaxSplit: Bool, size: CGSize) {
        self.isLandscape = isLandscape
        self.isiPad = isiPad
        self.isSplit = isSplit
        self.isMaxSplit = isMaxSplit
        self.size = size
    }
}
