import TermiNetwork

protocol RefreshMiddleware {
    func refreshIfNecessary()
}

extension RefreshMiddleware {
    func refreshIfNecessary() {
        let group = DispatchGroup()
        if let expiredAt = JWTManager.standard.expiredAtDate(),
            Date() > expiredAt {
            group.enter()
            self.refresh { (jwtTokens) in
                JWTManager.standard.persist(jwtTokens: jwtTokens)
                group.leave()
            }
        }
        group.wait()
    }

    func refresh(success: @escaping (JWTTokens) -> Void) {
        TNRouter.start(UserRouter.refreshToken,
                       responseType: JWTTokens.self,
                       onSuccess: { jwtTokens in

                        print("Refresh successful")
                        success(jwtTokens)
        },
                       onFailure: { (_, _) in
        })

    }
}
