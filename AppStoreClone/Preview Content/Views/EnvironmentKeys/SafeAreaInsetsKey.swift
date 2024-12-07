//
//
// SafeAreaInsetsKey.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
