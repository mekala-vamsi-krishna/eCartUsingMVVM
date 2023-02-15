//
//  ProductTableViewCell.swift
//  MVVMPattern-eCart
//
//  Created by Mekala Vamsi Krishna on 14/02/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet var productBackgroundView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productCategoryLabel: UILabel!
    @IBOutlet var rateButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    var product: Product? {
        didSet {
            productDetailConfiguration()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15
        
        productImageView.layer.cornerRadius = 10
        
        productBackgroundView.backgroundColor = .systemGray6
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let product = product else { return }
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$ \(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
    
}
