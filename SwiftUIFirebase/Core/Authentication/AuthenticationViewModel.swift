//
//  AuthenticationViewModel.swift
//  SwiftUIFirebase
//
//  Created by Goncalves Higino on 20/09/23.
//

import Foundation
import GoogleSignIn


@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.sigin()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signInAnonymous() async throws {
       let authDataResult = try await AuthenticationManager.shared.sigInAnonymous()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
       // try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}
