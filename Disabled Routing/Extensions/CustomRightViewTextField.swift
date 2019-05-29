//
//  CustomRightViewTextField.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 10/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import CoreLocation
protocol CustomLocationSearchTextFieldDelegate:class {
    func sendPlacesRequest(withUserInput userInput: String,type:MapRequestModel.QueryType)
    func didTextFieldBecomeEmpty()
    func didTextFieldBecomeActive()
}
extension CustomLocationSearchTextFieldDelegate { func didTextFieldBecomeEmpty(){}}
@IBDesignable
class CustomLocationSearchTextField: UITextField {

    var currentLocation = LocationServiceManager.sharedInstance.currentLocation?.coordinate
    weak var customDelegate: CustomLocationSearchTextFieldDelegate?
    
    private var rightViewButton: UIButton =  UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    private var searchTimer : Timer!
    private var queryString : String!
    var isCurrentFieldSource = false


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LocationServiceManager.sharedInstance.viewDelegate = self
        
        self.rightViewButton.setImage(#imageLiteral(resourceName: "ic_my_location"), for: .normal)
        self.rightViewButton.addTarget(self, action:#selector(setCurrentLocation(_:)), for: .touchUpInside)
       
        self.rightViewMode = .always
        self.rightViewButton.contentMode = .left
        self.clearButtonMode = .whileEditing
        self.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        self.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.size.width - 33, y: 2.5, width: 25, height: 25)
    }
    @objc private func setCurrentLocation(_ sender: Any) {
        let lat = currentLocation?.latitude ?? 0.0
        let long = currentLocation?.longitude ?? 0.0
        self.queryString = "point.lat=\(lat)&point.lon=\(long)"
        self.customDelegate?.sendPlacesRequest(withUserInput: queryString,type:MapRequestModel.QueryType.location)
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: Any) {
        self.rightView = self.text == "" ? rightViewButton : nil
        self.customDelegate?.didTextFieldBecomeActive()
    }
    @IBAction func textFieldDidEndEditing(_ sender: Any) {
        self.rightView = nil
    }
    @IBAction func textFieldDidChange(_ sender: Any) {
        self.rightView = self.text == "" ? rightViewButton : nil
        if self.text == ""
        {
            self.customDelegate?.didTextFieldBecomeEmpty()
        }
        queryString = "\(self.text ?? "")&boundary.circle.lat=\(AppConstants.ScreenSpecificConstant.MapScreen.CITY_CENTER_LATITIUDE)&boundary.circle.lon=\(AppConstants.ScreenSpecificConstant.MapScreen.CITY_CENTER_LONGITUDE)"
        self.searchLocation()
    }
    private func searchLocation()
    {
        if let searchTimer = searchTimer {
            searchTimer.invalidate()
        }
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(requestSuggestionsForQuery(_:)), userInfo: nil, repeats: false)
    }
    @objc private func requestSuggestionsForQuery(_ sender: Any)
    {
        self.customDelegate?.sendPlacesRequest(withUserInput: queryString,type:MapRequestModel.QueryType.query)
    }
}
extension CustomLocationSearchTextField : LocationUpdateDelegate
{
    func locationUpdated(lat: Double, long: Double) {
        self.currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
