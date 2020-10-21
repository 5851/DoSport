//
//  RecoveryPasswordController.swift
//  DoSport
//
//  Created by MAC on 21.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class RecoveryPasswordController: UIViewController {

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        imageView.widthAnchor.constraint(equalToConstant: 141).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    private let descriptionView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 15
        return view
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel(
            title: "Вы забыли пароль?\nИнструкция по изменению пароля",
            textAlignment: .left,
            textColor: .white, numberOfLines: 0, fontSize: 18)
        return label
    }()
    private let checkCodeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)
        button.setImage(UIImage(
            systemName: "circle.fill",
            withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleCheckTapped), for: .touchUpInside)
        return button
    }()
    private let checkPasswordButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)
        button.setImage(UIImage(
            systemName: "circle.fill",
            withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleCheckTapped), for: .touchUpInside)
        return button
    }()
    private let emailTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Адрес эл. почты")
    private let numberTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Код")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Actions
    @objc private func dismissController() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func handleCheckTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            sender.isSelected = !sender.isSelected
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = .identity
            })
        })
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)
        if sender.isSelected {
            sender.setImage(UIImage(
                systemName: "checkmark.circle.fill",
                withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .selected)
        } else {
            sender.setImage(UIImage(
                systemName: "circle.fill",
                withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        }
    }
}

// MARK: - SetupUI
extension RecoveryPasswordController {
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
        let topStackView = UIStackView(arrangedSubviews: [
            backButton, logoImageView
        ])
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        topStackView.spacing = 30
        view.addSubview(topStackView)
        topStackView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view).offset(20)
        }

        view.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(topStackView.snp.bottom).offset(40)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.height.equalTo(200)
        }
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(descriptionView).offset(20)
            make.trailing.equalTo(descriptionView).offset(-20)
        }

        checkCodeButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }

        let passwordStackView = UIStackView(arrangedSubviews: [
            emailTextField, checkCodeButton
        ])
        view.addSubview(passwordStackView)
        passwordStackView.spacing = 30
        passwordStackView.alignment = .center
        passwordStackView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom).offset(50)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
        }

        numberTextField.snp.makeConstraints { (make) in
            make.width.equalTo(200)
        }
        checkPasswordButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }
        let codeStackView = UIStackView(arrangedSubviews: [
            numberTextField, checkPasswordButton, UIView()
        ])
        codeStackView.spacing = 30
        codeStackView.alignment = .center
        view.addSubview(codeStackView)
        codeStackView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordStackView.snp.bottom).offset(50)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
        }
    }
}
