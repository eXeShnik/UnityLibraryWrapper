//
//  Wrapper.swift
//  UnityLibraryWrapper
//
//  Created by Vitalii Overchuk on 22.10.2021.
//

import Foundation
import UnityFramework

@objc(UnityLibraryWrapper) public class UnityLibraryWrapper : NSObject {
    
    var framework: UnityFramework?
    
    private func unityFrameworkLoad() -> UnityFramework {
        
        let b = Bundle.main.bundlePath.appending("/Frameworks/UnityFramework.framework")
        
        let bundle = Bundle(path: b)!
        
        if !bundle.isLoaded {
            bundle.load()
        }

        let ufw: UnityFramework! = bundle.principalClass?.getInstance()
        ufw.setDataBundleId("com.unity3d.framework")
        self.framework = ufw
        
        return ufw
    }
    
    @objc(runEmbeded) func runEmbeded(){
        
        let unityframework = self.unityFrameworkLoad()
        
        unityframework.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: [UIApplication.LaunchOptionsKey: Any]())
    }
    
    @objc(getRootView) func getRootView() -> UIView? {
        return self.framework?.appController().rootView
    }
    
    @objc(quit) func quit() {
        self.framework?.quitApplication(0)
    }
}
