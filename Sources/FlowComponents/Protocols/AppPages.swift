//
//  AppPages.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/25/23.
//

import Foundation

public protocol AppPages: CaseIterable, Hashable, Codeable {
    var title: String { get }
    var image: Image { get }
    var view: some View { get }
}
