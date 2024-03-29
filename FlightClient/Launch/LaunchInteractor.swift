import Foundation
import SwiftyJSON
import TermiNetwork

class LaunchInteractor: LaunchInteracting, RefreshMiddleware {
    weak var output: LaunchInteractingOutput?

    func signIn(login: String, password: String) {
        TNRouter.start(UserRouter.signIn(login: login, password: password),
                       responseType: JWTTokens.self,
                       onSuccess: { [weak self] jwtTokens in
                        guard let self = self else { return }

                        JWTManager.standard.persist(jwtTokens: jwtTokens)
                        self.output?.didSignIn()
        },
                       onFailure: { [weak self] (error, _) in
                        guard let self = self else { return }

                        self.output?.didReceiveError(error)
        })
    }

    func signUp(login: String, password: String) {
        TNRouter.start(UserRouter.signUp(login: login, password: password),
                       responseType: EmptyResponse.self,
                       onSuccess: { [weak self] _ in
                        guard let self = self else { return }

                        self.output?.didSignUp()
            },
                       onFailure: { [weak self] (error, _) in
                        guard let self = self else { return }

                        self.output?.didReceiveError(error)
        })
    }

    func getProjects() {
        DispatchQueue.global().async {
            self.refreshIfNecessary()

            TNRouter.start(ProjectsRouter.getProjects,
                           responseType: [Project].self,
                           onSuccess: { [weak self] projects in
                            guard let self = self else { return }

                            self.output?.didGetProjects(projects)
                },
                           onFailure: { [weak self] (error, _) in
                            guard let self = self else { return }

                            self.output?.didReceiveError(error)
            })
        }
    }

    func createProject(title: String) {
        DispatchQueue.global().async {
            self.refreshIfNecessary()
            TNRouter.start(ProjectsRouter.createProject(title: title),
                           responseType: Project.self,
                           onSuccess: { [weak self] project in
                            guard let self = self else { return }

                            self.output?.didCreateProject(project)
                },
                           onFailure: { [weak self] (error, _) in
                            guard let self = self else { return }

                            self.output?.didReceiveError(error)
            })
        }
    }
}
