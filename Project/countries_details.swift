//
//  countries_details.swift
//  Project
//
//  Created by user on 3/14/24.
//

import UIKit



class countries_details: UIViewController {
    
    var countryName: String?

    @IBOutlet weak var timezone: UILabel!
    @IBOutlet weak var subregion: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var img: UIImageView!   
    @IBOutlet weak var titlecountry: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        if let countryName = countryName {
                    fetchCountryInfo(countryName: countryName)
                }

    }
    
    func fetchCountryInfo(countryName: String) {
        let urlString = "https://restcountries.com/v3.1/name/\(countryName)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Print the raw data as a string
            
            do {
                let decoder = JSONDecoder()
                let countryData = try decoder.decode([CountryData].self, from: data)
                
                if let countryInfo = countryData.first {
                    DispatchQueue.main.async {
                        self.updateUI(with: countryInfo)
                    }
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }

    func updateUI(with countryInfo: CountryData) {
        titlecountry.text = countryInfo.name.common
        capital.text = countryInfo.capital.joined(separator: ", ")
        population.text = "\(countryInfo.population)"
        region.text = countryInfo.region
        subregion.text = countryInfo.subregion
        timezone.text = countryInfo.timezones.joined(separator: ", ")
        
        if let flagURL = URL(string: countryInfo.flags.png) {
            URLSession.shared.dataTask(with: flagURL) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.img.image = image
                }
            }.resume()
        }
    }


    
}

struct CountryData: Codable {
    let name: NameData
    let capital: [String]
    let population: Int
    let region: String
    let subregion: String
    let timezones: [String]
    let flags: FlagData
}

struct NameData: Codable {
    let common: String
    let official: String
}

struct FlagData: Codable {
    let png: String
}
