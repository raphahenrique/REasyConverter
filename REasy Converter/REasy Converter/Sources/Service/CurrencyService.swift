//
//  CurrencyService.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 18/11/23.
//

import CoreData

class CurrencyService {

    // MARK: - Create

    static func createCurrency(name: String, flagURL: String) {
        let context = persistentContainer.viewContext
        let newCurrency = Currency(context: context)
        
        newCurrency.name = name
        newCurrency.flagURL = flagURL
        
        saveContext()
    }

    static func createExchangeRate(fromCurrency: Currency, toCurrency: Currency, rate: Float) {
        let context = persistentContainer.viewContext
        let newExchangeRate = ExchangeRate(context: context)
        
        newExchangeRate.fromCurrency = fromCurrency
        newExchangeRate.toCurrency = toCurrency
        newExchangeRate.rate = rate
        
        saveContext()
    }

    static func createDefaultCurrenciesAndRates() {
        let countries: [Country] = [.brazil, .chile, .europeanUnion, .unitedStates]
        for country in countries {
            createCurrency(
                name: country.code,
                flagURL: ImageFlagHelper.flagURL(
                    forCountry: country
                )
            )
        }
        createDefaultExchangesRates()
    }

    static func createDefaultExchangesRates() {
        let currencies = fetchAllCurrencies()
        
        for (indexA, fromCurrency) in currencies.enumerated() {
            for indexB in (indexA + 1)..<currencies.count {
                let toCurrency = currencies[indexB]

                guard let fromCountry = Country(rawValue: fromCurrency.name ?? String()),
                      let toCountry = Country(rawValue: toCurrency.name ?? String()) else {
                    // Handle the case where the currency names don't match any country codes
                    continue
                }

                let rate: Float = Country.defaultRate(from: fromCountry, to: toCountry)

                // Create exchange rate from A to B
                createExchangeRate(fromCurrency: fromCurrency, toCurrency: toCurrency, rate: rate)

                // Create exchange rate from B to A (invert the rate)
                let invertedRate: Float = 1.0 / rate
                createExchangeRate(fromCurrency: toCurrency, toCurrency: fromCurrency, rate: invertedRate)
            }
        }
        
        
        
//        for fromCurrency in currencies {
//            for toCurrency in currencies {
//                guard fromCurrency != toCurrency else {
//                    // Skip creating exchange rates for the same currency
//                    continue
//                }
//
//                guard let fromCountry = Country(rawValue: fromCurrency.name ?? String()),
//                      let toCountry = Country(rawValue: toCurrency.name ?? String()) else {
//                    // Handle the case where the currency names don't match any country codes
//                    continue
//                }
//
//                let rate: Float = Country.defaultRate(from: fromCountry, to: toCountry)
//
//                createExchangeRate(fromCurrency: fromCurrency, toCurrency: toCurrency, rate: rate)
//                let invertedRate: Float = 1.0 / rate
//                createExchangeRate(fromCurrency: toCurrency, toCurrency: fromCurrency, rate: invertedRate)
//            }
//        }

    }


    // MARK: - Read

    static func fetchAllCurrencies() -> [Currency] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Currency> = Currency.fetchRequest()

        do {
            let currencies = try context.fetch(fetchRequest)
            return currencies
        } catch {
            print("Failed to fetch currencies: \(error)")
            return []
        }
    }

    static func fetchAllExchangeRates() -> [ExchangeRate] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ExchangeRate> = ExchangeRate.fetchRequest()
        
        do {
            let exchangeRates = try context.fetch(fetchRequest)
            return exchangeRates
        } catch {
            print("Failed to fetch exchange rates: \(error)")
            return []
        }
    }

    static func fetchCurrency(forCountry country: Country) -> Currency? {
        let context = persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Currency> = Currency.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", country.code)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch currency: \(error)")
            return nil
        }
    }

    static func fetchExchangeRate(fromCurrency: Currency, toCurrency: Currency) -> ExchangeRate? {
        let context = persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<ExchangeRate> = ExchangeRate.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "fromCurrency == %@ AND toCurrency == %@", fromCurrency, toCurrency)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch exchange rate: \(error)")
            return nil
        }
    }

    // MARK: - Update

    static func updateCurrency(_ currency: Currency, name: String, flagURL: String) {
        currency.name = name
        currency.flagURL = flagURL
        saveContext()
    }

    static func updateExchangeRate(_ exchangeRate: ExchangeRate, rate: Float) {
        exchangeRate.rate = rate
        saveContext()
    }

    // MARK: - Delete

    static func deleteCurrency(_ currency: Currency) {
        let context = persistentContainer.viewContext
        context.delete(currency)
        saveContext()
    }

    static func deleteExchangeRate(_ exchangeRate: ExchangeRate) {
        let context = persistentContainer.viewContext
        context.delete(exchangeRate)
        saveContext()
    }
    
    static func deleteAllData() {
        let currencies = fetchAllCurrencies()
        let rates = fetchAllExchangeRates()

        for rate in rates {
            deleteExchangeRate(rate)
        }
        for currency in currencies {
            deleteCurrency(currency)
        }
    }
    
    // MARK: - Core Data Stack

    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private static func saveContext() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

