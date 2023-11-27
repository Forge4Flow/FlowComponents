//
//  AppPages.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/25/23.
//

import SwiftUI
import Foundation

public protocol AppPages {
    var slug: String { get }
    var title: String { get }
    var image: Image { get }
    var view: any View { get }
}
