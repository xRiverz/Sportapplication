//
//  SportViewCell.swift
//  Sportapplication
//
//  Created by administrator on 11/01/2022.
//



import UIKit

class SportViewCell: UITableViewCell{
    
    @IBOutlet weak var sportNameLabel:UILabel!
    @IBOutlet weak var sportImage:UIImageView!
    
    weak var cellDelegate:CellDelegate?
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        sportImage.isUserInteractionEnabled = true
        sportImage.addGestureRecognizer(tapGR)
        // Initialization code
    }
    
    override func prepareForReuse() {
        sportImage.image = UIImage(named: "AddImage")
    }
    
    func configure(_ name:String?, _ imageData:Data?){
        sportNameLabel.text = name
        
        if let imageData = imageData {
            sportImage.image = UIImage(data: imageData)
        }
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer){
        cellDelegate?.changeImage(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
