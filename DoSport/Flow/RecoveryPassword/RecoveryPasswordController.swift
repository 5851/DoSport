//
//  RecoveryPasswordController.swift
//  DoSport
//
//  Created by MAC on 21.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

// Экран восстановления пароля
final class RecoveryPasswordController: UIViewController {

    // MARK: - Outlets
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        view.layer.borderColor = UIColor.mainBlue.cgColor
        view.layer.cornerRadius = 15
        return view
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel(
            title: "Вы забыли пароль?\nИнструкция по изменению пароля",
            textAlignment: .left,
            textColor: .black, numberOfLines: 0, fontSize: 18)
        return label
    }()

    private let getCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.halantRegular(size: 16)
        label.text = "Получить\nкод"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    private let getPasswardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.halantRegular(size: 16)
        label.text = "Получить пароль"
        return label
    }()
    private let enterCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.halantRegular(size: 16)
        label.text = "Введите код"
        return label
    }()

    private let checkCodeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)
        button.addTarget(self, action: #selector(handleCheckTapped), for: .touchUpInside)
        button.layer.borderColor = UIColor.mainBlue.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        return button
    }()
    private let checkPasswordButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)
        button.addTarget(self, action: #selector(handleCheckTapped), for: .touchUpInside)
        button.layer.borderColor = UIColor.mainBlue.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        return button
    }()
    private let emailTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Адрес эл. почты")
    private let numberTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Код")

    // MARK: - Init
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
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        if sender.isSelected {
            sender.setImage(UIImage(
                systemName: "checkmark",
                withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.mainBlue), for: .selected)
        }
    }
}

// MARK: - SetupUI
extension RecoveryPasswordController {
    private func setupUI() {
        view.backgroundColor = .white

        // Расположение кнопки назад и лого
        backButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
        }

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

        // Расположение описания восстановления пароля
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

        // Расположение стека email
        checkCodeButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }

        let emailStackView = UIStackView(arrangedSubviews: [
            emailTextField, checkCodeButton
        ])
        view.addSubview(emailStackView)
        emailStackView.alignment = .center
        emailStackView.spacing = 30
        emailStackView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom).offset(90)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
        }

        view.addSubview(getCodeLabel)
        getCodeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(checkCodeButton.snp.centerX)
            make.bottom.equalTo(checkCodeButton.snp.top).offset(-10)
        }

        // Расположение стека code
        numberTextField.snp.makeConstraints { (make) in
            make.width.equalTo(1500)
        }
        checkPasswordButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }
        let codeStackView = UIStackView(arrangedSubviews: [
            numberTextField, checkPasswordButton, UIView()
        ])
        codeStackView.spacing = 40
        codeStackView.alignment = .center
        view.addSubview(codeStackView)
        codeStackView.snp.makeConstraints { (make) in
            make.top.equalTo(emailStackView.snp.bottom).offset(90)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
        }

        view.addSubview(getPasswardLabel)
        view.addSubview(enterCodeLabel)
        enterCodeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(numberTextField.snp.centerX)
            make.bottom.equalTo(numberTextField.snp.top).offset(-10)
        }
        getPasswardLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(checkPasswordButton.snp.centerX)
            make.centerY.equalTo(enterCodeLabel.snp.centerY)
        }
    }
}
