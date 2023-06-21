//
//  MenuCollectionViewCell.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/8.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"
        
    private let drinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "白玉歐蕾")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "Name"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .kebukeYellow
        label.text = "Price"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        contentView.addSubview(drinkImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func setupLayout() {
        drinkImageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(self)
            make.height.equalTo(self.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(drinkImageView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(priceLabel)
            make.height.equalTo(25)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-8)
            make.trailing.equalTo(self).offset(-8)
            make.leading.equalTo(self).offset(8)
            make.height.equalTo(20)
        }
    }
    
    func layoutCell(drinkData: Record) {
        self.nameLabel.text = drinkData.fields.name
        self.priceLabel.text = "$\(drinkData.fields.medium)"
        self.drinkImageView.image = UIImage(named: "白玉歐蕾")
        let imageURL = URL(string: drinkData.fields.image[0].url)
        self.drinkImageView.kf.indicatorType = .activity
        self.drinkImageView.kf.setImage(with: imageURL)
        
    }

    
}
