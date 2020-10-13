//
//  PageViewController.swift
//  DoSportProject
//
//  Created by MAC on 11.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class PageViewController: UIViewController {

    // MARK: - Dependency
    private let authService = NetworkServiceFactory.shared.makeAuthRequestFactory()

    // MARK: - Properties
    var pages: [PageModel] = [
        PageModel(imageName: "map", textDescription: "Находи на карте города стадион, площадку, поле.Делись локацией с друзьями"),
        PageModel(imageName: "man", textDescription: "Cоздавай свой круг по интересам и общайся в чате "),
        PageModel(imageName: "map", textDescription: "Находи на карте города стадион, площадку, поле.Делись локацией с друзьями"),
        PageModel(imageName: "man", textDescription: "Cоздавай свой круг по интересам и общайся в чате")
    ]

    // MARK: - Outlets
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pageControl
    }()

    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пропустить", for: .normal)
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
        authService.registerUser(user: UserFullInform(login: "111", password: "111")) { item in
            print(item)
        }
    }

    // MARK: - Actions
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc private func handlePrevious() {
        let nextIndex = min(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc private func handleDismiss() {
        let controller = MapViewController()
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
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }

    private func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [
            previousButton, pageControl, nextButton
        ])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually

        view.addSubview(bottomControlsStackView)

        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
