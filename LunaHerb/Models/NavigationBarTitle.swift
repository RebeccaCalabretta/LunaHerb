//
//  NavigationBarTitle.swift
//  LunaHerb
//
//  Created by Rebecca Calabretta on 19.03.25.
//

import SwiftUI

struct NavigationBarTitle {
    static func setupNavigationBarAppearance() {
        let font = UIFont(name: "Pompiere-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24)
                let textColor = UIColor(named: "titleText") ?? UIColor.white
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor
        ]
    }
}
