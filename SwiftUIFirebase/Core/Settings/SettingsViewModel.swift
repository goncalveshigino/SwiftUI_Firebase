//
//  SettingsViewModel.swift
//  SwiftUIFirebase
//
//  Created by Goncalves Higino on 20/09/23.
//

import Foundation


@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProvider() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func logOut() throws {
       try AuthenticationManager.shared.sigOut()
    }
    
    func deleteAccount() async throws{
        try await AuthenticationManager.shared.delete();
    }
    func  resetPassword() async throws {
        let authUSer = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUSer.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "goncalves@gmail.com"
        try await  AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "123456"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
//    func linkGoogleAccount() async throws {
//        let helper = SignInGoogleHelper()
//        let token = try await helper.signIn()
//        self.authUser  = try await AuthenticationManager.shared.linkGoogle(token: token)
//       
//    }
    
    func linkEmailAccount() async throws {
        let email = "goncalves@gmail.com"
        let password = "123456"
        try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    }
    
}
