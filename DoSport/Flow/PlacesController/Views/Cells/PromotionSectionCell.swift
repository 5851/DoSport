//
//  PromotionSectionCell.swift
//  DoSport
//
//  Created by MAC on 25.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class PromotionSectionCell: UICollectionViewCell {

    // MARK: - Properties
    static var resuseId = "PromotionSectionCell"

    // MARK: - Oulets
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.layer.cornerRadius = 5
        return view
    }()
    private let imageViewSport: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.337254902, blue: 0.6745098039, alpha: 1)
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

    // MARK: - Configure Cell
    func configure(model: SectionCellModel) {
        imageViewSport.image = model.imageCell
        titleLabel.text = model.titleCell
    }

    // MARK: - Setup UI
    private func configureUI() {

        view.addSubview(imageViewSport)
        imageViewSport.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.leading.equalTo(view).offset(10)
            make.bottom.equalTo(view).offset(-10)
        }

        view.addSubview(imageViewSport)
        imageViewSport.snp.makeConstraints { (make) in
            make.centerY.equalTo(view).offset(-10)
            make.centerX.equalTo(view)
        }

        let stackView = UIStackView(arrangedSubviews: [
            view, titleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 15
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
