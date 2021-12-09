//
//  TicTacToeCollectionViewCell.swift
//  Assignment8
//
//  Created by DCS on 08/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class TicTacToeCollectionViewCell: UICollectionViewCell {
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupCell(with status:Int) {
        contentView.addSubview(myImageView)
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = UIColor.white.cgColor
        
        myImageView.frame = CGRect(x: 5, y: 5, width: 60, height: 60)
        
        //circle => o
        //multiply => x
        
        let name = (status == 0 ) ? ("circle") : (status == 1 ? "multiply" : "")
        myImageView.image = UIImage(named: name)
    }
}
