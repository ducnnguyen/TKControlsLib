//
//  UIApplication+TKExtension.swift
//  TKControlsLib
//
//  Created by LAP01272 on 11/18/21.
//

import Foundation
import UIKit

public extension UIApplication {
    @objc
    class func webUserAgent(appName: String, executeName: String) -> String {
        //[AppName]/[App version] ([Device type]; [Platform version]; [Device model + Build number])
        return "\(appName)/\(UIApplication._appVersion) (\(UIDevice.current.model); \(UIDevice.current.systemName) \(UIDevice.current.systemVersion); WebView; \(executeName); \(UIDevice.modelName) \(UIApplication._appBuild))"
    }
    
    @objc
    class func userAgent(appName: String) -> String {
        //[AppName]/[App version] ([Device type]; [Platform version]; [Device model + Build number])
        return "\(appName)/\(UIApplication._appVersion) (\(UIDevice.current.model); \(UIDevice.current.systemName) \(UIDevice.current.systemVersion); \(UIDevice.modelName) \(UIApplication._appBuild))"
    }
    
    static let _appVersion : String = {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "Unknown"
    }()
    
    static let _appBuild : String = {
        return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "Unknown"
    }()
    
    static let _bundleId : String = {
        return Bundle.main.bundleIdentifier ?? "Unknown"
    }()
    
    static let _appVersionWithBuild: String = {
        if UIApplication._appVersion == UIApplication._appBuild {
            return UIApplication._appVersion
        }
        return "\(UIApplication._appVersion)(\(UIApplication._appBuild))"
    }()
    
    
}
