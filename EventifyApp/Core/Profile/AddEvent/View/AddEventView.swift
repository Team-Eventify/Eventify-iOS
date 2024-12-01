//
//  AddEventView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.09.2024.
//

import Flow
import PhotosUI
import PopupView
import SwiftUI

struct AddEventView: View {
	@EnvironmentObject private var networkManager: NetworkManager
	@Environment(\.dismiss) var dismiss

	/// ViewModel для управления логикой вью
	@StateObject private var viewModel = AddEventViewModel(eventService: EventsService())
	@StateObject private var categoriesVM = CategoriesViewModel(categoriesService: CategoriesService())
	
	var body: some View {
        if networkManager.isDisconnected {
            NoInternetView()
        } else {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    eventNameSection
                    dateTimeSection
                    descriptionSection
                    photosSection
                    categoriesSection
                    publishButton
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("title_add_event")
            .background(Color.bg.ignoresSafeArea())
            .onTapGesture {
                self.hideKeyboard()
            }
            .onAppear {
                categoriesVM.getCategories()
            }

            .popup(isPresented: $viewModel.showPopUp) {
                EventifySnackBar(config: .failureOfAddingEvent)
                    .padding(.vertical, 50)
            } customize: {
                $0
                    .type(
                        .floater(
                            useSafeAreaInset: true
                        )
                    )
                    .disappearTo(.bottomSlide)
                    .position(.bottom)
                    .closeOnTap(true)
                    .autohideIn(3)
            }
        }
	}

	private var eventNameSection: some View {
		VStack(alignment: .leading) {
			Text("label_event_name")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(viewModel.isError ? .error : .mainText)

			EventifyTextField(
				text: $viewModel.name,
				placeholder: String(localized: "placeholder_enter_event_name"),
				hasError: viewModel.isError)
		}
	}

	private var dateTimeSection: some View {
		HStack(alignment: .top, spacing: 54) {
			VStack(alignment: .leading) {
				Text("label_date")
					.font(.mediumCompact(size: 20))
					.foregroundStyle(.mainText)

				DatePicker(
                    "", selection: $viewModel.startTime, displayedComponents: .date
				)
				.labelsHidden()
			}

			VStack(alignment: .leading) {
				Text("label_time")
					.font(.mediumCompact(size: 20))
					.foregroundStyle(.mainText)

				HStack(alignment: .center, spacing: 8) {
					DatePicker(
						"", selection: $viewModel.startTime,
						displayedComponents: .hourAndMinute
					)
					.labelsHidden()

					Text("-")
						.font(.mediumCompact(size: 20))
						.foregroundStyle(.mainText)

					DatePicker(
						"", selection: $viewModel.endTime,
						displayedComponents: .hourAndMinute
					)
					.labelsHidden()
				}
			}
		}
	}

	private var descriptionSection: some View {
		VStack(alignment: .leading) {
			Text("label_description")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(viewModel.isError ? .error : .mainText)
			TextEditor(text: $viewModel.description)
				.frame(height: 88)
				.scrollContentBackground(.hidden)
				.background(.cards)
				.foregroundStyle(.mainText)
				.clipShape(RoundedRectangle(cornerRadius: 10))
		}
	}

	private var photosSection: some View {
		VStack(alignment: .leading) {
			Text("label_photos")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(viewModel.isError ? .error : .mainText)
			HStack {
				AddPhotoButton(pickerItem: $viewModel.imageSelections)

				if !viewModel.selectedImages.isEmpty {
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(viewModel.pairedArrays(), id: \.0) {
								image, pickerItem in
								ZStack(alignment: .topTrailing) {
									Image(uiImage: image)
										.resizable()
										.scaledToFill()
										.frame(width: 100, height: 100)
										.cornerRadius(10)
									Button {
										if let indexUIImage = viewModel
											.selectedImages.firstIndex(
												of: image),
											let indexPicker = viewModel
												.imageSelections.firstIndex(
													of: pickerItem) {
											viewModel.selectedImages.remove(
												at: indexUIImage)
											viewModel.imageSelections.remove(
												at: indexPicker)
										}
									} label: {
										Image(systemName: "xmark.circle.fill")
											.foregroundStyle(.white)
											.font(.body)
									}
									.padding(8)
								}
							}
						}
					}
				}
			}
		}
	}

	private var categoriesSection: some View {
		VStack(alignment: .leading) {
			Text("label_categories")
				.font(.mediumCompact(size: 20))
				.foregroundStyle(.mainText)

			HFlow {
				ForEach(categoriesVM.categories) { category in
					PersonalCategoriesCheeps(
						viewModel: categoriesVM, category: category)
				}
			}
		}
	}

	private var publishButton: some View {
		EventifyButton(
			configuration: .addEvent, isLoading: false, isDisabled: false
		) {
			Task {
				await viewModel.sendEvent()
			}
		}
		.onChange(of: viewModel.shouldDismiss) { newValue in
			if newValue {
				dismiss()
			}
		}
	}
}

#Preview {
	AddEventView()
		.environmentObject(NetworkManager())
}
