//
//  StartViewController.swift
//  DoSportProject
//
//  Created by MAC on 11.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {

    // MARK: - Outlets
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.montserratBold(size: 64)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "DoSport  поможет тебе заняться любимым видом спорта вместе с друзьями. Подбери площадку  на карте города, поделись локацией с теми, кто разделяет твои интересы. Общайся в чате, встречайся и начинай играть, тренироваться.\n\nDoSport - это новые впечатления, новые друзья и твои любимые занятия в отличной компании."
        label.font = UIFont.halantRegular(size: 20)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .justified
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(title: "Начать", isShadow: true)
        button.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        setGradientBackground(colorTop: #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), colorBottom: .white)
    }

    // MARK: - Actions
    @objc private func handleStart(sender: UIButton) {
        let controller = PageViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers function
    private func generateAttributedString(title: String, description: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.foregroundColor: UIColor.red])
        attributedString.append(.init(string: description, attributes: [.foregroundColor: UIColor.white]))
        return attributedString
    }

    private func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 0.25, 1]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - SetupUI
extension StartViewController {

    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1)
        loginLabel.attributedText = generateAttributedString(title: "Do", description: "Sport")

        view.addSubview(loginLabel)
        view.addSubview(startButton)
        view.addSubview(descriptionLabel)

        loginLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(loginLabel.snp.bottom).offset(30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-40)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
}