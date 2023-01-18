import UIKit
import Moya
import RxSwift
import RxCocoa

protocol SchoolInfoProtocol: AnyObject {
    var schoolData: PublishSubject<[SchoolInfo]> { get set }
}

class SchoolNameViewModel: BaseViewModel {
    weak var delegate: SchoolInfoProtocol?
    var schoolAddress: [Row] = []
    
    func fetchSchoolName(schoolName: String) {
        let provider = MoyaProvider<SchoolNameAPI>()
        
        provider.request(.schools(schoolName: schoolName, apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                do {
                    let decoded = try JSONDecoder().decode(Welcome.self, from: responseData).schoolInfo
//                    self.delegate?.schoolData.onNext(decoded)
                    print(decoded)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("1")
            }
        }
    }
}
