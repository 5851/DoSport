//
//  CustomSwitch.swift
//  DoSport
//
//  Created by MAC on 18.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

protocol CustomSwitchDelegate: class {
    func didTapSwitch(isON: Bool)
}

class CustomSwitch: UIView {

    private var containerView: UIView!
    private var elipticalView: UIView!
    private var thumb: UIView!
    private var thumbTrailingConstraint: NSLayoutConstraint!
    private var thumbLeadingConstraint: NSLayoutConstraint!
    weak var delegate: CustomSwitchDelegate?
    var isOn = false
    var onThumbColor = UIColor.white
    var offThumbColor = UIColor.white
    var onBackgroundColor = UIColor(cgColor: #colorLiteral(red: 0.2595242858, green: 0.4154637456, blue: 0.9985032678, alpha: 1).cgColor)
    var offBackgroungColor = UIColor(cgColor: #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1).cgColor)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }

    private func commonInit() {
        let padding = frame.size.height*(-0.25)

        containerView = UIView()
        containerView.backgroundColor = UIColor.red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true

        elipticalView = UIView()
        elipticalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(elipticalView)
        elipticalView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        elipticalView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        elipticalView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        elipticalView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        elipticalView.layer.cornerRadius = (frame.size.height - padding * 2)/2

        thumb = UIView()
        thumb.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumb)
        thumbTrailingConstraint = thumb.trailingAnchor.constraint(equalTo: trailingAnchor)
        thumbTrailingConstraint.isActive = true

        thumbLeadingConstraint = thumb.leadingAnchor.constraint(equalTo: leadingAnchor)
        thumbLeadingConstraint.isActive = true

        setState()
        thumb.heightAnchor.constraint(equalToConstant: frame.size.height).isActive = true
        thumb.widthAnchor.constraint(equalToConstant: frame.size.height).isActive = true
        thumb.layer.cornerRadius = frame.size.height/2
                thumb.layer.borderColor = UIColor.white.cgColor

        let thumbTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnThumb))
        thumb.addGestureRecognizer(thumbTapGesture)
    }

    @objc private func didTapOnThumb() {
        isOn = isOn ? false : true
        setState()
        delegate?.didTapSwitch(isON: isOn)
    }

    private func setState() {
        if isOn {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                self.thumbTrailingConstraint.constant = 0
                self.thumbLeadingConstraint.constant = self.frame.size.width/2
                self.layoutIfNeeded()
            }, completion: nil)
            elipticalView.backgroundColor = onBackgroundColor
            elipticalView.layer.borderColor = #colorLiteral(red: 0.2595242858, green: 0.4154637456, blue: 0.9985032678, alpha: 1).cgColor
            elipticalView.layer.borderWidth = 2
            thumb.backgroundColor = onThumbColor
        } else {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                self.thumbTrailingConstraint.constant = -self.frame.size.width/2
                self.thumbLeadingConstraint.constant = 0
                self.layoutIfNeeded()
            }, completion: nil)
            elipticalView.backgroundColor = offBackgroungColor
            elipticalView.layer.borderColor = UIColor.white.cgColor
            elipticalView.layer.borderWidth = 2
            thumb.backgroundColor = offThumbColor
        }
    }
}
