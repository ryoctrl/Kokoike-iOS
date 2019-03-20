//
//  Constants.swift
//  Kokoike
//
//  Created by mosin on 2019/03/06.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation

class Constants {
    static let BACKEND_URL = "https://kokoike.mosin.jp/"
    class ENDPOINTS {
        static let SHOPS = "shops/"
        static let AUTH = "auth/twitter/"
        static let RECOMMENDS = "recommends/"
        static let GPS = "gps/"
        static let LOCATIONS = "locations/"
    }
    
    class GNAVI_RESPONSE {
        static let NAME = "name"
        static let ADDRESS = "address"
        static let IMAGE_URLS = "image_url"
        static let IMAGE_URL1 = "shop_image1"
        static let IMAGE_URL2 = "shop_image2"
        
    }
    class USER_KEYS {
        static let DISPLAY_NAME = "display_name"
        static let SCREEN_NAME = "screen_name"
        static let TWITTER_ID = "twitter_id"
        static let ID = "id"
        static let ICON_URL = "icon_url"
    }
    
    class LOCATION_KEYS {
        
    }
    
    class STRINGS {
        static let SEARCH_TITLE = "新規店舗 - 検索"
    }
    
}
