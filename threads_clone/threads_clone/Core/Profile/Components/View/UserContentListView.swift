//
//  UserContentListView.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import SwiftUI

struct UserContentListView: View {
    
    @StateObject var viewModel: UserContentListViewModel
    
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    
    init(user: User) {
        // StateObjectを初期化
        // UserContentListViewModelのインスタンスを作成し、それをviewModelのStateObjectにラップしています
        // user: user : UserContentListViewModelの初期化に必要なUser型の引数を渡しています
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
        /// _の部分 : @StateObjectなどのプロパティラッパーは、実際には2つのプロパティを生成します
        /// 1つ目は、 _ で始まるプロパティで、これはラッパー自体を保持します
        /// 2つ目は、ラッパーを使用するためのプロパティで、ここではviewModelです
        /// _viewModelを直接操作することで、ラッパー自体を操作している
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            LazyVStack {
                switch selectedFilter {
                case .threads:
                    ForEach(viewModel.threads) { thread in
                        ThreadCell(thread: thread)
                            .transition(.move(edge: .leading))
                    }
                case .replies:
                    ForEach(viewModel.replies) { reply in
                        ThreadReplyProfileCell(reply: reply)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserContentListView(user: DeveloperPreview.shared.user)
}
