//
//  MenuHeaderCell.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class MenuHeaderCell: UICollectionReusableView {

    // MARK: - Properties
    static let reuseId = "MenuHeaderCell"

    // MARK: - Outlets
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        imageView.widthAnchor.constraint(equalToConstant: 141).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    private let questButton: UIButton = {
        let button = UIButton(title: "Гостевой вход", background: #colorLiteral(red: 0.319616586, green: 0.5028756261, blue: 1, alpha: 1), isShadow: true)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

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
        let topStackView = UIStackView(arrangedSubviews: [
            logoImageView, UIView(), questButton
        ])
        self.addSubview(topStackView)
        topStackView.alignment = .center
        topStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
        }
    }
}
