//
//  MainMenuCell.swift
//  DoSport
//
//  Created by MAC on 18.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class MainMenuCell: UICollectionViewCell {

    // MARK: - Properties
    static let reuseId = "MainMenuCell"
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? #colorLiteral(red: 0.2595242858, green: 0.4154637456, blue: 0.9985032678, alpha: 1) : #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
        }
    }
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? #colorLiteral(red: 0.2595242858, green: 0.4154637456, blue: 0.9985032678, alpha: 1) : #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
        }
    }

    // MARK: - Outlets
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.halantRegular(size: 15)
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
        backgroundColor = #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.top.equalTo(self).offset(14)
        }
    }
}
