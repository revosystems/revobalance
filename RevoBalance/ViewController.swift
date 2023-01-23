//
//  ViewController.swift
//  RevoBalance
//
//  Created by Jordi Puigdellívol on 23/1/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightLabel: UILabel!
    lazy var balance:Balance = {
        Balance(ip:"10.0.1.190")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                try await balance.start()
            }catch{
                debugPrint("\(error)")
            }
        }
    }

    @IBAction func getWeightPresset(_ sender: Any) {
        Task {
            do{
                let result = try await balance.getWeight()
                weightLabel.text = "\(result)"
            }catch{
                debugPrint("error: \(error)")
            }
        }
    }
}

