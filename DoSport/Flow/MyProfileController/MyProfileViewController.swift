//
//  MyProfileView.swift
//  DoSport
//
//  Created by Sergey on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit

final class MyProfileViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - OUTLETS
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        imageView.widthAnchor.constraint(equalToConstant: 101).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 21).isActive = true
        return imageView
    }()
    private let headerTextField: UILabel = {
        let textField = UILabel(title: "Личный кабинет", height: 32, fontSize: 20)
        textField.layer.borderWidth = 0
        return textField
    }()
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "avatar")
        imageView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 67).isActive = true
        return imageView
    }()
    private let saveLabel: UILabel = {
        let textField = UILabel(title: "Сохранить", height: 19, fontSize: 12)
        textField.layer.borderWidth = 0
        textField.sizeToFit()
        return textField
    }()
    private let saveSwitcher: UISwitch = {
       let switcher = UISwitch()
        switcher.onTintColor = #colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1)
        return switcher
    }()
    private let nameTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Имя")
        return textField
    }()
    private let surnameTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Фамилия")
        return textField
    }()
    private let oldPasswordTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Старый пароль")
        return textField
    }()
    private let newPasswordTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Новый пароль")
        return textField
    }()
    private let infoNewPasswordTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Вы можете изменить пароль")
        textField.backgroundColor = .none
        textField.isEnabled = false
        return textField
    }()
    private let retypeNewPasswordTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Введите новый пароль еще раз")
        return textField
    }()
    private let birthdayDateTextField: CustomTextField = {
       let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "__ . __ . ____")
        textField.textAlignment = .center
        textField.sizeToFit()
        return textField
    }()
    private let aboutMeTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 120, fontSize: 20, labelText: "О Себе")
        textField.textAlignment = .natural
        return textField
    }()
    // MARK: - UIButtons
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    private let editAvatarButton: EditButton = {
        let button = EditButton(width: 35, hight: 35)
        return button
    }()
    private let editFirstNameButton: EditButton = {
        let button = EditButton(width: 35, hight: 35)
        return button
    }()
    private let editLastNameButton: EditButton = {
        let button = EditButton(width: 35, hight: 35)
        return button
    }()
    private let genderManButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "manGender"), for: .normal)
        button.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 18
       return button
    }()
    private let genderWomanButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "womanGender"), for: .normal)
        button.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 18
       return button
    }()
    private let changePasswordButton: UIButton = {
        let button = UIButton(title: "Вы можете сменить пароль", background: .red)
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let mySkillsButton: UIButton =  {
        let button = UIButton(titleProvider: "Виды спорта, \n уровень подготовки", heigth: 70, width: 245, fontSize: 18, isShadow: false)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1)
        button.tintColor = .white
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    private let myTimingButton: UIButton =  {
        let button = UIButton(titleProvider: "Моё расписание", heigth: 70, width: 245, fontSize: 18, isShadow: false)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1)
        button.tintColor = .white
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    private let myRoomsButton: UIButton =  {
        let button = UIButton(titleProvider: "Мои площадки, залы \n и тренировки", heigth: 70, width: 245, fontSize: 18, isShadow: false)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1)
        button.tintColor = .white
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    // MARK: - UILabels
    private let genderLabel: UILabel = {
        let textField = UILabel(title: "Пол", height: 28, fontSize: 18)
        textField.layer.borderWidth = 0
        return textField
    }()
    private let birthdayLabel: UILabel = {
        let textField = UILabel(title: "Дата рождения", height: 28, fontSize: 18)
        textField.layer.borderWidth = 0
        return textField
    }()
    private let hideBirthdayDateLabel: UILabel = {
        let textField = UILabel(title: "Скрыть", height: 22, fontSize: 14)
        textField.layer.borderWidth = 0
        return textField
    }()
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureUI()
        createDatePicker()
        setGradientBackground(colorTop: #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), colorBottom: #colorLiteral(red: 0.8260528445, green: 0.8579083085, blue: 0.998154223, alpha: 1))
    }
    // MARK: - Helpers functions and property
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    private func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(confirmBirthdayPicker))
        toolBar.setItems([doneButton], animated: true)
        birthdayDateTextField.inputAccessoryView = toolBar
        birthdayDateTextField.inputView = datePicker
    }
    // MARK: - Actions
    @objc func confirmButtonTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = .identity
            })
        })
        if sender.backgroundColor == UIColor.white {
             sender.backgroundColor = UIColor.blue
        } else {
             sender.backgroundColor = UIColor.white
        }
    }
    @objc func confirmBirthdayPicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        birthdayDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.birthdayDateTextField.endEditing(true)
    }

// MARK: - UISettings
    private func configureUI() {
        view.backgroundColor = .white
        //Расположение лого картинки и гостевой вход
        let topStackView = UIStackView(arrangedSubviews: [
            logoImageView, headerTextField
        ])
        view.addSubview(topStackView)
        topStackView.alignment = .center
        topStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        // MARK: - ScrollViewSettings
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1000)
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topStackView.snp.bottom)
//            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
//            make.height.equalTo(view.frame.height + 400)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading).offset(40)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width).offset(-40)
            make.height.equalTo(scrollView.snp.height)
        }
        let avatarAndEditButtonStackView = UIStackView(arrangedSubviews: [avatarImageView, editAvatarButton, saveLabel, saveSwitcher])
        avatarAndEditButtonStackView.axis = .horizontal
        avatarAndEditButtonStackView.alignment = .center
        avatarAndEditButtonStackView.spacing = 15
        contentView.addSubview(avatarAndEditButtonStackView)
        avatarAndEditButtonStackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-40)
        }

        // MARK: - Расположение маленьких textfield'ов
        let firstNameStackView = UIStackView(arrangedSubviews: [nameTextField, editFirstNameButton])
        firstNameStackView.axis = .horizontal
        firstNameStackView.alignment = .center
        firstNameStackView.spacing = 15
        
        let lastNameStackView = UIStackView(arrangedSubviews: [surnameTextField, editLastNameButton])
        lastNameStackView.axis = .horizontal
        lastNameStackView.spacing = 15
        lastNameStackView.alignment = .center
        
        let genderTypeStackView = UIStackView(arrangedSubviews: [genderLabel,genderManButton,genderWomanButton, UIView()])
        genderManButton.snp.makeConstraints { (make) in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        genderWomanButton.snp.makeConstraints { (make) in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        genderTypeStackView.axis = .horizontal
        genderTypeStackView.spacing = 40
        genderTypeStackView.alignment = .leading
        
        let birthdayStackView = UIStackView(arrangedSubviews: [birthdayLabel, birthdayDateTextField])
        birthdayStackView.axis = .horizontal
        birthdayStackView.spacing = 10
        birthdayStackView.alignment = .center
        
        let fullNameStackView = UIStackView(arrangedSubviews: [firstNameStackView,
                                                               lastNameStackView,
                                                               genderTypeStackView,
                                                               birthdayStackView,
                                                               changePasswordButton])
        fullNameStackView.axis = .vertical
        fullNameStackView.spacing = 20
        contentView.addSubview(fullNameStackView)
        fullNameStackView.snp.makeConstraints { (make) in
            make.top.equalTo(avatarAndEditButtonStackView.snp.bottom).offset(40)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(-40)
        }
        let myButtonsStackView = UIStackView(arrangedSubviews: [mySkillsButton,myRoomsButton,myTimingButton])
        myButtonsStackView.alignment = .center
        myButtonsStackView.axis = .vertical
        myButtonsStackView.spacing = 28
        
        let bigTextFieldsStackView = UIStackView(arrangedSubviews: [aboutMeTextField,myButtonsStackView])
        bigTextFieldsStackView.axis = .vertical
        contentView.addSubview(bigTextFieldsStackView)
        bigTextFieldsStackView.spacing = 15
        bigTextFieldsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameStackView.snp.bottom).offset(70)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.trailing).offset(-40)
//            make.bottom.equalTo(contentView.snp.bottom)
        }
//        contentView.addSubview(confirmButton)
//        confirmButton.snp.makeConstraints { (make) in
//            make.top.equalTo(bigTextFieldsStackView.snp.bottom).offset(15)
//            make.height.equalTo(28)
//            make.width.equalTo(28)
//            make.trailing.equalTo(bigTextFieldsStackView.snp.trailing)
//        }
}
}
