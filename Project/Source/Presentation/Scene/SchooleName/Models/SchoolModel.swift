import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let schoolInfo: [SchoolInfo]
}

// MARK: - SchoolInfo
struct SchoolInfo: Codable {
    let head: [Head]?
    let row: [Row]?
}

// MARK: - Head
struct Head: Codable {
    let listTotalCount: Int?
    let result: Result?

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
    }
}

// MARK: - Result
struct Result: Codable {
    let code, message: String

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

// MARK: - Row
struct Row: Codable {
    let atptOfcdcScCode, atptOfcdcScNm, sdSchulCode, schulNm: String
    let engSchulNm, schulKndScNm, lctnScNm, juOrgNm: String
    let fondScNm, orgRdnzc, orgRdnma, orgRdnda: String
    let orgTelno: String
    let hmpgAdres: String
    let coeduScNm, orgFaxno: String
    let hsScNm: String?
    let indstSpeclCccclExstYn, hsGnrlBusnsScNm: String
    let spclyPurpsHsOrdNm: String?
    let eneBfeSehfScNm, dghtScNm, fondYmd, foasMemrd: String
    let loadDtm: String
    
    enum CodingKeys: String, CodingKey {
        case atptOfcdcScCode = "ATPT_OFCDC_SC_CODE"
        case atptOfcdcScNm = "ATPT_OFCDC_SC_NM"
        case sdSchulCode = "SD_SCHUL_CODE"
        case schulNm = "SCHUL_NM"
        case engSchulNm = "ENG_SCHUL_NM"
        case schulKndScNm = "SCHUL_KND_SC_NM"
        case lctnScNm = "LCTN_SC_NM"
        case juOrgNm = "JU_ORG_NM"
        case fondScNm = "FOND_SC_NM"
        case orgRdnzc = "ORG_RDNZC"
        case orgRdnma = "ORG_RDNMA"
        case orgRdnda = "ORG_RDNDA"
        case orgTelno = "ORG_TELNO"
        case hmpgAdres = "HMPG_ADRES"
        case coeduScNm = "COEDU_SC_NM"
        case orgFaxno = "ORG_FAXNO"
        case hsScNm = "HS_SC_NM"
        case indstSpeclCccclExstYn = "INDST_SPECL_CCCCL_EXST_YN"
        case hsGnrlBusnsScNm = "HS_GNRL_BUSNS_SC_NM"
        case spclyPurpsHsOrdNm = "SPCLY_PURPS_HS_ORD_NM"
        case eneBfeSehfScNm = "ENE_BFE_SEHF_SC_NM"
        case dghtScNm = "DGHT_SC_NM"
        case fondYmd = "FOND_YMD"
        case foasMemrd = "FOAS_MEMRD"
        case loadDtm = "LOAD_DTM"
    }
}
