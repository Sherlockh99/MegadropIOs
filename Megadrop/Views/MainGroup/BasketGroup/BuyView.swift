import SwiftUI

struct BuyView: View {
    
    @StateObject private var viewModel = BuyViewModel()
    @State private var selectedDelivery: String = "Укрпошта" // Переменная для хранения выбранной службы доставки
    @State private var branchNumber: String = "" // Переменная для хранения номера отделения
    @State private var isCityDisabled: Bool = true // Переменная для отслеживания доступности поля населенного пункта
    @State private var selectedPaymentMethod: String = "Предоплата" // Переменная для хранения выбранного типа оплаты
    @State private var paymentAmount: String = "" // Переменная для хранения суммы наложенного платежа
    @State private var sendWithMyInvoice: Bool = false // Переменная для чекбокса "Відправити по моїй накладній"
    @State private var invoiceNumber: String = "" // Переменная для номера накладной
    @State private var comment: String = "" // Переменная для комментария

    @State private var txtMessage = ""
    
    @EnvironmentObject var shopRecycle: ShopRecycle
    
    let deliveries = ["Нова Пошта", "Укрпошта"] // Опции для служб доставки
    let paymentMethods = ["Предоплата", "Оплата з балансу", "Накладеним платежем"] // Опции для типов оплаты

	
    var body: some View {
        VStack{
            NavigationBarDetailView()
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
                                isCityDisabled = true
                                viewModel.city = ""
                                branchNumber = ""
                            } else {
                                viewModel.fetchCities()
                                isCityDisabled = false
                                branchNumber = ""
                            }
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 10)
                    }
                    
                    Group {
                        if selectedDelivery == "Укрпошта" {
                            Text("Населений пункт:")
                                .font(.headline)
                            TextField("Населений пункт", text: $viewModel.city)
                                .disabled(true)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                .padding(.bottom, 10)
                                .onChange(of: viewModel.city) { newValue in
                                    //TODO получить отделения Новой почты
                                    //viewModel.fetch___(query: newValue)
                                }
                            
                            Text("Введіть номер відділення:")
                                .font(.headline)
                            TextField("Номер відділення", text: $branchNumber)
                                .keyboardType(.numberPad)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                .padding(.bottom, 10)
                                .onChange(of: branchNumber) { newValue in
                                    if newValue.count == 5 {
                                        viewModel.fetchCityByBranch(branch: newValue)
                                    }
                                }
                        }else {
                            if !viewModel.cities.isEmpty {
                                Text("Виберіть населений пункт зі списку:")
                                    .font(.headline)
                                Picker("Виберіть населений пункт", selection: $viewModel.city) {
                                    ForEach(viewModel.cities, id: \.self) { city in
                                        Text(city).tag(city)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding(.bottom, 10)
                            }
                            
                            if !viewModel.branches.isEmpty {
                                Text("Виберіть відділення:")
                                    .font(.headline)
                                Picker("Виберіть відділення", selection: $branchNumber) {
                                    ForEach(viewModel.branches, id: \.self) { branch in
                                        Text(branch).tag(branch)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding(.bottom, 10)
                            }
                            
                        }
                    }
                    Group{
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
                            TextField("Сума платежу", text: $paymentAmount)
                                .keyboardType(.decimalPad)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                .padding(.bottom, 10)
                        }
                        
                        Toggle("Відправити по моїй накладній", isOn: $sendWithMyInvoice)
                            .padding(.bottom, 10)
                        
                        if sendWithMyInvoice {
                            Text("Введіть номер накладної:")
                                .font(.headline)
                            TextField("Номер накладної", text: $invoiceNumber)
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
                    if viewModel.shopRecycleIsBuy {
                        Text("Order confirmed!")
                            .onAppear {
                                shopRecycle.isBuy = false
                            }
                    }
                    //if (showToast){
                    if !txtMessage.isEmpty{
                        
                        Text(txtMessage)
                            .foregroundColor(.red)
                        
                    }
                    Button(action: {
                        confirmOrder()
                    }) {
                        Text("ЗАКАЗ ПІДТВЕРДЖУЮ")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                } //END: VSTACK
                .padding()
            }//END: ScrollView
        }
    }
    
    func confirmOrder(){
        
        txtMessage = ""
        
        if viewModel.phoneNumber.count < 10 {
            txtMessage = txtMessage + "Phone number must be at least 10 digits long. "
        }

        if viewModel.lastName.isEmpty {
            txtMessage = txtMessage + "\nНе вказана фамілія. "
        }

        if viewModel.firstName.isEmpty {
            txtMessage = txtMessage + "\nНе вказане імʼя. "
        }
        
        if viewModel.middleName.isEmpty {
            txtMessage = txtMessage + "\nНе вказано по-батькові. "
        }

        if viewModel.city.isEmpty {
            txtMessage = txtMessage + "\nНе вказаний населений пункт. "
        }

        if branchNumber.isEmpty {
            txtMessage = txtMessage + "\nНе вказан номер відділення. "
        }

        if (sendWithMyInvoice){
            if invoiceNumber.isEmpty {
                txtMessage = txtMessage + "\nНе вказан номер Вашої накладної."
            }
        }

        if txtMessage.isEmpty {
            viewModel.confirmOrder(
                deliveryService: selectedDelivery,
                city: viewModel.city,
                branchNumber: branchNumber,
                paymentMethod: selectedPaymentMethod,
                paymentAmount: paymentAmount,
                sendWithMyInvoice: sendWithMyInvoice,
                invoiceNumber: invoiceNumber,
                comment: comment)
        }

        
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
