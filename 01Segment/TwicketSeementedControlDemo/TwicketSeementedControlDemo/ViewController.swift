//
//  ViewController.swift
//  TwicketSeementedControlDemo
//
//  Created by Maple on 2019/2/24.
//  Copyright © 2019 Maple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var  tView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        let titles = ["Dog", "Cat", "Tiger"]
        let frame = CGRect(x: 5, y: view.frame.height / 2 - 20, width: view.frame.width - 40, height: 40)
        let segmentC = TwicketSegmentedControl(frame: frame)
        segmentC.setSegmentItems(titles)
        segmentC.delegate = self
        view.addSubview(segmentC)
        
        return
        // 测试 mask 属性
        let aView = UIView()
        aView.backgroundColor = .red
        aView.frame = CGRect(x: 10, y: view.frame.height / 2 - 20 + 80, width: view.frame.width - 40, height: 40)
        view.addSubview(aView)
        let aLabel = UILabel()
        aLabel.text = "123456789012345678901234567890"
        aLabel.frame = CGRect(x: 0, y: 0, width: aView.frame.size.width, height: aView.frame.size.height)
        aView.addSubview(aLabel)
        tView = UIView()
        tView?.backgroundColor = .red
        tView?.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        tView?.backgroundColor = .black
        tView?.addShadow(with: .black)
        aView.layer.mask = tView?.layer
    }

    
    
    

}

extension ViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        print("选择 \(segmentIndex)")
    }
}

