//
//  MatchManager+GKMatchmakerVCDelegate.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/30/24.
//

import Foundation
import UIKit
import GameKit

extension MatchManager: GKMatchmakerViewControllerDelegate{
    
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        print("match found")
        //wait until everyone joins
        getReadyforGame(match)
        viewController.dismiss(animated: true)
    }

    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("error occurred")
        print(error.localizedDescription)
        viewController.dismiss(animated: true)
    }

    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        print("match maker view controller cancelled")
        viewController.dismiss(animated: true)
    }
    
}
