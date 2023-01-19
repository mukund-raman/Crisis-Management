//
//  ViewController.swift
//  Crisis Management
//
//  Created by Adarsh Goura on 11/1/22.
//

import UIKit

class InOutSchoolController: UIViewController, BackTitle {

    /* Variables from Interface Builder */
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet var cisdLogo: UIImageView!
    
    @IBOutlet var reportIssueLabel: UILabel!
    @IBOutlet var reportSubtitleLabel: UILabel!
    
    @IBOutlet var settingsButton: UIBarButtonItem!
    @IBOutlet var inSchoolButton: UIButton!
    @IBOutlet var outSchoolButton: UIButton!
    
    @IBOutlet var stackView: UIStackView!
    var backTitle: String!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Home View Controller
    var homeViewController: HomeViewController!
    static var insideSchool: Bool!
    
    // When the view is initially loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = UIScreen.main.bounds.size
        if size.height < size.width {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
        inSchoolButton.layer.cornerRadius = 25
        inSchoolButton.layer.masksToBounds = true
        
        outSchoolButton.layer.cornerRadius = 25
        outSchoolButton.layer.masksToBounds = true
        
        
    }
    
    // Change layout of in and out of school buttons to vertical
    // or horizontal based on device orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let _ = stackView else { return }
        
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
        print(appDelegate.hasAlreadyLaunched!)
        if(!appDelegate.hasAlreadyLaunched){
            //set hasAlreadyLaunched to false
            appDelegate.sethasAlreadyLaunched()
            //display teams alert
            teamsAlert()
        }
    }

    // Show Teams Alert
    func teamsAlert() {
        let alertController = UIAlertController(title: "Calls", message:
                "This app uses Microsoft Teams to make calls. Please make sure to set up Teams on your device before you call.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    /* Actions for buttons from Interface Builder */
    
    // When the settings button is pressed
    @IBSegueAction func settingsSegueAction(_ coder: NSCoder, sender: Any?) -> SettingsController? {
        self.backTitle = "Select Location"
        return SettingsController(coder: coder)
    }
    
    
    // When the In School button is pressed
    @IBSegueAction func inSchoolSegueAction(_ coder: NSCoder, sender: UIButton?) -> HomeViewController? {
        self.backTitle = "In School"
        InOutSchoolController.insideSchool = true
        return HomeViewController(coder: coder)
    }
    
    // When the Out of School button is pressed
    @IBSegueAction func outSchoolSegueAction(_ coder: NSCoder, sender: UIButton?) -> HomeViewController? {
        self.backTitle = "Out of School"
        InOutSchoolController.insideSchool = false
        return HomeViewController(coder: coder)
    }
}

protocol BackTitle {
    var backTitle: String! { get set }
}