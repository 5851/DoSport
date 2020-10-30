//
//  MainViewController.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

protocol MenuViewControllerProtocol: class {
    /// Для изменения цвета backgoundView TabBarVC
    func doBlackBackGroundColor()
}

final class MenuViewController: CommonSettingsViewController {

    // MARK: - Outlets
    private let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "forward")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
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
        label.text = "Главное меню"
        label.font = UIFont.halantRegular(size: 24)
        label.textColor = .white
        return label
    }()

    private let regButton: UIButton = {
        let button = UIButton(title: "Регистрация", background: .yellow, heigth: 40, width: 150, isShadow: false)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Properties
    var namesCell: [String] = [
        "Объекты на карте", "Аренда залов,\nплощадок", "Мои тренировки"
    ]
    let alertView = CustomPopupLogoutController()
    weak var delegate: MenuViewControllerProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Actions
    @objc private func handleRegistration() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }

    @objc private func handleLogout() {
        delegate?.doBlackBackGroundColor()
        alertView.modalPresentationStyle = .custom
        self.present(alertView, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesCell.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuViewCell.reuseId,
            for: indexPath) as? MenuViewCell else {
                return UICollectionViewCell()
        }
        cell.textLabel.text = namesCell[indexPath.item]
        cell.backgroundColor = #colorLiteral(red: 0.860845089, green: 0.898216784, blue: 0.9998374581, alpha: 1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let controller = MapViewController()
            navigationController?.pushViewController(controller, animated: true)
        default:
            print(indexPath.item)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 80, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 70, right: 0)
    }
}

// MARK: - SetupUI
extension MenuViewController {
    private func setupUI() {
        let topStackView = UIStackView(arrangedSubviews: [
            logoImageView, UIView(), menuLabel
        ])
        view.addSubview(topStackView)
        topStackView.alignment = .center
        topStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(view).offset(-20)
            make.leading.equalTo(view).offset(20)
            make.height.equalTo(50)
        }
        view.addSubview(regButton)
        regButton.snp.makeConstraints { (make) in
            make.top.equalTo(topStackView.snp.bottom).offset(5)
            make.trailing.equalTo(view).offset(-20)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(regButton.snp.bottom).offset(5)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(MenuViewCell.self, forCellWithReuseIdentifier: MenuViewCell.reuseId)
    }
}
