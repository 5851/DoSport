//
//  MyProfileView.swift
//  DoSport
//
//  Created by Sergey on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

final class MyProfileViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - OUTLETS
    var viewModel: MyProfileViewModel?
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        return scrollView
    }()
    private let skillsTableView: MySkillsTableView = {
        let tableView = MySkillsTableView()
        return tableView
    }()
    private let starView: StarIcon = {
        let tableView = StarIcon()
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
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
        imageView.image = #imageLiteral(resourceName: "avatar").withRenderingMode(.alwaysOriginal)
        imageView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 67).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - UITextFields
    private let nameTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Имя")
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        return textField
    }()
    private let surnameTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 20, labelText: "Фамилия")
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        return textField
    }()
    private let birthdayDateTextField: CustomTextField = {
       let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 19, labelText: "__.__.____")
        textField.textAlignment = .center
        textField.sizeToFit()
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        return textField
    }()
    private let aboutMeTextField: CustomTextView = {
        let textField = CustomTextView(cornerRadius: 20, height: 120, fontSize: 20, labelText: "О Себе")
        textField.textAlignment = .left
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.target(forAction: #selector(textFieldDidBeginEditing(_:)), withSender: self)
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
    private let editFullInfoButton: EditButton = {
        let button = EditButton(width: 35, hight: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let saveFullInfoButton: UIButton = {
        let button = UIButton(titleProvider: "Сохранить", heigth: 40, width: 132, fontSize: 18)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1), for: .normal)
        button.layer.borderWidth = 0
        button.alpha = 0
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveFullInfoAction), for: .touchUpInside)
        return button
    }()
    private let genderManButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "manGender"), for: .normal)
        button.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 18
        button.layer.borderColor = #colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1)
       return button
    }()
    private let genderWomanButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "womanGender"), for: .normal)
        button.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 18
        button.layer.borderColor = #colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1)
       return button
    }()
    private let changePasswordButton: ChangePasswordBtn = {
        let button = ChangePasswordBtn(titleProvider: "Вы можете сменить пароль", heigth: 23, width: 253, fontSize: 18)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(changePasswordAction), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let mySkillsButton: UIButton =  {
        let button = UIButton(titleProvider: "Виды спорта, \n уровень подготовки", heigth: 70, width: 245, fontSize: 18, isShadow: false)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1)
        button.tintColor = .white
        button.titleLabel?.numberOfLines = 2
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
        button.titleLabel?.numberOfLines = 2
        return button
    }()
    // MARK: - UILabels
    private let editFullInfoLabel: UILabel = {
        let textField = UILabel(title: "Внести изменения", height: 22, fontSize: 14)
        textField.layer.borderWidth = 0
        textField.clipsToBounds = true
        return textField
    }()
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
        downloadModel()
        navigationController?.navigationBar.isHidden = true
        self.aboutMeTextField.delegate = self
        configureUI()
        createDatePicker()
        setGradientBackground(colorTop: #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), colorBottom: #colorLiteral(red: 0.8260528445, green: 0.8579083085, blue: 0.998154223, alpha: 1))
    }
    // MARK: - Helpers functions and property
    func downloadModel() {
        let baseModel = UserInfoResult(birthdayDate: "", firstName: "",
                                       gender: "", hideBirthdayDate: true,
                                       id: 0, info: "",photoLink: "",
                                       lastName: "",
                                       username: "")
        self.viewModel = MyProfileViewModelImpl(model: baseModel)
        let token = Token()
        let temp = token.loadToken()
//        print("temp token \(temp)")
        let headers: HTTPHeaders = ["Authorization": "Bearer_\(token)"]
//
//        let request = AF.request("https://dosport-ru.herokuapp.com/api/v1/profile", method: .get, parameters: nil, headers: headers).validate(statusCode: 200...300).response { (response) in
//            print("test response from new request \(response)")
//        }

//        self.viewModel?.getUserInfo(token: temp, completion: { (response) in
//            let model = UserInfoResult(birthdayDate: response.birthdayDate, firstName: response.firstName,
//                                       gender: response.gender, hideBirthdayDate: response.hideBirthdayDate,
//                                       id: response.id, info: response.info, lastName: response.lastName,
//                                       photoLink: response.photoLink, username: response.username)
//            self.viewModel = MyProfileViewModelImpl(model: model)
//            self.nameTextField.text = self.viewModel?.firstname
//        })
    }
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.bounds.size.height = 100
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
    private func createOverlay(frame: CGRect) {
        let overlayView = UIView(frame: frame)
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
            maskLayer.fillRule = .evenOdd
        overlayView.layer.mask = maskLayer
            overlayView.clipsToBounds = true
        view.addSubview(overlayView)
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        starView.handleTouchAtLocation(withTouches: touches)
            print("\(#function) \(starView.ratingNumber)")
    }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            starView.handleTouchAtLocation(withTouches: touches)
            print("\(#function) \(starView.ratingNumber)")
        }
    @objc func saveFullInfoAction() {
        _ = [nameTextField, surnameTextField, aboutMeTextField, birthdayDateTextField]
        _ = [genderManButton, genderWomanButton]

        UIView.animate(withDuration: 0.5) { [self] in
            self.saveFullInfoButton.isHidden = true
            self.saveFullInfoButton.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.editFullInfoButton.alpha = 1
                self.editFullInfoLabel.alpha = 1
                self.editFullInfoLabel.isHidden = false
                self.editFullInfoButton.isHidden = false
            }
        }
    }
    @objc func changePasswordAction() {
        let newView = ChangePasswordView(frame: CGRect(x: view.center.x - 150, y: view.center.y-220, width: 300, height: 445))
        newView.alpha = 0
//        createOverlay(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        self.view.addSubview(newView)
        UIView.animate(withDuration: 0.5) {
            newView.alpha = 1
        }
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
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topStackView.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        let avatarAndEditButtonStackView = UIStackView(arrangedSubviews:
            [avatarImageView, UIView(), saveFullInfoButton])
        avatarAndEditButtonStackView.axis = .horizontal
        avatarAndEditButtonStackView.alignment = .center
        avatarAndEditButtonStackView.spacing = 15
        avatarAndEditButtonStackView.distribution = .equalCentering

        contentView.addSubview(avatarAndEditButtonStackView)
        avatarAndEditButtonStackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView).offset(40)
            make.trailing.equalTo(contentView).offset(-40)
        }

        // MARK: - Расположение маленьких textfield'ов
        let genderTypeStackView = UIStackView(arrangedSubviews: [genderLabel, genderManButton, genderWomanButton, UIView()])
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
        genderTypeStackView.alignment = .center
        let birthdayStackView = UIStackView(arrangedSubviews: [birthdayLabel, birthdayDateTextField, UIView()])
        birthdayStackView.axis = .horizontal
        birthdayStackView.spacing = 10
        birthdayStackView.alignment = .center
        birthdayLabel.snp.makeConstraints { (make) in
            make.width.equalTo(149)
        }
        birthdayDateTextField.snp.makeConstraints { (make) in
            make.width.equalTo(135)
        }
        let fullNameStackView = UIStackView(arrangedSubviews: [nameTextField,
                                                               surnameTextField,
                                                               genderTypeStackView,
                                                               birthdayStackView,
                                                               changePasswordButton])
        fullNameStackView.axis = .vertical
        fullNameStackView.spacing = 20
        fullNameStackView.alignment = .leading
        nameTextField.snp.makeConstraints { (make) in
            make.width.equalTo(230)
        }
        surnameTextField.snp.makeConstraints { (make) in
            make.width.equalTo(230)
        }
        contentView.addSubview(fullNameStackView)
        fullNameStackView.snp.makeConstraints { (make) in
            make.top.equalTo(avatarAndEditButtonStackView.snp.bottom).offset(40)
            make.leading.equalTo(contentView.snp.leading).offset(40)
            make.trailing.equalTo(contentView.snp.trailing).offset(-40)
        }
        let myButtonsStackView = UIStackView(arrangedSubviews: [mySkillsButton, myRoomsButton, myTimingButton])
        myButtonsStackView.alignment = .center
        myButtonsStackView.axis = .vertical
        myButtonsStackView.spacing = 28

        let bigTextFieldsStackView = UIStackView(arrangedSubviews: [aboutMeTextField, starView, myButtonsStackView])
        bigTextFieldsStackView.isUserInteractionEnabled = true
        bigTextFieldsStackView.axis = .vertical
        contentView.addSubview(bigTextFieldsStackView)
        bigTextFieldsStackView.spacing = 40
        bigTextFieldsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameStackView.snp.bottom).offset(70)
            make.leading.equalTo(contentView).offset(40)
            make.trailing.equalTo(contentView.snp.trailing).offset(-40)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

extension MyProfileViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) { [self] in
            self.saveFullInfoButton.isHidden = false
            self.saveFullInfoButton.alpha = 1
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.gray
        }
        UIView.animate(withDuration: 0.5) { [self] in
            self.saveFullInfoButton.isHidden = false
            self.saveFullInfoButton.alpha = 1
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "О себе"
            textView.textColor = UIColor.lightGray
        }
    }
}
