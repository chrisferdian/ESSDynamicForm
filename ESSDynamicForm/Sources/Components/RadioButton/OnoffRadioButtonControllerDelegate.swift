/**
 * @copyright ©2018 Onoff Insurance All rights reserved. Trade Secret, Confidential and Proprietary.
 *            Any dissemination outside of Onoff Insurance is strictly prohibited.
 */
import UIKit
/**
 * OnoffRadioButtonControllerDelegate.
 * This protocol is responsible to create the way for radioButton connected with viewController.
 * @author    Chris Ferdian <chrisferdian@onoff.insure>
 */
@objc protocol OnoffRadioButtonControllerDelegate {
    /**
     * This function is called when a button is selected. If 'shouldLetDeSelect' is true, and a button is deselected, this function is called with a nil.
     */
    @objc func didSelectButton(selectedButton: UIButton?)
}
