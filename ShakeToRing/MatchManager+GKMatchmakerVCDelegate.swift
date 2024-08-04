//
//  MatchManager+GKMatchmakerVCDelegate.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/30/24.
//

import Foundation
import GameKit

extension MatchManager: GKTurnBasedMatchmakerViewControllerDelegate {
    func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
}
