//
//  AppDelegate.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 12.11.2024.
//

import FirebaseCore
import FirebaseMessaging
import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate,
	UNUserNotificationCenterDelegate, MessagingDelegate {
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication
			.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		FirebaseApp.configure()

		/// Установка делегатов
		UNUserNotificationCenter.current().delegate = self
		Messaging.messaging().delegate = self

		/// Запрос разрешений
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter.current().requestAuthorization(
			options: authOptions,
			completionHandler: { _, _ in }
		)

		application.registerForRemoteNotifications()
		return true
	}

	/// Метод для получения APNs токена
	func application(
		_ application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
	) {
		Messaging.messaging().apnsToken = deviceToken
	}

	/// Обработка входящих уведомлений когда приложение открыто
	func userNotificationCenter(
		_ center: UNUserNotificationCenter,
		willPresent notification: UNNotification,
		withCompletionHandler completionHandler: @escaping (
			UNNotificationPresentationOptions
		) -> Void
	) {
		completionHandler([.banner, .sound])
	}

	/// Получение FCM токена
	func messaging(
		_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?
	) {
		Logger.log(
			level: .info,
			"Firebase registration token: \(String(describing: fcmToken))")

		if let token = fcmToken {
			UserDefaultsManager.shared.setFcmToken(token)
		}
	}
}
