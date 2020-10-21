//
//  MainMenuTabController.swift
//  DoSportProject
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

enum TabItem: String, CaseIterable {
    case mainMenu = "Главное\nменю"
    case chat = "Чат"
    case privatCabinet = "Личный\nкабинет"

    var viewController: UIViewController {
        switch self {
        case .mainMenu:
            return UINavigationController(rootViewController: MenuViewController())
        case .chat:
            return RecoveryPasswordController()
        case .privatCabinet:
            return UIViewController()
        }
    }

    var icon: UIImage? {
        switch self {
        case .mainMenu:
            return UIImage(named: "icon_menu")!
        case .chat:
            return UIImage(named: "icon_chat")!
        case .privatCabinet:
            return UIImage(named: "icon_cabinet")!
        }
    }

    var displayTitle: String {
        return self.rawValue
    }
}
