//
//  CoreDataManager.swift
//  Disabled Routing
//
//  Created by Daffodil_pc on 09/10/18.
//  Copyright © 2018 Daffodil_pc. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class RouteOptionManager {
    static let shared = RouteOptionManager()
    private var managedContext : NSManagedObjectContext!
    private var routeOptions : RouteOptions!
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        
        let routeOptionFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "RouteOptions")
        routeOptionFetch.fetchLimit = 1
        
        let allOptions = try! managedContext.fetch(routeOptionFetch)
        
        if allOptions.count == 0 {
            let routeEntity = NSEntityDescription.entity(forEntityName: "RouteOptions", in: managedContext)!
            routeOptions = (NSManagedObject(entity: routeEntity, insertInto: managedContext) as! RouteOptions)
        } else {
            routeOptions = (allOptions.first as! RouteOptions)
        }
    }
    
    public func saveRouteOption(_ infoRequestModel:FilterScreenRequestModel) {
        
        routeOptions.sourceLocation = infoRequestModel.sourceInfo.address
        routeOptions.sourceLocationLat = infoRequestModel.sourceInfo.lat!
        routeOptions.sourceLocationLong = infoRequestModel.sourceInfo.long!
        
        routeOptions.destinationLocation = infoRequestModel.destinationInfo.address
        routeOptions.destinationLocationLat = infoRequestModel.destinationInfo.lat!
        routeOptions.destinationLocationLong = infoRequestModel.destinationInfo.long!
        
        routeOptions.routeViaLocation = infoRequestModel.routeViaInfo.address
        routeOptions.routeViaLocationLat = infoRequestModel.routeViaInfo.lat
        routeOptions.routeViaLocationLong = infoRequestModel.routeViaInfo.long
        
        routeOptions.surfaceType = infoRequestModel.surfaceType
        routeOptions.slopedCurb = infoRequestModel.slopedCurb
        routeOptions.pitchOptions = infoRequestModel.incline
        routeOptions.width = infoRequestModel.width
        
        routeOptions.surfaceTypeValue = infoRequestModel.surfaceTypeValue
        routeOptions.slopedCurbValue = infoRequestModel.slopedCurbValue
        routeOptions.pitchOptionsValue = infoRequestModel.inclineValue
        routeOptions.widthValue = infoRequestModel.widthValue
        
        routeOptions.isFilterApplied = infoRequestModel.isFilterApplied
        
        saveRouteOption()
        
    }
    public func getRouteOption()->FilterScreenRequestModel {
        
        var infoRequestModel = FilterScreenRequestModel()
        
        infoRequestModel.sourceInfo.address = routeOptions.sourceLocation
        infoRequestModel.sourceInfo.lat = routeOptions.sourceLocationLat
        infoRequestModel.sourceInfo.long = routeOptions.sourceLocationLong

        infoRequestModel.destinationInfo.address = routeOptions.destinationLocation
        infoRequestModel.destinationInfo.lat = routeOptions.destinationLocationLat
        infoRequestModel.destinationInfo.long = routeOptions.destinationLocationLong

        infoRequestModel.routeViaInfo.address = routeOptions.routeViaLocation ?? ""
        infoRequestModel.routeViaInfo.lat = routeOptions.routeViaLocationLat
        infoRequestModel.routeViaInfo.long = routeOptions.routeViaLocationLong
        
        infoRequestModel.surfaceType = routeOptions.surfaceType
        infoRequestModel.slopedCurb = routeOptions.slopedCurb
        infoRequestModel.incline = routeOptions.pitchOptions
        infoRequestModel.width = routeOptions.width
        
        infoRequestModel.surfaceTypeValue = routeOptions.surfaceTypeValue
        infoRequestModel.slopedCurbValue = routeOptions.slopedCurbValue
        infoRequestModel.inclineValue = routeOptions.pitchOptionsValue
        infoRequestModel.widthValue = routeOptions.widthValue
        
        infoRequestModel.isFilterApplied = routeOptions.isFilterApplied
        
        return infoRequestModel
    }
    private func saveRouteOption() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
