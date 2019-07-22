//
//  DummyViewController.swift
//  ESSDynamicFormTests
//
//  Created by AIA-Chris on 22/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import UIKit
import ESSDynamicForm

class DummyViewController: UIViewController, ESSDynamicFormDelegate {
    
    func formResponse(form: ESSDynamicForm, didFinishFormWithData data: [FormResponse]) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
