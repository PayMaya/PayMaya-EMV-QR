//
//  QRConstants.swift
//  QRScan
//
//  Created by Ralph Jacob Chua on 1/7/19.
//  Copyright © 2019 Ralph Jacob Chua. All rights reserved.
//

import Foundation

struct MerchantQR {
    
}

struct ConsumerQR {
    
}

enum MerQRRootFieldID:Int {
    case FormatIndicator = 00
    case PointOfInitiationMethod = 01
    case MerchantInfo = 26
    case MerchantCategoryCode = 52
    case TransactionCurrency = 53
    case TransactionAmount = 54
    case CountryCode = 58
    case MerchantName = 59
    case MerchantCity = 60
    case DataField = 62
    case CRC = 63
    case BayadCenter = 80
}

enum QREnum {
    case PayMaya
    case GCash
    case Bancnet
}

