//
//  MainMenuTabController.swift
//  DoSportProject
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

// Enum определяющий наименование и изображения иконок
// Также определяет типы контроллеров
enum TabItem: String, CaseIterable {

    case map = "Площадки"
    case places = "Залы"
    case schedule = "Расписание"
    case chat = "Чат"
    case bonus = "Акции"

    var viewController: UIViewController {
        switch self {
        case .map:
            return UINavigationController(rootViewController: PlacesViewController())
        case .places:
            return MapViewController()
        case .schedule:
            return UIViewController()
        case .chat:
            return UIViewController()
        case .bonus:
            return UIViewController()
        }
    }

    var icon: UIImage? {
        switch self {
        case .map:
            return UIImage(named: "mapTab")!
        case .places:
            return UIImage(named: "areas")!
        case .schedule:
            return UIImage(named: "schedule")!
        case .chat:
            return UIImage(named: "chat")!
        case .bonus:
            return UIImage(named: "bonus")!
        }
    }

    var displayTitle: String {
        return self.rawValue
    }
}
