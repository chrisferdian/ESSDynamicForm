/**
 * @copyright ©2018 Onoff Insurance All rights reserved. Trade Secret, Confidential and Proprietary.
 *            Any dissemination outside of Onoff Insurance is strictly prohibited.
 */
import UIKit

/**
 * OnoffRadioButton class.
 * This class is responsible to craete radio button.
 * @author    Chris Ferdian <chrisferdian@onoff.insure>
 */
class OnoffRadioButton: UIButton {
    /**
     * Initialized layer for create circle shape
     */
    fileprivate var circleLayer = CAShapeLayer()
    /**
     * I nitialized layer for create fill circle shape
     */
    fileprivate var fillCircleLayer = CAShapeLayer()
    
    /**
     * Bool property for getting radio state
     */
    override var isSelected: Bool {
        didSet {
            toggleButon()
        }
    }
    
    /**
     Color of the radio button circle. Default value is UIColor red.
     */
    @IBInspectable var circleColor: UIColor = UIColor.red {
        didSet {
            circleLayer.strokeColor = strokeColor.cgColor
            self.toggleButon()
        }
    }
    
    /**
     Color of the radio button stroke circle. Default value is UIColor red.
     */
    @IBInspectable var strokeColor: UIColor = UIColor.gray {
        didSet {
            circleLayer.strokeColor = strokeColor.cgColor
            self.toggleButon()
        }
    }
    
    /**
     * Radius of RadioButton circle.
     */
    @IBInspectable var circleRadius: CGFloat = 5.0
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /**
     * Frame of circle
     */
    fileprivate func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        circleFrame.origin.x = 0 + circleLayer.lineWidth
        circleFrame.origin.y = bounds.height/2 - circleFrame.height/2
        return circleFrame
    }
    
    /**
     * prepare layer.
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /**
     * prepare frame.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /**
     * Prepare to customize layer.
     */
    fileprivate func initialize() {
        circleLayer.frame = bounds
        circleLayer.lineWidth = 2
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = strokeColor.cgColor
        layer.addSublayer(circleLayer)
        fillCircleLayer.frame = bounds
        fillCircleLayer.lineWidth = 2
        fillCircleLayer.fillColor = UIColor.clear.cgColor
        fillCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(fillCircleLayer)
        self.titleEdgeInsets = UIEdgeInsets(top:0, left:(2*circleRadius + 2*circleLayer.lineWidth), bottom:0, right:0)
        self.toggleButon()
    }
    
    /**
     Toggles selected state of the button.
     */
    func toggleButon() {
        if self.isSelected {
            fillCircleLayer.fillColor = circleColor.cgColor
            circleLayer.strokeColor = circleColor.cgColor
        } else {
            fillCircleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    /**
     * Variable to create circle line
    */
    fileprivate func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame())
    }
    
    /**
     * Variable to create inside circle
     */
    fileprivate func fillCirclePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame().insetBy(dx: 2, dy: 2))
    }
    
    /**
     * setup frame.
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.frame = bounds
        circleLayer.path = circlePath().cgPath
        fillCircleLayer.frame = bounds
        fillCircleLayer.path = fillCirclePath().cgPath
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: (2*circleRadius + 4*circleLayer.lineWidth), bottom: 0, right: 0)
    }
    
    /**
     * prepare interface builder.
     */
    override func prepareForInterfaceBuilder() {
        initialize()
    }
}
