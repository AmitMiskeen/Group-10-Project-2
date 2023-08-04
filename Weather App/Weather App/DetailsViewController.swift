//
//  DetailsViewController.swift
//  Weather App
//
//  Created by Abhay Miskeen on 2023-08-02.
//

import UIKit

class DetailsViewController: UIViewController,  UITextFieldDelegate  {
    
    weak var delegate: DetailsViewControllerDelegate?
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var weatherImageDisplay: UIImageView!
    
    
    @IBOutlet weak var tempertureLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var searchLocation: UITextField!
    
    @IBOutlet weak var conditionDisplay: UILabel!
    
    var errorItems: [Error] = []
    var celsiusTemperature: Float = 0.00
    var fahrenheitTemperature: Float = 0.00
    var isCelsiusSelected = true
    var responseData: WeatherResponse?
    let firstScreen = "firstScreen"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchLocation.delegate = self
    }
    func textFieldReturn(_ textField: UITextField) -> Bool {
        loadWeather(search: searchLocation.text)
        textField.endEditing(true)
        return true
    }
    
    @IBAction func temperatureType(_ sender: UIButton) {
        if isCelsiusSelected {
            tempertureLabel.text = "\(fahrenheitTemperature)°F"
        } else {
            tempertureLabel.text = "\(celsiusTemperature)°C"
        }
        isCelsiusSelected = !isCelsiusSelected
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        loadWeather(search: searchLocation.text)
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func addLocationButton(_ sender: UIBarButtonItem) {
        if let responseData = self.responseData {
            delegate?.didAddWeatherData(responseData)
        }
        dismiss(animated: true)
    }
    
    @IBAction func logsButton(_ sender: UIButton) {
        if let historyViewController = storyboard?.instantiateViewController(withIdentifier: "history") as? CitiesHistoryViewController {
            historyViewController.errorArray = errorItems
            present(historyViewController, animated: true, completion: nil)
        }
    }
    
    func loadWeather(search: String?) {
        guard let search = search else {
            return
        }
        
        guard let url = getUrl(query: search) else {
            print("Could not get url")
            return
        }
        
        let urlSession = URLSession.shared
                
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            print("Network call complete")
            
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            
            if let weatherResponse = self.parseJson(data: data) {

                self.responseData = weatherResponse

                self.errorItems.append(weatherResponse.error ?? Error(code: 200, message: "Data Found!"))

                self.cel = weatherResponse.current?.temp_c ?? 0.00
                self.far = weatherResponse.current?.temp_f ?? 0.00

                self.setImageFromUrl("https:\(String(describing: weatherResponse.current?.condition.icon))", on: self.weatherImage)
                DispatchQueue.main.async {

                    if weatherResponse.current?.is_day == 1 {
                        self.view.layer.contents = UIImage(named: "day_1")?.cgImage
                        self.tempratureLabel.textColor = UIColor.black
                        self.locationName.textColor = UIColor.black
                        self.searchTextField.backgroundColor = UIColor.white

                    } else {
                        self.view.layer.contents = UIImage(named: "urban")?.cgImage
                        self.tempratureLabel.textColor = UIColor.yellow
                        self.locationName.textColor = UIColor.white
                        self.searchTextField.backgroundColor = UIColor.gray
                    }

                    self.locationName.text = weatherResponse.location?.name
                    self.tempratureLabel.text = "\(String(describing: weatherResponse.current?.temp_c))°C"
                    self.conditionsLabel.text = weatherResponse.current?.condition.text

                }
            }
        }
        
        dataTask.resume()
        
    }

    func setImage(_ urlString: String, on imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        task.resume()
    }
    
    private func getUrl(query: String) -> URL? {
        let baseUrl = "https://api.weatherapi.com"
        let endpoint = "/v1/forecast.json"
        let apiKey = "cc904dc39d0f41159c622652230408 "
        guard let url = "\(baseUrl)\(endpoint)?key=\(apiKey)&q=\(query)&days=1"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        print(url)
        
        return URL(string: url)
    }
    
    func parseJson(data: Data) -> WeatherResponse? {
        let decoder = JSONDecoder()
        var weather: WeatherResponse?
        do {
            weather = try decoder.decode(WeatherResponse.self, from: data)
        } catch {
            print("Error decoding: \(error)")
        }
        return weather
    }
}
    
   protocol DetailsViewControllerDelegate: AnyObject {
      func didAddWeatherData(_ data: WeatherResponse)
}
    

