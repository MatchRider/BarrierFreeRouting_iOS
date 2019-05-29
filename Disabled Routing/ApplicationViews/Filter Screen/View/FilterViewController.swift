//
//  FilterViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 16/03/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {
    enum FeedbackPoint:Int {
        case routing
        case surfaceType
        case slopedCurb
        case incline
        case width
        case obstacle
    }
    @IBOutlet weak var buttonClear: CustomButton!
    @IBOutlet weak var buttonAppy: CustomButton!
    @IBOutlet weak var tableViewInformation: UITableView!
    @IBOutlet weak var labelInfotitle: UILabel!
    @IBOutlet weak var labelInfoQuestion: UILabel!
    
    let titles = AppConstants.ScreenSpecificConstant.FilterOptionScreen.titles
    let titlesOptionsText = AppConstants.ScreenSpecificConstant.FilterOptionScreen.titlesOptionsText
     let titlesOptionsValues = AppConstants.ScreenSpecificConstant.FilterOptionScreen.titlesOptionsValues
    var selections = Array(repeating: "", count: 5)
    var informationRequestModel : FilterScreenRequestModel!
    var selectedSection = -1
    weak var delegate : MapScreenViewControllerDelegate?
    var isFromFilter = true
    var collapsedData = [false,true,true,true,true]
    override func viewDidLoad() {
        super.viewDidLoad()
       self.setUpInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpInitialView()
    {
        self.setUpTableView()
        self.localiseStringInView()
    }
    private func setUpTableView()
    {
        self.tableViewInformation.delegate = self
        self.tableViewInformation.dataSource = self
        self.tableViewInformation.registerTableViewCell(tableViewCell: RoutingTableViewCell.self)
    }
    
    private func localiseStringInView()
    {
        self.buttonClear.isHidden = !isFromFilter
        self.buttonAppy.setTitle(AppConstants.ScreenSpecificConstant.FilterOptionScreen.APPLY_TITLE, for: .normal)
        self.buttonClear.setTitle(AppConstants.ScreenSpecificConstant.FilterOptionScreen.CLEAR_TITLE, for: .normal)
        self.labelInfotitle.text = AppConstants.ScreenSpecificConstant.FilterOptionScreen.OPTIONS
        self.labelInfoQuestion.text = ""//AppConstants.ScreenSpecificConstant.FilterOptionScreen.FEEDBACK_QUESTION
    }
    
    @objc func sectionLabelTapped(_ tapGesture:UITapGestureRecognizer)
    {
        let sectionView = tapGesture.view as! InfoSectionHeader
        let labelTag = sectionView.tag
        
        
        if selectedSection != labelTag
        {
            let lastSelection = selectedSection == -1 ? labelTag  : selectedSection
            self.collapsedData[lastSelection] = true
             self.tableViewInformation.reloadSections([lastSelection], with: .none)
            self.collapsedData[labelTag] = false
            selectedSection = labelTag
             self.tableViewInformation.reloadSections([labelTag], with: .none)
            self.tableViewInformation.scrollToRow(at: IndexPath(row: 0, section: labelTag), at: .none, animated: true)
        }
        else
        {
            selectedSection = -1
            self.collapsedData[labelTag] = !self.collapsedData[labelTag]
            self.tableViewInformation.reloadSections([labelTag], with: .none)
        }
    }
    @IBAction func applyButtonTapped(_ sender: Any) {
       
        if self.informationRequestModel.routeViaInfo.address.count > 0 || self.informationRequestModel.surfaceType != nil || self.informationRequestModel.slopedCurb != nil || self.informationRequestModel.width != nil || self.informationRequestModel.incline != nil {
            self.informationRequestModel.isFilterApplied = true
             RouteOptionManager.shared.saveRouteOption(self.informationRequestModel)
             self.delegate?.filtersAdded(self.informationRequestModel)
        }
       
        self.backButtonClick()
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
    
        self.selections = Array(repeating: "", count: 5)
        self.informationRequestModel.highway = nil
        self.informationRequestModel.surfaceType = nil
        self.informationRequestModel.incline = nil
        self.informationRequestModel.slopedCurb = nil
        self.informationRequestModel.width = nil
        self.informationRequestModel.surfaceTypeValue = nil
        self.informationRequestModel.inclineValue = nil
        self.informationRequestModel.slopedCurbValue = nil
        self.informationRequestModel.widthValue = nil
        self.informationRequestModel.obstacle = nil
        self.informationRequestModel.routeViaInfo = (0.0,0.0,"")
        self.informationRequestModel.isFilterApplied = false
        RouteOptionManager.shared.saveRouteOption(self.informationRequestModel)
        self.delegate?.filtersCleared(self.informationRequestModel)
        self.tableViewInformation.reloadData()

    }
    fileprivate func populateEntryInModel(entry:FeedbackPoint,selection:Int)
    {
        switch entry {
        case .surfaceType:
            self.informationRequestModel.surfaceType = AppConstants.ScreenSpecificConstant.FilterOptionScreen.surfaceTypeOptions[selection]
              self.informationRequestModel.surfaceTypeValue = AppConstants.ScreenSpecificConstant.FilterOptionScreen.surfaceTypeOptionsValues[selection]
            break
//        case .highway:
//            self.informationRequestModel.highway = AppConstants.ScreenSpecificConstant.FilterOptionScreen.trackTypeOptionsValues[selection]
//            break
//        case .smoothness:
//            self.informationRequestModel.smoothness = AppConstants.ScreenSpecificConstant.FilterOptionScreen.smoothnessOptionsValues[selection]
//            break
        case .slopedCurb:
            self.informationRequestModel.slopedCurb = AppConstants.ScreenSpecificConstant.FilterOptionScreen.slopedCurbOptions[selection]
            self.informationRequestModel.slopedCurbValue = AppConstants.ScreenSpecificConstant.FilterOptionScreen.slopedCurbOptionsValues[selection]
            break
        case .incline:
            self.informationRequestModel.incline = AppConstants.ScreenSpecificConstant.FilterOptionScreen.pitchOptions[selection]
            self.informationRequestModel.inclineValue = AppConstants.ScreenSpecificConstant.FilterOptionScreen.pitchOptionsValues[selection]
            break
        case .width:
            self.informationRequestModel.width = AppConstants.ScreenSpecificConstant.FilterOptionScreen.sideWalkOptions[selection]
            self.informationRequestModel.widthValue = AppConstants.ScreenSpecificConstant.FilterOptionScreen.sideWalkOptionsValues[selection]
            break
        case .obstacle:
            self.informationRequestModel.obstacle = AppConstants.ScreenSpecificConstant.FilterOptionScreen.obstacleOptions[selection]
            break
        case .routing:
            break
        }
    }
}
extension FilterViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collapsedData[section] ? 0 : (self.titlesOptionsText[section]).count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.selections[section] == "" ? 57 : 82
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 200
        }
        else
        {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let sectionView  = Bundle.main.loadNibNamed(String(describing:InfoSectionHeader.self), owner: self, options: nil)![0] as! InfoSectionHeader
        sectionView.tag = section
        sectionView.labelInfoTitle?.text = self.titles[section]
        sectionView.isUserInteractionEnabled = true
       sectionView.labelInfoSelection.text = self.selections[section]
        sectionView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(sectionLabelTapped(_:)))]
        if (self.titlesOptionsText[section])[0] == ""
        {
            sectionView._iConstraintTrailingStackView.constant = 16
            sectionView.buttonArrow.isHidden = true
            sectionView.isUserInteractionEnabled = false
        }
        else
        {
            sectionView._iConstraintTrailingStackView.constant = 62
            sectionView.buttonArrow.isHidden = false
            sectionView.isUserInteractionEnabled = true
        }
        if !collapsedData[section]
        {
         sectionView.buttonArrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        else
        {
            sectionView.buttonArrow.transform = CGAffineTransform.identity
        }
        return sectionView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.titlesOptionsText[indexPath.section])[indexPath.row] == ""
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoutingTableViewCell") as! RoutingTableViewCell
            cell.delegate = self
            cell.textFieldRouteWia.placeholder = AppConstants.ScreenSpecificConstant.FilterOptionScreen.ENTER_LOCATION
            return cell
        }
        else
        {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellIdentifier")
        cell.textLabel?.text = (self.titlesOptionsText[indexPath.section])[indexPath.row]
        return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutSubviews()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0
        {
        self.selections[indexPath.section] = (self.titlesOptionsText[indexPath.section])[indexPath.row]
        self.populateEntryInModel(entry: FeedbackPoint(rawValue: indexPath.section)!,selection: indexPath.row)
            self.collapsedData[indexPath.section] = true
        self.tableViewInformation.reloadSections([indexPath.section], with: .top)
        }
    }
    
}
extension FilterViewController : RouteViaDelegate
{
    func didSelectRoutePoint(_ routeInfo: (String, Double, Double)) {
         self.selections[0] = routeInfo.0
      
        let lat = routeInfo.1
        let long = routeInfo.2
        let addr = routeInfo.0
        self.informationRequestModel.routeViaInfo = (lat,long,addr)
        
        self.tableViewInformation.reloadSections([0], with: .none)
    }
    func showLoader() {
        self.showLoader(self)
    }
    
    func hideLoader() {
        self.hideLoader(self)
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {
        self.showErrorAlert(alertTitle, alertMessage: alertMessage, VC: self)
    }
}
