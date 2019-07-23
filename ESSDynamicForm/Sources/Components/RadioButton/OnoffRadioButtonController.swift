/**
 * @copyright ©2018 Onoff Insurance All rights reserved. Trade Secret, Confidential and Proprietary.
 *            Any dissemination outside of Onoff Insurance is strictly prohibited.
 */
import UIKit

/**
 * OnoffRadioButtonController class.
 * This class is responsible to create logical for radio button.
 * @author    Chris Ferdian <chrisferdian@onoff.insure>
 */
public class ESSRadioButtonController: NSObject {
    /**
     * Initiialized array.
     */
    fileprivate var buttonsArray = [ESSRadioButton]()
    /**
     * Initialized delegate
     */
    weak var delegate: ESSRadioButtonControllerDelegate?
    /**
     Set whether a selected radio button can be deselected or not. Default value is false.
     */
    var shouldLetDeSelect = false
    /**
     * Variadic parameter init that accepts UIButtons.
     - parameter buttons: Buttons that should behave as Radio Buttons
     */
    public init(buttons: [ESSRadioButton]) {
        super.init()
        for aButton in buttons {
            aButton.addTarget(self, action: #selector(ESSRadioButtonController.pressed(_:)), for: .touchUpInside)
        }
        self.buttonsArray = buttons
    }
    /**
     * Add a UIButton to Controller
     - parameter button: Add the button to controller.
     */
    func addButton(_ aButton: ESSRadioButton) {
        buttonsArray.append(aButton)
        aButton.addTarget(self, action: #selector(ESSRadioButtonController.pressed(_:)), for: .touchUpInside)
    }
    /**
     * Remove a UIButton from controller.
     - parameter button: Button to be removed from controller.
     */
    func removeButton(_ aButton: ESSRadioButton) {
        var iteratingButton: ESSRadioButton?
        if buttonsArray.contains(aButton) {
            iteratingButton = aButton
        }
        if iteratingButton != nil {
            buttonsArray.remove(at: buttonsArray.index(of: iteratingButton!)!)
            iteratingButton!.removeTarget(self, action: #selector(ESSRadioButtonController.pressed(_:)),
                                          for: .touchUpInside)
            iteratingButton!.isSelected = false
        }
    }
    /**
     * Set an array of UIButons to behave as controller.
     - parameter buttonArray: Array of buttons
     */
    func setButtonsArray(_ aButtonsArray: [ESSRadioButton]) {
        for aButton in aButtonsArray {
            aButton.addTarget(self, action: #selector(ESSRadioButtonController.pressed(_:)), for: .touchUpInside)
        }
        buttonsArray = aButtonsArray
    }
    /**
     * Radio button action
     - parameter buttonArray: Array of buttons
     */
    @objc func pressed(_ sender: UIButton) {
        var currentSelectedButton: UIButton?
        if sender.isSelected {
            if shouldLetDeSelect {
                sender.isSelected = false
                currentSelectedButton = nil
            }
        } else {
            for aButton in buttonsArray {
                aButton.isSelected = false
            }
            sender.isSelected = true
            currentSelectedButton = sender
        }
        delegate?.didSelectButton(selectedButton: currentSelectedButton)
    }
    /**
     * Get the currently selected button.
     - returns: Currenlty selected button.
     */
    func selectedButton() -> UIButton? {
        guard let index = buttonsArray.index(where: { button in button.isSelected }) else { return nil }
        return buttonsArray[index]
    }
}
