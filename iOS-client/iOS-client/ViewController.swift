//
//  ViewController.swift
//  SelfSignedSSLCertDemo
//
//  Created by Shameem Ahamad on 26/03/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func connect() {
        
        NetworkClient().healthCheck { data, error in
            if let data = data {
                let serverMessage = String(data: data, encoding: .utf8)
                print("response: \(String(describing: serverMessage))")
            }
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
}

