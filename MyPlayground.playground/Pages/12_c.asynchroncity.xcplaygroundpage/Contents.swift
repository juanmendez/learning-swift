//: [Previous](@previous)

import Foundation

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int


    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }

    func getCelcius() -> [Int] {
        var celciusMeasurements = [Int]()
        for i in measurements.indices {
            celciusMeasurements.append((measurements[i] - 32) * 5 / 9)
        }

        return celciusMeasurements
    }
}


Task {
    let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
    print(await logger.max)

    Task {
        await logger.update(with: 30)
        print(await logger.max)

        print("convert to Celcius 1: \(await logger.getCelcius())")
    }

    Task {
        await logger.update(with: 40)
        print(await logger.max)
        print("convert to Celcius 2: \(await logger.getCelcius())")
    }
}
