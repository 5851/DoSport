//
//  MenuHeaderCell.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class MenuHeaderCell: UICollectionReusableView {

    // MARK: - Properties
    static let reuseId = "MenuHeaderCell"

    // MARK: - Outlets
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.halantRegular(size: 20)
        label.textAlignment = .left
        label.text = "Регистрация"
        return label
    }()

    let switchView = CustomSwitch(frame: .init(x: 0, y: 0, width: 65, height: 30))

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupUI
    private func configureUI() {
        addSubview(switchView)
        addSubview(textLabel)

        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        switchView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        switchView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        switchView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: switchView.leadingAnchor, constant: -15).isActive = true
    }
}
