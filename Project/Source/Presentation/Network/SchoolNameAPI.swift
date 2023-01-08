import Moya
import Foundation

public enum SchoolNameAPI {
    case schools(schoolName: String, apiKey: String)
}

extension SchoolNameAPI: TargetType {
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
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .schools:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .schools(let name, let apiKey):
            return .requestParameters(parameters: ["KEY": apiKey, "SCHUL_NM": name], encoding:
                                        URLEncoding.queryString)        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
