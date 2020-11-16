//
//  MainViewCell.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class MenuViewCell: UICollectionViewCell {

    // MARK: - Outlets
    static let reuseId = "MainViewCell"

    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.halantRegular(size: 20)
        label.textAlignment = .center
        return label
    }()

    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor.mainBlue : UIColor.mainWhite
            self.textLabel.textColor = isHighlighted ? UIColor.mainWhite : .black
        }
    }

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
        layer.borderColor = UIColor.mainBlue.cgColor
        layer.borderWidth = 2

        let stackView = UIStackView(arrangedSubviews: [
            textLabel
        ])
        stackView.alignment = .center
        stackView.spacing = 15
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
        }
    }
}
