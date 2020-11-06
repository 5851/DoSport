//
//  StartViewController.swift
//  DoSportProject
//
//  Created by MAC on 11.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

// Стартовый экран после запуска приложения
final class StartViewController: UIViewController {

    // MARK: - Outlets
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = #imageLiteral(resourceName: "DoSport")
//        label.textAlignment = .center
//        label.font = UIFont.montserratBold(size: 64)
        return logoView
    }()
    private let datamanger = RequestFactory()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "DoSport  поможет тебе заняться любимым видом спорта вместе с друзьями. Подбери площадку  на карте города, поделись локацией с теми, кто разделяет твои интересы. Общайся в чате, встречайся и начинай играть, тренироваться.\n\nDoSport - это новые впечатления, новые друзья и твои любимые занятия в отличной компании."
        label.font = UIFont.halantRegular(size: 20)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .justified
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(title: "Главное меню", background: #colorLiteral(red: 0.9921568627, green: 1, blue: 0.9843137255, alpha: 1), heigth: 50, isShadow: true)
        button.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }

    // MARK: - Actions
    @objc private func handleStart(sender: UIButton) {
        let controller = PageViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers function
    private func generateAttributedString(title: String, description: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.foregroundColor: UIColor.red])
        attributedString.append(.init(string: description, attributes: [.foregroundColor: UIColor.white]))
        return attributedString
    }
}

// MARK: - SetupUI
extension StartViewController {

    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1)
//        loginLabel.attributedText = generateAttributedString(title: "Do", description: "Sport")

        view.addSubview(logoView)
        view.addSubview(startButton)
        view.addSubview(descriptionLabel)

        logoView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.centerX.equalTo(view)
            make.height.equalTo(59)
            make.width.equalTo(283)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-40)
            make.centerX.equalTo(view)
//            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }

}
