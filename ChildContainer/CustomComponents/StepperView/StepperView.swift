import UIKit

class StepperView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet weak var trailingLayoutConstraint: NSLayoutConstraint!
    private var totalItems: Int = 0
    
    init(totalItems: Int, frame: CGRect) {
        super.init(frame: frame)
        self.totalItems = totalItems
        setupView()
    }
    
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
        if self.totalItems != 0 {
            trailingLayoutConstraint.constant = (UIScreen.main.bounds.width / (CGFloat(self.totalItems + 1) ))
        }
        self.addSubview(contentView)
        
        if self.totalItems != 0 {
            for index in 1...self.totalItems {
                print(index)
                if index == 1 {
                    let initialStepContentView = InitialStepContentView.init()
                    initialStepContentView.tag = index
                    initialStepContentView.stepLabel.text = "\(index)"
                    stackView.addArrangedSubview(initialStepContentView)
                } else {
                    let stepContentView = StepContentView.init()
                    stepContentView.tag = index
                    stepContentView.stepLabel.text = "\(index)"
                    stackView.addArrangedSubview(stepContentView)
                }
            }
        }
    }
    
    func initialState(index: Int) {
        let subview = getStackView(index: index)
        if subview.isKind(of: StepContentView.self) {
            if let stepContent = subview as? StepContentView {
                stepContent.state = .initial
            }
        } else if subview.isKind(of: InitialStepContentView.self) {
            if let stepContent = subview as? InitialStepContentView {
                stepContent.state = .initial
            }
        }
    }
    
    func currentState(index: Int) {
        let subview = getStackView(index: index)
        if subview.isKind(of: StepContentView.self) {
            if let stepContent = subview as? StepContentView {
                stepContent.state = .current
            }
        } else if subview.isKind(of: InitialStepContentView.self) {
            if let stepContent = subview as? InitialStepContentView {
                stepContent.state = .current
            }
        }
    }
    
    func completedState(index: Int) {
        let subview = getStackView(index: index)
        if subview.isKind(of: StepContentView.self) {
            if let stepContent = subview as? StepContentView {
                stepContent.state = .completed
            }
        } else if subview.isKind(of: InitialStepContentView.self) {
            if let stepContent = subview as? InitialStepContentView {
                stepContent.state = .completed
            }
        }
    }
    
    func finalizedState(index: Int) {
        let subview = getStackView(index: index)
        if subview.isKind(of: StepContentView.self) {
            if let stepContent = subview as? StepContentView {
                stepContent.state = .finalized
            }
        } else if subview.isKind(of: InitialStepContentView.self) {
            if let stepContent = subview as? InitialStepContentView {
                stepContent.state = .finalized
            }
        }
    }
    
    private func getStackView(index: Int) -> UIView {
        return stackView.subviews[index-1]
    }
}
