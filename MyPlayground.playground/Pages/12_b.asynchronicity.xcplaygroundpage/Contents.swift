//: [Previous](@previous)

import Foundation

// an Actor is of reference type. Its purpose is to share a mutable state among several tasks.
// An Actor allows access to access its state to only one task at a time.
// So only one task can read or update the Actor's state.
// The Coroutine counterpart is Mutex.
// https://medium.com/@android-world/kotlin-mutex-a-comprehensive-guide-a79d0f4f2de7
actor Logger {
    private(set) var log: String = ""
    
    func setLog(_ message: String) {
        log += "\(message)\n"
    }
}

let logger = Logger()

// all these tasks are run in parallel but they all can access Logger one at a time..
func getMessages(_ index: Int) async -> [String] {
    await logger.setLog("message \(index)")
    print( "log messages \n\(await logger.log)" )
    return ["IMG001", "IMG99", "IMG0404"]
}

Task {
    // lets do several tasks in parallel
    async let job4 = getMessages(1)
    async let job5 = getMessages(2)
    async let job6 = getMessages(3)
    
    // then after waiting for all jobs combine them into a list.
    let parallelJobs = await [job4, job5, job6]
    print("parallel jobs combined \(parallelJobs)")
}

// when working with tasks and/or different threads there is a situation of having raised conditions
// because data shared can be modified concurrently. That's why Swift came with the idea of defining
// data types as Sendables.. lets take a look
struct Message : Sendable {
    var text: String = ""
}

actor MessageLogger {
    private(set) var messages: [Message] = []
    
    func setLog(_ message: Message) {
        messages.append(message)
    }
}

func getSendableMessage( _ messageLogger: MessageLogger, _ message: Message) async -> String {
    await messageLogger.setLog(message)
    return message.text
}

Task {
    let messageLogger = MessageLogger()
    async let job4 = getSendableMessage(messageLogger, Message(text: "hello"))
    async let job5 = getSendableMessage(messageLogger, Message(text: "world"))
    async let job6 = getSendableMessage(messageLogger, Message(text: "!"))
    
    let parallelJobs = await [job4, job5, job6]
    
    print("parallel jobs combined \(parallelJobs)")
}
