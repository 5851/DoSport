//
//  BottomMenuView.swift
//  DoSport
//
//  Created by MAC on 03.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ButtomMenuView: UIView {

    // MARK: - Ouptlets
    private let typeSportButton: UIButton = {
        let button = UIButton(title: "Вид спорта", background: #colorLiteral(red: 0.860845089, green: 0.898216784, blue: 0.9998374581, alpha: 1), heigth: 50, width: 150, isShadow: false)
        return button
    }()
    private let adressButton: UIButton = {
        let button = UIButton(title: "Адрес", background: #colorLiteral(red: 0.860845089, green: 0.898216784, blue: 0.9998374581, alpha: 1), heigth: 50, width: 150, isShadow: false)
        return button
    }()
    private let nameButton: UIButton = {
        let button = UIButton(title: "Название", background: #colorLiteral(red: 0.860845089, green: 0.898216784, blue: 0.9998374581, alpha: 1), heigth: 50, width: 150, isShadow: false)
        return button
    }()
    private let createButton: UIButton = {
        let button = UIButton(title: "Создать", background: #colorLiteral(red: 1, green: 0.9547553658, blue: 0.5084705353, alpha: 1), heigth: 50, width: 150, isShadow: false)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
