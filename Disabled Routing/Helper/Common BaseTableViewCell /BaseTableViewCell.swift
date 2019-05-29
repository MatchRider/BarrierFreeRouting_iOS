
import UIKit
import ObjectMapper

//MARK:- protocol for FirstTableViewCell

protocol BaseTableViewCellDelegate:class {
    func onClick(_ sender:Any?,eventKey:String,model:CommonModelProtocol?) -> Void
}

protocol CommonModelProtocol {
}

//Notes:- This class is used to create table view cell of BaseTableViewCell type.
//For our implementation it will act as the base class for rest of the table view cells.

class BaseTableViewCell: UITableViewCell {

    //MARK:- BaseTableViewCell life cycle methods.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Binding methods
    func bindWithData(withModel dataModel:CommonModelProtocol,delegate:BaseTableViewCellDelegate){
        
    }
}


