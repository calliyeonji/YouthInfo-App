//
//  SmallLibraryInfo.swift
//  YouthInfoApp
//
//  Created by yeonji on 2022/10/29.
//

import Foundation

struct RootSmallLibraryData: Codable {
    let SeoulSmallLibraryInfo: SeoulSmallLibraryInfoData
}

struct SeoulSmallLibraryInfoData: Codable {
    let list_total_count:Int
    let RESULT:SmallLibraryResult
    let row:[SmallLibraryInfo]
}

struct SmallLibraryResult: Codable {
    let CODE:String
    let MESSAGE:String
}

struct SmallLibraryInfo: Codable {
    let LBRRY_SEQ_NO:String
    let LBRRY_NAME:String
    let GU_CODE:String
    let CODE_VALUE:String
    let ADRES:String
    let TEL_NO:String
    let HMPG_URL:String
    let OP_TIME:String
    let FDRM_CLOSE_DATE:String
    let LBRRY_SE_NAME:String
    let XCNTS:String
    let YDNTS:String
}
