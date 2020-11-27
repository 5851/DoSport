//
//  TypeSportsCell.swift
//  DoSport
//
//  Created by MAC on 26.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class TypeSportsCell: UICollectionViewCell {

    // MARK: - Properties
    static var resuseId = "TypeSportsCell"

    // MARK: - Oulets
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        return view
    }()
    private let imageViewSport: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? #colorLiteral(red: 0.1457747817, green: 0.5690770149, blue: 0.9917067885, alpha: 1) : UIColor.mainBlue
        }
    }
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? #colorLiteral(red: 0.1457747817, green: 0.5690770149, blue: 0.9917067885, alpha: 1) : UIColor.mainBlue
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

    // MARK: - Configure Cell
    func configure(model: SectionCellModel) {
        imageViewSport.image = model.imageCell
        titleLabel.text = model.titleCell
    }

    // MARK: - Setup UI
    private func configureUI() {
        self.backgroundColor = .mainBlue
        self.layer.cornerRadius = 5

        view.addSubview(imageViewSport)
        imageViewSport.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.leading.equalTo(view).offset(15)
        }

        let stackView = UIStackView(arrangedSubviews: [
            view, titleLabel
        ])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 15
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.top).offset(30)
        }
    }
}
