//
//  InfoViewController.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 8/17/22.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let query = WikipediaResultManager.shared.wikiAPIResult?.query
        else {
            return
        }
        
        self.infoLabel.text = query.pages[query.pageids.first ?? ""]?.extract
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    

}
