import SwiftUI

struct SearchScreen: View{
    @State private var searchString = ""
    @ObservedObject var suggestionViewModel = SuggestionViewModel()
    @ObservedObject var searchViewModel = SearchViewModel()
    let localStorage = LocalStorage()
    @State var searchHistory:[String]=[]
    @State var showSearchedView : Bool = false;
    
    func updateSearchHistory(){
        let i = localStorage.getStoredValue(key: StorageKeys.searchHistory);
        if(i != nil) {
            searchHistory = i as! [String];
        }
        else {searchHistory=[];}
    }
    
    func searchForQuery(query:String){
        searchViewModel.searchFor(query: query);
    }
    
    func addToHistory(query:String){
        if(searchHistory.contains(query)) {return;}
        searchHistory.append(query);
        localStorage.deleteStorageKey(key: StorageKeys.searchHistory);
        localStorage.setStoragePair(key: StorageKeys.searchHistory, val: searchHistory)
    }
    
    func onSuggestionTap(query:String){
        searchString = query;
        searchForQuery(query: query);
        addToHistory(query: query);
        showSearchedView.toggle();
    }
    
    var searchedView :some View{
        SearchedQueryView(searchedQuery: searchString, showSearchedView: $showSearchedView)
    }
    
    func suggestionView()->some View{
        return VStack{
            if(suggestionViewModel.suggestionList != nil){
                List{
                    ForEach(suggestionViewModel.suggestionList ?? [], id: \.self) { item in
                        Text(item)
                            .onTapGesture{ onSuggestionTap(query: item) }
                    }
                }
            }
            else{
                List{
                    ForEach(searchHistory, id: \.self) { item in
                        Text(item)
                            .onTapGesture{ onSuggestionTap(query: item) }
                    }
                }
            }
            Text("")
                .font(.system(size: 0))
                .navigationTitle("Search History")
                .onChange(of: searchString){
                    searchText in
                    if(searchText == ""){
                        suggestionViewModel.suggestionList=nil
                    }
                    else{
                        suggestionViewModel.getSuggestedString(query: searchText)
                    }
                }
        }
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                if(showSearchedView){
                    searchedView
                }
                else{
                    suggestionView();
                }
            }.searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always))
        }
        .onAppear(perform: updateSearchHistory)
    }
}



struct SearchedQueryView: View {
    var searchedQuery:String
    @Binding var showSearchedView : Bool;
    @ObservedObject var searchViewModel = SearchViewModel()
    
    func channelItem(item:Item)->some View{
        return Text(item.name ?? "");
    }
    
    func videoItem(item:Item)->some View{
        return Text(item.title ?? "");
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text(searchedQuery)
                        .font(.system(size: 20,weight: .bold))
                    Spacer()
                    Button{
                        showSearchedView.toggle();
                    }label: {
                        Label("",systemImage: "xmark.circle")
                    }
                }
            }
        }
    }
}
