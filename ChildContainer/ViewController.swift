//
//  ViewController.swift
//  ChildContainer
//
//  Created by softtek on 17/07/20.
//  Copyright © 2020 softtek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var childContainerView: UIView!
    @IBOutlet weak var stepperView: StepperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--Initialize MainVC")
        setupObservers()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerA") as? ViewControllerA {
            self.addChildViewController(childViewController: vc)
        }
        stepperView.currentState()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addChildCVFrom(notification:)), name: Notification.Name("addChildVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeChildVCFrom(notification:)), name: Notification.Name("removeChildVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(completedState(notification:)), name: Notification.Name("completedState"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finalizedState(notification:)), name: Notification.Name("finalizedState"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(currentState(notification:)), name: Notification.Name("currentState"), object: nil)
    }
    
    @objc func currentState(notification: NSNotification) {
        stepperView.currentState()
    }
    
    @objc func completedState(notification: NSNotification) {
        stepperView.completedState()
    }
    
    @objc func finalizedState(notification: NSNotification) {
        stepperView.finalizedState()
    }
    
    @objc func addChildCVFrom(notification: NSNotification) {
        if let vc = notification.object as? UIViewController {
            addChildViewController(childViewController: vc)
            stepperView.currentState()
        }
    }
    
    @objc func removeChildVCFrom(notification: NSNotification) {
        stepperView.initialState()
        removeChildViewController()
    }
    
    private func addChildViewController(childViewController: UIViewController) {
        childViewController.view.frame = childContainerView.bounds
        self.childContainerView?.addSubview(childViewController.view)
        self.addChild(childViewController)
        childViewController.didMove(toParent: self)
    }
    
    private func removeChildViewController() {
        if self.children.count > 0 {
            let viewControllers: [UIViewController] = self.children
            if let last = viewControllers.last {
                last.willMove(toParent: nil)
                last.view.removeFromSuperview()
                last.removeFromParent()
            }
        }
    }
    
}

class ViewControllerA: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--ViewControllerA")
        delay(2.0) {
            NotificationCenter.default.post(name: Notification.Name("completedState"), object: nil)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        NotificationCenter.default.post(name: Notification.Name("currentState"), object: nil)
//    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("removeChildVC"), object: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("finalizedState"), object: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerB") as? ViewControllerB
        NotificationCenter.default.post(name: Notification.Name("addChildVC"), object: vc)
    }
    
}

class ViewControllerB: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--ViewControllerB")
        delay(2.0) {
            NotificationCenter.default.post(name: Notification.Name("completedState"), object: nil)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        NotificationCenter.default.post(name: Notification.Name("currentState"), object: nil)
//    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("removeChildVC"), object: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("finalizedState"), object: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerC") as? ViewControllerC
        NotificationCenter.default.post(name: Notification.Name("addChildVC"), object: vc)
    }
}

class ViewControllerC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--ViewControllerC")
        delay(2.0) {
            NotificationCenter.default.post(name: Notification.Name("completedState"), object: nil)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        NotificationCenter.default.post(name: Notification.Name("currentState"), object: nil)
//    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("removeChildVC"), object: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        print("--comming soon")
        NotificationCenter.default.post(name: Notification.Name("finalizedState"), object: nil)
    }
}

