import UIKit
import Moya
import RxSwift
import RxCocoa

protocol SchoolInfoProtocol: AnyObject {
    var schoolData: PublishSubject<[schoolsInfo]> { get set }
}

class SchoolNameViewModel: BaseViewModel {
    weak var delegate: SchoolInfoProtocol?
    var schoolAddress: [schoolsInfo] = []
    
    func fetchSchoolName(schoolName: String) {
        let provider = MoyaProvider<SchoolNameAPI>()
        
        provider.request(.schools(schoolName: schoolName, apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                do {
                    let decoded = try JSONDecoder().decode(schoolResponse.self, from: responseData )
                    self.delegate?.schoolData.onNext(decoded.schools)
                    print(decoded.schools)
                } catch {
                    print(error.localizedDescription)
                    print("2")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("1")
            }
        }
    }
}
