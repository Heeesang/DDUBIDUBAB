import Moya
import Foundation

public enum SchoolNameAPI {
    case schools(name: String, apiKey: String)
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
        case .schools(let name, apiKey: let apiKey):
            return .requestParameters(parameters: ["SCHUL_NM": name, "Key": apiKey], encoding: URLEncoding.default)        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
