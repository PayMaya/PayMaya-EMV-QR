//
//  ViewController.swift
//  QRScan
//
//  Created by Ralph Jacob Chua on 1/2/19.
//  Copyright © 2019 Ralph Jacob Chua. All rights reserved.
//

import UIKit
import QRCodeReader

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        print(result.value)
    }

}

