//
//  PageViewCell.swift
//  DoSport
//
//  Created by MAC on 12.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class PageViewCell: UICollectionViewCell {

    // MARK: - Outlets
    static let reuseId = "PageViewCell"

    var page: PageModel? {
        didSet {
            guard let page = page else { return }
            imageView.image = UIImage(named: page.imageName)
            textLabel.text = page.textDescription
        }
    }

    private let commonOval: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.4, blue: 0.8470588235, alpha: 0.84)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 6, height: 6)
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "map")
        imageView.backgroundColor = .clear
        return imageView
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.halantRegular(size: 20)
        label.textColor = .white
        label.numberOfLines = 0
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
        addSubview(commonOval)
        commonOval.addSubview(imageView)
        commonOval.addSubview(textLabel)

        commonOval.snp.makeConstraints { (make) in
            make.top.equalTo(130)
            make.bottom.equalTo(-100)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(commonOval).offset(10)
            make.width.equalTo(360)
            make.height.equalTo(360)
            make.centerX.equalTo(commonOval)
        }

        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalTo(commonOval).offset(20)
            make.right.equalTo(commonOval).offset(-20)
        }
    }
}
