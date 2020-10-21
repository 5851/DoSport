//
//  CustomAlertView.swift
//  DoSport
//
//  Created by MAC on 20.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

protocol CustomPopupRegViewDelegate: class {
    func toRecoveryController()
}

class CustomPopupRegView: UIView {

    // MARK: - Properties
    weak var delegate: CustomPopupRegViewDelegate?

    // MARK: - Outlets
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        view.layer.opacity = 0.7
        return view
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(
            systemName: "xmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(animationOut), for: .touchUpInside)
        return button
    }()
    private let regButton: UIButton = {
        let button = UIButton(title: "Регистрация", background: .yellow, heigth: 40, isShadow: false)
        return button
    }()
    private let textLabel = UILabel(title: "Пароль уже существует или получен вновь",
                                    textAlignment: .center,
                                    textColor: .white,
                                    numberOfLines: 0,
                                    fontSize: 18)
    private let emailTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Адрес эл. почты")
    private let passwordTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Пароль")
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Вы забыли пароль?", for: .normal)
        button.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.halantRegular(size: 18)
        button.addTarget(self, action: #selector(recoveryTapped), for: .touchUpInside)
        return button
    }()
    private let enterButon: UIButton = {
        let button = UIButton(title: "Войти", background: #colorLiteral(red: 0.860845089, green: 0.898216784, blue: 0.9998374581, alpha: 1), heigth: 50, width: 105, isShadow: false)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animationOut)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc func recoveryTapped() {
        delegate?.toRecoveryController()
    }

    @objc func animationOut() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }, completion: { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        })
    }

    func animationIn() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            self.containerView.transform = .identity
            self.alpha = 1
        })
    }

    // MARK: - Helpers
    private func setupUI() {
        self.frame = UIScreen.main.bounds
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.equalTo(self).multipliedBy(0.6)
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
            make.top.equalTo(backButton.snp.bottom).offset(40)
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
