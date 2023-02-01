import UIKit
import Moya
import RxSwift
import RxCocoa

protocol SchoolInfoProtocol: AnyObject {
    var schoolData: PublishSubject<[SchoolInfo]> { get set }
}

class SchoolNameViewModel: BaseViewModel {
    weak var delegate: SchoolInfoProtocol?
    
    func fetchSchoolName(schoolName: String) {
        let provider = MoyaProvider<SchoolNameAPI>()
        
        provider.request(.schools(schoolName: schoolName, apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                do {
                    let decoded = try JSONDecoder().decode(Welcome.self, from: responseData ).schoolInfo
                    self.delegate?.schoolData.onNext(decoded)
                    print(decoded)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("")
            }
        }
    }
}
