import UIKit

class CountryDetailViewController: UIViewController {
    var countryName: String?
    
    @IBOutlet weak var countryNameLabel: UILabel! // Connect this outlet to the UILabel in your storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the country name
        if let countryName = countryName {
            countryNameLabel.text = "Country: \(countryName)"
        }
    }
}
