//
//  NetUtils.swift
//  HockeyApp
//
//  Created by Yoji on 03.09.2025.
//
import Foundation

protocol Datable: Encodable {
    func getData(boundary: String) -> Data?
}



extension Datable {
    func getData(boundary: String) -> Data? {
        let encoder = JSONEncoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = .prettyPrinted
        guard let encodedData = try? encoder.encode(self) else { return nil }
        guard let data = try? JSONSerialization.jsonObject(with: encodedData, options: []) as? [String: Any] else {
            return nil
        }
        
        return data.encoded(boundary: boundary)
    }
}

extension Dictionary {
    func encoded(boundary: String) -> Data {
        var body = Data()
        for (key, value) in self {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

extension String {
    func handleAsDecodable<T: Decodable> (data dataModel: Datable) async -> T? {
        do {
            guard let url = URL(string: self) else { return nil }

            let boundary = UUID().uuidString

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = dataModel.getData(boundary: boundary)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print("♦️\(error)")
            return nil
        }
    }
}

struct LowercasedKey: CodingKey {
    var intValue: Int?
    var stringValue: String
    
    init?(intValue: Int) {
        fatalError("init?(intValue:) has not been implemented")
    }
    
    init(stringValue: String) {
        self.stringValue = stringValue.lowercased()
    }
}

struct UppercasedKey: CodingKey {
    var intValue: Int?
    var stringValue: String
    
    init?(intValue: Int) {
        fatalError("init?(intValue:) has not been implemented")
    }
    
    init(stringValue: String) {
        self.stringValue = stringValue.uppercased()
    }
}
