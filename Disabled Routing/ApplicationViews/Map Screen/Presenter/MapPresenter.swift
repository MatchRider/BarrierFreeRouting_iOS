//
//  MapPresenter.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
class MapPresenter: ResponseCallback{
    
    //MARK:- MapPresenter local properties
    private weak var mapViewDelegate             : MapScreenViewDelgate?
    private var shouldShowLoaderOnScreen = true
    private  var type : MapRequestModel.QueryType!
    //MARK:- Constructor
    init(delegate responseDelegate:MapScreenViewDelgate) {
        self.mapViewDelegate = responseDelegate
    }
    
    
    
    //MARK:- ResponseCallback delegate methods
    
    func servicesManagerSuccessResponse<T:Mappable> (responseObject : T){
        
        self.mapViewDelegate?.hideLoader()
        if responseObject is DirectionResponseModel {
            self.mapViewDelegate?.didReceiveDirections(withResponseModel: responseObject as! DirectionResponseModel)
        }
        if responseObject is NodesResponseModel {
            self.mapViewDelegate?.didReceiveNodes(withResponseModel: responseObject as! NodesResponseModel)
        }
        if responseObject is WayResponseModel {
            self.mapViewDelegate?.didReceiveWayInfo(withResponseModel: responseObject as! WayResponseModel)
        }
        if responseObject is UpdateResponseModel {
            self.mapViewDelegate?.didUpdateWay(withResponseModel: responseObject as! UpdateResponseModel)
        }
    }
    
    func servicesManagerError(error : AnyObject){
        self.mapViewDelegate?.hideLoader()
         if let errorObject = Mapper<WayError>().map(JSONString: ServiceManager.getJsonStringFor(dictionary: error)),let errorMessage = errorObject.message
         {
             self.mapViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: errorMessage)
        }
        else if let errorObject = Mapper<DirectionResponseModel>().map(JSONString: ServiceManager.getJsonStringFor(dictionary: error)),let errorCode = errorObject.error?.code
        {
            self.mapViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: ErrorResolver.message(forErrorCode: errorCode))
        }
        else
        {
            self.mapViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: AppConstants.ErrorMessages.SOME_ERROR_OCCURED)
        }
    }
    
    
    //MARK:- Methods to call server
    
    /**
     This method is used to send direction request to business layer with valid Request model
     - returns : Void
     */
    func sendDirectionRequest(withLocations locationModel:FilterScreenRequestModel) -> Void{
        self.mapViewDelegate?.showLoader()
        var mapRequestModel : MapRequestModel!
        
        
        if locationModel.isFilterApplied
        {
            let restriction = self.getRestrictionData(locationModel)
            mapRequestModel = MapRequestModel.Builder()
                .addRequestHeader(key: "Content-Type", value:"application/json").setFromLat(locationModel.sourceInfo.lat!).setFromLong(locationModel.sourceInfo.long!).setToLat(locationModel.destinationInfo.lat!).setToLong(locationModel.destinationInfo.long!).setRestrictions(restriction).setRouteLat((locationModel.routeViaInfo.lat)).setRouteLong((locationModel.routeViaInfo.long))
                .build()
        }
        else
        {
            
            mapRequestModel = MapRequestModel.Builder()
                .addRequestHeader(key: "Content-Type", value:"application/json").setFromLat(locationModel.sourceInfo.lat!).setFromLong(locationModel.sourceInfo.long!).setToLat(locationModel.destinationInfo.lat!).setToLong(locationModel.destinationInfo.long!)
                .build()
        }
         MapAPIRequest().makeAPIRequest(withReqFormData: mapRequestModel, responseCallback: self)
    }
    
    func sendWayDataRequest(withLocations locationModel:FilterScreenRequestModel) -> Void{
        
        if let path = Bundle.main.path(forResource: "Befahrung_Incline_Matchrider", ofType: "osm") {
            do {
                let text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                // print(text)
            } catch {
                print("Failed to read text from Befahrung_Incline_Matchrider")
            }
        } else {
            print("Failed to load file from app bundle Befahrung_Incline_Matchrider")
        }
        //       let mapRequestModel = MapRequestModel.Builder()
        //            .addRequestHeader(key: "Content-Type", value:"application/json").setFromLat(locationModel.sourceInfo.0!).setFromLong(locationModel.sourceInfo.1!).setToLat(locationModel.destinationInfo.0!).setToLong(locationModel.destinationInfo.1!)
        //            .build()
    }
    
    
    
    /**
     This method is used to send places request to business layer with valid Request model
     - returns : Void
     */
    func sendNodesRequest(withLocations locationModel:FilterScreenRequestModel) -> Void{
        // self.mapViewDelegate?.showLoader()
        var mapRequestModel : MapRequestModel!
        mapRequestModel = MapRequestModel.Builder()
            .setFromLat(locationModel.sourceInfo.0!).setFromLong(locationModel.sourceInfo.1!).setToLat(locationModel.destinationInfo.0!).setToLong(locationModel.destinationInfo.1!)
            .build()
         MapAPIRequest().makeAPIRequestForNodes(withReqFormData: mapRequestModel, responseCallback: self)
    }
    func sendWayIdRequest(withWayId wayId:String) -> Void{
        self.mapViewDelegate?.showLoader()
        var mapRequestModel : MapRequestModel!
        mapRequestModel = MapRequestModel.Builder()
            .setFromWayId(wayId)
            .build()
         MapAPIRequest().makeAPIRequestForWayInformation(withReqFormData: mapRequestModel, responseCallback: self)
    }
    func sendWayDataUpdateRequest(withWayInfoModel infoModel:FilterScreenRequestModel,andWayID wayId :String,andVerificationData verificationData:[Bool?]) -> Void{
        self.mapViewDelegate?.showLoader()
        
        let updateAttributes = self.getRequestDictionaryForUpdate(withWayInfoModel: infoModel)
        let validateAttributes = getRequestDictionaryForValidate(withWayInfoModel:infoModel,andVerificationData :verificationData)
       if updateAttributes.keys.count != 0
       {
        let requestDic = ["Id":wayId,"Attributes":updateAttributes] as [String : Any]
        var mapRequestModel : MapRequestModel!
        mapRequestModel = MapRequestModel.Builder()
            .setWayData(requestDic)
            .build()
        
        MapAPIRequest().makeAPIRequestForWayUpdateInformation(withReqFormData: mapRequestModel, responseCallback: self)
        }
        if validateAttributes.keys.count != 0
        {
            let requestDic = ["Id":wayId,"Attributes":validateAttributes] as [String : Any]
            var mapRequestModel : MapRequestModel!
            mapRequestModel = MapRequestModel.Builder()
                .setWayData(requestDic)
                .build()
              MapAPIRequest().makeAPIRequestForWayValidation(withReqFormData: mapRequestModel, responseCallback: self)
        }
    }
    private func getRequestDictionaryForUpdate(withWayInfoModel infoModel:FilterScreenRequestModel) -> [String : Any]
    {
        var attributes = [String : Any]()
        if let surfaceType = infoModel.surfaceType
        {
            attributes["footway"] = surfaceType
        }
        if let slopedCurb = infoModel.slopedCurb
        {
            attributes["highway"] = slopedCurb
        }
        if let incline = infoModel.incline
        {
            attributes["incline"] = incline
        }
        if let width = infoModel.width
        {
            attributes["width"] = width
        }
        return attributes
    }
    private func getRequestDictionaryForValidate(withWayInfoModel infoModel:FilterScreenRequestModel,andVerificationData verificationData:[Bool?]) -> [String : Any]
    {
        var attributes = [String : Any]()
        if let surfaceType = infoModel.surfaceType,let _ = verificationData[0]
        {
            attributes["footway"] = surfaceType
        }
        if let slopedCurb = infoModel.slopedCurb,let _ = verificationData[1]
        {
            attributes["highway"] = slopedCurb
        }
        if let incline = infoModel.incline,let _ = verificationData[2]
        {
            attributes["incline"] = incline
        }
        if let width = infoModel.width,let _ = verificationData[3]
        {
            attributes["width"] = width
        }
        return attributes
    }
    private func getRestrictionData(_ infoRequest:FilterScreenRequestModel) -> String
    {
        var restrictions = ""
        if let surfaceType = infoRequest.surfaceTypeValue,!surfaceType.isEmpty
        {
            restrictions = restrictions + "surface_type:\(surfaceType),"
        }
        if let width = infoRequest.widthValue,!width.isEmpty
        {
            
                restrictions = restrictions + "minimum_width:\(width),"
            //restrictions = restrictions + "width:\(width),"
        }
//        if let smoothness = infoRequest.smoothness
//        {
//            restrictions = restrictions + "smoothness_type:\(smoothness),"
//        }
        if let slopedCurb = infoRequest.slopedCurbValue,!slopedCurb.isEmpty
        {
            restrictions = restrictions + "maximum_sloped_kerb:\(slopedCurb),"
        }
        if let incline = infoRequest.inclineValue,!incline.isEmpty
        {
            restrictions = restrictions + "maximum_incline:\(incline),"
        }
        if restrictions != ""
        {
            restrictions.removeLast()
        }
        
        return restrictions
    }
}
extension String
{
    var toDouble : Double {
        return Double(self) ?? 0.0
    }
}
