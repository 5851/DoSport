//
//  SectionModel.swift
//  DoSport
//
//  Created by MAC on 26.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class SectionCellModel: Hashable {

    let titleCell: String
    let imageCell: UIImage

    init(titleCell: String, imageCell: UIImage) {
        self.titleCell = titleCell
        self.imageCell = imageCell
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(titleCell)
    }

    static func == (lhs: SectionCellModel, rhs: SectionCellModel) -> Bool {
        return lhs.titleCell == rhs.titleCell
    }
}
