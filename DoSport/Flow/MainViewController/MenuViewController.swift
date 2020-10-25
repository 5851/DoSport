//
//  MainViewController.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class MenuViewController: CommonSettingsViewController {

    // MARK: - Outlets
    // Кнопка назад
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    // Набор лого картинки и гостевой вход
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // Набор кнопок управления
    private let mainMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Главное\nменю", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.halantRegular(size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 0.9)
        return button
    }()
    private let chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Чат", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.halantRegular(size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 0.9)
        return button
    }()
    private let personalCabinetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Личный\nкабинет", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.halantRegular(size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 0.9)
        return button
    }()

    // MARK: - Properties
    var namesCell: [String] = [
        "Объекты на карте", "Аренда залов,\nплощадок", "Мои тренировки",
        "Любительские лиги", "Авторские туры",
        "Здоровое питание", "О нас"
    ]

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureCollectionView()
        setupUI()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MenuHeaderCell.reuseId, for: indexPath) as? MenuHeaderCell else {
            return UICollectionReusableView()
        }
        return header
    }

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
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width - 40,
                      height: 60)
    }
}

// MARK: - SetupUI
extension MenuViewController {
    private func setupUI() {
        // Расположение кнопки назад
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view).offset(20)
        }
        // Расположение collectionView
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }

        // Расположение botton menu
        let bottomMenuStackView = UIStackView(arrangedSubviews: [
            mainMenuButton, chatButton, personalCabinetButton
        ])
        bottomMenuStackView.distribution = .fillEqually
        view.addSubview(bottomMenuStackView)
        bottomMenuStackView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(view)
            make.height.equalTo(100)
        }
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(MenuViewCell.self, forCellWithReuseIdentifier: MenuViewCell.reuseId)
        collectionView.register(
            MenuHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MenuHeaderCell.reuseId)
    }
}
