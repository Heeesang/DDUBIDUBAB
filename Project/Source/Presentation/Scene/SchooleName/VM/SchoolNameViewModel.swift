import UIKit
import Moya

class SchoolNameViewModel: BaseViewModel {
    
    var schoolAddress: [schoolsInfo] = []
    
    func fetchSchoolName() {
        let provider = MoyaProvider<SchoolNameAPI>()
        provider.request(.schools(name: "", apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                do {
                    let decoded = try JSONDecoder().decode(schoolResponse.self, from: responseData )
                    self.schoolAddress = decoded.schools
                    print(decoded.schools)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
