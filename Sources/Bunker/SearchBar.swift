//
//  SearchBar.swift
//  
//
//  Created by Sam Spencer on 10/6/20.
//

import Foundation
import SwiftUI

public struct SearchBar: UIViewRepresentable {
    
    @Binding public var text: String
    @Binding public var predicate: NSPredicate?
    
    public class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        @Binding var predicate: NSPredicate?
        
        init(text: Binding<String>, predicate: Binding<NSPredicate?>) {
            _text = text
            _predicate = predicate
        }
        
        // UISearchBarDelegate
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            predicate = NSPredicate(format: "name contains[c] %@", searchText)
        }
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    public func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, predicate: $predicate)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .sentences
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = false
        return searchBar
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBar(text: .constant("search"), predicate: .constant(NSPredicate()))
    }
    
}
