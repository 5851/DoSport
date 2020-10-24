//
//  CustomPopuLogoutView.swift
//  DoSport
//
//  Created by MAC on 21.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//
import UIKit

protocol CustomPopupLogoutControllerProtocol: class {
    /// Функция для изменения цвета BackgroundView TabBarVC
    func dismissBackgroundView()
}

// Экран выхода из личного кабинета
final class CustomPopupLogoutController: UIViewController {

    // MARK: - Outlets
    private let backgroundView: UIView = {
        let backGroundView = UIView()
        return backGroundView
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
    private let textLabel = UILabel(title: "Вы действительно хотите выйти из приложения?",
                                    textAlignment: .center,
                                    textColor: .white,
                                    numberOfLines: 0,
                                    fontSize: 18)
    private let yesButon: UIButton = {
        let button = UIButton(title: "ДА", background: #colorLiteral(red: 1, green: 0.9547553658, blue: 0.5084705353, alpha: 1), heigth: 60, isShadow: false)
        button.layer.cornerRadius = 10
        return button
    }()
    private let noButon: UIButton = {
        let button = UIButton(title: "НЕТ", background: #colorLiteral(red: 0.9895803332, green: 1, blue: 0.9852907062, alpha: 1), heigth: 60, isShadow: false)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(animationOut), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties
    weak var delegate: CustomPopupLogoutControllerProtocol?

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animationOut)))
    }

    // MARK: - Actions
    @objc func animationOut() {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.dismissBackgroundView()
    }
}

// MARK: - SetupUI
extension CustomPopupLogoutController {
    private func setupUI() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(220)
        }

        containerView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).offset(-20)
        }

        containerView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalTo(containerView).offset(40)
            make.trailing.equalTo(containerView).offset(-40)
        }

        let stackView = UIStackView(arrangedSubviews: [
            noButon, yesButon
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.trailing.equalTo(containerView).offset(-40)
            make.leading.equalTo(containerView).offset(40)
        }
    }
}
