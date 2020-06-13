//
//  ViewController.swift
//  LuckyTeam_HW2.8
//
//  Created by Михаил Кожанов on 13.06.2020.
//  Copyright © 2020 KozhanovMikhail. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var pensionLabel: UIButton!
    @IBOutlet var creditLabel: UIButton!
    @IBOutlet var payDayLabel: UIButton!

    // MARK: - Public Properties


    // MARK: - Private Properties


    // MARK: - Initializers


    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        pensionLabel.layer.cornerRadius = 7
        creditLabel.layer.cornerRadius = 7
        payDayLabel.layer.cornerRadius = 7
    }

    // MARK: - Life Cycles Methods


    // MARK: - Public Methods


    // MARK: - Private Methods
}

