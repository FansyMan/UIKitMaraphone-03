//
//  MainView.swift
//  UIKit-maraphone-3
//
//  Created by Surgeont on 08.07.2023.
//

import UIKit


final class MainView: UIView {
    private let cubeView = UIView()
    private let slider = UISlider()
    
    private var selfWidth: CGFloat = 0
    private var currentValue: CGFloat = 0.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selfWidth = self.bounds.width
    }
}

private extension MainView {
    func setupUI() {
        setupCubeView()
        setupSlider()
        addSubviews()
        setupConstraints()
    }
    
    func setupCubeView() {
        cubeView.layer.cornerRadius = 10
        cubeView.backgroundColor = .blue
        cubeView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSlider() {
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDismiss), for: .touchUpInside)
        slider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func sliderAction(sender: UISlider) {
        if sender == slider {
            self.currentValue = CGFloat(sender.value)
            if currentValue < 0.5 {
                cubeView.transform = CGAffineTransform(
                    scaleX: 1 + currentValue,
                    y: 1 + currentValue
                ).rotated(by: (.pi * currentValue) / 2)
                self.cubeView.center = CGPoint(
                    x: (40 + (self.selfWidth - 2 * (30 + 80/2)) * CGFloat(sender.value)) + self.layoutMargins.left / 2,
                    y: self.cubeView.center.y
                )
            } else {
                cubeView.transform = CGAffineTransform(
                    scaleX: 1.5,
                    y: 1.5
                ).rotated(by: (.pi * currentValue) / 2)
                self.cubeView.center = CGPoint(
                    x: (40 + (self.selfWidth - 2 * (30 + 80/2)) * CGFloat(sender.value)) + self.layoutMargins.left * 2,
                    y: self.cubeView.center.y
                )
            }
            
        }
    }
    
    @objc func sliderDismiss(sender: UISlider) {
        if sender == slider {
            layoutIfNeeded()
            UIView.animate(withDuration: 1) {
                self.slider.setValue(1, animated: true)
                if CGFloat(sender.value) < 0.5 {
                    self.cubeView.transform = CGAffineTransform(
                        scaleX: 1 + CGFloat(sender.value),
                        y: 1 + CGFloat(sender.value)
                    ).rotated(by: (.pi * CGFloat(sender.value)) / 2)
                } else {
                    self.cubeView.transform = CGAffineTransform(
                        scaleX: 1.5,
                        y: 1.5
                    ).rotated(by: (.pi * CGFloat(sender.value)) / 2)
                }
                self.cubeView.center = CGPoint(
                    x: (40 + (self.selfWidth - 2 * (30 + 80/2)) * CGFloat(sender.value)) + self.layoutMargins.left * 2,
                    y: self.cubeView.center.y
                )
                self.layoutIfNeeded()
            }
            
        }
    }
    
    func addSubviews() {
        addSubview(cubeView)
        addSubview(slider)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cubeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            cubeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layoutMargins.left),
            cubeView.widthAnchor.constraint(equalToConstant: 80),
            cubeView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: cubeView.bottomAnchor, constant: 30),
            slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layoutMargins.left),
            slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layoutMargins.right),
        ])
    }
}
