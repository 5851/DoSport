//
//  UserModel.swift
//  DoSport
//
//  Created by MAC on 13.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class RegistrationViewController: CommonSettingsViewController {

    // MARK: - Dependency
    var viewModel: RegistrationViewModel?

    // MARK: - Outlets
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        return scrollView
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    private let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "forward")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        imageView.widthAnchor.constraint(equalToConstant: 141).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont.halantRegular(size: 24)
        label.textColor = .white
        return label
    }()
    private let repeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите пароль еще раз"
        label.font = UIFont.halantRegular(size: 20)
        label.textColor = .white
        return label
    }()

    // Набор textField'o
    private let nameTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Имя")
    private let surnameTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Фамилия")
    private let emailTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Адрес эл. почты")
    private let passwordTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Пароль")
    private let repeatPasswordTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Пароль")

    // Набор согласия на обработку персональных данных
    private let checkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleCheckTapped), for: .touchUpInside)
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)
        button.setImage(UIImage(
            systemName: "circle.fill",
            withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        return button
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel(
            title: "согласие на обработку персональных  данных \n(обязательно для продолжения)",
            height: 50, fontSize: 12)
        return label
    }()

    // Набор ИЛИ и линии
    private let borderLabel = CustomAuthLabel(title: "ИЛИ", fontSize: 20, fontWeight: .medium, color: .white)
    private let leftBorderView = CustomBorderAuthView()
    private let rigthBorderView = CustomBorderAuthView()

    // Набор кнопок регистрации
    private let registrationButton: UIButton = {
        let button = UIButton(title: "Регистрация", background: #colorLiteral(red: 0.9921568627, green: 1, blue: 0.9843137255, alpha: 1), heigth: 50, isShadow: true)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    private let providerVKontakteRegButton = UIButton(titleProvider: "login with Vkontakte", heigth: 50, width: 280, image: #imageLiteral(resourceName: "vk"), fontSize: 18)
    private let providerGoogleRegButton = UIButton(titleProvider: "login with Google", heigth: 50, width: 280, image: #imageLiteral(resourceName: "google"), fontSize: 18)
    private let providerFacebookRegButton = UIButton(titleProvider: "login with Facebook", heigth: 50, width: 280, image: #imageLiteral(resourceName: "facebook"), fontSize: 18)

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureUI()
        //MARK: - я понятия пока не имею как это делать правильно)
        self.viewModel = RegistrationViewModelImpl(model: User(firstname: "123", lastname: "123", password: "123", passwordConfirm: "123", username: "123"))
    }

    // MARK: - Actions
    @objc private func handleRegistration() {
        print(#function)
        
        let user = User(firstname: nameTextField.text ?? "", lastname: surnameTextField.text ?? "",
                        password: passwordTextField.text ?? "", passwordConfirm: repeatPasswordTextField.text ?? "" ,
                        username: emailTextField.text ?? "")
        self.viewModel = RegistrationViewModelImpl(model: user)
        viewModel?.placeRregisterRequest(firstname: user.firstname, lastname: user.lastname,
                                         password: user.password, passwordConfirm: user.passwordConfirm,
                                         username: user.username, completion: { (completion) in
                                            print(completion)
                                         })

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
            checkButton.setImage(UIImage(
                systemName: "checkmark.circle.fill",
                withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .selected)
        } else {
            checkButton.setImage(UIImage(
                systemName: "circle.fill",
                withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        }
    }

    @objc func dismissController() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Helpers
//    func chechRegisterBtn()   {
//        registrationButton.isEnabled = viewModel?.areBtnEnabled ?? false
//        viewModel?.areBtnEnabledChanged = { [unowned self] (enabled) in
//            self.registrationButton.isEnabled = enabled
//        }
//    }
//    func textFieldEditingChanged(_sender: Any) {
//        let allTextfields = [nameTextField, surnameTextField, passwordTextField, repeatPasswordTextField, emailTextField]
//        
//        viewModel?.areBtnEnabledChanged(allTextfields.
//    }
//    func registerButtonPressed(_ sender: Any) {
//        
//    }

}


// MARK: - Setup UI
extension RegistrationViewController {
    private func configureUI() {
        view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        // Расположение ScrollView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        // Расположение кнопок навигации
        let buttonsStackView = UIStackView(arrangedSubviews: [
            backButton, UIView()
        ])
        scrollView.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.leading.equalTo(view).offset(20)
        }

        // Расположение логотипа и label
        let topStackView = UIStackView(arrangedSubviews: [
            logoImageView, UIView(), menuLabel
        ])
        scrollView.addSubview(topStackView)
        topStackView.alignment = .center
        topStackView.snp.makeConstraints { (make) in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.leading.equalTo(view).offset(20)
            make.height.equalTo(50)
        }

        // Расположение textfield'ов
        let textFieldStackView = UIStackView(arrangedSubviews: [
            nameTextField,
            surnameTextField,
            emailTextField,
            passwordTextField,
            repeatLabel,
            repeatPasswordTextField
        ])
        textFieldStackView.axis = .vertical
        scrollView.addSubview(textFieldStackView)
        textFieldStackView.spacing = 20
        textFieldStackView.snp.makeConstraints { (make) in
            make.top.equalTo(topStackView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(60)
            make.trailing.equalTo(view).offset(-60)
        }

        scrollView.addSubview(repeatLabel)
        scrollView.addSubview(repeatPasswordTextField)
        repeatLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(20)
            make.leading.equalTo(textFieldStackView.snp.leading).offset(10)
        }
        repeatPasswordTextField.snp.makeConstraints { (make) in            make.top.equalTo(repeatLabel.snp.bottom).offset(10)
            make.leading.equalTo(textFieldStackView.snp.leading)
            make.trailing.equalTo(textFieldStackView.snp.trailing)
        }

        // Расположение объектов согласия на обработку персональных данных
        checkButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
        }

        let centerStackView = UIStackView(arrangedSubviews: [
            checkButton, descriptionLabel
        ])
        centerStackView.spacing = 20
        scrollView.addSubview(centerStackView)
        centerStackView.alignment = .center
        centerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        // Расположение кнопки регистрации
        scrollView.addSubview(registrationButton)
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(centerStackView.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
        }
        // Расположение разделительно линии
        let borderStackView = UIStackView(arrangedSubviews: [
            rigthBorderView, borderLabel, leftBorderView
        ])
        borderStackView.alignment = .center
        borderStackView.distribution = .fillEqually
        scrollView.addSubview(borderStackView)
        borderStackView.snp.makeConstraints { (make) in
            make.top.equalTo(registrationButton.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
        // Расположение кнопок регистрации
        let registrationStackView = UIStackView(arrangedSubviews: [
            providerVKontakteRegButton,
            providerGoogleRegButton,
            providerFacebookRegButton
        ])
        registrationStackView.axis = .vertical
        registrationStackView.spacing = 20
        scrollView.addSubview(registrationStackView)
        registrationStackView.snp.makeConstraints { (make) in
            make.top.equalTo(borderStackView.snp.bottom).offset(30)
            make.centerX.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
        }
    }
}
