//
//  CodeBlock.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/20/23.
//

import SwiftUI
import SyntaxHighlight

public struct CodeBlock: View {
    @State private var theme: Theme?
    @State private var grammar: Grammar?
    @State private var isLoading = true
    
    
    @State var code = """
        // This transaction is a template for a transaction
        // to add a Vault resource to their account
        // so that they can use the exampleToken
        import ExampleToken from "../contracts/ExampleToken.cdc"
        import FungibleToken from "../contracts/utility/FungibleToken.cdc"

        transaction() {

            prepare(signer: AuthAccount) {
                /*
                    NOTE: In any normal DApp, you would NOT DO these next 3 lines. You would never want to destroy
                    someone's vault if it's already set up. The only reason we do this for the
                    tutorial is because there's a chance that, on testnet, someone already has
                    a vault here and it will mess with the tutorial.
                */
                destroy signer.load<@FungibleToken.Vault>(from: ExampleToken.VaultStoragePath)
                signer.unlink(ExampleToken.VaultReceiverPath)
                signer.unlink(ExampleToken.VaultBalancePath)

                // These next lines are the only ones you would normally do.
                if signer.borrow<&ExampleToken.Vault>(from: ExampleToken.VaultStoragePath) == nil {
                    // Create a new ExampleToken Vault and put it in storage
                    signer.save(<-ExampleToken.createEmptyVault(), to: ExampleToken.VaultStoragePath)

                    // Create a public capability to the Vault that only exposes
                    // the deposit function through the Receiver interface
                    signer.link<&ExampleToken.Vault{FungibleToken.Receiver}>(ExampleToken.VaultReceiverPath, target: ExampleToken.VaultStoragePath)

                    // Create a public capability to the Vault that only exposes
                    // the balance field through the Balance interface
                    signer.link<&ExampleToken.Vault{FungibleToken.Balance}>(ExampleToken.VaultBalancePath, target: ExampleToken.VaultStoragePath)
                }
            }
        }
    """
    
    public init() {}
    
    public var body: some View {
        VStack {
            if isLoading {
                Text("Loading...")
            } else {
                // Your syntax highlight view here
                // For example, using Text to display the code
                // You should replace this with your actual code view
                Text(from: Highlighter(string: code, theme: theme!, grammar: grammar!))
            }
        }
        .onAppear {
            downloadThemeAndGrammar()
        }
    }
    
    private func downloadThemeAndGrammar() {
            let themeURL = "https://raw.githubusercontent.com/filmgirl/TextMate-Themes/master/inkdeep.tmTheme"
            let grammarURL = "https://raw.githubusercontent.com/onflow/vscode-cadence/master/extension/language/syntaxes/cadence.tmGrammar.json"

        downloadFile(from: themeURL) { data in
            if let data = data {
                do {
                    // Attempt to deserialize the JSON data to a dictionary
                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Initialize the Theme with the dictionary
                        self.theme = try Theme(dictionary: dictionary)
                    } else {
                        print("Error: Could not cast JSON to [String: Any]")
                    }
                } catch {
                    print("Error initializing theme: \(error)")
                }
            }
        }


            downloadFile(from: grammarURL) { data in
                if let data = data {
                    do {
                        self.grammar = try Grammar(data: data)
                        self.isLoading = false
                    } catch {
                        print("Error initializing grammar: \(error)")
                    }
                }
            }
        }

        private func downloadFile(from urlString: String, completion: @escaping (Data?) -> Void) {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                completion(nil)
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        print("Error downloading file: \(error?.localizedDescription ?? "Unknown error")")
                        completion(nil)
                        return
                    }
                    completion(data)
                }
            }
            task.resume()
        }
}

#Preview {
    CodeBlock()
}
