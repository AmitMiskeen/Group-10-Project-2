//
//  ViewController.swift
//  Weather App
//
//  Created by Abhay Miskeen on 2023-08-02.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tempToggleButton(_ sender: UIButton) {
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    
    @IBAction func logsButton(_ sender: UIButton) {
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func addLocationButton(_ sender: UIBarButtonItem) {
    }
}

