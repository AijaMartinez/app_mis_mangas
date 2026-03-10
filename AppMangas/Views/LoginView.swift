//
//  LoginView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @State private var isShowingPassword = false
    
    let maxLength = 30
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("mnsterfondo").resizable().scaledToFill().frame(width: 300, height: 250).clipShape(Circle())
                Text("Iniciar Sesión")
                    .font(.largeTitle).bold()
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .frame(width: 380)
                
                ZStack(alignment: .trailing){
                    Group{
                        if isShowingPassword{
                            TextField("Contraseña", text: $viewModel.password).textFieldStyle(.roundedBorder)
                                .onChange(of: viewModel.password, initial: false){oldValue, newValue in
                                    if newValue.count > maxLength{
                                        viewModel.password = String(newValue.prefix(maxLength))
                                    }
                                }
                        }else{
                            SecureField("Contraseña", text: $viewModel.password)
                                .textFieldStyle(.roundedBorder)
                                .onChange(of: viewModel.password, initial: false){oldValue, newValue in
                                    if newValue.count > maxLength{
                                        viewModel.password = String(newValue.prefix(maxLength))
                                    }
                                }
                        }
                    }
                    .padding(.trailing, 0)
                    
                    Button{
                        isShowingPassword.toggle()
                    } label: {
                        Image(systemName: isShowingPassword ? "eye.slash" : "eye")
                            .foregroundStyle(Color.gray)
                    }
                    .padding(.trailing,10)
                }.frame(width: 380)
                
                
                
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
                    .alert("Registro Exitoso", isPresented: $viewModel.registrationSuccess){
                        Button("OK", role: .cancel){}
                    } message: {
                        Text("El usuario se ha registrado correctamente")
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color("BackgroundColor"))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    
    LoginView(viewModel: LoginViewModel(session: SessionManager()))
}
