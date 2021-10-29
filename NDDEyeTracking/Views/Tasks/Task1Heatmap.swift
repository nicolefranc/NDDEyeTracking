//
//  HeatmapView.swift
//  NDDEyeTracking
//
//  Created by Edvin Berhan on 22.10.21.
//

import SwiftUI

extension CGPoint: Hashable {
    static func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

struct HeatmapView: View {
    
    let pointSize: CGFloat = 5
    let shadowRadius: CGFloat = 20
    let pointColor: Color = .red
    
    var body: some View {
        ZStack {
            Image("field").resizable().aspectRatio(contentMode: .fill)

            ForEach(pointArray, id: \.self) { point in
                Circle()
                    .foregroundColor(pointColor)
                    .frame(width: pointSize, height: pointSize, alignment: .center)
                    .brightness(0.2)
                    .position(point)
                    .shadow(color: pointColor, radius: shadowRadius, x: 0, y: 0)
                    .shadow(color: pointColor, radius: shadowRadius, x: 0, y: 0)
                    .shadow(color: pointColor, radius: shadowRadius, x: 0, y: 0)
                    .shadow(color: pointColor, radius: shadowRadius, x: 0, y: 0)
            }
        }
    }
    
    // Perhaps it will become relevant to use the radial gradient in the future
    
    //  .fill(.radialGradient(colors: [.red, .clear, .clear], center: UnitPoint(x: 0.5, y: 0.5), startRadius: 0, endRadius: 30))
    
    
    // Testdata
    let pointArray: [CGPoint] = [
        CGPoint(x: 415.2645814471385, y: 366.83399479108016),
        CGPoint(x: 415.7896827652174, y: 366.4877121465849),
        CGPoint(x: 416.3422474430389, y: 366.30713354404986),
        CGPoint(x: 416.8665280890565, y: 366.1967743646733),
        CGPoint(x: 417.3379924395004, y: 366.1682324542368),
        CGPoint(x: 417.60884032805427, y: 366.05656546325406),
        CGPoint(x: 417.8768772189858, y: 365.96904268653793),
        CGPoint(x: 418.30338649414165, y: 365.7831178651295),
        CGPoint(x: 418.95481474159146, y: 365.73803429360925),
        CGPoint(x: 419.69097063471287, y: 366.2394291432108),
        CGPoint(x: 420.4349938400653, y: 366.9338339913835),
        CGPoint(x: 421.04654421350534, y: 367.9967973960236),
        CGPoint(x: 421.5545132408122, y: 369.24659103010697),
        CGPoint(x: 421.7652484238649, y: 371.06200599805214),
        CGPoint(x: 421.7961432893737, y: 373.3475289379452),
        CGPoint(x: 421.6196404875827, y: 375.7709613302797),
        CGPoint(x: 421.39871522057956, y: 378.4208319606997),
        CGPoint(x: 420.98857587275387, y: 381.21365645975595),
        CGPoint(x: 420.40349674224854, y: 384.1907386797117),
        CGPoint(x: 419.82295262988873, y: 387.12845720747947),
        CGPoint(x: 418.81487579556074, y: 389.91948526202185),
        CGPoint(x: 417.69355927094693, y: 392.8085417007976),
        CGPoint(x: 416.42130348762544, y: 395.7556304831497),
        CGPoint(x: 414.97350307848274, y: 398.5431087633327),
        CGPoint(x: 413.48607369481016, y: 401.35751933966776),
        CGPoint(x: 411.98426470936846, y: 403.9958639820866),
        CGPoint(x: 410.5181188420588, y: 406.63029956124325),
        CGPoint(x: 409.0761127431853, y: 409.2553361427033),
        CGPoint(x: 407.5055326573989, y: 411.698471938466),
        CGPoint(x: 405.9737312846324, y: 414.13791424430815),
        CGPoint(x: 404.58693300500636, y: 416.6154986600691),
        CGPoint(x: 403.43231964787515, y: 419.58506455617885),
        CGPoint(x: 402.58410938297, y: 423.31991581520083),
        CGPoint(x: 402.1475074949886, y: 426.9291453022564),
        CGPoint(x: 401.925214151124, y: 430.8346587900969),
        CGPoint(x: 401.6444807758852, y: 434.96629434178834),
        CGPoint(x: 401.50731366497126, y: 439.07494977525823),
        CGPoint(x: 401.64647545283583, y: 443.0811503852126),
        CGPoint(x: 402.09698612224156, y: 446.95092181300504),
        CGPoint(x: 402.9178505149208, y: 450.9970034911675),
        CGPoint(x: 404.1597118425269, y: 455.29192866339247),
        CGPoint(x: 405.67038547867486, y: 459.6101644996295),
        CGPoint(x: 407.20842587371834, y: 463.9615842589269),
        CGPoint(x: 408.9507927253467, y: 468.6937496542738),
        CGPoint(x: 410.6883469401788, y: 473.1948060557993),
        CGPoint(x: 412.46629510381644, y: 477.7527019617438),
        CGPoint(x: 414.2590910787342, y: 482.34271829559657),
        CGPoint(x: 415.9850618946953, y: 486.72444766673215),
        CGPoint(x: 417.80057821479164, y: 491.2126558970943),
        CGPoint(x: 419.5979344459141, y: 495.4542625961474),
        CGPoint(x: 421.2279301446025, y: 499.53269464711576),
        CGPoint(x: 422.81420482206744, y: 503.06368538270283),
        CGPoint(x: 424.0849541543412, y: 505.6379185133104),
        CGPoint(x: 425.26589428827543, y: 507.51359341602915),
        CGPoint(x: 426.2911634625507, y: 508.7270557562639),
        CGPoint(x: 427.3674109054714, y: 509.5351683563871),
        CGPoint(x: 428.3093605437199, y: 510.16707130703287),
        CGPoint(x: 429.2132720754427, y: 510.7588201299045),
        CGPoint(x: 430.02014588057494, y: 511.27652669569216),
        CGPoint(x: 430.55009290601026, y: 511.6353413371162),
    ]
}

struct HeatmapView_Previews: PreviewProvider {
    static var previews: some View {
        HeatmapView()
    }
}



