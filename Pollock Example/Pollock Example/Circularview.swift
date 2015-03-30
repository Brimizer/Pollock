//
//  Circularview.swift
//  Pollock
//
//  Created by Daniel Brim on 3/30/15.
//  Copyright (c) 2015 Daniel Brim. All rights reserved.
//

import UIKit

class Circularview: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 2.0
    }
}
