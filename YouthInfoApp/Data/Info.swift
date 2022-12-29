//
//  Info.swift
//  YouthInfoApp
//
//  Created by yeonji on 2022/10/27.
//

import Foundation

struct RootData: Codable {
    let jobCafeOpenInfo: JobCafeOpenInfo
}

struct JobCafeOpenInfo: Codable {
    let list_total_count:Int
    let RESULT:Result
    let row:[Info]
}

struct Result: Codable {
    let CODE:String
    let MESSAGE:String
}

struct Info: Codable {
    let CAFE_NM:String
    let SMPL_INTRO:String
    let SPACE_INFRO:String
    let USE_DT:String
    let HOLI_DD:String
    
    let FACLT_INFO1:String
    let FACLT_INFO2:String
    let FACLT_INFO3:String
    let FACLT_INFO4:String
    let FACLT_INFO5:String
    let FACLT_INFO6:String
    let FACLT_INFO7:String
    let FACLT_INFO8:String
    let FACLT_INFO9:String
    let FACLT_INFO10:String
    
    let RSRV_SGGST1:String
    let RSRV_SGGST2:String
    let RSRV_SGGST3:String
    let RSRV_SGGST4:String
    let RSRV_SGGST5:String
    let RSRV_SGGST6:String
    let RSRV_SGGST7:String
    let RSRV_SGGST8:String
    let RSRV_SGGST9:String
    let RSRV_SGGST10:String
    
    let BASS_ADRES_CN:String
    let GUGUN:String
    let ROAD_ADRES2_CN:String
    let APPR_MTHD_NM:String
    let FILE_NM:String
    let CAFE_TYPE_NM:String
}
