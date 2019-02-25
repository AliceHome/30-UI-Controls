//
//  ViewController.swift
//  TwicketSeementedControlDemo
//
//  Created by Maple on 2019/2/24.
//  Copyright © 2019 Maple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles = ["Dog", "Cat", "Tiger"]
        let frame = CGRect(x: 5, y: view.frame.height / 2 - 20, width: view.frame.width - 40, height: 40)
        let segmentC = TwicketSegmentedControl(frame: frame)
        segmentC.setSegmentItems(titles)
        segmentC.delegate = self
        view.addSubview(segmentC)
    }


}

extension ViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        print("选择 \(segmentIndex)")
    }
}

