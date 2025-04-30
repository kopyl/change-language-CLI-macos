import ArgumentParser

@main
struct ChangeLanguage: ParsableCommand {
    @Argument(help: "Specfiy input source ID to switch to")
    public var inputSourceID: Int?
    
    private func listAllInputSources() {
        for (_, name, layoutID) in getInputSourcesWithIDs() {
            print("\(name): \(layoutID)")
        }
        
        print("To change your input source, run:")
        print("change-language {id}")
    }

    public func run() throws {
        if inputSourceID == nil {
            print("Currently available input sources you can switch ti:")
            listAllInputSources()
            return
        }
        
        let availableInputSources = getInputSourcesWithIDs()
        
        if !availableInputSources.map(\.2).contains(inputSourceID) {
            print("Input source with ID \(inputSourceID ?? 0) not found.")
            print("Please specify the ID from available input sources:")
            listAllInputSources()
            return
        }
        
        for (source, _, layoutID) in availableInputSources {
            
            if layoutID == inputSourceID {
                changeInputSource(inputSource: source)
            }
        }
    }
}
