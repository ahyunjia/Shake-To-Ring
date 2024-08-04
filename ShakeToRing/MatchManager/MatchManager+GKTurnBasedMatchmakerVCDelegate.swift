//
//  MatchManager+GKMatchmakerVCDelegate.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/30/24.
//

import Foundation
import UIKit
import GameKit

extension MatchManager: GKTurnBasedMatchmakerViewControllerDelegate {
    
    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFind match: GKTurnBasedMatch) {
        
        startGame(match)
        viewController.dismiss(animated: true)
    }
    
    func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
        print("match maker view controller cancelled")
        viewController.dismiss(animated: true)
    }
    
    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
        print("error occurred")
        print(error.localizedDescription)
        viewController.dismiss(animated: true)
    }
    
//    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
//        print("match found")
//        viewController.dismiss(animated: true)
//    }
//
//    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
//        print("error occurred")
//        print(error.localizedDescription)
//        viewController.dismiss(animated: true)
//    }
//
//    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
//        print("match maker view controller cancelled")
//    }
    
}
