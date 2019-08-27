import Foundation
import UIKit

class TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "TableViewCell"
    
    var container: UIView!
    
    var lbTitle: UILabel!
    var collectionView: UICollectionView!
    
    var listData: [CollectionItem]!
    
    lazy var layout: UICollectionViewFlowLayout = {
        let spacing: CGFloat = 8
        
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        
        cellWidth = (UIScreen.main.bounds.width / 2) - (spacing * 4)
        cellHeight = 100
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createAll()
        layoutAll()
    }
    
    func bind(tag: Int, title: String, listData:[CollectionItem]) {
        self.lbTitle.text = title
        self.listData = listData
        
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
    
    func createAll() {
        // container
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        
        // title
        lbTitle = UILabel()
        lbTitle.textAlignment = NSTextAlignment.left
        lbTitle.textColor = UIColor.black
        lbTitle.font = UIFont.systemFont(ofSize: 16)
        lbTitle.numberOfLines = 1
        lbTitle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(lbTitle)
        
        // collection view
        
        // Why not use default collection view?
        //collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        container.addSubview(collectionView)
    }
    
    func layoutAll() {
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[container]|", options: [], metrics: nil, views: [
            "container": container!,
            ]))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[container]|", options: [], metrics: nil, views: [
            "container": container!,
            ]))
        
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[lbTitle]-|", options: [], metrics: nil, views: [
            "lbTitle": lbTitle!,
            ]))
        
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: [], metrics: nil, views: [
            "collectionView": collectionView!
            ]))
        
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[lbTitle]-2-[collectionView]-12-|", options: [], metrics: nil, views: [
            "lbTitle": lbTitle!,
            "collectionView": collectionView!
            ]))
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        if let item = listData?[indexPath.row] {
            cell.bind(item: item)
        }
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
