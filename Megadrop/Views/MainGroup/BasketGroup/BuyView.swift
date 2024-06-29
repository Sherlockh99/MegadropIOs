import SwiftUI

struct BuyView: View {
    @StateObject private var viewModel = BuyViewModel()
    @State private var selectedDelivery: String = "Нова Пошта" // Переменная для хранения выбранной службы доставки
    @State private var city: String = "" // Переменная для хранения населенного пункта
    @State private var branchNumber: String = "" // Переменная для хранения номера отделения
    @State private var isCityDisabled: Bool = false // Переменная для отслеживания доступности поля населенного пункта
    @State private var selectedPaymentMethod: String = "Предоплата" // Переменная для хранения выбранного типа оплаты
    @State private var paymentAmount: String = "" // Переменная для хранения суммы наложенного платежа
    @State private var sendWithMyInvoice: Bool = false // Переменная для чекбокса "Відправити по моїй накладній"
    @State private var invoiceNumber: String = "" // Переменная для номера накладной
    @State private var comment: String = "" // Переменная для комментария

    let deliveries = ["Нова Пошта", "Укрпошта"] // Опции для служб доставки
    let paymentMethods = ["Предоплата", "Оплата з балансу", "Накладеним платежем"] // Опции для типов оплаты

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Введіть номер телефону:")
                        .font(.headline)
                    TextField("Номер телефону", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                    
                    Text("Введіть прізвище:")
                        .font(.headline)
                    TextField("Прізвище", text: $viewModel.lastName)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                    
                    Text("Введіть ім'я:")
                        .font(.headline)
                    TextField("Ім'я", text: $viewModel.firstName)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                    
                    Text("Введіть по батькові:")
                        .font(.headline)
                    TextField("По батькові", text: $viewModel.middleName)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                    
                    Text("Виберіть службу доставки:")
                        .font(.headline)
                    
                    Picker("Виберіть службу доставки", selection: $selectedDelivery) {
                        ForEach(deliveries, id: \.self) { delivery in
                            Text(delivery).tag(delivery)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedDelivery) { newValue in
                        if newValue == "Укрпошта" {
                            city = "" // Очищаем поле населенного пункта
                            isCityDisabled = true // Делаем поле населенного пункта недоступным
                        } else {
                            isCityDisabled = false // Делаем поле населенного пункта доступным
                        }
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 10)

                    Text("Введіть населений пункт:")
                        .font(.headline)
                    TextField("Населений пункт", text: $city)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                        .disabled(isCityDisabled)

                    Text("Введіть номер відділення:")
                        .font(.headline)
                    TextField("Номер відділення", text: $branchNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)

                    Text("Виберіть тип оплати:")
                        .font(.headline)
                    
                    Picker("Виберіть тип оплати", selection: $selectedPaymentMethod) {
                        ForEach(paymentMethods, id: \.self) { method in
                            Text(method).tag(method)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 10)

                    if selectedPaymentMethod == "Накладеним платежем" {
                        Text("Введіть суму платежу:")
                            .font(.headline)
                        TextField("Сума платежу", text: Binding(
                            get: {
                                paymentAmount
                            },
                            set: { newValue in
                                let filtered = newValue.filter { "0123456789.".contains($0) }
                                if filtered.components(separatedBy: ".").count <= 2 {
                                    paymentAmount = filtered
                                }
                            }
                        ))
                        .keyboardType(.decimalPad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                    }

                    Toggle(isOn: $sendWithMyInvoice) {
                        Text("Відправити по моїй накладній")
                            .font(.headline)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 10)

                    if sendWithMyInvoice {
                        Text("Введіть номер накладної:")
                            .font(.headline)
                        TextField("Номер накладної", text: $invoiceNumber)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            .padding(.bottom, 10)
                    }

                    Text("Коментар:")
                        .font(.headline)
                    TextField("Коментар", text: $comment)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                }
                
                Button(action: {
                    viewModel.confirmOrder(
                        deliveryService: selectedDelivery,
                        city: city,
                        branchNumber: branchNumber,
                        paymentMethod: selectedPaymentMethod,
                        paymentAmount: paymentAmount,
                        sendWithMyInvoice: sendWithMyInvoice,
                        invoiceNumber: invoiceNumber,
                        comment: comment
                    )
                }) {
                    Text("ЗАКАЗ ПІДТВЕРДЖУЮ")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                Spacer() // Для отступа между элементами
            }
            .padding() // Отступы для всего VStack
        }
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
