//
//  Log.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.10.2024.
//

import Foundation

enum Log {
    enum LogLevel {
        case info, network, warning, error(Error? = nil)
        fileprivate var prefix: String {
            switch self {
                case .info: return "INFO ✅"
			case .network: return "Network 🛜"
                case .warning: return "WARN ⚠️"
                case .error: return "ERROR ❌"
            }
        }
    }
    
    struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
    }
    
    static func info(
        _ str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        
        Log.handleLog(level: .info, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
	
	static func network(
		_ str: String,
        shouldLogContext: Bool = true,
		file: String = #file,
		function: String = #function,
		line: Int = #line
	) {
		let context = Context(file: file, function: function, line: line)
		
		Log.handleLog(level: .network, str: str.description, shouldLogContext: shouldLogContext, context: context)
	}
    
    static func warning(
        _ str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        
        Log.handleLog(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func warning(
        _ str: String,
        _ error: Error,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        
        Log.handleLog(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func error(
        _ str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        
        Log.handleLog(level: .error(), str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func error(
        _ str: String,
        error: Error,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        
        Log.handleLog(level: .error(), str: str.description, shouldLogContext: shouldLogContext, context: context)
    }

    // MARK: - TODO: Переделать все логанные эвенты на Log.log (enum Log - я бы переименовал на Logger чтобы было понятно)
    static func log(
        level: LogLevel,
        _ str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let context = Context(file: file, function: function, line: line)
        handleLog(level: level, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }

    fileprivate static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(level.prefix)]", str]
        var fullString = logComponents.joined(separator: " ")
        
        if shouldLogContext {
            fullString += " ➜ \(context.description)"

            if case .error(let error) = level, let error {
                fullString += "➜ error log: \(error.localizedDescription)"
            }
        }
        print(fullString)
    }
}
