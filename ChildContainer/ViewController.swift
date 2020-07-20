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
    private var stepperView: StepperView = StepperView.init(totalItems: 3, frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--Initialize MainVC")
        self.view.addSubview(stepperView)
        setupObservers()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerA") as? ViewControllerA {
            self.addChildViewController(childViewController: vc)
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addChildCVFrom(notification:)), name: Notification.Name("addChildVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeChildVCFrom(notification:)), name: Notification.Name("removeChildVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(completedState(notification:)), name: Notification.Name("completedState"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finalizedState(notification:)), name: Notification.Name("finalizedState"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(currentState(notification:)), name: Notification.Name("currentState"), object: nil)
    }
    
    @objc func currentState(notification: NSNotification) {
        if let index = notification.object as? Int {
            stepperView.currentState(index: index)
        }
    }
    
    @objc func completedState(notification: NSNotification) {
        if let index = notification.object as? Int {
            stepperView.completedState(index: index)
        }
    }
    
    @objc func finalizedState(notification: NSNotification) {
        if let index = notification.object as? Int {
            stepperView.finalizedState(index: index)
        }
    }
    
    @objc func addChildCVFrom(notification: NSNotification) {
        if let vc = notification.object as? UIViewController {
            addChildViewController(childViewController: vc)
            //stepperView.currentState()
        }
    }
    
    @objc func removeChildVCFrom(notification: NSNotification) {
        if let index = notification.object as? Int {
            stepperView.initialState(index: index)
            stepperView.currentState(index: index-1)
        }
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("--viewDidAppear A")
        NotificationCenter.default.post(name: Notification.Name("currentState"), object: 1)
        delay(2.0) {
            NotificationCenter.default.post(name: Notification.Name("completedState"), object: 1)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("finalizedState"), object: 1)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerB") as? ViewControllerB
        NotificationCenter.default.post(name: Notification.Name("addChildVC"), object: vc)
    }
    
}

class ViewControllerB: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--ViewControllerB")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("--viewDidAppear B")
        NotificationCenter.default.post(name: Notification.Name("currentState"), object: 2)
        delay(2.0) {
            NotificationCenter.default.post(name: Notification.Name("completedState"), object: 2)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("--viewDidDisappear")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("removeChildVC"), object: 2)
        //NotificationCenter.default.post(name: Notification.Name("currentState"), object: 1)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("finalizedState"), object: 2)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerC") as? ViewControllerC
        NotificationCenter.default.post(name: Notification.Name("addChildVC"), object: vc)
    }
}

class ViewControllerC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--ViewControllerC")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("--viewDidAppear C")
        NotificationCenter.default.post(name: Notification.Name("currentState"), object: 3)
        delay(2.0) {
            NotificationCenter.default.post(name: Notification.Name("completedState"), object: 3)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("--viewDidDisappear")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("removeChildVC"), object: 3)
        //NotificationCenter.default.post(name: Notification.Name("currentState"), object: 2)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        print("--comming soon")
        NotificationCenter.default.post(name: Notification.Name("finalizedState"), object: 3)
    }
}

