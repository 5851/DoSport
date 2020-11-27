//
//  PromotionSectionHeader.swift
//  DoSport
//
//  Created by MAC on 25.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class PromotionSectionHeader: UICollectionReusableView {

    // MARK: - Properties
    static var resuseId = "PromotionSectionHeader"

    // MARK: - Oulets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Спецпредложения"
        label.textColor = #colorLiteral(red: 0, green: 0.337254902, blue: 0.6745098039, alpha: 1)
        label.textAlignment = .left
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

    // MARK: - Setup UI
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.snp.topMargin).offset(20)
        }
    }
}
