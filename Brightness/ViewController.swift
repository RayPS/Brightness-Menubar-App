//
//  ViewController.swift
//  Brightness
//
//  Created by Ray on 11/28/19.
//  Copyright © 2019 Ray. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var slider: NSSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear() {
        slider.floatValue = DKBrightness.getBrightnessLevel()
    }

    @IBAction func sliderDidChange(_ sender: Any) {
        DKBrightness.setBrightnessLevel(level: max(0.01, slider.floatValue))
    }


}

