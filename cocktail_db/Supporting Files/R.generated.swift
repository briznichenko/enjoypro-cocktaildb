//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    /// This struct is generated for `LTCocktailsTableViewController`, and contains static references to 1 segues.
    struct ltCocktailsTableViewController {
      /// Segue identifier `toFilterViewController`.
      static let toFilterViewController: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, LTCocktailsTableViewController, LTFilterViewController> = Rswift.StoryboardSegueIdentifier(identifier: "toFilterViewController")

      #if os(iOS) || os(tvOS)
      /// Optionally returns a typed version of segue `toFilterViewController`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func toFilterViewController(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, LTCocktailsTableViewController, LTFilterViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.ltCocktailsTableViewController.toFilterViewController, segue: segue)
      }
      #endif

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 13 files.
  struct file {
    /// Resource file `LICENSE.txt`.
    static let licenseTxt = Rswift.FileResource(bundle: R.hostingBundle, name: "LICENSE", pathExtension: "txt")
    /// Resource file `Roboto-Black.ttf`.
    static let robotoBlackTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-Black", pathExtension: "ttf")
    /// Resource file `Roboto-BlackItalic.ttf`.
    static let robotoBlackItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-BlackItalic", pathExtension: "ttf")
    /// Resource file `Roboto-Bold.ttf`.
    static let robotoBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-Bold", pathExtension: "ttf")
    /// Resource file `Roboto-BoldItalic.ttf`.
    static let robotoBoldItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-BoldItalic", pathExtension: "ttf")
    /// Resource file `Roboto-Italic.ttf`.
    static let robotoItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-Italic", pathExtension: "ttf")
    /// Resource file `Roboto-Light.ttf`.
    static let robotoLightTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-Light", pathExtension: "ttf")
    /// Resource file `Roboto-LightItalic.ttf`.
    static let robotoLightItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-LightItalic", pathExtension: "ttf")
    /// Resource file `Roboto-Medium.ttf`.
    static let robotoMediumTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-Medium", pathExtension: "ttf")
    /// Resource file `Roboto-MediumItalic.ttf`.
    static let robotoMediumItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-MediumItalic", pathExtension: "ttf")
    /// Resource file `Roboto-Regular.ttf`.
    static let robotoRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-Regular", pathExtension: "ttf")
    /// Resource file `Roboto-Thin.ttf`.
    static let robotoThinTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-Thin", pathExtension: "ttf")
    /// Resource file `Roboto-ThinItalic.ttf`.
    static let robotoThinItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto-ThinItalic", pathExtension: "ttf")

    /// `bundle.url(forResource: "LICENSE", withExtension: "txt")`
    static func licenseTxt(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.licenseTxt
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-Black", withExtension: "ttf")`
    static func robotoBlackTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoBlackTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-BlackItalic", withExtension: "ttf")`
    static func robotoBlackItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoBlackItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-Bold", withExtension: "ttf")`
    static func robotoBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-BoldItalic", withExtension: "ttf")`
    static func robotoBoldItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoBoldItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-Italic", withExtension: "ttf")`
    static func robotoItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-Light", withExtension: "ttf")`
    static func robotoLightTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoLightTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-LightItalic", withExtension: "ttf")`
    static func robotoLightItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoLightItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-Medium", withExtension: "ttf")`
    static func robotoMediumTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoMediumTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-MediumItalic", withExtension: "ttf")`
    static func robotoMediumItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoMediumItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-Regular", withExtension: "ttf")`
    static func robotoRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-Thin", withExtension: "ttf")`
    static func robotoThinTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoThinTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Roboto-ThinItalic", withExtension: "ttf")`
    static func robotoThinItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.robotoThinItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 12 fonts.
  struct font: Rswift.Validatable {
    /// Font `Roboto-BlackItalic`.
    static let robotoBlackItalic = Rswift.FontResource(fontName: "Roboto-BlackItalic")
    /// Font `Roboto-Black`.
    static let robotoBlack = Rswift.FontResource(fontName: "Roboto-Black")
    /// Font `Roboto-BoldItalic`.
    static let robotoBoldItalic = Rswift.FontResource(fontName: "Roboto-BoldItalic")
    /// Font `Roboto-Bold`.
    static let robotoBold = Rswift.FontResource(fontName: "Roboto-Bold")
    /// Font `Roboto-Italic`.
    static let robotoItalic = Rswift.FontResource(fontName: "Roboto-Italic")
    /// Font `Roboto-LightItalic`.
    static let robotoLightItalic = Rswift.FontResource(fontName: "Roboto-LightItalic")
    /// Font `Roboto-Light`.
    static let robotoLight = Rswift.FontResource(fontName: "Roboto-Light")
    /// Font `Roboto-MediumItalic`.
    static let robotoMediumItalic = Rswift.FontResource(fontName: "Roboto-MediumItalic")
    /// Font `Roboto-Medium`.
    static let robotoMedium = Rswift.FontResource(fontName: "Roboto-Medium")
    /// Font `Roboto-Regular`.
    static let robotoRegular = Rswift.FontResource(fontName: "Roboto-Regular")
    /// Font `Roboto-ThinItalic`.
    static let robotoThinItalic = Rswift.FontResource(fontName: "Roboto-ThinItalic")
    /// Font `Roboto-Thin`.
    static let robotoThin = Rswift.FontResource(fontName: "Roboto-Thin")

    /// `UIFont(name: "Roboto-Black", size: ...)`
    static func robotoBlack(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBlack, size: size)
    }

    /// `UIFont(name: "Roboto-BlackItalic", size: ...)`
    static func robotoBlackItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBlackItalic, size: size)
    }

    /// `UIFont(name: "Roboto-Bold", size: ...)`
    static func robotoBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBold, size: size)
    }

    /// `UIFont(name: "Roboto-BoldItalic", size: ...)`
    static func robotoBoldItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBoldItalic, size: size)
    }

    /// `UIFont(name: "Roboto-Italic", size: ...)`
    static func robotoItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoItalic, size: size)
    }

    /// `UIFont(name: "Roboto-Light", size: ...)`
    static func robotoLight(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoLight, size: size)
    }

    /// `UIFont(name: "Roboto-LightItalic", size: ...)`
    static func robotoLightItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoLightItalic, size: size)
    }

    /// `UIFont(name: "Roboto-Medium", size: ...)`
    static func robotoMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoMedium, size: size)
    }

    /// `UIFont(name: "Roboto-MediumItalic", size: ...)`
    static func robotoMediumItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoMediumItalic, size: size)
    }

    /// `UIFont(name: "Roboto-Regular", size: ...)`
    static func robotoRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoRegular, size: size)
    }

    /// `UIFont(name: "Roboto-Thin", size: ...)`
    static func robotoThin(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoThin, size: size)
    }

    /// `UIFont(name: "Roboto-ThinItalic", size: ...)`
    static func robotoThinItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoThinItalic, size: size)
    }

    static func validate() throws {
      if R.font.robotoBlack(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Black' could not be loaded, is 'Roboto-Black.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBlackItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-BlackItalic' could not be loaded, is 'Roboto-BlackItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Bold' could not be loaded, is 'Roboto-Bold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBoldItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-BoldItalic' could not be loaded, is 'Roboto-BoldItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Italic' could not be loaded, is 'Roboto-Italic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoLight(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Light' could not be loaded, is 'Roboto-Light.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoLightItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-LightItalic' could not be loaded, is 'Roboto-LightItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Medium' could not be loaded, is 'Roboto-Medium.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoMediumItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-MediumItalic' could not be loaded, is 'Roboto-MediumItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Regular' could not be loaded, is 'Roboto-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoThin(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Thin' could not be loaded, is 'Roboto-Thin.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoThinItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-ThinItalic' could not be loaded, is 'Roboto-ThinItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `ic_checkmark`.
    static let ic_checkmark = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_checkmark")
    /// Image `ic_filter_off`.
    static let ic_filter_off = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_filter_off")
    /// Image `ic_filter_on`.
    static let ic_filter_on = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_filter_on")
    /// Image `img_cocktailCellPlaceholder`.
    static let img_cocktailCellPlaceholder = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_cocktailCellPlaceholder")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_checkmark", bundle: ..., traitCollection: ...)`
    static func ic_checkmark(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_checkmark, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_filter_off", bundle: ..., traitCollection: ...)`
    static func ic_filter_off(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_filter_off, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_filter_on", bundle: ..., traitCollection: ...)`
    static func ic_filter_on(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_filter_on, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "img_cocktailCellPlaceholder", bundle: ..., traitCollection: ...)`
    static func img_cocktailCellPlaceholder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_cocktailCellPlaceholder, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `LTFilterTableViewCell`.
    static let ltFilterTableViewCell = _R.nib._LTFilterTableViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "LTFilterTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.ltFilterTableViewCell) instead")
    static func ltFilterTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.ltFilterTableViewCell)
    }
    #endif

    static func ltFilterTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> LTFilterTableViewCell? {
      return R.nib.ltFilterTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? LTFilterTableViewCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `LTFilterTableViewCell`.
    static let ltFilterTableViewCell: Rswift.ReuseIdentifier<LTFilterTableViewCell> = Rswift.ReuseIdentifier(identifier: "LTFilterTableViewCell")
    /// Reuse identifier `cocktailCell`.
    static let cocktailCell: Rswift.ReuseIdentifier<CustomImagedTableViewCell> = Rswift.ReuseIdentifier(identifier: "cocktailCell")

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _LTFilterTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = LTFilterTableViewCell

      let bundle = R.hostingBundle
      let identifier = "LTFilterTableViewCell"
      let name = "LTFilterTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> LTFilterTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? LTFilterTableViewCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let ltCocktailsTableViewController = StoryboardViewControllerResource<LTCocktailsTableViewController>(identifier: "LTCocktailsTableViewController")
      let ltFilterTableViewController = StoryboardViewControllerResource<LTFilterViewController>(identifier: "LTFilterTableViewController")
      let name = "Main"

      func ltCocktailsTableViewController(_: Void = ()) -> LTCocktailsTableViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: ltCocktailsTableViewController)
      }

      func ltFilterTableViewController(_: Void = ()) -> LTFilterViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: ltFilterTableViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ic_filter_off", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_filter_off' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().ltCocktailsTableViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'ltCocktailsTableViewController' could not be loaded from storyboard 'Main' as 'LTCocktailsTableViewController'.") }
        if _R.storyboard.main().ltFilterTableViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'ltFilterTableViewController' could not be loaded from storyboard 'Main' as 'LTFilterViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
