//
//  ViewController.swift
//  Pollock
//
//  Created by Daniel Brim on 3/30/15.
//  Copyright (c) 2015 Daniel Brim. All rights reserved.
//

import UIKit
import Pollock

class ViewController: UIViewController {
    
    @IBOutlet weak var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drawView.brush = Brush(color: UIColor.orangeColor(), width: 20.0, alpha: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func colorPressed(sender: UIGestureRecognizer) {
        if let color = sender.view?.backgroundColor {
            drawView.brush.color = color
        }
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
        drawView.reset()
    }
}

