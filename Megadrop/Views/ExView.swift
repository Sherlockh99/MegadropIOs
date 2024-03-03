import SwiftUI

struct ExView	: View {
    // Переменная состояния для управления отображаемым представлением
    @State private var isTabViewShown = true
    @State private var selection: Bool = true
    
    var body: some View {
        // Проверяем состояние, чтобы определить, какое представление показать
        if isTabViewShown {
            Button("Вернуться к TabView") {
                isTabViewShown = false
            }
            TabView(selection: $isTabViewShown) {
                // Ваши вкладки здесь
                Text("Tab 1").tabItem {
                    Label("Tab 1", systemImage: "1.circle")
                }
                .tag(true)
                Text("Tab 2").tabItem {
                    Label("Tab 2", systemImage: "2.circle")
                }
                .tag(false)
            }
        } else {
            // Представление, которое показывается вместо TabView
            NewView(changeView: $isTabViewShown)
        }
    }
}

struct NewView: View {
    // Привязка к состоянию в ContentView, чтобы можно было его изменить
    @Binding var changeView: Bool
    
    var body: some View {
        VStack {
            Text("Это новое представление")
            Button("Вернуться к TabView") {
                // Изменяем состояние, чтобы показать TabView снова
                changeView = true
            }
        }
    }
}

#Preview {
    ExView()
}
