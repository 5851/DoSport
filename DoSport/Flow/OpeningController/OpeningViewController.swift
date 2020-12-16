//
//  MainViewController.swift
//  DoSport
//
//  Created by MAC on 27.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class OpeningViewController: UIViewController {
    let networkManager = RequestFactory()

    // MARK: - Outlets
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        return imageView
    }()
    private let enterAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход", for: .normal)
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()
    private let regAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.addTarget(self, action: #selector(getToken), for: .touchUpInside)
        return button
    }()
    private let questAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("Гостевой вход", for: .normal)
        button.addTarget(self, action: #selector(loadToken), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: - Helpers
    @objc func getToken() {
        let request = networkManager.makeAuthRequest()
        request.login(userName: "eduard", password: "eduard") { (response) in
            switch response.result {
            case .success(let success):
                let temp = Token()
                temp.saveToken(token: success.token)
                print(temp.loadToken())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @objc func loadToken() {
        let token = Token()
        let temp = token.loadToken()
        getUserInfo(token: temp) { (result) in
            print(result)
        }
    }
    func getUserInfo(token: String, completion: @escaping (UserInfoResult) -> Void) {
            let request = networkManager.makeUserInfoRequest()
            print("request printin \(request)")
        request.getInfo(token: token) { (response) in
                switch response.result {
                case .success(let success):
                    print("success username \(success.username), success ID \(success.id) ")
                    completion(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    @objc func changePassword() {
        let token = Token()
        let temp = token.loadToken()
        changepassword(token: temp) { (result) in
            print(result)
        }

    }
    func changepassword(token: String, completion: @escaping (String) -> Void) {
            let request = networkManager.makeEditPasswordRequest()
            print("request printin \(request)")
        request.editPassword(token: token, newPassword: "jumper", newPasswordConfirm: "jumper", oldPassword: "Jumper")
                         { (response) in
                switch response.result {
                case .success(let success):
                    completion(success)
                    print("success passwordChange \(success)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
}

// MARK: - SetupUI
extension OpeningViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(60)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }

        [enterAppButton, regAppButton, questAppButton].forEach { (button) in
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
            button.setBackgroundColor(#colorLiteral(red: 0.3615658879, green: 0.6828438044, blue: 0.9989137053, alpha: 1), for: .normal)
            button.setBackgroundColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .selected)
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }

        let stackView = UIStackView(arrangedSubviews: [
            enterAppButton, regAppButton, questAppButton
        ])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(40)
            make.trailing.equalTo(view).offset(-40)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
