//
//  ValidationViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 18/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

protocol ValidationControllerDelegate:class {
    func didSectionOption(_ infoRequest:FilterScreenRequestModel,forIndex index:Int)
}

class ValidationViewController: BaseViewController {
    enum InfoPoints:Int {
        case surfaceType
        case incline
        case width
    }
    @IBOutlet weak var viewOtherValueView: UIView!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonNext: CustomButton!
    @IBOutlet weak var tableViewOptions: UITableView!
    @IBOutlet weak var labelOption: UILabel!
    @IBOutlet weak var labelOtherValue: UILabel!
    @IBOutlet weak var textFieldOtherValue: UITextField!
    @IBOutlet weak var _iConstraintTableViewHeight: NSLayoutConstraint!
    weak var delegate : ValidationControllerDelegate?
    var infoModel : FilterScreenRequestModel!
    var titles = AppConstants.ScreenSpecificConstant.ValidationScreen.titles
    var titlesOptions = AppConstants.ScreenSpecificConstant.ValidationScreen.titlesOptions
    fileprivate let surfaceTypeImages =  [#imageLiteral(resourceName: "ic_asphalt"),#imageLiteral(resourceName: "ic_concrete"),#imageLiteral(resourceName: "ic_paving"),#imageLiteral(resourceName: "ic_cobblestones"),#imageLiteral(resourceName: "ic_compacted")]
    var currentOptionIndex : Int = 3
    var nextOptionIndex : Int = 0
    var otherValuePrefilledValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOptions.delegate = self
        self.tableViewOptions.dataSource = self
        self.labelOption.text = "\u{2022} \(self.titles[self.currentOptionIndex]) (\(AppConstants.ScreenSpecificConstant.ValidationScreen.PLEASE_CHOOSE_TEXT)) :"
        self.labelTitle.text = "OPTIONS".localized()
        self.textFieldOtherValue.delegate = self
        self.initialiseOtherValueView()
        self.tableViewOptions.registerTableViewCell(tableViewCell: ValidationOptionTableViewCell.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func otherValueSubmitted(_ sender: UIButton) {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: Locale.current.regionCode ?? "")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        let otherValue = self.textFieldOtherValue.text!.getWhitespaceTrimmedString()
        if let _ = formatter.number(from: otherValue),otherValue != "" {} else {
            
            formatter.locale = Locale(identifier: Locale.current.languageCode ?? "")
            if let _ = formatter.number(from: otherValue),otherValue != "" {} else {
                return
            }
        }
      
//        guard let _ = formatter.number(from: otherValue),otherValue != "" else {
//            return
//        }
        
        switch InfoPoints.init(rawValue: self.currentOptionIndex)! {
        case .surfaceType:
            if titles.count == 1 {
                self.infoModel.slopedCurb = otherValue
            }
            else {
                self.infoModel.surfaceType = otherValue
            }
            
            break
        case .incline:
            self.infoModel.incline = otherValue
            break
        case .width:
            self.infoModel.width = otherValue
            break
            
        }
        self.delegate?.didSectionOption(self.infoModel, forIndex: self.currentOptionIndex)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func initialiseOtherValueView() {
        self.labelOtherValue.text = AppConstants.ErrorMessages.OTHER_VALUE
        self.textFieldOtherValue.placeholder = AppConstants.ErrorMessages.OTHER_VALUE
        self.textFieldOtherValue.text = otherValuePrefilledValue.getWhitespaceTrimmedString()
        if titles.count != 1 && (currentOptionIndex == 1 || currentOptionIndex == 2) {
            viewOtherValueView.isHidden = false
        } else {
            viewOtherValueView.isHidden = true
        }
    }
    
}
extension ValidationViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        var regionFormat = newText
        if newText.contains(",") {
           regionFormat = regionFormat.replacingOccurrences(of: ",", with: ".")
        }
        let isNumeric = newText.isEmpty || (Double(newText) != nil) || (Double(regionFormat) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1 != 0 ? newText.components(separatedBy: ".").count - 1 : newText.components(separatedBy: ",").count - 1
        
        var numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else if let dotIndex = newText.index(of: ",") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
       
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
}
extension ValidationViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesOptions[self.currentOptionIndex].count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValidationOptionTableViewCell") as! ValidationOptionTableViewCell
        cell.labelOption?.text = self.titlesOptions[self.currentOptionIndex][indexPath.row]
        // cell.textLabel?.font = UIFont.getFrutigerLight(withSize: 17)
        if self.currentOptionIndex == 0,titles.count != 1 {
            cell.imageViewOption?.image = surfaceTypeImages[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.populateEntryInModel(ValidationViewController.InfoPoints(rawValue: self.currentOptionIndex)!, selection: indexPath.row)
        self.delegate?.didSectionOption(self.infoModel, forIndex: self.currentOptionIndex)
        self.navigationController?.popViewController(animated: true)
        
    }
    fileprivate func populateEntryInModel(_ entry: InfoPoints,selection:Int)
    {
        switch entry {
        case .surfaceType:
            if titles.count == 1 {
                self.infoModel.slopedCurb = AppConstants.ScreenSpecificConstant.ValidationScreen.slopedOptions[selection]
            }
            else {
                self.infoModel.surfaceType = AppConstants.ScreenSpecificConstant.ValidationScreen.surfaceTypeOptions[selection]
            }
            break
        case .incline:
            self.infoModel.incline = AppConstants.ScreenSpecificConstant.ValidationScreen.inclineOptions[selection]
            break
        case .width:
            self.infoModel.width = AppConstants.ScreenSpecificConstant.ValidationScreen.widthOptions[selection]
            break
        }
    }
}
