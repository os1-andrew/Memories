//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Andrew Dhan on 8/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localNotificationHelper.getAuthorizationStatus { (authorizationStatus) in
            if authorizationStatus == .authorized{
                self.performSegue(withIdentifier: "AccessGranted", sender: nil)
            }
            
        }
    }
    @IBAction func finishOnboarding(_ sender: Any) {
        localNotificationHelper.requestAuthorization { (isSuccessful) in
            if isSuccessful {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "AccessGranted", sender: nil)
            } else {
                NSLog("Did not receive permission")
            }
        }
    }
    
    
    
    //MARK: - Properties
    let localNotificationHelper = LocalNotificationHelper()
    
}
