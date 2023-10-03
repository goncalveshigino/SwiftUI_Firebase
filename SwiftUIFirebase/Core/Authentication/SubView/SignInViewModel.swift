//
//  SignInViewModel.swift
//  SwiftUIFirebase
//
//  Created by Goncalves Higino on 20/09/23.
//

import Foundation


@MainActor
final class SigInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
       let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    
    func signIn() async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
         try await AuthenticationManager.shared.sigInUser(email: email, password: password)
      
    }
}
