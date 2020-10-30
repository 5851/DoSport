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
    let mapView: YMKMapView = {
        let view = YMKMapView()
        return view
    }()
    let targetLocation = YMKPoint(latitude: 59.945933, longitude: 30.320045)

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: targetLocation, zoom: 10, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
    }
}

// MARK: - Setup UI
extension MapViewController {
    private func setupUI() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
}
