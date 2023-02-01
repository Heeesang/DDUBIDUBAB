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
    let atptOfcdcScCode, sdSchulCode, schulNm: String
    let engSchulNm, juOrgNm: String
    let fondScNm, orgRdnzc, orgRdnma, orgRdnda: String
    
    enum CodingKeys: String, CodingKey {
        case atptOfcdcScCode = "ATPT_OFCDC_SC_CODE"
        case sdSchulCode = "SD_SCHUL_CODE"
        case schulNm = "SCHUL_NM"
        case engSchulNm = "ENG_SCHUL_NM"
        case juOrgNm = "JU_ORG_NM"
        case fondScNm = "FOND_SC_NM"
        case orgRdnzc = "ORG_RDNZC"
        case orgRdnma = "ORG_RDNMA"
        case orgRdnda = "ORG_RDNDA"
    }
}
