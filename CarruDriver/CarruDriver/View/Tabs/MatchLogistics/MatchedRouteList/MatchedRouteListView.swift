//
//  MatchedRouteListView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import SwiftUI

struct MatchedRouteListView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: MatchedRouteListViewModel
    
    // viewModel에서 변화 인식이 안되네
    @State private var sortPriceButtonTitle: String = "가격"
    @State private var filterRegionButtonTitle: String = "지역"
    @State private var sortOperationDistanceButtonTitle: String = "운행거리"
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Menu {
                    Button("오름차순") {
                        logger.printOnDebug("가격 오름차순")
                        sortPriceButtonTitle = "오름차순"
                        viewModel.sortPrice = 0
                    }
                    Button("내림차순") {
                        logger.printOnDebug("가격 내림차순")
                        sortPriceButtonTitle = "내림차순"
                        viewModel.sortPrice = 1
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                        Text(sortPriceButtonTitle)
                            .foregroundStyle(.black)
                    }
                    .foregroundStyle(.crGray2)
                    .padding(8)
                    .background(Color.white)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.crGray2, lineWidth: 1) // 테두리 추가
                    )
                }
                Menu {
                    ForEach(RegisonList.allCases, id: \.self) { region in
                        Button(region.rawValue) {
                            logger.printOnDebug("\(region.rawValue) 선택")
                            viewModel.warehouseKeyword = region.rawValue
                            filterRegionButtonTitle = region.rawValue
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                        Text(filterRegionButtonTitle)
                            .foregroundStyle(.black)
                    }
                    .foregroundStyle(.crGray2)
                    .padding(8)
                    .background(Color.white)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.crGray2, lineWidth: 1) // 테두리 추가
                    )
                }
                
                Menu {
                    Button("먼순") {
                        logger.printOnDebug("운행거리 먼순 선택")
                        sortOperationDistanceButtonTitle = "먼순"
                        viewModel.sortOperationDistance = 1
                        
                    }
                    Button("가까운순") {
                        logger.printOnDebug("운행거리 가까운순 선택")
                        sortOperationDistanceButtonTitle = "가까운순"
                        viewModel.sortOperationDistance = 0
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                        Text(sortOperationDistanceButtonTitle)
                            .foregroundStyle(.black)
                    }
                    .foregroundStyle(.crGray2)
                    .padding(8)
                    .background(Color.white)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.crGray2, lineWidth: 1) // 테두리 추가
                    )
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            List(viewModel.logistics, id: \.self) { logistic in
                MatchedListCell(logistic: logistic)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                    .onTapGesture {
                        guard let id = logistic.productId else { return }
                        path.append(.matchedLogisticsMap(id: id))
                    }
            }
            .listStyle(.plain)
        }
        .onChange(of: viewModel.sortPrice) { _, _ in
            viewModel.loadLogistics()
        }
        .onChange(of: viewModel.sortOperationDistance) { _, _ in
            viewModel.loadLogistics()
        }
        .onChange(of: viewModel.warehouseKeyword) { _, _ in
            viewModel.loadLogistics()
        }
    }
}

#Preview {
    @Previewable @State var path: [MainScreen] = []
    
    MatchedRouteListView(path: $path, viewModel: .init(maxWeight: 100, minWeight: 10))
}