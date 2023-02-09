import UIKit
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

protocol SchoolInfoProtocol: AnyObject {
    var schoolData: PublishSubject<[String]> { get set }
}

class SchoolNameViewModel: BaseViewModel {
    weak var delegate: SchoolInfoProtocol?
    var schoolInfo: [String] = []
    
    func fetchSchoolName(schoolName: String) {
        let provider = MoyaProvider<SchoolNameAPI>()
        self.schoolInfo = []
        
        provider.request(.schools(schoolName: schoolName, apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                let json = JSON(responseData)
                let data = json["schoolInfo"].arrayValue
                let row = data[1]["row"]
                for index in 0...row.count-1 {
                    self.schoolInfo.append(row[index]["SCHUL_NM"].string ?? "학교 정보가 없습니다.")
                    self.schoolInfo.append(row[index]["ORG_RDNMA"].string ?? "학교 정보가 없습니다.")
                }
                print(self.schoolInfo)
                self.delegate?.schoolData.onNext(self.schoolInfo)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
