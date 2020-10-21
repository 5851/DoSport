//
//  CustomPopuLogoutView.swift
//  DoSport
//
//  Created by MAC on 21.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//
import UIKit

class CustomPopupLogoutView: UIView {

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