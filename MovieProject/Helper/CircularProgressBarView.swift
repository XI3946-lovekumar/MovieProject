//
//  CircularProgressBarView.swift
//  MovieProject
//
//  Created by Apple on 12/01/23.
//

import Foundation
import UIKit

final class CircularProgressView: UIView {
    /// Varriable
    private let  progressLyr = CAShapeLayer()
    private let trackLyr = CAShapeLayer()
    private var isLoader = false
    private let titleLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeCircularPath()
    }
    
    var progressClr = UIColor.red {
        didSet {
            progressLyr.strokeColor = progressClr.cgColor
        }
    }
    
    var trackClr = UIColor.red.withAlphaComponent(0.3) {
        didSet {
            trackLyr.strokeColor = trackClr.cgColor
        }
    }
    
    func makeCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLyr.path = circlePath.cgPath
        trackLyr.fillColor = UIColor.clear.cgColor
        trackLyr.strokeColor = trackClr.cgColor
        trackLyr.lineWidth = 5.0
        trackLyr.strokeEnd = 1.0
        layer.addSublayer(trackLyr)
        progressLyr.path = circlePath.cgPath
        progressLyr.fillColor = UIColor.clear.cgColor
        progressLyr.strokeColor = progressClr.cgColor
        progressLyr.lineWidth = 5.0
        progressLyr.strokeEnd = 0.0
        layer.addSublayer(progressLyr)
        
        titleLabel.frame = self.bounds
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        self.addSubview(titleLabel)
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        if !isLoader {
            isLoader = true
        }
        
        animation.duration = isLoader ? duration : 0
        animation.fromValue = 0
        animation.toValue = value
        titleLabel.text = "\(Int(value*100))%"
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLyr.strokeEnd = CGFloat(value)
        progressLyr.add(animation, forKey: "animateprogress")
    }
}
