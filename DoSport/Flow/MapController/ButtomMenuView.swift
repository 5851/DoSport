//
//  BottomMenuView.swift
//  DoSport
//
//  Created by MAC on 03.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

protocol ButtomMenuViewDelegate: class {
    func launchSideMenu()
}

class ButtomMenuView: UIView {

    // MARK: - Ouptlets
    private let typeSportButton: UIButton = {
        let button = UIButton(title: "Вид спорта", background: .white, heigth: 50, width: 150, isShadow: false)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4470588235, blue: 0.8901960784, alpha: 1), for: .normal)
        return button
    }()
    private let adressButton: UIButton = {
        let button = UIButton(title: "Адрес", background: .white, heigth: 50, width: 150, isShadow: false)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4470588235, blue: 0.8901960784, alpha: 1), for: .normal)
        return button
    }()
    private let nameButton: UIButton = {
        let button = UIButton(title: "Название", background: .white, heigth: 50, width: 150, isShadow: false)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4470588235, blue: 0.8901960784, alpha: 1), for: .normal)
        return button
    }()
    private let createButton: UIButton = {
        let button = UIButton(title: "Создать", background: #colorLiteral(red: 0.2941130996, green: 0.6454226375, blue: 1, alpha: 1), heigth: 50, width: 150, isShadow: false)
        button.addTarget(self, action: #selector(createTypeSport), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: - Properties
    weak var delegate: ButtomMenuViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainBlue
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc func createTypeSport() {
        delegate?.launchSideMenu()
    }
}

// MARK: - SetupUI
extension ButtomMenuView {
    private func setupUI() {
        self.snp.makeConstraints { (make) in
            make.height.equalTo(180)
        }

        let topStack = UIStackView(arrangedSubviews: [
            typeSportButton, adressButton
        ])
        topStack.distribution = .fillEqually
        topStack.spacing = 10
        let bottomStack = UIStackView(arrangedSubviews: [
            nameButton, createButton
        ])
        bottomStack.distribution = .fillEqually
        bottomStack.spacing = 10
        let overallStack = UIStackView(arrangedSubviews: [
            topStack, bottomStack
        ])
        overallStack.axis = .vertical
        overallStack.spacing = 20
        addSubview(overallStack)
        overallStack.snp.makeConstraints { (make) in
            make.top.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
        }
    }
}
