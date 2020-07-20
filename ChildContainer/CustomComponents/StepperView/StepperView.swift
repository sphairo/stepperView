import UIKit

class StepperView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        contentView = loadViewFromNib()
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
    
    func initialState() {
        for step in stackView.subviews.reversed() {
            print(step)
            if let stepContent = step as? StepContentView, stepContent.state == .finalized {
                stepContent.state = .initial
                return
            }
        }
    }
    
    func currentState() {
        for step in stackView.subviews {
            print(step)
            if let stepContent = step as? StepContentView, stepContent.state == .initial {
                stepContent.state = .current
                return
            }
        }
    }
    
    func completedState() {
        for step in stackView.subviews {
            print(step)
            if let stepContent = step as? StepContentView, stepContent.state == .current {
                stepContent.state = .completed
                return
            }
        }
    }
    
    func finalizedState() {
        for step in stackView.subviews {
            print(step)
            if let stepContent = step as? StepContentView, stepContent.state == .completed {
                stepContent.state = .finalized
                return
            }
        }
    }
    
//    func nextStep() {
//        for step in stackView.subviews {
//            print(step)
//            if let stepContent = step as? StepContentView, !stepContent.isCurrentState {
//                stepContent.isCurrentState = true
//                return
//            }
//        }
//    }
//
//    func stepCompleted() {
//        for step in stackView.subviews {
//            if let stepContent = step as? StepContentView, !stepContent.isCompleted {
//                stepContent.isCompleted = true
//                return
//            }
//        }
//    }
//
//    func previousStep() {
//        for step in stackView.subviews.reversed() {
//            if let stepContent = step as? StepContentView, stepContent.isCurrentState {
//                stepContent.isCurrentState = false
//                return
//            }
//        }
//    }
}
