//
//  MainViewCell.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class MenuViewCell: UICollectionViewCell {

    // MARK: - Outlets
    static let reuseId = "MainViewCell"

    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.1803921569, green: 0.3529411765, blue: 1, alpha: 1)
        label.font = UIFont.halantRegular(size: 20)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers functions
    private func configureUI() {
        layer.cornerRadius = 90 / 2
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
        }
    }
}
