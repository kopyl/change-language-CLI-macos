import InputMethodKit

func getInputSourcesWithIDs() -> [(TISInputSource, String, Int)] {
    let selectableIsProperties = [
        kTISPropertyInputSourceType: kTISTypeKeyboardLayout as CFString,
    ] as CFDictionary
    
    let inputSourceArray = TISCreateInputSourceList(selectableIsProperties, false).takeRetainedValue() as! [TISInputSource]
    
    return inputSourceArray.map { source in
        let nameProperty = TISGetInputSourceProperty(source, kTISPropertyLocalizedName)
        let name = nameProperty != nil ? Unmanaged<CFString>.fromOpaque(nameProperty!).takeUnretainedValue() as String : "Unknown"
        
        let description = String(describing: source)
        var layoutID = -9999
        
        if let idRange = description.range(of: "id=") {
            let afterIDRange = description[idRange.upperBound...]
            if let endParenRange = afterIDRange.range(of: ")") {
                let idString = description[idRange.upperBound..<endParenRange.lowerBound]
                if let extractedID = Int(idString) {
                    layoutID = extractedID
                }
            }
        }
        
        return (source, name, layoutID)
    }
}

func changeInputSource(inputSource: TISInputSource) {
    TISSelectInputSource(inputSource)
}
