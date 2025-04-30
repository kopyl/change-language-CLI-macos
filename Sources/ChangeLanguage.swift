import ArgumentParser

@main
struct ChangeLanguage: ParsableCommand {
    /// has to be parsed as array, otherwise negative values are not supported
    @Argument(parsing: .allUnrecognized)
    public var inputSourceID: [Int] = []
    
    private func listAllInputSources() {
        for (_, name, layoutID) in getInputSourcesWithIDs() {
            print("\(name): \(layoutID)")
        }
        
        print("To change your input source, run:")
        print("change-language {id}")
    }

    public func run() throws {
        
        if inputSourceID.isEmpty {
            print("Currently available input sources you can switch to:")
            listAllInputSources()
            return
        }
        if inputSourceID.count > 1 {
            print("Please specify only one input source ID out of these:")
            listAllInputSources()
        }
        
        let _inputSourceID = Int(inputSourceID[0])
        
        let availableInputSources = getInputSourcesWithIDs()
        
        if !availableInputSources.map(\.2).contains(_inputSourceID) {
            print("Input source with ID \(_inputSourceID) not found.")
            print("Please specify the ID from available input sources:")
            listAllInputSources()
            return
        }
        
        for (source, _, layoutID) in availableInputSources {
            
            if layoutID == _inputSourceID {
                changeInputSource(inputSource: source)
            }
        }
    }
}
