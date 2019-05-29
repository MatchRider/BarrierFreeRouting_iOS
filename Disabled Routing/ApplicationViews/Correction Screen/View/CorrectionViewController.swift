//
//  CorrectionViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 21/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import EVReflection
import AEXML
enum ElementType:Int {
    case way
    case node
}
class CorrectionViewController: BaseViewController {
    
    /// Stores all the selected user response of user.
    fileprivate var titlesSelections : [String?]!
    
    //Store the titles of each property.
    fileprivate var titles : [String] {
        if let _ = wayDataModelCopied
        {
            return AppConstants.ScreenSpecificConstant.ValidationScreen.titles
        }
        else if let _ = nodeDataModelCopied
        {
            return [AppConstants.ScreenSpecificConstant.ValidationScreen.MAXIMUM_SLOPED_CURB]
        }
        else {
            return []
        }
    }
    
    /// Stores if the values are verified or not.
    var isVerified : [Bool?] = [nil,nil,nil] //[nil,nil,nil,nil]
    var isVerifiedServer : [Bool?] = [nil,nil,nil] //[nil,nil,nil,nil]
    var elementType : ElementType = .way
    var informationRequestModel : FilterScreenRequestModel!
    var isValid : Bool = false
    var isOSMData : Bool = false
    var changeSetId : String?
    var version : String?
     var calledWithFinish = false
    var inclineKey = "incline"
    var surfaceKey = "surface"
    var widthKey = "width"
    
    @IBOutlet weak var buttonFinish: CustomButton!
    @IBOutlet weak var tableViewOptions: UITableView!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSidewalkDirection: UILabel!
    
    var wayDataModelCopied : WayData?
    var nodeDataModelCopied : NodeReference?
    var wayDataModel : WayData?
    var nodeDataModel : NodeReference?
    var presenterCorrection : CorrectionPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenterCorrection = CorrectionPresenter(delegate: self)
        isVerified =  wayDataModelCopied != nil ? [nil,nil,nil] : [nil]
        isVerifiedServer =  wayDataModelCopied != nil ? [nil,nil,nil] : [nil]
         self.labelSidewalkDirection.isHidden = true
        if let _ = wayDataModelCopied {
            if isOSMData {
                let sidewalkDirection = (self.wayDataModelCopied?.attributes?.filter { $0.key == "sidewalk"}[0].value)!
                inclineKey = "incline"
                widthKey = "sidewalk:\(sidewalkDirection):width"
                surfaceKey = "sidewalk:\(sidewalkDirection):surface"
                self.labelSidewalkDirection.isHidden = false
                if sidewalkDirection == "left" {
                    self.labelSidewalkDirection.text = AppConstants.ScreenSpecificConstant.ValidationScreen.SIDEWAlK_LEFT
                } else if sidewalkDirection == "right" {
                    self.labelSidewalkDirection.text = AppConstants.ScreenSpecificConstant.ValidationScreen.SIDEWAlK_RIGHT
                } else if sidewalkDirection == "both" {
                    self.labelSidewalkDirection.text = AppConstants.ScreenSpecificConstant.ValidationScreen.SIDEWAlK_BOTH
                }
            } else {
                self.labelSidewalkDirection.isHidden = true
                self.initialiseValidFields()
            }
            self.initialiseUnAvailableTags(inWay: wayDataModelCopied!)
            self.populateSelectionTitlesForWays()
            self.elementType = .way
        }
        else if let _ = nodeDataModelCopied {
            self.populateSelectionTitlesForNodes()
            self.elementType = .node
        }
        else {
            self.titlesSelections = [informationRequestModel.surfaceType,informationRequestModel.incline,informationRequestModel.width]
        }
        self.initialiseTableView()
        self.localizeOutletTexts()
        
       self.presenterCorrection.sendCreateChangeSetRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func backButtonTapped(_ sender: Any) {
//        
//    }
    private func initialiseUnAvailableTags(inWay wayModel:WayData) {
        var doSurfaceKeyExists = false
        var doInclineKeyExists = false
        var doWidthKeyExists = false
        for attribute in wayModel.attributes ?? [] {
            if attribute.key == surfaceKey {
                doSurfaceKeyExists = true
            } else if attribute.key == widthKey {
                doWidthKeyExists = true
            } else if attribute.key == inclineKey {
                doInclineKeyExists = true
            }
            else if attribute.key == "footway" {
                attribute.isValid = "true"
                attribute.value = attribute.value == "" ? "sidewalk" : attribute.value
            }
            else if attribute.key == "highway" {
                attribute.isValid = "true"
                 attribute.value = attribute.value == "" ? "footway" : attribute.value
            }
        }
        if !doSurfaceKeyExists {
            wayModel.attributes?.append(Attributes(JSON: ["Key":surfaceKey,"Value":"","IsValid":"false"])!)
            self.wayDataModel!.attributes?.append(Attributes(JSON: ["Key":surfaceKey,"Value":"","IsValid":"false"])!)
        }
        if !doWidthKeyExists {
            wayModel.attributes?.append(Attributes(JSON: ["Key":widthKey,"Value":"","IsValid":"false"])!)
            self.wayDataModel!.attributes?.append(Attributes(JSON: ["Key":widthKey,"Value":"","IsValid":"false"])!)
        }
        if !doInclineKeyExists {
            wayModel.attributes?.append(Attributes(JSON: ["Key":inclineKey,"Value":"","IsValid":"false"])!)
             self.wayDataModel!.attributes?.append(Attributes(JSON: ["Key":inclineKey,"Value":"","IsValid":"false"])!)
        }
        
    }
    private func initialiseTableView() {
        self.tableViewOptions.delegate = self
        self.tableViewOptions.dataSource = self
        self.tableViewOptions.registerTableViewCell(tableViewCell: CorrectionTableViewCell.self)
    }
    private func initialiseValidFields() {
        for attribute in self.wayDataModelCopied?.attributes ?? []  where attribute.key == inclineKey || attribute.key == surfaceKey || attribute.key == widthKey {
            switch attribute.key {
            case surfaceKey :
                self.isVerifiedServer[0] = attribute.isValid == "true" ? true : false
                break
            case inclineKey :
                self.isVerifiedServer[1] = attribute.isValid == "true" ? true : false
                break
            case widthKey :
                self.isVerifiedServer[2] = attribute.isValid == "true" ? true : false
                break
            default :
                break
            }
        }
    }
    private func localizeOutletTexts() {
        self.labelTitle.text = "OPTIONS".localized()// AppConstants.ScreenSpecificConstant.LocationPickScreen.ENHANCE_ROUTING_TEXT
        self.labelQuestion.text = AppConstants.ScreenSpecificConstant.MapScreen.FOLLOWING_CORRECT_TEXT
        self.buttonFinish.setTitle(AppConstants.ScreenSpecificConstant.FilterOptionScreen.FINISHED_TITLE, for: .normal)
    }
    @objc fileprivate func editButtonTapped(_ sender:UIButton) {
        self.navigateToValidationScreen(withIndex: sender.tag)
    }
    
    @objc fileprivate func verifiedButtonTapped(_ sender:UIButton) {
        let cell = self.tableViewOptions.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! CorrectionTableViewCell
        if cell.buttonCheckBox.imageView?.image == #imageLiteral(resourceName: "ic_check_box") {
            cell.buttonCheckBox.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for: .normal)
            self.isVerified[sender.tag] = false
        }
        else {
            cell.buttonCheckBox.setImage(#imageLiteral(resourceName: "ic_check_box"), for: .normal)
            self.isVerified[sender.tag] = true
        }
        if let _ = self.wayDataModelCopied {
            self.updateWayData()
        }
        else if let _ = self.nodeDataModelCopied {
            self.updateNodeData()
        }
        
    }
    private func updateNodeData() {
        for atrObj in (nodeDataModelCopied?.attributes)!
        {
            
            switch atrObj.key! {
            case "kerb:height":
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.slopedOptions.firstIndex(of: informationRequestModel.slopedCurb!)
                if let index = selectedIndex {
                    atrObj.value = AppConstants.ScreenSpecificConstant.ValidationScreen.slopedValues[index]
                }
                atrObj.isValid =  String(describing:self.isVerified[0] ?? false)
                break
            default:
                break
            }
        }
    }
    private func updateWayData() {
        for atrObj in (wayDataModelCopied?.attributes)!
        {
            
            switch atrObj.key! {
            case inclineKey:
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.inclineOptions.firstIndex(of: informationRequestModel.incline!)
                         if let index = selectedIndex {
                            atrObj.value = AppConstants.ScreenSpecificConstant.ValidationScreen.inclineValues[index]
                         } else if let inclineValue = getOtherValue(fromFormattedValue:informationRequestModel.incline!) {
                            atrObj.value = String(describing:inclineValue)
                            atrObj.value!.append("%")
                            informationRequestModel.incline?.append("%")
                         }
                atrObj.isValid =  String(describing:self.isVerified[1] ?? false)
                break
            case widthKey:
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.widthOptions.firstIndex(of: informationRequestModel.width!)
                if let index = selectedIndex {
                    atrObj.value = AppConstants.ScreenSpecificConstant.ValidationScreen.widthValues[index]
                } else if let widthValue = getOtherValue(fromFormattedValue:informationRequestModel.width!) {
                    atrObj.value = String(describing:widthValue)
                }
                atrObj.isValid =  String(describing:self.isVerified[2] ?? false)
                break
            case surfaceKey:
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.surfaceTypeOptions.firstIndex(of: informationRequestModel.surfaceType!)
                if let index = selectedIndex {
                    atrObj.value = AppConstants.ScreenSpecificConstant.ValidationScreen.surfaceTypeOptionsValues[index]
                   
                } else {
                    atrObj.value = informationRequestModel.surfaceType!
                }
                 atrObj.isValid =  String(describing:self.isVerified[0] ?? false)
                break
            default:
                break
            }
        }
    }
    
    private func getOtherValue(fromFormattedValue value: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: Locale.current.regionCode ?? "")
        if let otherValue = formatter.number(from: value.getWhitespaceTrimmedString()){
            return String(describing:otherValue)
        } else {
            formatter.locale = Locale(identifier: Locale.current.languageCode ?? "")
            if let otherValue = formatter.number(from: value.getWhitespaceTrimmedString()){
                return String(describing:otherValue)
            }
        }
        return nil
    }
    private func populateSelectionTitlesForNodes() {
        self.informationRequestModel = FilterScreenRequestModel()
        
        var slopedCurb:String? = ""
        
        for atrObj in (nodeDataModelCopied?.attributes)!
        {
            switch atrObj.key! {
            case "kerb:height":
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.slopedValues.firstIndex(of:atrObj.value!)
                if let index = selectedIndex {
                    slopedCurb = AppConstants.ScreenSpecificConstant.ValidationScreen.slopedOptions[index]
                    //   atrObj.isValid =  String(describing:self.isVerified[1] ?? false)
                    // atrObj.isValid =  String(describing:self.isVerified[2] ?? false)
                } else {
                    slopedCurb = atrObj.value ?? ""
                }
                self.isVerified[0] = atrObj.isValid == "true" ? true : false
                informationRequestModel.slopedCurb = slopedCurb!
                break
            default:
                break
            }
        }
        self.titlesSelections = [slopedCurb]//[surfaceType,slopedCurb,incline,width]
        
    }
    private func populateSelectionTitlesForWays() {
        self.informationRequestModel = FilterScreenRequestModel()
        var surfaceType:String? = ""
        let slopedCurb:String? = ""
        var incline:String? = ""
        var width:String? = ""
        
        //Quick Fix
      //  self.isVerified[0] = false
        informationRequestModel.surfaceType = ""
        
        //        self.isVerified[1] = false
        //        informationRequestModel.slopedCurb = ""
        
        for atrObj in (wayDataModelCopied?.attributes)!
        {
            switch atrObj.key! {

            case inclineKey:
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.inclineValues.firstIndex(of:atrObj.value!)
                if let index = selectedIndex {
                    incline = AppConstants.ScreenSpecificConstant.ValidationScreen.inclineOptions[index]
                } else {
                     incline = atrObj.value ?? ""
                }
                self.isVerified[1] = atrObj.isValid == "true" ? true : false
                
                informationRequestModel.incline = incline!
                break
            case surfaceKey:
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.surfaceTypeOptionsValues.firstIndex(of:atrObj.value!)
                if let index = selectedIndex {
                    surfaceType = AppConstants.ScreenSpecificConstant.ValidationScreen.surfaceTypeOptions[index]
                } else {
                    surfaceType = atrObj.value ?? ""
                }
                self.isVerified[0] = atrObj.isValid == "true" ? true : false
                informationRequestModel.surfaceType = surfaceType!
                break
            case widthKey:
                let selectedIndex = AppConstants.ScreenSpecificConstant.ValidationScreen.widthValues.firstIndex(of:atrObj.value!)
                if let index = selectedIndex {
                    width = AppConstants.ScreenSpecificConstant.ValidationScreen.widthOptions[index]
                } else {
                    width = atrObj.value ?? ""
                }
                self.isVerified[2] = atrObj.isValid == "true" ? true : false
                informationRequestModel.width = width!
                break
            default:
                break
            }
        }
        self.titlesSelections = [surfaceType,incline,width]
        
    }
    private func navigateToValidationScreen(withIndex index:Int) {
        let validVC = UIViewController.getViewController(ValidationViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        validVC.currentOptionIndex = index
        validVC.delegate = self
        validVC.infoModel = self.informationRequestModel
        validVC.otherValuePrefilledValue = otherValue(forIndex: index)
        if let _ = nodeDataModelCopied {
            validVC.titles = [AppConstants.ScreenSpecificConstant.ValidationScreen.MAXIMUM_SLOPED_CURB]
            validVC.titlesOptions = [AppConstants.ScreenSpecificConstant.ValidationScreen.slopedOptions]
        }
        self.navigationController?.pushViewController(validVC, animated: true)
    }
    
    private func otherValue(forIndex index:Int)->String {
        switch index {
        case 1:
            if var inclineValue = self.informationRequestModel.incline {
                if AppConstants.ScreenSpecificConstant.ValidationScreen.inclineOptions.firstIndex(of: inclineValue) == nil &&  AppConstants.ScreenSpecificConstant.ValidationScreen.inclineValues.firstIndex(of: inclineValue) == nil {
                    if inclineValue.last == "%" {
                        inclineValue.removeLast()
                        if Locale.current.languageCode == "de" {
                            return inclineValue.replacingOccurrences(of: ".", with: ",")
                        } else {
                             return inclineValue.replacingOccurrences(of: ",", with: ".")
                        }
                       
                    }
                }
            }
            break
        case 2:
            if let widthValue = self.informationRequestModel.width {
                if AppConstants.ScreenSpecificConstant.ValidationScreen.widthOptions.firstIndex(of: widthValue) == nil &&  AppConstants.ScreenSpecificConstant.ValidationScreen.widthValues.firstIndex(of: widthValue) == nil {
              
                        if Locale.current.languageCode == "de" {
                            return widthValue.replacingOccurrences(of: ".", with: ",")
                        } else {
                            return widthValue.replacingOccurrences(of: ",", with: ".")
                        }
                        
                    }
                }
            break
        default:
            break
        }
        return ""
    }
    @IBAction func finishButtonTapped(_ sender: Any) {
        if changeSetId == "" {
            calledWithFinish = true
            self.presenterCorrection.sendCreateChangeSetRequest()
            return
        }
        if isValidRequest()  {
        if let _ = self.wayDataModelCopied {
            self.presenterCorrection.elementType = .way
            if self.wayDataModelCopied?.osmWayId == "" {
                self.createDataOnOSM()
            } else {
                self.updateDataOnOSM()
            }
        } else {
            self.presenterCorrection.elementType = .node
            self.presenterCorrection.nodeData = self.nodeDataModelCopied
            if self.nodeDataModelCopied?.osmNodeId == "" {
                self.createDataOnOSM()
            } else {
                self.updateDataOnOSM()
            }
        }
    }
}
    private func isValidRequest()->Bool {
       
        guard !isOSMData else {
             return true
        }
        if self.wayDataModelCopied != nil && (self.informationRequestModel.surfaceType == "" || self.informationRequestModel.incline == "" || self.informationRequestModel.width == "")  {
            self.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: AppConstants.ErrorMessages.MESSAGE_TO_PROCEED)
            return false
        } else if self.nodeDataModelCopied != nil && self.informationRequestModel.slopedCurb == "" {
            self.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: AppConstants.ErrorMessages.MESSAGE_TO_PROCEED)
            return false
        }
        guard (isVerified.filter{$0 == false || $0 == nil}).count == 0 else {
            self.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: AppConstants.ErrorMessages.MESSAGE_TO_PROCEED)
            return false
        }
        return true
    }
    private func updateDataOnOSM() {
        
        if let isValid = self.wayDataModelCopied?.isValid,isValid == "false" {
            self.presenterCorrection.sendGetElementDataFromOSM(withID: (self.wayDataModelCopied?.osmWayId!)!,forType: .way)
        }
        else if !isValid {
            self.presenterCorrection.sendGetElementDataFromOSM(withID: (self.nodeDataModelCopied?.osmNodeId!)!,forType: .node)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func createDataOnOSM() {
        
        if let isValid = self.wayDataModelCopied?.isValid,isValid == "false" {
            self.presenterCorrection.createWayOnOSMServer(withData: self.wayDataModelCopied!)
        }
        else if !isValid {
            self.presenterCorrection.sendCreateElementRequestOnOSM(withInformationRequest: self.nodeDataModelCopied!, changeSetId: self.changeSetId!, ofType: .node)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func formattedValue(forSelection selection:String)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
                            formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: Locale.current.languageCode ?? "")
        if let selectedValue = Double((selection)),let formattedValue = formatter.string(from: NSNumber(value: selectedValue)) {
            return "\(formattedValue)"
        }
        else {
           return selection
        }
    }
}
extension CorrectionViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectionTableViewCell") as! CorrectionTableViewCell
        var checkImage = #imageLiteral(resourceName: "ic_check_box_outline_blank")
        var editImage = #imageLiteral(resourceName: "ic_mode_edit")
        cell.buttonCheckBox.isUserInteractionEnabled = false
        if let selectionValue =  self.titlesSelections[indexPath.row] {
            if let isVerify = isVerified[indexPath.row]  {
                checkImage = isVerify ? #imageLiteral(resourceName: "ic_check_box") : #imageLiteral(resourceName: "ic_check_box_outline_blank")
                cell.buttonEdit.isHidden = isVerifiedServer[indexPath.row] ?? false
                cell.buttonCheckBox.isUserInteractionEnabled = selectionValue != "" && !(isVerifiedServer[indexPath.row] ?? false)
            }
            cell.labeltitle?.textColor = UIColor.black
            cell.labelVerified?.textColor = UIColor.black
            cell.labelOption?.textColor = UIColor.appThemeColor()
        }
        else {
            checkImage = #imageLiteral(resourceName: "ic_check_box_outline_gray")
            editImage = #imageLiteral(resourceName: "ic_mode_edit_gray")
            cell.labeltitle?.textColor = UIColor.lightGray
            cell.labelOption?.textColor = UIColor.lightGray
            cell.labelVerified?.textColor = UIColor.lightGray
            cell.buttonEdit.isHidden = false
            cell.buttonCheckBox.isUserInteractionEnabled = false
            cell.buttonEdit.isUserInteractionEnabled = false
        }
        
        cell.labeltitle?.text = self.titles[indexPath.row]
        var option = self.titlesSelections[indexPath.row]
        if let _ = wayDataModel,indexPath.row != 0 {
            option = option?.replacingOccurrences(of: "&lt;", with: "<")
            option = option?.replacingOccurrences(of: "&Lt;", with: "<")
            option = option?.replacingOccurrences(of: "&gt;", with: ">")
            option = option?.replacingOccurrences(of: "&Gt;", with: ">")
            if Locale.current.languageCode == "de" {
                cell.labelOption.text = option?.replacingOccurrences(of: ".", with: ",")
            } else {
                cell.labelOption.text = option?.replacingOccurrences(of: ",", with: ".")
            }
        } else {
            if Locale.current.languageCode == "de" {
                cell.labelOption.text = option?.replacingOccurrences(of: ".", with: ",")
            } else {
                cell.labelOption.text = option?.replacingOccurrences(of: ",", with: ".")
            }
        }
      //  cell.labelOption.text = self.formattedValue(forSelection: self.titlesSelections[indexPath.row] ?? "")

        cell.buttonEdit.tag = indexPath.row
        cell.buttonCheckBox.tag = indexPath.row
        cell.buttonCheckBox.setImage(checkImage, for: .normal)
        cell.buttonEdit.setImage(editImage, for: .normal)
        cell.buttonEdit.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        cell.buttonCheckBox.addTarget(self, action: #selector(verifiedButtonTapped(_:)), for: .touchUpInside)
        
        if let wayModel = wayDataModelCopied, wayModel.isValid == "true"
        {
            cell.buttonEdit.isUserInteractionEnabled = false
            cell.buttonCheckBox.isUserInteractionEnabled = false
        }
        else if let nodeModel = nodeDataModelCopied, nodeModel.attributes?[0].isValid == "true"{
            cell.buttonEdit.isUserInteractionEnabled = false
            cell.buttonCheckBox.isUserInteractionEnabled = false
        }
        else
        {
            cell.buttonEdit.isUserInteractionEnabled = true
           // cell.buttonCheckBox.isUserInteractionEnabled = true
        }
        if isOSMData {
            cell.buttonCheckBox.isHidden = true
            cell.labelVerified.isHidden = true
        } else {
            cell.buttonCheckBox.isHidden = false
            cell.labelVerified.isHidden = false
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
    }
}

extension CorrectionViewController : ValidationControllerDelegate
{
    func didSectionOption(_ infoRequest:FilterScreenRequestModel,forIndex index:Int) {
        self.informationRequestModel = infoRequest
        
        if let _ = wayDataModelCopied {
            self.updateWayData()
            self.titlesSelections = [informationRequestModel.surfaceType,informationRequestModel.incline,informationRequestModel.width]
        }
        else if let _ = nodeDataModelCopied {
            self.updateNodeData()
            self.titlesSelections = [informationRequestModel.slopedCurb]
        }
        self.tableViewOptions.reloadData()
    }
}
extension CorrectionViewController : CorrectionViewDelgate
{
    func didGetDataOSM(withResponseModel osmData: OSM, andXMLData xmlData: AEXMLDocument) {
        if self.elementType == .way {
            self.presenterCorrection.sendUpdateElementRequestOnOSM(withInformationRequest: self.wayDataModelCopied!, xmlData: xmlData, changeSetId: self.changeSetId!, andVersion: (osmData.way?._version!)!)
        }
        else {
            self.presenterCorrection.sendUpdateElementRequestOnOSM(withInformationRequest: self.nodeDataModelCopied!, xmlData: xmlData, changeSetId: self.changeSetId!, andVersion: (osmData.node?._version!)!)
        }
        
        
    }
    
    func didUpdateElementDataOnServer(withResponseModel changeSetResponseModel: WayResponseModel) {
        if self.elementType == .way {
            let nonVerifiedAttributes = self.wayDataModelCopied?.attributes?.filter({ (attribute) -> Bool in
                return attribute.isValid == "false"
            })
            if nonVerifiedAttributes?.count == 0
            {
                self.wayDataModelCopied?.isValid = "true"
            }
        }
        else {
            let nonVerifiedAttributes = self.nodeDataModelCopied?.attributes?.filter({ (attribute) -> Bool in
                return attribute.isValid == "false"
            })
            if nonVerifiedAttributes?.count == 0
            {
                self.nodeDataModelCopied?.attributes?[0].isValid = "true"
            }
        }
         if self.elementType == .way {
            self.wayDataModel!.updateModel(withData: self.wayDataModelCopied!)
            print("Way Id :\(self.wayDataModel?.osmWayId)")
         } else {
            self.nodeDataModel!.updateModel(withData: self.nodeDataModelCopied!)
            print("Node Id :\(self.nodeDataModel?.osmNodeId)")
        }
      
        NotificationCenter.default.post(name: AppConstants.NSNotificationNames.WAY_DATA_UPDATED_NOTIFICATION, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func didUpdateWayDataOSM(forType type:ElementType,andResponseModel changeSetResponseModel: String) {
        self.version = changeSetResponseModel
        self.wayDataModelCopied?.version = self.version
        if isOSMData {
            if self.elementType == .way {
                self.wayDataModel!.updateModel(withData: self.wayDataModelCopied!)
                 print("Way Id :\(self.wayDataModel?.osmWayId)")
            } else {
                self.nodeDataModel!.updateModel(withData: self.nodeDataModelCopied!)
                 print("Node Id :\(self.nodeDataModel?.osmNodeId)")
            }
            NotificationCenter.default.post(name: AppConstants.NSNotificationNames.OSM_WAY_DATA_UPDATED_NOTIFICATION, object: nil)
            self.navigationController?.popViewController(animated: true)
        } else {
            if self.elementType == .way {
                self.presenterCorrection.sendUpdateElementRequestOnServer(withInformationRequest: self.wayDataModelCopied!, forType: self.elementType)
            }
            else {
                self.presenterCorrection.sendUpdateElementRequestOnServer(withInformationRequest: self.nodeDataModelCopied!, forType: .node)
            }
        }
    }
    func didCreatedChangeSet(withResponseModel changeSetResponseModel: String) {
        self.changeSetId = changeSetResponseModel
        if  calledWithFinish {
            calledWithFinish = false
            finishButtonTapped(UIButton())
           
        }
    }
    func showLoader() {
        self.showLoader(self)
    }
    
    func hideLoader() {
        self.hideLoader(self)
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {

        if alertMessage != "" {
        self.showErrorAlert(alertTitle, alertMessage: alertMessage, VC: self)
        }
    }
    
}
