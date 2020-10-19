//
//  Test2ViewController.swift
//  DoSport
//
//  Created by MAC on 17.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class MainMenuViewController: CommonSettingsViewController {

    // MARK: - Outlets
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let menuBarView: UIView = {
        let view = UIView()
        return view
    }()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Properties
    let controllerOne = MenuViewController()
    let controllerTwo = PageViewController()
    let controllerThree = LoginViewController()
    let namesTitleCell = ["Главное\nменю", "Чат", "Личный\nкабинет"]

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
        configureViewController(controller: controllerOne)

        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
    }

    // MARK: - Helper functions
    func configureViewController(controller: UIViewController) {
        removeViewController()
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.view.snp.makeConstraints { (make) in
            make.edges.equalTo(containerView)
        }
        containerView.layer.masksToBounds = true
        controller.didMove(toParent: self)
    }

    func removeViewController() {
        controllerOne.removeFromParent()
        controllerTwo.removeFromParent()
        controllerThree.removeFromParent()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/CGFloat(namesTitleCell.count), height: view.frame.height)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesTitleCell.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainMenuCell.reuseId,
            for: indexPath) as? MainMenuCell else {
            return UICollectionViewCell()
        }
        cell.textLabel.text = namesTitleCell[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            configureViewController(controller: controllerOne)
        case 1:
            configureViewController(controller: controllerThree)
        default:
            configureViewController(controller: controllerTwo)
        }
    }
}

// MARK: - SetupUI
extension MainMenuViewController {
        func setupUI() {
            view.addSubview(menuBarView)
            menuBarView.snp.makeConstraints { (make) in
                make.bottom.leading.trailing.equalTo(view)
                make.height.equalTo(80)
            }
            menuBarView.addSubview(collectionView)
            collectionView.snp.makeConstraints { (make) in
                make.edges.equalTo(menuBarView)
            }
            view.addSubview(containerView)
            containerView.snp.makeConstraints { (make) in
                make.top.equalTo(view)
                make.leading.trailing.equalTo(view)
                make.bottom.equalTo(menuBarView.snp.top)
            }
        }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(MainMenuCell.self, forCellWithReuseIdentifier: MainMenuCell.reuseId)
    }
}
