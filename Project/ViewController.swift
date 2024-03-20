//
//  ViewController.swift
//  Project
//
//  Created by user on 3/6/24.
//

import UIKit
struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class TableViewController: UITableViewController {
    
    var tableViewData = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewData = [
            cellData(opened: false, title: "Africa", sectionData: ["algeria", "angola", "benin", "botswana", "burkina Faso", "burundi", "cabo Verde", "cameroon", "central African Republic", "chad", "comoros", "congo", "Democratic Republic of the Congo", "djibouti", "egypt", "equatorial Guinea", "eritrea", "eswatini", "ethiopia", "gabon", "gambia", "ghana", "guinea", "guinea-Bissau", "ivory coast", "kenya", "lesotho", "liberia", "libya", "madagascar", "malawi", "mali", "mauritania", "mauritius", "morocco", "mozambique", "namibia", "niger", "nigeria", "rwanda", "sao Tome and Principe", "senegal", "seychelles", "sierra Leone", "somalia", "south Africa", "south sudan", "sudan", "tanzania", "togo", "tunisia", "uganda", "zambia", "zimbabwe"]),
            cellData(opened: false, title: "Asia", sectionData: ["afghanistan", "armenia", "azerbaijan", "bahrain", "bangladesh", "bhutan", "brunei", "cambodia", "china", "cyprus", "georgia", "india", "indonesia", "iran", "iraq", "israel", "japan", "jordan", "kazakhstan", "kuwait", "kyrgyzstan", "laos", "lebanon", "malaysia", "maldives", "mongolia", "myanmar", "nepal", "north Korea", "oman", "pakistan", "palestine", "philippines", "qatar", "russia", "saudi arabia", "singapore", "south korea", "sri lanka", "syria", "tajikistan", "thailand", "timor-leste", "turkey", "turkmenistan", "united arab emirates", "uzbekistan", "vietnam", "yemen"]),
            cellData(opened: false, title: "Europe", sectionData: ["albania", "andorra", "austria", "belarus", "belgium", "bosnia and Herzegovina", "bulgaria", "croatia", "czech republic", "denmark", "estonia", "finland", "france", "germany", "greece", "hungary", "iceland", "ireland", "italy", "kosovo", "latvia", "liechtenstein", "lithuania", "luxembourg", "malta", "moldova", "monaco", "montenegro", "netherlands", "north macedonia", "norway", "poland", "portugal", "romania", "san marino", "serbia", "slovakia", "slovenia", "spain", "sweden", "switzerland", "ukraine", "united kingdom", "vatican city"]),
            cellData(opened: false, title: "North America", sectionData: ["antigua and Barbuda", "bahamas", "barbados", "belize", "canada", "costa rica", "cuba", "dominica", "dominican republic", "el salvador", "grenada", "guatemala", "haiti", "honduras", "jamaica", "mexico", "nicaragua", "panama", "saint kitts and Nevis", "saint lucia", "saint vincent and the grenadines", "trinidad and tobago", "united states"]),
            cellData(opened: false, title: "South America", sectionData: ["argentina", "bolivia", "brazil", "chile", "colombia", "ecuador", "guyana", "paraguay", "peru", "suriname", "uruguay", "venezuela"]),
            
    ]
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        }else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            //cell.backgroundColor = UIColor.lightGray
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        if indexPath.row == 0 {
                // Continent cell is selected
                if tableViewData[indexPath.section].opened {
                    tableViewData[indexPath.section].opened = false
                } else {
                    tableViewData[indexPath.section].opened = true
                }
                let sections = IndexSet(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                // Country cell is selected
                let VC = countries_details()
                let selectedCountry = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                VC.countryName = selectedCountry
                print(selectedCountry)
                self.navigationController?.pushViewController(VC, animated: true)
            }
    }

}

