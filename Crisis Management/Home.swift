//
//  HomeViewController.swift
//  Crisis Management
//
//  Created by Mukund Raman on 11/7/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, BackTitle {
    
    /* Variables from Interface Builder */
    
    @IBOutlet weak var Call911Btn: UIButton!
    @IBOutlet weak var ReportBtn: UIButton!
    @IBOutlet weak var ProtocolsBtn: UIButton!
    @IBOutlet weak var CallAdminBtn: UIButton!
    @IBOutlet weak var ResourcesBtn: UIButton!
    @IBOutlet var HomeBtns: [UIButton]!
    var backTitle: String!
    
    // Storyboard instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundBtns(radius: 15)
        self.backTitle = "Home"
        
        if let ctrs = self.navigationController?.viewControllers, ctrs.count > 1 {
            let viewController = ctrs[ctrs.count - 2] as! BackTitle
            let backButton = UIBarButtonItem()
            backButton.title = viewController.backTitle
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    }
    
    // Round the corners of the buttons
    func roundBtns(radius: Double) {
        for btn in self.HomeBtns {
            btn.layer.cornerRadius = CGFloat(radius)
            btn.layer.masksToBounds = true
        }
    }

    // Call 911 if necessary
    @IBAction func call911(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to call 911", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default))
        alertController.addAction(UIAlertAction(title: "Call", style: .destructive, handler: { (_) in
            let alertController = UIAlertController(title: "Calling 911", message: "If this was the final app you'd be calling 911 right now.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            print("911")
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Call In School or Out of School Version of 'Call An Admin' Screen
    @IBAction func callAdminPressed(_ sender: UIButton) {
        var callAdminController: UIViewController!
        if InOutSchoolController.insideSchool {
            callAdminController = storyboard!.instantiateViewController(withIdentifier: "adminInSchool") as! CallAdminInSchoolController
        } else {
            callAdminController = storyboard!.instantiateViewController(withIdentifier: "adminOutSchool") as! CallAdminOutSchoolController
        }
        self.navigationController?.pushViewController(callAdminController, animated: true)
    }
}