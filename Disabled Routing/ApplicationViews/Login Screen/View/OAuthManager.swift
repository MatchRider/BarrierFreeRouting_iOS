//
//  OAuthManager.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 25/06/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import OAuthSwift
class OAuthManager {
    static let shared = OAuthManager()
    var oauthswift: OAuth1Swift
    private init() {
        oauthswift = OAuth1Swift(
            consumerKey     :       AppConstants.OAUTHSettings.CONSUMER_KEY,
            consumerSecret  :       AppConstants.OAUTHSettings.CONSUMER_SECRET,
            requestTokenUrl :       AppConstants.OAUTHSettings.REQUEST_TOKEN_URL,
            authorizeUrl    :       AppConstants.OAUTHSettings.AUTHORIZE_TOKEN_URL,
            accessTokenUrl  :       AppConstants.OAUTHSettings.ACCESS_TOKEN_URL
        )
        
        if UserDefaultUtility.objectAlreadyExist(AppConstants.UserDefaultKeys.OAUTH_TOKEN) {
            oauthswift.client.credential.oauthToken = UserDefaultUtility.retrieveStringWithKey(AppConstants.UserDefaultKeys.OAUTH_TOKEN)
            oauthswift.client.credential.oauthTokenSecret = UserDefaultUtility.retrieveStringWithKey(AppConstants.UserDefaultKeys.OAUTH_TOKEN_SECRET)
        }
    }
}
