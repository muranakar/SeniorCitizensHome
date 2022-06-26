//
//  SettingViewController.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/12.
//

import UIKit
import GoogleMobileAds

class SettingViewController: UIViewController {
    let pickerViewItemsOfFilterServiceType = FilterServiceType.allCases
    let filterServiceTypeRepository = FilterServiceTypeRepository()

    @IBOutlet weak private var filterServiceTypePickerView: UIPickerView!
    @IBOutlet weak private var bannerView: GADBannerView!
    // 追加したUIViewを接続
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdBannar()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectRowFilterServiceTypePickerView()
    }

    @IBAction private func configureCoreLocation(_ sender: Any) {
        configureLocationInformation()
    }

    @IBAction private func jumpToTwitter(_ sender: Any) {
        jumpToTwitterInformation()
    }
    @IBAction private func shareTwitter(_ sender: Any) {
        shareOnTwitter()
    }
    @IBAction private func shareLine(_ sender: Any) {
        shareOnLine()
    }
    @IBAction private func shareOtherApp(_ sender: Any) {
           shareOnOtherApp()
       }

    private func selectRowFilterServiceTypePickerView() {
        guard let loadedFilterServiceType = filterServiceTypeRepository.load() else { return }
        let filterServiceTypeRow = pickerViewItemsOfFilterServiceType.firstIndex(of: loadedFilterServiceType)
        guard let filterServiceTypeRow = filterServiceTypeRow else { return }
        filterServiceTypePickerView.selectRow(filterServiceTypeRow, inComponent: 0, animated: true)
    }

    private func configureLocationInformation() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }

    private func jumpToTwitterInformation() {
        let url = NSURL(string: "https://twitter.com/iOS76923384")
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    private func configureAdBannar() {
        // GADBannerViewのプロパティを設定
        bannerView.adUnitID = "\(GoogleAdID.bannerID)"
        bannerView.rootViewController = self

        // 広告読み込み
        bannerView.load(GADRequest())
    }

    func shareOnTwitter() {
        // シェアするテキストを作成
        let text = "全国の老人ホームの検索が可能！"
        // swiftlint:disable:next line_length
        let hashTag = "#高齢者　#身体障害 #認知症 #老人ホーム  #特養  #介護保険 #医療保険 #在宅 #介護 #医療\nhttps://apps.apple.com/jp/app/%E8%80%81%E4%BA%BA%E3%83%9B%E3%83%BC%E3%83%A0map-%E5%85%A8%E5%9B%BD%E3%81%AE%E8%80%81%E4%BA%BA%E3%83%9B%E3%83%BC%E3%83%A0%E3%82%92%E6%A4%9C%E7%B4%A2/id1628213256"
        let completedText = text + "\n" + hashTag

        // 作成したテキストをエンコード
        let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        // エンコードしたテキストをURLに繋げ、URLを開いてツイート画面を表示させる
        if let encodedText = encodedText,
           let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            UIApplication.shared.open(url)
        }
    }

    func shareOnLine() {
        let urlscheme: String = "https://line.me/R/share?text="
        // swiftlint:disable:next line_length
        let message = "全国の老人ホームの検索が可能！#高齢者　#身体障害 #認知症 #老人ホーム  #特養  #介護保険 #医療保険 #在宅 #介護 #医療\nhttps://apps.apple.com/jp/app/%E8%80%81%E4%BA%BA%E3%83%9B%E3%83%BC%E3%83%A0map-%E5%85%A8%E5%9B%BD%E3%81%AE%E8%80%81%E4%BA%BA%E3%83%9B%E3%83%BC%E3%83%A0%E3%82%92%E6%A4%9C%E7%B4%A2/id1628213256"

        // line:/msg/text/(メッセージ)
        let urlstring = urlscheme + "/" + message

        // URLエンコード
        guard let  encodedURL =
                urlstring.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return
        }

        // URL作成
        guard let url = URL(string: encodedURL) else {
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (succes) in
                    //  LINEアプリ表示成功
                })
            }else{
                UIApplication.shared.openURL(url)
            }
        }else {
            // LINEアプリが無い場合
            let alertController = UIAlertController(title: "エラー",
                                                    message: "LINEがインストールされていません",
                                                    preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alertController,animated: true,completion: nil)
        }
    }
    private func shareOnOtherApp() {
            let url = URL(string: "https://sites.google.com/view/muranakar")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!)
            }
        }
}

extension SettingViewController: UIPickerViewDelegate {
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.text = pickerViewItemsOfFilterServiceType[row].string
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerViewItemsOfFilterServiceType[row].string
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let filterServiceType =
        FilterServiceType.allCases.filter { $0.string == pickerViewItemsOfFilterServiceType[row].string }.first!
        filterServiceTypeRepository.save(filterServiceType: filterServiceType)
    }
}

extension SettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewItemsOfFilterServiceType.count
    }
}
