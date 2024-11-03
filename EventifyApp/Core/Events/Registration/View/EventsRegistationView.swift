//
//  EventsRegistationView.swift
//  EventifyApp
//
//  Created by Литвинчук Захар Евгеньевич on 03.09.2024.
//

import SwiftUI
import PopupView

struct EventsRegistationView: View {
    @StateObject private var viewModel: EventsRegistrationViewModel
    
    init(register: Bool) {
           _viewModel = StateObject(wrappedValue: EventsRegistrationViewModel(register: register))
    }

	var body: some View {
		VStack(alignment: .center, spacing: 16) {
            photoCarousel
            detailsView
			footerView
		}
        .navigationTitle(viewModel.name)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.bg, ignoresSafeAreaEdges: .all)
        
        .popup(
            isPresented: $viewModel.isRegistered) {
            EventifySnackBar(config: .registration)
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
    
    private var photoCarousel: some View {
        VStack(spacing: 16) {
            TabView(selection: $viewModel.currentPage) {
                ForEach(0 ..< viewModel.eventImages.count, id: \.self) { index in
                    Image(viewModel.eventImages[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            PageControl(numberOfPages: viewModel.eventImages.count, currentPage: $viewModel.currentPage)
        }
    }
    
    private var detailsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            EventifyCheeps(items: viewModel.cheepsTitles, style: .registation)
            Text(viewModel.description)
                .font(.regularCompact(size: 17))
        }
    }
    
    private var footerView: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink {
                TestView()
            } label: {
                Text(String(localized: "full_description_title") + ">")
                    .font(.mediumCompact(size: 14))
                    .foregroundStyle(.linkButton)
            }

            Text("organizer_title")
                .font(.semiboldCompact(size: 12))
                .foregroundStyle(.secondaryText)
                .padding(.top, 23)

            HStack(spacing: 16) {
                Image("misis")
                    .clipShape(Circle())
                    .frame(height: 40)
                    .padding(.top, 8)

                Text("МИСИС")
                    .font(.semiboldCompact(size: 20))
                    .foregroundStyle(.mainText)
            }

            EventifyButton(configuration: viewModel.register ? .registration : .cancel, isLoading: false, isDisabled: false) {
                viewModel.isRegistered.toggle()
                if viewModel.isRegistered {
                        Log.info("Пользователь зарегистрировался на мероприятие")
                    } else {
                        Log.info("Пользователь отменил регистрацию на мероприятие")
                }
            }
            .padding(.top, 24)
        }
    }
}

#Preview {
    EventsRegistationView(register: false)
}
