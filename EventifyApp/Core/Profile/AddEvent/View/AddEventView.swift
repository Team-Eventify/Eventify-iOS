//
//  AddEventView.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 14.09.2024.
//

import PhotosUI
import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss)
    var dismiss

    /// ViewModel для управления логикой вью
    @StateObject private var viewModel: AddEventViewModel

    @StateObject private var categoriesVM: PersonalCategoriesViewModel

    init(
        viewModel: AddEventViewModel? = nil,
        categoriesVM: PersonalCategoriesViewModel? = nil
    ) {
        _viewModel = StateObject(
            wrappedValue: viewModel ?? AddEventViewModel()
        )
        _categoriesVM = StateObject(
            wrappedValue: categoriesVM ?? PersonalCategoriesViewModel(categoriesService: CategoriesService())
        )
    }

    var body: some View {
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
        .navigationTitle("Создание мероприятия")
        .background(Color.bg.ignoresSafeArea())
    }

    private var eventNameSection: some View {
        VStack(alignment: .leading) {
            Text("Название*")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

            EventifyTextField(
                text: $viewModel.name, placeholder: "Введите название",
                isSecure: false)
        }
    }

    private var dateTimeSection: some View {
        HStack(alignment: .top, spacing: 54) {
            VStack(alignment: .leading) {
                Text("Дата*")
                    .font(.mediumCompact(size: 20))
                    .foregroundStyle(.mainText)

                DatePicker(
                    "", selection: $viewModel.date, displayedComponents: .date
                )
                .labelsHidden()
            }

            VStack(alignment: .leading) {
                Text("Время*")
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
            Text("Описание")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)
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
            Text("Фотографии")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)
            HStack {
                AddPhotoButton(pickerItem: $viewModel.imageSelections)

                if !viewModel.selectedImages.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.selectedImages, id: \.self) {
                                image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
        }
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading) {
            Text("Категории")
                .font(.mediumCompact(size: 20))
                .foregroundStyle(.mainText)

//            ForEach(PersonalCategoriesMockData.categories.indices, id: \.self) {
//                index in
//                HStack(spacing: 8) {
//                    ForEach(
//                        PersonalCategoriesMockData.categories[index].indices,
//                        id: \.self
//                    ) { inner in
//                        PersonalCategoriesCheeps(
//                            viewModel: categoriesVM,
//                            category: PersonalCategoriesMockData.categories[
//                                index][inner]
//                        )
//                    }
//                }
//            }
        }
    }

    private var publishButton: some View {
        EventifyButton(
            configuration: .addEvent, isLoading: false, isDisabled: false
        ) {
            print("Ивент добавлен")
            dismiss()
        }
    }
}

#Preview {
    AddEventView()
}
