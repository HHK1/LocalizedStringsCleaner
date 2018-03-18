import LocalizedStringsCleanerCore

let tool = LocalizedStringsCleaner()

do {
    try tool.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}

