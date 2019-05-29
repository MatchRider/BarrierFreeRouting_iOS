//
//  MapScreenViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 8/10/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import WebKit
import Polyline
import CoreLocation


protocol MapScreenViewControllerDelegate:class {
    func filtersAdded(_ routeRequestModel:FilterScreenRequestModel)
    func filtersCleared(_ routeRequestModel:FilterScreenRequestModel)
}
class MapScreenViewController: BaseViewController {
    
    
    @IBOutlet weak var imageViewLocationPicker: UIImageView!
    @IBOutlet weak var segmentControlWayNodes: UISegmentedControl!

    @IBOutlet weak var stackViewAB: UIStackView!
    
    @IBOutlet weak var switchToggle: UISwitch!
     @IBOutlet weak var toggleValidationWays: UISwitch!
    
    @IBOutlet weak var viewRouteInfo: UIView!
    @IBOutlet weak var mapViewBackGroundView: UIView!
    @IBOutlet weak var stackViewLocations: UIStackView!
    @IBOutlet weak var stackViewRouteOption: UIStackView!
   
    
    @IBOutlet weak var textFieldSource: CustomLocationSearchTextField!
    @IBOutlet weak var textFieldDestination: CustomLocationSearchTextField!
    @IBOutlet weak var tableViewPlaces: UITableView!
    
    @IBOutlet weak var labelValidation: UILabel!
    
    @IBOutlet weak var _iConstraintLabelToMapBackground: NSLayoutConstraint!
    @IBOutlet weak var _iConstraintMapVieInfoView: NSLayoutConstraint!
    @IBOutlet weak var _iConstraintSwitcgToLabel: NSLayoutConstraint!
    @IBOutlet weak var _iConstraintSwitchToTopView: NSLayoutConstraint!
    @IBOutlet weak var _iConstraintVerticalSpacingMapViewTextField: NSLayoutConstraint!
    
    @IBOutlet weak var buttonGo: CustomButton!
    @IBOutlet weak var buttonOptions: UIButton!
    @IBOutlet weak var buttonDistance: UIButton!
    @IBOutlet weak var buttonTime: UIButton!
    @IBOutlet weak var buttonAscent: UIButton!
    @IBOutlet weak var buttonDescent: UIButton!
    @IBOutlet weak var buttonLocationSwapped: UIButton!
    @IBOutlet weak var buttonInfo: UIButton!
    @IBOutlet weak var buttonRefresh: UIButton!

    
    var currentView : MapType = .route
    var presenterMap : MapPresenter!
    var presenterPlaces : PlacesPresenter!
    var nodes : [Nodes]!
    var latLngs : [[Double]]!
    var wayPoints : [Int]!
    var currentPosition = 1
    var routeRequestModel : FilterScreenRequestModel?
    var isViewIntitialised = false
    var navigationTimer : Timer?
    var mapWebView: MapView!
    var directionsResponseModel:DirectionResponseModel!
    var currentZoomLevel = 0
    var  isFromSuggestionScreen = false
    var  isOSMData = false
    var  isNodeShown = false
    var  isRouteNavigation = false
    let locationButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    fileprivate var placesResponseModel : PlacesResponseModel!
    
    var popUpVC : ConfirmationPopUpVC!
    var wayData : WayData?
    var nodeData : NodeReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         print("Map viewDidAppear")
        if !isViewIntitialised {
            self.intialSetupForView()
            if isFromSuggestionScreen
            {
                self.setUpViewForSuggestion()
            }
            isViewIntitialised = true
        }
 
        buttonGo.makeViewCircular()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(true)
         print("Map viewDidDisappear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
          print("Map viewWillDisappear")
        if isMovingFromParent {
    self.mapWebView.configuration.userContentController.removeScriptMessageHandler(forName: AppConstants.LeafletEvents.MAP_MOVE_END_EVENT)
             self.mapWebView.configuration.userContentController.removeScriptMessageHandler(forName: AppConstants.LeafletEvents.MAP_ZOOM_LEVEL_CHANGED)
    self.mapWebView.configuration.userContentController.removeScriptMessageHandler(forName: AppConstants.LeafletEvents.POLYLINE_TAPPED)
    self.mapWebView.configuration.userContentController.removeScriptMessageHandler(forName: AppConstants.LeafletEvents.MAP_MOVE_START_EVENT)
    self.mapWebView.configuration.userContentController.removeScriptMessageHandler(forName: AppConstants.LeafletEvents.NODE_TAPPED)
            
        NotificationCenter.default.removeObserver(self)
        }
    }
    //MARK:- Helper methods
    
    private func prepareViewController() {
        
        self.presenterMap               = MapPresenter(delegate: self)
        self.presenterPlaces            = PlacesPresenter(delegate: self)
        
        self.routeRequestModel = RouteOptionManager.shared.getRouteOption()
        
        self.textFieldSource.customDelegate = self
        self.textFieldDestination.customDelegate = self
        self.textFieldSource.delegate = self
        self.textFieldDestination.delegate = self
        self.buttonGo.isHidden = false
        self.buttonRefresh.isHidden = true
        self.textFieldSource.placeholder = AppConstants.ScreenSpecificConstant.MapScreen.FROM_LOCATION_PLACEHOLDER
        self.textFieldDestination.placeholder = AppConstants.ScreenSpecificConstant.MapScreen.TO_LOCATION_PLACEHOLDER
        self.buttonGo.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.GO_BUTTON_TITLE, for: .normal)
        
        self.segmentControlWayNodes.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.WAY, forSegmentAt: 0)
        self.segmentControlWayNodes.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.NODE, forSegmentAt: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateWayData), name: AppConstants.NSNotificationNames.WAY_DATA_UPDATED_NOTIFICATION, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateOSMWayData), name: AppConstants.NSNotificationNames.OSM_WAY_DATA_UPDATED_NOTIFICATION, object: nil)
    }
    /**
     This method is used for initial setups
     */
    private func intialSetupForView(){
        self.setUpWkWebView()
        self.tableViewInitalization()
        self.prefillLastRouteInfo()
    }
    private func prefillLastRouteInfo() {
        if let sourceAddress = routeRequestModel?.sourceInfo.address {
            self.textFieldSource.text = sourceAddress
        }
        if let destinationAddress = routeRequestModel?.destinationInfo.address {
            self.textFieldDestination.text = destinationAddress
        }
    }
    private func tableViewInitalization(){
        self.tableViewPlaces.delegate   = self
        self.tableViewPlaces.dataSource = self
        self.tableViewPlaces.estimatedRowHeight = 30
    }
    
    private func setUpViewForRoute() {
    self._iConstraintLabelToMapBackground.isActive = false
    self._iConstraintVerticalSpacingMapViewTextField.isActive = true
    self.segmentControlWayNodes.isHidden = true
    self._iConstraintSwitchToTopView.isActive = true
    self._iConstraintSwitcgToLabel.isActive = false
    
    self.stackViewAB.isHidden = false
    self.stackViewLocations.isHidden = false
    self.stackViewRouteOption.isHidden = false
    self.buttonGo.isHidden = false
    self.buttonRefresh.isHidden = true
    
    self.labelValidation.isHidden = true
    self.toggleValidationWays.isHidden = true
    self.mapWebView.mapType = .route
    if self._iConstraintMapVieInfoView.isActive == true
    {
        self._iConstraintVerticalSpacingMapViewTextField.isActive = false
        self._iConstraintSwitchToTopView.constant = 46
    }
    
    self.showRouteBetweenLocations(forDirectionModel:self.directionsResponseModel)
    UIView.animate(withDuration: 1, animations: {
        self.view.layoutSubviews()
        self.viewRouteInfo.alpha = self._iConstraintMapVieInfoView.isActive ? 1 : 0
        
    }, completion: nil)
}
    private func setUpViewForSuggestion() {
    
    if self.isFromSuggestionScreen {
        self.switchToggle.isOn = true
        self.switchToggle.isHidden = true
    }
    
    self.imageViewLocationPicker.isHidden = true
    self.segmentControlWayNodes.isHidden = false
        self.labelValidation.text = self.toggleValidationWays.isOn ? AppConstants.ScreenSpecificConstant.MapScreen.VALID_WAYS : (isOSMData ? AppConstants.ScreenSpecificConstant.MapScreen.OSM : AppConstants.ScreenSpecificConstant.MapScreen.IN_VALID_WAYS)
    self.mapWebView.mapType = .suggestion
    self._iConstraintLabelToMapBackground.isActive = true
    self._iConstraintVerticalSpacingMapViewTextField.isActive = false
    
    self._iConstraintSwitchToTopView.isActive = false
    self._iConstraintSwitcgToLabel.isActive = true
    
    self.stackViewAB.isHidden = true
    self.stackViewLocations.isHidden = true
    self.stackViewRouteOption.isHidden = true
    self.buttonGo.isHidden = true
    self.buttonInfo.isHidden = true
    self.buttonRefresh.isHidden = false
    self.labelValidation.isHidden = false
    self.toggleValidationWays.isHidden = false

    
    UIView.animate(withDuration: 1, animations: {
        self.view.layoutSubviews()
        self.viewRouteInfo.alpha = 0
        
    }, completion: nil)
        if isOSMData { self.toggleValidationWays.isHidden = true}
}
    private func setUpWkWebView()
    {
        self.mapWebView = MapView(frame: self.mapViewBackGroundView.bounds)
        self.mapWebView.mapType = isFromSuggestionScreen ? .suggestion : .route
        self.mapViewBackGroundView.addSubview(self.mapWebView)
        self.mapWebView.delegate = self
        
        if let wayData = WayDetails.shared.wayData?.way,!isOSMData,!isRouteNavigation {
            
            self.mapWebView.initialiseWayInfo(withWayData: wayData)
            self.mapWebView.initialiseNodeInfo(withNodeData: WayDetails.shared.nodeData ?? [])
        }
        else if !isOSMData,!isRouteNavigation {
             self.showLoader()
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveWayData), name: AppConstants.NSNotificationNames.WAY_DATA_RECEIVED_NOTIFICATION, object: nil)
        }
        
        if let osmWayData = WayDetails.shared.osmWayData?.way,isOSMData,!isRouteNavigation {
            self.mapWebView.initialiseWayInfo(withWayData: osmWayData)
            self.mapWebView.initialiseNodeInfo(withNodeData: WayDetails.shared.osmNodeData ?? [])
        }
        else if isOSMData,!isRouteNavigation {
             self.showLoader()
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveOSMWayData), name: AppConstants.NSNotificationNames.OSM_WAY_DATA_RECEIVED_NOTIFICATION, object: nil)
        }
    }
    private func showFeedbackPopUp(forType type:Int)
    {
        self.popUpVC = UIViewController.getViewController(ConfirmationPopUpVC.self, storyboard: UIStoryboard.Storyboard.Main.object)
        self.popUpVC.message = type == 0 ? AppConstants.ScreenSpecificConstant.MapScreen.LOOK_CLOSER_TEXT_WAY : AppConstants.ScreenSpecificConstant.MapScreen.LOOK_CLOSER_TEXT_NODE
        self.popUpVC.type = type
        popUpVC.modalPresentationStyle = .overCurrentContext

        popUpVC.delegate = self
        self.present(popUpVC, animated: true, completion: nil)
    }
    @objc func didReceiveWayData()
    {
        if let wayData = WayDetails.shared.wayData?.way,!isOSMData {
            self.mapWebView.initialiseWayInfo(withWayData: wayData)
            self.mapWebView.initialiseNodeInfo(withNodeData: WayDetails.shared.nodeData ?? [])
        }
        if self.mapWebView.mapType == .suggestion,!isOSMData
        {
             showElementsBased(onSegmentIndex: self.segmentControlWayNodes.selectedSegmentIndex)
//            let info : (type:Int,color:String) = self.toggleValidationWays.isOn ? (2,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_VALID_COLOR) : (1,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
//            
//             self.mapWebView.showWayData(ofType: info.type, withColor:info.color)
        }
        if !isOSMData {self.hideLoader()}
    }
    @objc func didReceiveOSMWayData()
    {
        if let wayData = WayDetails.shared.osmWayData?.way,isOSMData {
            self.mapWebView.initialiseWayInfo(withWayData: wayData)
            self.mapWebView.initialiseNodeInfo(withNodeData: WayDetails.shared.osmNodeData ?? [])
        }
        if self.mapWebView.mapType == .suggestion,isOSMData
        {
            showElementsBased(onSegmentIndex: self.segmentControlWayNodes.selectedSegmentIndex)
//            let info : (type:Int,color:String) = self.toggleValidationWays.isOn ? (2,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_VALID_COLOR) : (1,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
//
//            self.mapWebView.showWayData(ofType: info.type, withColor:info.color)
        }
        if isOSMData {self.hideLoader()}
    }
    @objc func didUpdateOSMWayData()
    {
        if let wayData = WayDetails.shared.osmWayData?.way {
            self.mapWebView.initialiseWayInfo(withWayData: wayData)
            
        }
        if let nodeData = WayDetails.shared.osmNodeData {
            self.mapWebView.initialiseNodeInfo(withNodeData:nodeData)
        }
        
        if self.segmentControlWayNodes.selectedSegmentIndex == 0 {
            self.mapWebView.showWayData(ofType: 1, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
        }
        else {
            self.mapWebView.showNodeData(ofType: 1, withColor:AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
        }
    }
    @objc func didUpdateWayData()
    {
        if let wayData = WayDetails.shared.wayData?.way {
            self.mapWebView.initialiseWayInfo(withWayData: wayData)
           
        }
        if let nodeData = WayDetails.shared.nodeData {
             self.mapWebView.initialiseNodeInfo(withNodeData:nodeData)
        }
        
        if self.segmentControlWayNodes.selectedSegmentIndex == 0 {
             self.mapWebView.showWayData(ofType: 1, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
        }
        else {
             self.mapWebView.showNodeData(ofType: 1, withColor:AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
        }
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.showLoader()
        if isOSMData {
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveOSMWayData), name: AppConstants.NSNotificationNames.OSM_WAY_DATA_RECEIVED_NOTIFICATION, object: nil)
              NotificationCenter.default.post(name: AppConstants.NSNotificationNames.GET_OSM_WAY_NOTIFICATION, object: nil, userInfo: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveWayData), name: AppConstants.NSNotificationNames.WAY_DATA_RECEIVED_NOTIFICATION, object: nil)
              NotificationCenter.default.post(name: AppConstants.NSNotificationNames.GET_SURVEY_WAY_NOTIFICATION, object: nil, userInfo: nil)
        }
        
    }
    @IBAction func infoButtonTapped(_ sender: UIButton) {
         let instructionVC = UIViewController.getViewController(InstructionsViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        instructionVC.segments = self.directionsResponseModel.features?[0].properties?.segments!
        self.navigationController?.pushViewController(instructionVC, animated: true)
    }
    
    @IBAction func myLocationButtonTapped(_ sender: Any) {
        let lat = self.mapWebView.currentLocation?.latitude ?? 0.0
        let long = self.mapWebView.currentLocation?.longitude ?? 0.0
        currentZoomLevel = 18
        mapWebView.setMapView(withLatitude: lat, longitude: long, andZoom: 18)
    }
    @IBAction func optionsButtonTapped(_ sender: Any) {
        self.navigateToFeedbackScreen()
    }
    @IBAction func buttonSwapTapped(_ sender: Any) {
        
        let temp = self.routeRequestModel!.destinationInfo
        self.routeRequestModel!.destinationInfo = self.routeRequestModel!.sourceInfo
        self.routeRequestModel!.sourceInfo = temp
        populateSourceDestinationFields()
        self.buttonGo.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.GO_BUTTON_TITLE, for: .normal)
        if let _ = self.navigationTimer
        {
            self.navigationTimer?.invalidate()
        }
        self.goButtonTapped(UIButton())
    }
    @IBAction func toggleTapped(_ sender: Any) {

        if self.switchToggle.isOn {
         self.checkForLogin()
        }
        else {
            self.setUpViewForRoute()
        }
    }
    private func checkForLogin() {
        if !UserDefaultUtility.retrieveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN)
        {
            self.switchToggle.isOn = false
            self.showLoginViewController()
        }
        else
        {
            self.setUpViewForSuggestion()
            guard let _ = WayDetails.shared.wayData else {
                self.showLoader()
                return
            }
                self.mapWebView.showWayData(ofType: 1, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
        }
}
    private func showLoginViewController()
    {
        let loginViewController = UIViewController.getViewController(LoginViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        loginViewController.delegate = self
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        showElementsBased(onSegmentIndex: sender.selectedSegmentIndex)
    }
    private func showElementsBased(onSegmentIndex segmentIndex:Int) {
        if segmentIndex == 0 {
            let info : (type:Int,color:String) = self.toggleValidationWays.isOn ? (2,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_VALID_COLOR) : (1,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
            
            self.mapWebView.showWayData(ofType: info.type, withColor:info.color)
        }
        else {
            let info : (type:Int,color:String) = self.toggleValidationWays.isOn ? (2,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_VALID_COLOR) : (1,AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
            
            self.mapWebView.showNodeData(ofType: info.type, withColor:info.color)
        }
    }
    @IBAction func validatedToggleTapped(_ sender: Any) {
        
         self.labelValidation.text = self.toggleValidationWays.isOn ? AppConstants.ScreenSpecificConstant.MapScreen.VALID_WAYS : AppConstants.ScreenSpecificConstant.MapScreen.IN_VALID_WAYS
        self.segmentControlWayNodes.selectedSegmentIndex = 0
        if self.toggleValidationWays.isOn
        {
            self.mapWebView.showWayData(ofType: 2, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_VALID_COLOR)
        }
        else
        {
            self.mapWebView.showWayData(ofType: 1, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
        }
    }
    
    @IBAction func goButtonTapped(_ sender: Any) {
        
        if self.buttonGo.titleLabel?.text == AppConstants.ScreenSpecificConstant.MapScreen.GO_BUTTON_TITLE
        {
            guard let _ = routeRequestModel!.sourceInfo.lat,let _ = routeRequestModel!.sourceInfo.long else {
                self.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: "\(AppConstants.ScreenSpecificConstant.ValidationScreen.PLEASE_CHOOSE_TEXT) \(AppConstants.ScreenSpecificConstant.MapScreen.FROM_LOCATION_PLACEHOLDER)")
                return
            }
            
            guard let _ = routeRequestModel!.destinationInfo.lat,let _ = routeRequestModel!.destinationInfo.long else {
                self.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: "\(AppConstants.ScreenSpecificConstant.ValidationScreen.PLEASE_CHOOSE_TEXT) \(AppConstants.ScreenSpecificConstant.MapScreen.TO_LOCATION_PLACEHOLDER)")
                return
            }
            //  self.getWayDataInfo()
            self.imageViewLocationPicker.isHidden = true
            self.presenterMap.sendDirectionRequest(withLocations:routeRequestModel!)
            
            self.presenterMap.sendNodesRequest(withLocations: self.routeRequestModel!)
             RouteOptionManager.shared.saveRouteOption(self.routeRequestModel!)
        }
        else
        {
//            self.buttonGo.isHidden = true
//            self.buttonGo.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.GO_BUTTON_TITLE, for: .normal)
        }
    }
    @objc private func changeMarkerLocation(_ sender: Any) {
        if currentPosition < self.latLngs.count
        {
            let lat = self.latLngs[currentPosition][0]
            let long = self.latLngs[currentPosition][1]
            
            mapWebView.changePositionOfMarker(withLatitude: lat, longitude: long)
            currentZoomLevel = 18
            mapWebView.setMapView(withLatitude: lat, longitude: long, andZoom: 18)
            
            if self.wayPoints.contains(currentPosition)
            {
                let index = self.wayPoints.index(of: currentPosition) ?? 0
                mapWebView.changeColorOfPolyline(ofIndex: index)
            }
            currentPosition += 1
        }
        
    }
    fileprivate func populateSourceDestinationFields() {
        self.textFieldSource.text = self.routeRequestModel!.sourceInfo.2 ?? ""
        self.textFieldDestination.text = self.routeRequestModel!.destinationInfo.2 ?? ""
        
        guard let _ = routeRequestModel!.sourceInfo.lat,let _ = routeRequestModel!.sourceInfo.long,let _ = routeRequestModel!.destinationInfo.lat,let _ = routeRequestModel!.destinationInfo.long else {
            
            return
        }
    }
    private func navigateToFeedbackScreen(){
        let informationVC = UIViewController.getViewController(FilterViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        if let infoModel = self.routeRequestModel
        {
            informationVC.informationRequestModel = infoModel
            informationVC.selections = [infoModel.routeViaInfo.2,infoModel.surfaceType ?? "",infoModel.slopedCurb ?? "",infoModel.incline ?? "",infoModel.width ?? "",infoModel.obstacle ?? ""]
        }
        else
        {
            informationVC.informationRequestModel = FilterScreenRequestModel()
        }
        informationVC.delegate = self
        informationVC.isFromFilter = true
        self.navigationController?.pushViewController(informationVC, animated: true)
    }
    func navigateToCorrectionScreen(withWayResponseModel wayResponseModel:WayData?, andNodeResponseModel nodeResponseModel:NodeReference?) {
        let correctionVC = UIViewController.getViewController(CorrectionViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
            correctionVC.isOSMData = isOSMData
            correctionVC.wayDataModelCopied = wayResponseModel?.copy() as? WayData
            correctionVC.nodeDataModelCopied = nodeResponseModel?.copy() as? NodeReference
            correctionVC.wayDataModel = wayResponseModel
            correctionVC.nodeDataModel = nodeResponseModel
            correctionVC.isValid = self.toggleValidationWays.isOn ? true : false
        
        self.navigationController?.pushViewController(correctionVC, animated: true)
    }

    fileprivate func showRouteBetweenLocations(forDirectionModel directionsResponseModel:DirectionResponseModel?) {
    if let directionsResponseModel = directionsResponseModel
    {
        self.latLngs = directionsResponseModel.features?[0].geometry?.coordinates?.map({ (obj) -> [Double] in
            [obj[1],obj[0],obj[2]]
        })
        self.wayPoints = directionsResponseModel.features?[0].properties?.segments?[0].steps?.flatMap({
            return [$0.wayPoints?.first]
        }) as! [Int]
        self.drawPolyineOnMap(withDirectionModel: directionsResponseModel)
        self.showRouteInformationView(forDirectionModel:directionsResponseModel)
        self.buttonInfo.isHidden = false
    }
    else
    {
        self.mapWebView.removeAllLayers()
    }
}
    private func drawPolyineOnMap(withDirectionModel directionsResponseModel:DirectionResponseModel) {
        mapWebView.removeAllLayers()
        for index in 0 ..< directionsResponseModel.features![0].properties!.segments!.count
        {
            let segment = directionsResponseModel.features![0].properties!.segments![index]
            
            for index in (segment.steps!.indices)
            {
                let step = segment.steps![index]
                let partialLatLongs = latLngs[step.wayPoints![0]...step.wayPoints![1]]
                mapWebView.drawPolyLine(withLatLongs: partialLatLongs, andColor: "#a50050", withPadding: [25,25], shouldTap: false)
            }
            
        }
        mapWebView.boundMap(withLatLongs: latLngs, withPadding: [25,25])
        mapWebView.addSourceMarkerOnMap(withLatitude: latLngs.first![0], longitude: latLngs.first![1], address: self.textFieldSource.text!)
        if directionsResponseModel.info?.query?.coordinates?.count == 3
        {
            mapWebView.addDestinationMarkerOnMap(withLatitude: (directionsResponseModel.info?.query?.coordinates![1][1])!, longitude: (directionsResponseModel.info?.query?.coordinates![1][0])!, address: (self.routeRequestModel?.routeViaInfo.2)!)

              mapWebView.addMidPointMarkerOnMap(withLatitude: latLngs.last![0], longitude: latLngs.last![1], address: self.textFieldDestination.text!)
        } else {
           mapWebView.addDestinationMarkerOnMap(withLatitude: latLngs.last![0], longitude: latLngs.last![1], address: self.textFieldDestination.text!)
        }
        
        let lat = self.mapWebView.currentLocation?.latitude ?? 0.0
        let long = self.mapWebView.currentLocation?.longitude ?? 0.0
        mapWebView.addUserMarkerOnMap(withLatitude: lat, longitude: long)
    }
    private func showRouteInformationView(forDirectionModel directionsResponseModel:DirectionResponseModel) {
        self._iConstraintMapVieInfoView.isActive = true
        self._iConstraintVerticalSpacingMapViewTextField.isActive = false
        self._iConstraintSwitchToTopView.constant = 46
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutSubviews()
            self.viewRouteInfo.alpha = 1
            self.buttonTime.setTitle(directionsResponseModel.features?[0].properties?.summary?[0].duration?.getTimeFromSeconds() ?? "", for: .normal)
            self.buttonDistance.setTitle(String(format:"  %.2f km",directionsResponseModel.features?[0].properties?.summary?[0].distance?.km ?? 0.0), for: .normal)
            self.buttonAscent.setTitle(String(format:"  %.2f m",directionsResponseModel.features?[0].properties?.summary?[0].ascent ?? 0.0), for: .normal)
            self.buttonDescent.setTitle(String(format:"  %.2f m",directionsResponseModel.features?[0].properties?.summary?[0].descent ?? 0.0), for: .normal)
            self.mapViewBackGroundView.layoutSubviews()
        }, completion: nil)
    }
}
extension MapScreenViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let placesModel = self.placesResponseModel,let features = placesModel.features,features.count != 0 else
        {
            return 0
        }
        return features.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Int(ScreenSize.size.width) == ScreenWidth.Iphone5 ? self.tableViewPlaces.frame.height/3 : self.tableViewPlaces.frame.height/4
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellIdentifier")
        cell.textLabel?.text = self.placesResponseModel.features?[indexPath.row].properties?.name
        cell.textLabel?.font = UIFont.getFrutigerLight(withSize: 17)
        cell.detailTextLabel?.text =  self.presenterPlaces.getAddressFromProperties((self.placesResponseModel.features?[indexPath.row].properties)!)
        cell.detailTextLabel?.font = UIFont.getFrutigerLight(withSize: 14)
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = self.placesResponseModel.features?[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if self.textFieldSource.isFirstResponder
        {
            self.routeRequestModel?.sourceInfo = (feature?.geometry?.coordinates![1],feature?.geometry?.coordinates![0],cell?.detailTextLabel?.text)
            self.textFieldSource.text = cell?.detailTextLabel?.text
//            self.routeRequestModel.fromLat = feature?.geometry?.coordinates![1]
//            self.routeRequestModel.fromLong = feature?.geometry?.coordinates![0]
        }
        else
        {
            self.routeRequestModel?.destinationInfo = (feature?.geometry?.coordinates![1],feature?.geometry?.coordinates![0],cell?.detailTextLabel?.text)
            self.textFieldDestination.text = cell?.detailTextLabel?.text
//            self.routeRequestModel.toLat = feature?.geometry?.coordinates![1]
//            self.routeRequestModel.toLong = feature?.geometry?.coordinates![0]
        }
        populateSourceDestinationFields()
        self.tableViewPlaces.isHidden = true
        
    }
}
extension MapScreenViewController : MapScreenViewControllerDelegate
{
    func filtersCleared(_ routeRequestModel: FilterScreenRequestModel) {
         self.routeRequestModel = routeRequestModel
    }
    
    func filtersAdded(_ routeRequestModel: FilterScreenRequestModel) {
        self.routeRequestModel = routeRequestModel
    }
}
extension MapScreenViewController:MapScreenViewDelgate,PlacesViewDelegate
{
    func didUpdateWay(withResponseModel updateResponseModel: UpdateResponseModel) {
        
    }
    
    func didReceiveWayInfo(withResponseModel wayInofResponseModel: WayResponseModel) {
      //  self.navigateToCorrectionScreen(withWayResponseModel: wayInofResponseModel.way![0], andNodeResponseModel: nil)
    }
    
    func didReceivePlacesSuggestion(withResponseModel directionsResponseModel: PlacesResponseModel) {
        self.placesResponseModel = directionsResponseModel
        self.tableViewPlaces.isHidden = false
        self.tableViewPlaces.reloadData()
    }
    
    func showLoader() {
        showLoader(self)
    }
    
    func hideLoader() {
        hideLoader(self)
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {
        self.showErrorAlert(alertTitle,alertMessage:alertMessage,VC :self)
    }
    func didReceiveNodes(withResponseModel directionsResponseModel: NodesResponseModel) {
        self.nodes = directionsResponseModel.nodes?.filter({ (node) -> Bool in
            if node.nodeType?.identifier == "bus_stop" { return true } else
                if node.nodeType?.identifier == "parking" { return true } else
                    if node.nodeType?.identifier == "tram_stop" { return true } else
                        if node.nodeType?.identifier == "toilets" { return true }
            
            return false
        })
        for node in nodes
        {
            var publicTranferName = ""
            var funcName = ""
            let identifier = node.nodeType?.identifier ?? ""
            switch identifier {
            case "bus_stop" :
                funcName = "addBusStopMarkerOnMap"
                publicTranferName = AppConstants.ScreenSpecificConstant.MapScreen.BUS_STOP_TITLE
                break
            case "tram_stop" :
                funcName = "addTrainMarkerOnMap"
                publicTranferName = AppConstants.ScreenSpecificConstant.MapScreen.TRAM_STOP_TITLE
                break
            case "toilets" :
                funcName = "addToiletMarkerOnMap"
                publicTranferName = AppConstants.ScreenSpecificConstant.MapScreen.TOILETS_TITLE
                break
            case "parking" :
                funcName = "addParkingMarkerOnMap"
                publicTranferName = AppConstants.ScreenSpecificConstant.MapScreen.PARKING_TITLE
                break
            default:
                break
            }
             self.isNodeShown = true
            mapWebView.evaluateJavaScript(("\(funcName)(\(node.lat!),\(node.lon!),'\(node.wheelchair!.capitalizeWordsInSentence())','\(publicTranferName)')")) { (obj, error) in
                print(error?.localizedDescription ?? "")
               
            }
        }
    }
    
    func didReceiveAddress(withResponseModel directionsResponseModel: PlacesResponseModel) {
        guard let features = directionsResponseModel.features,features.count > 0 else
        { return }
        
        guard let properties =  features[0].properties else { return }
        guard let coordinates =  features[0].geometry?.coordinates,coordinates.count >= 2 else { return }
        
        let address = self.presenterPlaces.getAddressFromProperties(properties)
        let lat = coordinates[1]
        let long = coordinates[0]
        if self.textFieldSource.isFirstResponder || self.textFieldSource.isCurrentFieldSource
        {
            self.textFieldSource.text = address
            self.routeRequestModel!.sourceInfo.lat = lat
            self.routeRequestModel!.sourceInfo.long = long
            self.routeRequestModel!.sourceInfo.address = address
        }
        else if self.textFieldDestination.isFirstResponder || self.textFieldDestination.isCurrentFieldSource
        {
            self.textFieldDestination.text = address
            self.routeRequestModel!.destinationInfo.lat = lat
            self.routeRequestModel!.destinationInfo.long = long
            self.routeRequestModel!.destinationInfo.address = address
        }
    }
    func didReceiveDirections(withResponseModel directionsResponseModel: DirectionResponseModel) {
        self.directionsResponseModel = directionsResponseModel
        self.showRouteBetweenLocations(forDirectionModel: directionsResponseModel)
    }
}
extension MapScreenViewController : MapViewDelegate
{
    func didStartMapDrag() {
        if self.textFieldSource.isFirstResponder
        {
            self.textFieldSource.isCurrentFieldSource = true
            self.textFieldDestination.isCurrentFieldSource = false
        }
        else if self.textFieldDestination.isFirstResponder
        {
            self.textFieldSource.isCurrentFieldSource = false
            self.textFieldDestination.isCurrentFieldSource = true
        }
        
        self.view.endEditing(true)
    }
    
    func didEndMapDrag(withCenter center: [Double]) {
        guard center.count == 2, !self.imageViewLocationPicker.isHidden else {
            return
        }
        let queryString = "point.lat=\(center[0])&point.lon=\(center[1])"
        self.sendPlacesRequest(withUserInput: queryString,type:MapRequestModel.QueryType.location)
    }
    func didChangeMapZoomLevel(zoomLevel: Double) {
        print(zoomLevel)
        if !isNodeShown && zoomLevel >= 16 {
            self.mapWebView.showNodes()
            isNodeShown = true
        } else if isNodeShown && zoomLevel < 16 {
             self.mapWebView.removeNodes()
                 isNodeShown = false
        }
    }
    func didTapped(onNode node: NodeReference) {
       self.nodeData = node
        self.wayData = nil
        self.mapWebView.boundMap(withLatLongs: [[(node.lat?.toDouble)!,(node.lon?.toDouble)!]], withPadding: [0,0])
        self.showFeedbackPopUp(forType : 1)
    }
    
    func didTapped(onWay way: WayData) {
        self.wayData = way
        self.nodeData = nil
        self.mapWebView.boundMap(withLatLongs: way.coordinatesDouble!, withPadding: [0,0])
        self.showFeedbackPopUp(forType : 0)
    }
    func mapViewDidLoad() {
        if isFromSuggestionScreen
        {
            self.mapWebView.showWayData(ofType: 1, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
        }
        else
        {
            self.mapWebView.showWayData(ofType: 2, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_VALID_COLOR)
        }
    }
}
extension MapScreenViewController:CustomLocationSearchTextFieldDelegate,UITextFieldDelegate
{
    func didTextFieldBecomeActive() {
        self.imageViewLocationPicker.isHidden = false
    }
    
    func sendPlacesRequest(withUserInput userInput: String, type: MapRequestModel.QueryType) {
        if removeQueryParameter(forUserInput: userInput).count <= 2 && type == .query {
            self.tableViewPlaces.isHidden = true
            return
        }
        self.presenterPlaces.sendPlacesRequest(withUserInput: userInput, type: type)
    }
    private func removeQueryParameter(forUserInput userInput:String)->String {
    let queryParams = userInput.components(separatedBy: "&")
    if queryParams.count != 0
    {
        return queryParams[0].trimmingCharacters(in: .whitespacesAndNewlines)
    }
    return ""
}
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.buttonGo.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.GO_BUTTON_TITLE, for: .normal)
       // self.buttonGo.isHidden = false
        return true
    }
    func didTextFieldBecomeEmpty() {
        self.buttonGo.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.GO_BUTTON_TITLE, for: .normal)
        self.imageViewLocationPicker.isHidden = true
        self.buttonGo.isHidden = false
    }
}
extension MapScreenViewController:LoginViewDelgate
{
    func didReceiveUserDetails(withResponseModel userResponseModel: OSMUser) {
        
    }
    
    func loginSuccessful() {
        self.switchToggle.isOn = true
          self.setUpViewForSuggestion()
         self.mapWebView.showWayData(ofType: 1, withColor: AppConstants.ScreenSpecificConstant.MapScreen.POLYLINE_INVALID_COLOR)
    }
    
    func loginFailed() {
        self.switchToggle.isOn = false
    }
    
    
}
extension MapScreenViewController:ConfirmationPopUpVCDelegate
{
    func confimationYesButtonTapped(forType type: Int) {
        if type == 0 {
            self.navigateToCorrectionScreen(withWayResponseModel: self.wayData, andNodeResponseModel: self.nodeData)
        }
        else {
            self.navigateToCorrectionScreen(withWayResponseModel: self.wayData, andNodeResponseModel: self.nodeData)
        }
    }
    
    func confimationNoButtonTapped() {
        self.popUpVC.dismiss(animated: true, completion: nil)
    }
}
extension Double
{
    var km : Double { return self/1000 }
}
extension Int
{
    var hour : Int { return self / (60*60) }
    var min : Int { return (self - (self.hour * 3600))/60   }
    func getTimeFromSeconds()->String {
        if self.hour == 0
        {
            return " \(self.min) \(AppConstants.ScreenSpecificConstant.MapScreen.MIN)"
        }
        else
        {
            return " \(self.hour) \(AppConstants.ScreenSpecificConstant.MapScreen.HOUR) \(self.min) \(AppConstants.ScreenSpecificConstant.MapScreen.MIN)"
        }
    }
}
