//
//  CustomTableViewCell.swift
//  Guidomia
//
//  Created by Amine CHATATE on 30/3/2023.
//

import UIKit
import Cosmos

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomCollectionViewCell"
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var marketPriceLabel: UILabel!
    @IBOutlet weak var cosmosRating: CosmosView!
    @IBOutlet weak var consLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func configure(with carViewModel: CarViewModel) {
        makeLabel.lineBreakMode = .byTruncatingTail
        marketPriceLabel.lineBreakMode = .byTruncatingTail
        
        carImage.image = UIImage(named: carViewModel.make)
        makeLabel.text = "\(carViewModel.make)"
        marketPriceLabel.text = "\(carViewModel.marketPrice/1000)K"
        cosmosRating.rating = carViewModel.rating

        
        
        /*let bullet1 = "small string."
        let bullet2 = "medium string."
        let bullet3 = "longer string."
        let strings = [bullet1, bullet2, bullet3]
        let fullAttributedString = NSMutableAttributedString()
        for string: String in strings {
            let attributesDictionary:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font : consDetailTextView.font,NSAttributedString.Key.foregroundColor : UIColor.red]
            let bulletPoint: String = "\u{2022}"
            //let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString = NSMutableAttributedString(string: bulletPoint, attributes: attributesDictionary)
            attributedString.append(NSAttributedString(string: " \(string) \n"))
            let indent:CGFloat = 15
            let paragraphStyle = createParagraphAttribute(tabStopLocation: indent, defaultTabInterval: indent, firstLineHeadIndent: indent - 10, headIndent: indent)
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
        }
        consDetailTextView.attributedText = fullAttributedString*/
    }
    
    public func collapse(){
        consLabel.text = ""
    }
    
    public func expand(with carViewModel: CarViewModel){
        let bullet = "\u{2022}  "
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "", size: CGFloat(12)), NSAttributedString.Key.foregroundColor: UIColor.red]
        
        var prosList = [String]()
        prosList.append("Pros")
        for pros in carViewModel.prosList {
            if pros.count > 0 {
                prosList.append(pros)
            }
        }
        prosList = prosList.enumerated().map { (index, element) in
            if index != 0 {
                return bullet + element
            }
            return element
        }
        
        var consList = [String]()
        consList.append("Pros")
        for cons in carViewModel.consList {
            if cons.count > 0 {
                consList.append(cons)
            }
        }
        consList = consList.enumerated().map { (index, element) in
            if index != 0 {
                return bullet + element
            }
            return element
        }
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = UIColor.darkGray
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = prosList.joined(separator: "\n") + "\n" + consList.joined(separator: "\n")
        consLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
    }
    


}
