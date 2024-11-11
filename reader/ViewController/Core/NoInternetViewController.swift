//
//  NoInternetViewController.swift
//  reader
//
//  Created by Krina on 11/11/24.
//

import UIKit
import Lottie

protocol NoInternetViewControllerDelegate: AnyObject {
    func noInternetViewControllerDidTapRetry()
}

class NoInternetViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    // MARK: - Properties
    weak var delegate: NoInternetViewControllerDelegate?
    private let reachabilityManager: ReachabilityManager? = nil

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottieAnimation()
    }

    // MARK: - Setup
    private func setupLottieAnimation() {
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
    }

    // MARK: - Actions
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        if reachabilityManager?.isConnceted == true {
            delegate?.noInternetViewControllerDidTapRetry()
            dismiss(animated: true)
        } 
    }

}
