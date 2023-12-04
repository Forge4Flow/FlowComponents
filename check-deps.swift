import Foundation

let packageSwiftPath = "Package.swift"

do {
    let packageSwiftContents = try String(contentsOfFile: packageSwiftPath)
    
    // Remove comments from the Package.swift contents
    let contentsWithoutComments = packageSwiftContents.replacingOccurrences(of: #"//.*"#, with: "", options: .regularExpression)
    
    // Use regular expression to check for local paths in dependencies
    let regex = try NSRegularExpression(pattern: #"\.package\(.*path:\s*""#, options: [])
    let matches = regex.matches(in: contentsWithoutComments, options: [], range: NSRange(location: 0, length: contentsWithoutComments.utf16.count))

    if !matches.isEmpty {
        print("Error: Local dependency paths found in Package.swift. Please update before merging.")
        exit(1)
    }
} catch {
    print("Error reading Package.swift: \(error)")
    exit(1)
}
