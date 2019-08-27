import Foundation
import UIKit

class ListItem {
    
    var title: String
    var items: [CollectionItem]
    
    init(title: String, items: [CollectionItem]) {
        self.title = title
        self.items = items
    }
    
}
