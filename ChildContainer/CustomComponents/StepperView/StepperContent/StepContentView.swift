import UIKit

enum State {
    case initial
    case current
    case completed
    case finalized
}

class StepContentView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepImage: UIImageView!
    @IBOutlet weak var stepCircleView: UIView!
    @IBOutlet var stepLineView: UIView!
    
    var state: State = .initial {
        didSet {
            switch state {
            case State.initial:
                initalState()
                break
            case State.current:
                currentState()
                break
            case State.completed:
                completedStated()
                break
            case State.finalized:
                finalizedStated()
                break
            }
        }
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
        self.addSubview(contentView)
        state = .initial
        stepImage.isHidden = true
        stepImage.image = UIImage.init(named: "finalizedIcon")
        stepCircleView.layer.cornerRadius = stepCircleView.frame.size.width/2
        stepCircleView.clipsToBounds = true
    }
    
    private func initalState() {
        removeImageFromButton()
        stepCircleView.backgroundColor = UIColor.lavender()
        stepLineView.backgroundColor = UIColor.lavender()
    }
    
    private func currentState() {
        removeImageFromButton()
        stepCircleView.backgroundColor = UIColor.burple()
        stepLineView.backgroundColor = UIColor.burple()
    }
    
    private func completedStated() {
        removeImageFromButton()
        stepCircleView.backgroundColor = UIColor.primaryGreen()
        stepLineView.backgroundColor = UIColor.primaryGreen()
    }
    
    private func finalizedStated() {
        stepImage.isHidden = false
        stepCircleView.backgroundColor = UIColor.primaryGreen()
        stepLineView.backgroundColor = UIColor.primaryGreen()
        stepLabel.text = ""
    }
    
    private func removeImageFromButton() {
        stepImage.isHidden = true
        stepLabel.text = "1"
    }
}
