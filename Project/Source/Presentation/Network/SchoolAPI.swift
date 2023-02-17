import Moya
import Foundation

public enum SchoolAPI {
    case schools(schoolName: String, apiKey: String)
    case menu(mealDate: String, atptCode: String, schoolCode: String, apiKey: String)
}

extension SchoolAPI: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: "https://open.neis.go.kr") else {
            fatalError("base URL couldn't be configure")
        }
        
        return url
    }
    
    public var path: String {
        switch self {
        case .schools:
            return "/hub/schoolInfo"
        case .menu:
            return "/hub/mealServiceDietInfo"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .schools:
            return .get
        case .menu:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .schools(let name, let apiKey):
            return .requestParameters(parameters: ["KEY": apiKey, "SCHUL_NM": name, "type": "JSON"], encoding:
                                        URLEncoding.queryString)
        case .menu(let mealDate, let atptCode, let schoolCode, let apiKey):
            return .requestParameters(parameters: ["KEY": apiKey,"ATPT_OFCDC_SC_CODE": atptCode, "SD_SCHUL_CODE": schoolCode, "MLSV_YMD": mealDate, "type": "JSON"], encoding:
                                        URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
