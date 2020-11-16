//
//  MapViewController.swift
//  DoSportProject
//
//  Created by MAC on 11.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import SnapKit
import YandexMapsMobile

class MapViewController: UIViewController {

    // MARK: - Outlets
    private let mapView: YMKMapView = {
        let view = YMKMapView()
        return view
    }()
    private let targetLocation = YMKPoint(latitude: 59.945933, longitude: 30.320045)
    private let pointButton: UIButton = {
        let button = UIButton(title: "+   Выбрать точку", background: .mainBlue, heigth: 50, width: 187, isShadow: false)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showBottomMenu), for: .touchUpInside)
        return button
    }()
    private let detailsButton: UIButton = {
        let button = UIButton(title: "+   Подробности", background: .mainBlue, heigth: 50, width: 187, isShadow: false)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    private let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "forward"), for: .normal)
        return button
    }()
    private lazy var menuView: UIView = {
        let view = ButtomMenuView()
        view.delegate = self
        return view
    }()

    // MARK: - Properties
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: targetLocation, zoom: 10, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMenuView))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Actions
    @objc private func dismissMenuView() {
        UIView.animate(withDuration: 0.5) {
            self.menuView.transform = .identity
        }
    }

    @objc private func dismissController() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func showBottomMenu() {
        UIView.animate(withDuration: 0.5) {
            self.menuView.transform = CGAffineTransform(translationX: 0, y: -260)
        }
    }
}

// MARK: - ButtomMenuViewDelegate
extension MapViewController: ButtomMenuViewDelegate {
    func launchSideMenu() {
        let controller = SideMenuViewController()
        controller.transitioningDelegate = slideInTransitioningDelegate
        controller.modalPresentationStyle = .custom
        slideInTransitioningDelegate.direction = .left
        slideInTransitioningDelegate.disableCompactHeight = false
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK: - Setup UI
extension MapViewController {
    private func setupUI() {
        // Настройка стартового экрана с картой
        navigationController?.navigationBar.isHidden = true
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        setupButtons()
    }

    private func setupButtons() {
        // Расположение кнопок стортового управленич (выбрать точку и подробности)
        let stackView = UIStackView(arrangedSubviews: [
            pointButton, detailsButton
        ])
        stackView.spacing = 20
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.trailing.equalTo(view).offset(-30)
            make.bottom.equalTo(view).offset(-110)
        }
        // Расположение кнопок навигации
        backButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(36)
        }
        forwardButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(36)
        }
        let buttonsStackView = UIStackView(arrangedSubviews: [
            backButton, UIView(), forwardButton
        ])
        view.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.leading.equalTo(view).offset(20)
        }

        // Расположение нижнего меню в стартом состоянии за пределами экрана
        view.addSubview(menuView)
        menuView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(180)
        }
    }
}
