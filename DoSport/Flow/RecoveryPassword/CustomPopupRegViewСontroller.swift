//
//  CustomAlertView.swift
//  DoSport
//
//  Created by MAC on 20.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

protocol CustomPopupRegViewСontrollerProtocol: class {
    /// Функция для изменения цвета BackgroundView TabBarVC
    func dismissBackgroundView()
}

class CustomPopupRegViewСontroller: UIViewController {

    // MARK: - Outlets
    private let backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(
            systemName: "xmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), for: .normal)
        button.addTarget(self, action: #selector(animationOut), for: .touchUpInside)
        return button
    }()
    private let regButton: UIButton = {
        let button = UIButton(title: "Регистрация", background: .mainBlue, heigth: 50, isShadow: false)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let textLabel = UILabel(title: "Пароль уже существует или получен вновь",
                                    textAlignment: .center,
                                    textColor: .black,
                                    numberOfLines: 0,
                                    fontSize: 18)
    private let emailTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Адрес эл. почты")
    private let passwordTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Пароль")
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Вы забыли пароль?", for: .normal)
        button.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.halantRegular(size: 18)
        button.addTarget(self, action: #selector(recoveryTapped), for: .touchUpInside)
        return button
    }()
    private let enterButon: UIButton = {
        let button = UIButton(title: "Войти", background: .mainBlue, heigth: 55, width: 105, isShadow: false)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: - Properties
    weak var delegate: CustomPopupRegViewСontrollerProtocol?

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()

        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animationOut)))
    }

    // MARK: - Actions
    @objc func animationOut() {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.dismissBackgroundView()
    }

    @objc func recoveryTapped() {
        let controller = RecoveryPasswordController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers
    private func setupUI() {
        self.view.frame = UIScreen.main.bounds
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.6)
        }

        containerView.addSubview(backButton)
        containerView.addSubview(regButton)
        containerView.addSubview(textLabel)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).offset(-20)
            make.width.height.equalTo(20)
        }
        regButton.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.leading.equalTo(containerView).offset(30)
            make.trailing.equalTo(containerView).offset(-30)
        }

        let stackView = UIStackView(arrangedSubviews: [
            textLabel, emailTextField, passwordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(regButton.snp.bottom).offset(30)
            make.trailing.equalTo(containerView).offset(-30)
            make.leading.equalTo(containerView).offset(30)
        }
        containerView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.trailing.equalTo(containerView).offset(-50)
            make.width.equalTo(220)
        }
        dismissButton.imageView?.snp.makeConstraints({ (make) in
            make.trailing.equalTo(dismissButton)
            make.centerY.equalTo(dismissButton)
        })
        containerView.addSubview(enterButon)
        enterButon.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView).offset(-20)
            make.centerX.equalTo(containerView)
        }
    }
}
