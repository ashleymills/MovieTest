//
//  ViewControllerAlerting.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

protocol ViewControllerAlerting {
}

extension ViewControllerAlerting where Self: UIViewController {
    func presentAlert(for error: Error, retryAction: (() -> Void)? = nil) {
        
        let nsError = error as NSError
        let title = nsError.localizedDescription
        let message = nsError.localizedFailureReason
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let retryAction = retryAction {
            alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                retryAction()
            })
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

