//
//  DetailsViewController.swift
//  Weather App
//
//  Created by Abhay Miskeen on 2023-08-02.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var weatherImageDisplay: UIImageView!
    
    
    @IBOutlet weak var tempertureLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var searchLocation: UISearchBar!
    
    
    @IBOutlet weak var conditionDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func temperatureType(_ sender: UIButton) {
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func addLocationButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func logsButton(_ sender: UIButton) {
    }
    
}

