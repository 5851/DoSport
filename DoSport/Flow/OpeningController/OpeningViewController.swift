//
//  MainViewController.swift
//  DoSport
//
//  Created by MAC on 27.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class OpeningViewController: UIViewController {

    // MARK: - Outlets
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        return imageView
    }()
    private let enterAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход", for: .normal)
        return button
    }()
    private let regAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        return button
    }()
    private let questAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("Гостевой вход", for: .normal)
        return button
    }()

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI
extension OpeningViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(60)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }

        [enterAppButton, regAppButton, questAppButton].forEach { (button) in
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
            button.setBackgroundColor(#colorLiteral(red: 0.3615658879, green: 0.6828438044, blue: 0.9989137053, alpha: 1), for: .normal)
            button.setBackgroundColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .selected)
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }

        let stackView = UIStackView(arrangedSubviews: [
            enterAppButton, regAppButton, questAppButton
        ])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(40)
            make.trailing.equalTo(view).offset(-40)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
