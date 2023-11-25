//
//  File.swift
//
//
//  Created by Hao Fu on 29/11/2022.
//

import Foundation
import UIKit
import SafariServices

extension UIApplication {
    var topMostViewController: UIViewController? {
        let vc = UIApplication.shared.connectedScenes.filter {
            $0.activationState == .foregroundActive
        }.first(where: { $0 is UIWindowScene })
            .flatMap { $0 as? UIWindowScene }?.windows
            .first(where: \.isKeyWindow)?
            .rootViewController?
            .topMostViewController()

        return vc
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController? {
        // Check if the current presented view controller is not nil and not an SFSafariViewController
        if let presented = self.presentedViewController, !presented.isBeingDismissed, !(presented is SFSafariViewController) {
            return presented.topMostViewController()
        }

        // Additional checks for navigation and tab bar controllers
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }

        if let tab = self as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }

        // If none of the above, return self
        return self
    }
}
