import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var synth : AVSpeechSynthesizer?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        NSLog("***** Will create synth")
        let startDate = Date()
        synth = AVSpeechSynthesizer()
        let elapsedTime = Date().timeIntervalSince(startDate)
        NSLog("***** Creating AVSpeechSynthesizer took \(elapsedTime) seconds.")
        
        let string = String(format: "The debug console will fill with garbage.")
        NSLog("***** Will create utterance")
        let utterance = AVSpeechUtterance(string: string)
        NSLog("***** Will utter")
        self.synth!.speak(utterance)
        NSLog("***** Did utter")

        return true
    }
}

