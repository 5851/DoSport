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
        label.textColor = #colorLiteral(red: 0.1803921569, green: 0.3529411765, blue: 1, alpha: 1)
        label.font = UIFont.halantRegular(size: 20)
        label.textAlignment = .left
        return label
    }()

    lazy var viewCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override var isHighlighted: Bool {
        didSet {
            viewCircle.backgroundColor = isHighlighted ? #colorLiteral(red: 0.2595242858, green: 0.4154637456, blue: 0.9985032678, alpha: 1) : #colorLiteral(red: 0.9865223765, green: 0.9866868854, blue: 0.9667844176, alpha: 1)
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

        let stackView = UIStackView(arrangedSubviews: [
            viewCircle, textLabel
        ])
        stackView.alignment = .center
        stackView.spacing = 15
        viewCircle.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
        }
        viewCircle.layer.cornerRadius = 30/2
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
        }
    }
}
