//
//  ViewController.swift
//  UIKit-maraphone-3
//
//  Created by Surgeont on 08.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()

    override func loadView() {
        view = mainView
    }
    
}

