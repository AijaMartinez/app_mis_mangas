//
//  LoginView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20){
                    Image("mnsterfondo").resizable().scaledToFill().frame(width: 300, height: 250).clipShape(Circle())
                    Text("Iniciar Sesión")
                        .font(.largeTitle).bold()
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Contraseña", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                    
                    if let error =  viewModel.errorMessage{
                        Text(error)
                            .foregroundStyle(Color.red)
                            .padding().multilineTextAlignment(.center)
                    }
                    
                    if viewModel.isLoading{
                        ProgressView().progressViewStyle(.circular)
                    } else{
                        Button(action: {
                            viewModel.login()
                        }){
                            Text("Login")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button(action: {
                            viewModel.register()
                        }){
                            Text("Registrarse")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {

    LoginView(viewModel: LoginViewModel(session: SessionManager()))
}
