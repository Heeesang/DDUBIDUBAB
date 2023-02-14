import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let schoolInfo: [SchoolInfo]
}

// MARK: - SchoolInfo
struct SchoolInfo: Codable {
    var schoolCode: String
    var schoolName: String
    var schoolAdress: String
}
