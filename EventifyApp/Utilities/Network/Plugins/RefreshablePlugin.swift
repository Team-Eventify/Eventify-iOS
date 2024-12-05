//
//  MoyaProvider+RefreshToken.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 05.12.2024.
//

import Foundation
import Moya

extension MoyaProvider {
	
	public convenience init(
		handleRefreshToken: Bool,
		plugins: [PluginType] = [],
		session: Session = MoyaProvider<Target>.defaultAlamofireSession()) {
		
		if handleRefreshToken {
			let refreshingPlugins = plugins + [RefreshablePlugin()]
			self.init(session: session, plugins: refreshingPlugins)
		} else {
			self.init(session: session, plugins: plugins)
		}
	}
}

class RefreshablePlugin: PluginType {
	private let tokenService = TokenService()
	private var isRefreshing = false
	private var requestsToRetry: [(URLRequest, (Result<Moya.Response, MoyaError>) -> Void)] = []
	
	func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		return request
	}
	
	func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
		switch result {
		case .success(let response):
			if response.statusCode == 401 {
				print("RefreshablePlugin: Received 401 error, handling unauthorized error")
				handleUnauthorizedError(target: target, response: response)
				return .failure(MoyaError.underlying(NSError(domain: "RefreshablePlugin", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized"]), response))
			}
		case .failure(let error):
			if error.response?.statusCode == 401 {
				print("RefreshablePlugin: Received 401 error, handling unauthorized error")
				handleUnauthorizedError(target: target, response: error.response!)
			}
		}
		return result
	}
	
	func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
		print("RefreshablePlugin: Did receive result")
	}
	
	private func handleUnauthorizedError(target: TargetType, response: Response) {
		guard !isRefreshing else {
			print("RefreshablePlugin: Already refreshing, queueing request")
			if let request = response.request {
				requestsToRetry.append((request, { _ in }))
			}
			return
		}
		
		isRefreshing = true
		print("RefreshablePlugin: Starting token refresh")
		
		_Concurrency.Task {
			do {
				let tokenResponse = try await tokenService.refreshTokens()
				print("RefreshablePlugin: Token refresh successful")
				KeychainManager.shared.set(tokenResponse.accessToken, key: KeychainKeys.accessToken)
				KeychainManager.shared.set(tokenResponse.refreshToken, key: KeychainKeys.refreshToken)
				
				print("RefreshablePlugin: Retrying queued requests")
				retryRequests()
			} catch {
				print("RefreshablePlugin: Failed to refresh token: \(error)")
				// Handle failed refresh (e.g., log out user)
			}
			
			isRefreshing = false
		}
	}
	
	private func retryRequests() {
		requestsToRetry.forEach { urlRequest, completion in
			var modifiedRequest = urlRequest
			if let token = KeychainManager.shared.get(key: KeychainKeys.accessToken) {
				modifiedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
			}
			
			print("RefreshablePlugin: Retrying request to \(modifiedRequest.url?.absoluteString ?? "unknown URL")")
			URLSession.shared.dataTask(with: modifiedRequest) { data, response, error in
				if let error = error {
					print("RefreshablePlugin: Retry request failed with error: \(error)")
					completion(.failure(MoyaError.underlying(error, nil)))
				} else if let data = data, let response = response as? HTTPURLResponse {
					print("RefreshablePlugin: Retry request succeeded with status code: \(response.statusCode)")
					completion(.success(Response(statusCode: response.statusCode, data: data, request: modifiedRequest, response: response)))
				} else {
					print("RefreshablePlugin: Retry request failed with unknown error")
					completion(.failure(MoyaError.underlying(NSError(domain: "RefreshablePlugin", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to process response"]), nil)))
				}
			}.resume()
		}
		
		requestsToRetry.removeAll()
	}
}
