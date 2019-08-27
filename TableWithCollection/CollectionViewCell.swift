import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var lbTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createAll()
        layoutAll()
    }
    
    func bind(item: CollectionItem) {
        lbTitle.text = item.title
        lbTitle.backgroundColor = item.color
    }
    
    func createAll() {
        lbTitle = UILabel()
        lbTitle.textAlignment = NSTextAlignment.center
        lbTitle.textColor = UIColor.black
        lbTitle.font = UIFont.systemFont(ofSize: 16)
        lbTitle.numberOfLines = 0
        lbTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lbTitle)
    }
    
    func layoutAll() {
        contentView.addConstraint(NSLayoutConstraint(item: lbTitle!, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: lbTitle!, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: lbTitle!, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: lbTitle!, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
