import UIKit

final class MainCoordinator: BaseCoordinator {
    
    override func start() {
        let vm = SchoolNameViewModel(coordinator: self)
        let vc = SchoolNameViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: BabStep) {
    }
}

private extension MainCoordinator {
    
}
    
