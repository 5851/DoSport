//
//  NavigationBar.swift
//  DoSport
//
//  Created by MAC on 26.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class NavigationBar: UIView {

    // MARK: - Outlets
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let personalButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "avatar"), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.mainBlue.cgColor
        button.layer.borderWidth = 3
        return button
    }()
    private let personalTitle: UILabel = {
        let label = UILabel()
        label.text = "Личный кабинет"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = #colorLiteral(red: 0, green: 0.337254902, blue: 0.6745098039, alpha: 1)
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
        self.backgroundColor = .white
        self.layer.zPosition = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 6)

        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(120)
        }

        self.snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }

        addSubview(personalButton)
        personalButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerY.equalTo(imageView.snp.centerY)
            make.trailing.equalTo(self).offset(-50)
        }

        addSubview(personalTitle)
        personalTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(personalButton.snp.centerX)
            make.top.equalTo(personalButton.snp.bottom).offset(5)
        }
    }
}
