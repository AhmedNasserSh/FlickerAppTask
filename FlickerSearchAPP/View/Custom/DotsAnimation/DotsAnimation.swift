//
//  DotsAnimation.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/22/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import UIKit
class DotsAnimation {
    
    func stopDotsAnimation(dots:UIView?) {
        LoggerRepo.logInfo("DotsAnimation:stopDotsAnimation")
        LoggerRepo.logDebug("DotsAnimation:stopDotsAnimation,Parmters:(dots:UIView?)")
        if dots != nil {
            for subview in (dots?.subviews)! {
                subview.removeFromSuperview()
            }
            dots?.removeFromSuperview()
        }
    }
    
    func startDotsAnimation(superView:UIView, dotsColor:UIColor) -> UIView {
        LoggerRepo.logInfo("DotsAnimation:startDotsAnimation")
        LoggerRepo.logDebug("DotsAnimation:startDotsAnimation,Parmters:(superView:UIView, dotsColor:UIColor) -> UIView ")
        let dots = self.buildView(superView: superView, dotsColor: dotsColor)
        animateWithKeyframes(dotToAnimate: dots.subviews[0], delay: 0.0)
        animateWithKeyframes(dotToAnimate: dots.subviews[1], delay: 0.3)
        animateWithKeyframes(dotToAnimate: dots.subviews[2], delay: 0.6)
        return dots
    }
    
    private func buildView(superView:UIView, dotsColor:UIColor) -> UIView {
        LoggerRepo.logInfo("DotsAnimation:buildView")
        LoggerRepo.logDebug("DotsAnimation:buildView,Parmters:(superView:UIView, dotsColor:UIColor) -> UIView ")
        let dots = UIView(frame: CGRect(x:0 , y: 0, width: 50, height: 50))
        dots.backgroundColor = UIColor(white: 1, alpha: 0)
        let numberDots = CGFloat(3)
        let width = CGFloat(dots.frame.width/6)
        let dotDiameter = (dots.frame.height < width) ? dots.frame.height : width
        var frame = CGRect(x: (dots.frame.origin.x + width), y: (dots.frame.origin.y + (dots.frame.height/2) - (dotDiameter/2)), width: dotDiameter, height: dotDiameter)
        let cornerRadiusLocal = dotDiameter / 2
        for _ in 0...Int(numberDots-1) {
            let dot:UIView = UIView(frame:frame)
            dot.layer.cornerRadius = cornerRadiusLocal;
            dot.backgroundColor = dotsColor
            dots.addSubview(dot)
            frame.origin.x += (1.6 * dotDiameter)
        }
        return dots
    }
    
    private func animateWithKeyframes(dotToAnimate:UIView, delay:Double) {
        LoggerRepo.logInfo("DotsAnimation:animateWithKeyframes")
        LoggerRepo.logDebug("DotsAnimation:animateWithKeyframes,Parmters:(dotToAnimate:UIView, delay:Double) ")
        UIView.animateKeyframes(
            withDuration: 0.9,
            delay: delay,
            options: [UIView.KeyframeAnimationOptions.repeat],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.33333333333,
                    animations: {
                        dotToAnimate.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.33333333333,
                    relativeDuration: 0.66666666667,
                    animations: {
                        dotToAnimate.transform = CGAffineTransform.identity
                }
                )
            }
        )
    }
}
