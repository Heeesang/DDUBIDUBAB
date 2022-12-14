import Foundation

struct schoolResponse: Codable {
    
    let schools: [schoolsInfo]
    
    private enum CodingKeys: String, CodingKey {
        case schools
    }
}

struct schoolsInfo: Codable {
    var schoolName: String
    var schoolCode: String
    var officeCode: String
    
    private enum CodingKeys: String, CodingKey {
        case schoolName = "SCHUL_NM"
        case schoolCode = "SD_SCHUL_CODE"
        case officeCode = "ATPT_OFCDC_SC_CODE"
    }
}


