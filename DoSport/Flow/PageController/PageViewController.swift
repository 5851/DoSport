//
//  PageViewController.swift
//  DoSportProject
//
//  Created by MAC on 11.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import Alamofire
final class PageViewController: UIViewController {

    // MARK: - Dependency
    private let authService = NetworkServiceFactory.shared.makeAuthRequestFactory()
    private let testRequest = RequestFactory()

    // MARK: - Properties
    var pages: [PageModel] = [
        PageModel(imageName: "map", textDescription: "Находи на карте города стадион, площадку, поле.Делись локацией с друзьями"),
        PageModel(imageName: "man", textDescription: "Cоздавай свой круг по интересам и общайся в чате "),
        PageModel(imageName: "map", textDescription: "Находи на карте города стадион, площадку, поле.Делись локацией с друзьями"),
        PageModel(imageName: "man", textDescription: "Cоздавай свой круг по интересам и общайся в чате")
    ]

    // MARK: - Outlets
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1)
        pageControl.pageIndicatorTintColor = .white
        return pageControl
    }()

    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пропустить", for: .normal)
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
        setGradientBackground(colorTop: #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), colorBottom: #colorLiteral(red: 0.8260528445, green: 0.8579083085, blue: 0.998154223, alpha: 1))
        setupBottomControls()
        setupDismissButton()

        // Тестовое
        let auth = testRequest.makeAuthRequestFactory()
        auth.login(userName: "admin", password: "admin") { response in
            switch response.result {
            case .success(let login):
                let username = login.username
                let token = login.token
                print("response from server \(abs), token \(token)")
            case .failure(let error):
                print("Error discrubing \(error.localizedDescription)")
                
            }
        }
//        authService.registerUser(user: UserFullInform(login: "admin", password: "admin")) { item in
//            print("response from server \(item)")
//        }
    }

    // MARK: - Actions
    @objc private func handleDismiss() {
        let controller = LoginViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers functions
    private func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PageViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PageViewCell.reuseId,
            for: indexPath) as? PageViewCell else {
            return UICollectionViewCell()
        }

        let page = pages[indexPath.row]
        cell.page = page

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let xCoord = targetContentOffset.pointee.x
        pageControl.currentPage = Int(xCoord / view.frame.width)
    }
}

// MARK: - SetupUI
extension PageViewController {

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(PageViewCell.self, forCellWithReuseIdentifier: PageViewCell.reuseId)
    }

    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    private func setupDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.width.equalTo(145)
        }
        dismissButton.imageView?.snp.makeConstraints({ (make) in
            make.trailing.equalTo(dismissButton)
            make.centerY.equalTo(dismissButton)
        })
    }

    private func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [
            pageControl
        ])
        bottomControlsStackView.distribution = .fillEqually

        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
        }
    }
}
