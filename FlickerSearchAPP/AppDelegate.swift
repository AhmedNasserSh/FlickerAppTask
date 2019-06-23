//
//  AppDelegate.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/16/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit
import KVNProgress
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        setupLoaderConfigerations()
        return true
    }
    func setupLoaderConfigerations() {
        LoggerRepo.logInfo("AppDelegate:setupLoaderConfigerations")
        LoggerRepo.logDebug("AppDelegate:setupLoaderConfigerations,Parmters:()")
        let configuration = KVNProgressConfiguration()
        
        configuration.statusColor = UIColor.white
        
        configuration.circleStrokeForegroundColor = UIColor.white
        configuration.circleStrokeBackgroundColor = UIColor.clear
        configuration.circleFillBackgroundColor = UIColor.clear
        
        configuration.backgroundType = .solid
        configuration.backgroundFillColor = UIColor.clear
        configuration.backgroundTintColor = UIColor.clear
        
        configuration.successColor = UIColor.clear
        configuration.errorColor = UIColor.clear
        configuration.stopColor = UIColor.clear
        
        configuration.circleSize = 90.0
        configuration.lineWidth = 3.0
        configuration.isFullScreen = false
        configuration.doesShowStop = false
        configuration.stopRelativeHeight = 0.2
        configuration.tapBlock = { progressView in
        }
        
        configuration.doesAllowUserInteraction = false
        
        KVNProgress.setConfiguration(configuration)
    }
}

