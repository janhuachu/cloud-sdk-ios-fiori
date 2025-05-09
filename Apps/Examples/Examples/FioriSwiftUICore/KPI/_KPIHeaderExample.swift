import FioriSwiftUICore
import Foundation
import SwiftUI

class World: _KPIItemModel, Identifiable {
    var kpi: String? {
        "Hello World"
    }
    
    var subtitle: String? {
        "World subtitle"
    }
}

class Galaxy: _KPIProgressItemModel, Identifiable {
    var kpi: String? {
        "Hello Galaxy"
    }
    
    var footnote: String? {
        "Galaxy footnote"
    }
    
    var subtitle: String? {
        "What's outside"
    }
}

class Space: _KPIItemModel, Identifiable {
    var kpi: String? {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = MeasurementFormatter.UnitStyle.medium
        let distanceInMiles = Measurement(value: 321, unit: UnitLength.miles)
        return formatter.string(from: distanceInMiles)
    }
    
    var subtitle: String? {
        "Space subtitle"
    }
}

class Universe: _KPIItemModel, Identifiable {
    var kpi: String? {
        let number = NSNumber(value: 99.9)
        let formattedValue = self.formatter.string(from: number)
        return formattedValue ?? "Hello Universe"
    }
    
    var subtitle: String? {
        "Universe subtitle"
    }

    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

struct _KPIHeaderExample: View {
    var data: [_KPIHeaderItemModel] = [World(), Galaxy(), Space(), Universe()]

    var body: some View {
        ScrollView {
            VStack {
                ExpHeaderView("KPI Header", subtitle: "Header vs Layout container", desc: "semantic vs container. see code for comments")
                _KPIHeader {
                    _KPIItem(data: .components([.icon(Image(systemName: "heart.fill")), .metric("2K"), .icon(Image(systemName: "hand.thumbsup")), .metric("7.5K")]), subtitle: "Likes & Thumbs-Up")
                    _KPIItem(data: .percent(0.695), subtitle: "Acceptance Rate")
                        .disabled(true)
                    _KPIProgressItem(data: .percent(0.88), subtitle: "Completed")
                    _KPIProgressItem(data: .percent(0.66), footnote: "Completed")
                }
                _KPIHeader(self.data)
                _KPIHeader {
                    self.createItem(120)
                    self.createItem(200)
                    self.createItem(400)
                    self.createItem(200)
                }
                .frame(height: 100)
                Text("Group may break the max count limitation and pages organization")
                _KPIHeader {
                    self.createItem(120)
                    Group {
                        self.createItem(200)
                        self.createItem(400)
                        self.createItem(200)
                        self.createItem(222)
                    }
                }
                .frame(height: 100)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func createItem(_ width: CGFloat) -> some View {
        ZStack {
            Color.random
            Text(String(format: "width: %.1f", width))
        }
        .frame(width: width)
    }
}

struct KPIHeaderExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            KPIHeaderExample()
        }
    }
}
