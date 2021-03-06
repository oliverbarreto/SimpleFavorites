//
//  ColorPalette.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 25/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//


// Check this cool framework https://github.com/ViccAlexander/Chameleon/blob/master/Pod/Classes/Objective-C/UIColor%2BChameleon.m

import UIKit


// Flat Colors Palette
struct ColorPalette {
    
    // 
    enum Palette: String {
        case flatColors = "Flat Colors"
        case materialDesign = "Material Design Colors"
    }
    
    private var currentPalette: Palette = .flatColors
    
    var paletteColors: [PaletteColor] {
        get {
            switch currentPalette {
            case Palette.flatColors:
                return ColorPalette.flatPalette()
            case Palette.materialDesign:
                return ColorPalette.materialPalette()
            }
        }
    }
    
    init(palette: Palette) {
        self.currentPalette = palette
    }
    

    static func colors(ofPalette palette: Palette) -> [UIColor] {
        switch palette {
        case .flatColors:
            return flatColorsPalette()
        case .materialDesign:
            return materialColorsPalette()
        }
    }
    
    
    struct PaletteColor: CustomStringConvertible {
        let name:           String
        let color:          UIColor
        var tintColorStyle: ColorStyle
        
        var description: String {
            return "Color Name: \(name), Color: \(color.hexValue), Tint Color Style: \(tintColorStyle)"
        }
    }
    
    
    enum ColorStyle {
        case light
        case dark
    }
    
    
    // Flat Design Palette
    
    static func flatPalette() -> [PaletteColor]{
        return [
        // Flat Colors --   more colors here http://www.flatuicolorpicker.com
        
                // Green
                PaletteColor(name: "Turqoise", color: flatTurqoise(), tintColorStyle: .light),
                PaletteColor(name: "Green Sea", color: flatGreenSea(), tintColorStyle: .light),
                PaletteColor(name: "Emerald", color: flatEmeral(), tintColorStyle: .light),
                PaletteColor(name: "Nephritis", color: flatNephritis(), tintColorStyle: .light),
                
                // Blue
                PaletteColor(name: "Peter Rever", color: flatPeterRiver(), tintColorStyle: .light),
                PaletteColor(name: "Belize Hole", color: flatBelizeHole(), tintColorStyle: .light),
                
                // Violet
                PaletteColor(name: "Amethist", color: flatAmethyst(), tintColorStyle: .light),
                PaletteColor(name: "Wisteria", color: flatWisteria(), tintColorStyle: .light),
                
                // Pink
                PaletteColor(name: "Razzmatazz", color: flatRazzmatazz(), tintColorStyle: .light),
                PaletteColor(name: "Radical Red", color: flatRadicalRed(), tintColorStyle: .light),
            
                // Dark Blue
                PaletteColor(name: "Wet Asphalt", color: flatWetAsphalt(), tintColorStyle: .light),
                PaletteColor(name: "Midnight Blue", color: flatMidNightBlue(), tintColorStyle: .light),
                
                // Yellow & Orange
                PaletteColor(name: "Sun Flower", color: flatSunFlower(), tintColorStyle: .light),
                PaletteColor(name: "Orange", color: flatOrange(), tintColorStyle: .light),
                PaletteColor(name: "Carrot", color: flatCarrot(), tintColorStyle: .light),
                PaletteColor(name: "Pumkin", color: flatPumkin(), tintColorStyle: .light),

                // Red
                PaletteColor(name: "Alizarin", color: flatAlizarin(), tintColorStyle: .light),
                PaletteColor(name: "Pomegranate", color: flatPomegranate(), tintColorStyle: .light),
            
                // Grey
                PaletteColor(name: "Clouds", color: flatClouds(), tintColorStyle: .dark),
                PaletteColor(name: "Porcelain", color: flatPorcelain(), tintColorStyle: .dark),
                PaletteColor(name: "Silver", color: flatSilver(), tintColorStyle: .light),
                PaletteColor(name: "Concrete", color: flatConcrete(), tintColorStyle: .light),
                PaletteColor(name: "Asbestos", color: flatAsbestos(), tintColorStyle: .light),
                
                // Black
                PaletteColor(name: "Darken", color: flatDarken(), tintColorStyle: .light),
                
                // White
                PaletteColor(name: "White", color: flatWhite(), tintColorStyle: .dark),
                
                // iOS Defaults
            PaletteColor(name: "ios Default NavbarColor", color: iosDefaultNavbarColor(), tintColorStyle: .light),
            PaletteColor(name: "ios Default TintColor", color: iosDefaultTintColor(), tintColorStyle: .light)
        ]
    }
    
    
    static func flatColorsPalette() -> [UIColor] {
        return flatPalette().map {$0.color}
    }
    
    /*
    static func flatPaletteDarkColors() -> [UIColor] {
        return flatPalette().filter {$0.tintColorStyle == .dark}
    }

    static func flatPaletteLightColors() -> [UIColor] {
        return flatPalette().filter {$0.tintColorStyle == .light}
    }
    */
    
    
    // Material Design Palette

    static func materialPalette() -> [PaletteColor]{
        return [PaletteColor(name: "Razzmatazz", color: materialRazzmatazz(), tintColorStyle: .light),
                PaletteColor(name: "Lynch", color: materialLynch(), tintColorStyle: .light),
                PaletteColor(name: "Silver", color: materialSilver(), tintColorStyle: .light)
            // Add more colors to this palette here
        ]
    }
    

    static func materialColorsPalette() -> [UIColor] {
        return materialPalette().map {$0.color}
    }

    static func numberOfColors(InPalette palette: Palette) -> Int {
        switch palette {
        case .flatColors:
            return flatPalette().count
        case .materialDesign:
            return materialPalette().count
        }
    }
    

    // Helper Methods
    
    static func randomColor(fromPalette palette: Palette)  -> UIColor {
        // Picks a random color from 0 to palette available colors
        var colorsPalette: [UIColor]!
        
        switch palette {
        case .flatColors:
            colorsPalette = flatColorsPalette()
            
        case .materialDesign:
            colorsPalette = materialColorsPalette()
            
        }
        let randomColorIndex = Int.random(lower: 0, upper: colorsPalette.count)
        return colorsPalette[randomColorIndex]
    }
    
    
    // ***********************************************************************
    // ***********************************************************************
    
    // Flat Colors --   more colors here http://www.flatuicolorpicker.com
    
    // iOS Defaults
    static func iosDefaultNavbarColor() -> UIColor {
        return UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1)
    }
    
    static func iosDefaultTintColor() -> UIColor {
        return UIColor(red: (0/255), green: (122/255), blue: (255/255), alpha: 1)
    }
    
    
    // Green
    static func flatTurqoise() -> UIColor {
        return UIColor(hex: "#1abc9c")
    }
    
    static func flatGreenSea() -> UIColor {
        return UIColor(hex: "#16a085")
    }
    
    static func flatEmeral() -> UIColor {
        return UIColor(hex: "#2ecc71")
    }
    
    static func flatNephritis() -> UIColor {
        return UIColor(hex: "#27ae60")
    }
    
    
    //Blue
    static func flatPeterRiver() -> UIColor {
        return UIColor(hex: "#3498db")
    }
    
    static func flatBelizeHole() -> UIColor {
        return UIColor(hex: "#2980b9")
    }
    
    static func flatWetAsphalt() -> UIColor {
        return UIColor(hex: "#34495e")
    }
    
    static func flatMidNightBlue() -> UIColor {
        return UIColor(hex: "#2c3e50")
    }
    
    // Violet
    static func flatAmethyst() -> UIColor {
        return UIColor(hex: "#9b59b6")
    }
    
    static func flatWisteria() -> UIColor {
        return UIColor(hex: "#8e44ad")
    }
    
    // Pink
    
    static func flatRazzmatazz() -> UIColor {
        return UIColor(hex: "#DB0A5B")
    }
    
    static func flatRadicalRed() -> UIColor {
        return UIColor(hex: "#F62459")
    }
    
    // Yellow & Orange
    static func flatSunFlower() -> UIColor {
        return UIColor(hex: "#f1c40f")
    }
    
    static func flatOrange() -> UIColor {
        return UIColor(hex: "#f39c12")
    }
    
    static func flatCarrot() -> UIColor {
        return UIColor(hex: "#e67e22")
    }
    
    static func flatPumkin() -> UIColor {
        return UIColor(hex: "#d35400")
    }
    
    //Red
    static func flatAlizarin() -> UIColor {
        return UIColor(hex: "#e74c3c")
    }
    
    static func flatPomegranate() -> UIColor {
        return UIColor(hex: "#c0392b")
    }
    
    // White & Greys
    static func flatClouds() -> UIColor {
        return UIColor(hex: "#ecf0f1")
    }
    
    static func flatSilver() -> UIColor {
        return UIColor(hex: "#bdc3c7")
    }
    
    static func flatConcrete() -> UIColor {
        return UIColor(hex: "#95a5a6")
    }
    
    static func flatAsbestos() -> UIColor {
        return UIColor(hex: "#7f8c8d")
    }
    
    static func flatPorcelain() -> UIColor {
        return UIColor(hex:"ECF0F1")
    }
    
    // Black
    static func flatDarken() -> UIColor {
        return UIColor(hex: "#1D1D1D")
    }
    
    // White
    static func flatWhite() -> UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    
    // ***********************************************************************
    // ***********************************************************************
    
    // Material Design
    
    static func materialRazzmatazz() -> UIColor {
        return UIColor(hex: "#DB0A5B")
    }
    
    static func materialLynch() -> UIColor {
        return UIColor(hex: "#6C7A89")
    }
    
    static func materialSilver() -> UIColor {
        return UIColor(hex: "#BFBFBF")
    }
    
    
    /*
     SOFT RED
     EC644B
     236,100,75
     
     CHESTNUT ROSE
     D24D57
     210, 77, 87
     
     POMEGRANATE
     F22613
     242, 38, 19
     
     THUNDERBIRD
     D91E18
     217, 30, 24
     
     OLD BRICK
     96281B
     150, 40, 27
     
     FLAMINGO
     EF4836
     239, 72, 54
     
     VALENCIA
     D64541
     214, 69, 65
     
     TALL POPPY
     C0392B
     192, 57, 43
     
     MONZA
     CF000F
     207, 0, 15
     
     CINNABAR
     E74C3C
     231, 76, 60
     
     RAZZMATAZZ
     DB0A5B
     219, 10, 91
     
     SUNSET ORANGE
     F64747
     246, 71, 71
     
     WAX FLOWER
     F1A9A0
     241, 169, 160
     
     CABARET
     D2527F
     210, 82, 127
     
     NEW YORK PINK
     E08283
     224, 130, 131
     
     RADICAL RED
     F62459
     246, 36, 89
     
     SUNGLO
     E26A6A
     226, 106, 106
     
     SNUFF
     DCC6E0
     220, 198, 224
     
     REBECCAPURPLE
     663399
     102, 51, 153
     
     HONEY FLOWER
     674172
     103, 65, 114
     
     WISTFUL
     AEA8D3
     174, 168, 211
     
     PLUM
     913D88
     145, 61, 136
     
     SEANCE
     9A12B3
     154, 18, 179
     
     MEDIUM PURPLE
     BF55EC
     191, 85, 236
     
     LIGHT WISTERIA
     BE90D4
     190, 144, 212
     
     STUDIO
     8E44AD
     142, 68, 173
     
     WISTERIA
     9B59B6
     155, 89, 182
     
     SAN MARINO
     446CB3
     68,108,179
     
     ALICE BLUE
     E4F1FE
     228, 241, 254
     
     ROYAL BLUE
     4183D7
     65, 131, 215
     
     PICTON BLUE
     59ABE3
     89, 171, 227
     
     SPRAY
     81CFE0
     129, 207, 224
     
     SHAKESPEARE
     52B3D9
     82, 179, 217
     
     HUMMING BIRD
     C5EFF7
     197, 239, 247
     
     PICTON BLUE
     22A7F0
     34, 167, 240
     
     CURIOUS BLUE
     3498DB
     52, 152, 219
     
     MADISON
     2C3E50
     44, 62, 80
     
     DODGER BLUE
     19B5FE
     25, 181, 254
     
     MING
     336E7B
     51, 110, 123
     
     EBONY CLAY
     22313F
     34, 49, 63
     
     MALIBU
     6BB9F0
     107, 185, 240
     
     SUMMER SKY
     1E8BC3
     30, 139, 195
     
     CHAMBRAY
     3A539B
     58, 83, 155
     
     PICKLED BLUEWOOD
     34495E
     52, 73, 94
     
     HOKI
     67809F
     103, 128, 159
     
     JELLY BEAN
     2574A9
     37, 116, 169
     
     JACKSONS PURPLE
     1F3A93
     31, 58, 147
     
     JORDY BLUE
     89C4F4
     137, 196, 244
     
     STEEL BLUE
     4B77BE
     75, 119, 190
     
     FOUNTAIN BLUE
     5C97BF
     92, 151, 191
     
     MEDIUM TURQUOISE
     4ECDC4
     78,205,196
     
     AQUA ISLAND
     A2DED0
     162, 222, 208
     
     GOSSIP
     87D37C
     135, 211, 124
     
     DARK SEA GREEN
     90C695
     144, 198, 149
     
     EUCALYPTUS
     26A65B
     38, 166, 91
     
     CARIBBEAN GREEN
     03C9A9
     3, 201, 169
     
     SILVER TREE
     68C3A3
     104, 195, 163
     
     DOWNY
     65C6BB
     101, 198, 187
     
     MOUNTAIN MEADOW
     1BBC9B
     27, 188, 155
     
     LIGHT SEA GREEN
     1BA39C
     27, 163, 156
     
     MEDIUM AQUAMARINE
     66CC99
     102, 204, 153
     
     TURQUOISE
     36D7B7
     54, 215, 183
     
     MADANG
     C8F7C5
     200, 247, 197
     
     RIPTIDE
     86E2D5
     134, 226, 213
     
     SHAMROCK
     2ECC71
     46, 204, 113
     
     NIAGARA
     16A085
     22, 160, 133
     
     EMERALD
     3FC380
     63, 195, 128
     
     GREEN HAZE
     019875
     1, 152, 117
     
     FREE SPEECH AQUAMARINE
     03A678
     3, 166, 120
     
     OCEAN GREEN
     4DAF7C
     77, 175, 124
     
     NIAGARA 1
     2ABB9B
     42, 187, 155
     
     JADE
     00B16A
     0, 177, 106
     
     SALEM
     1E824C
     30, 130, 76
     
     OBSERVATORY
     049372
     4, 147, 114
     
     JUNGLE GREEN
     26C281
     38, 194, 129
     
     CREAM CAN
     F5D76E
     245, 215, 110
     
     RIPE LEMON
     F7CA18
     247, 202, 24
     
     SAFFRON
     F4D03F
     244, 208, 63
     
     CONFETTI
     #E9D460
     (233,212,96)
     
     CAPE HONEY
     FDE3A7
     253, 227, 167
     
     CALIFORNIA
     F89406
     248, 148, 6
     
     FIRE BUSH
     EB9532
     235, 149, 50
     
     TAHITI GOLD
     E87E04
     232, 126, 4
     
     CASABLANCA
     F4B350
     244, 179, 80
     
     CRUSTA
     F2784B
     242, 120, 75
     
     SEA BUCKTHORN
     EB974E
     235, 151, 78
     
     LIGHTNING YELLOW
     F5AB35
     245, 171, 53
     
     BURNT ORANGE
     D35400
     211, 84, 0
     
     BUTTERCUP
     F39C12
     243, 156, 18
     
     ECSTASY
     F9690E
     249, 105, 14
     
     SANDSTORM
     F9BF3B
     249, 191, 59
     
     JAFFA
     F27935
     242, 121, 53
     
     ZEST
     E67E22
     230, 126, 34
     
     WHITE SMOKE
     ECECEC
     236,236,236
     
     LYNCH
     6C7A89
     108, 122, 137
     
     PUMICE
     D2D7D3
     210, 215, 211
     
     GALLERY
     EEEEEE
     238, 238, 238
     
     SILVER SAND
     BDC3C7
     189, 195, 199
     
     PORCELAIN
     ECF0F1
     236, 240, 241
     
     CASCADE
     95A5A6
     149, 165, 166
     
     IRON
     DADFE1
     218, 223, 225
     
     EDWARD
     ABB7B7
     171, 183, 183
     
     CARARRA
     F2F1EF
     242, 241, 239
     
     SILVER
     BFBFBF
     191, 191, 191
     */
}
