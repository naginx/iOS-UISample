//
//  ChatViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/06/05.
//

import InputBarAccessoryView
import MessageKit
import UIKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

/// MessageKigを使ったチャット画面VC
/// 参考: https://blog.funseek.co.jp/2018/08/uimessagekit.html
///       https://qiita.com/chocovayashi/items/4950e4b33b92c5b35a16
final class ChatViewController: MessagesViewController {

    var messageList: [Message] = []
    private let sender = Sender(senderId: "111", displayName: "太郎")

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
    }
}

// MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource {

    /// 送信者の情報を返す
    func currentSender() -> SenderType {
        return sender
    }

    /// セクションに対応するメッセージを返す
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }

    /// メッセージのセクション数
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }

    /// セル上部に表示されるテキスト
    func cellTopLabelAttributedText(for message: MessageType,
                                    at indexPath: IndexPath) -> NSAttributedString? {
        // メッセージ送信日を付与
        let dateStr = MessageKitDateFormatter.shared.string(from: message.sentDate)
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                          NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        return NSAttributedString(string: dateStr, attributes: attributes)
    }

    /// メッセージ上部に表示されるテキスト
    func messageTopLabelAttributedText(for message: MessageType,
                                       at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)]
        return NSAttributedString(string: name, attributes: attributes)
    }

    /// メッセージ下部に表示されるテキスト
    func messageBottomLabelAttributedText(for message: MessageType,
                                          at indexPath: IndexPath) -> NSAttributedString? {
        let dateString = MessageKitDateFormatter.shared.string(from: message.sentDate)
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)]
        return NSAttributedString(string: dateString,
                                  attributes: attributes)
    }
}

// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {

}

// MARK: - MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {

    // MARK: Text Messages

    /// テキストの色設定
    /// 送信・受信で色を切り替え
    func textColor(for message: MessageType, at indexPath: IndexPath,
                   in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }

    func detectorAttributes(for detector: DetectorType, and message: MessageType,
                            at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        return MessageLabel.defaultAttributes
    }

    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation]
    }

    // MARK: All Messages

    func backgroundColor(for message: MessageType, at indexPath: IndexPath,
                         in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(red: 69 / 255, green: 193 / 255, blue: 89 / 255, alpha: 1) : UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
    }

    func messageStyle(for message: MessageType, at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }

    /// アバター情報を設定
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType,
                             at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // 画像を設定する場合はUIImageを設定
        let avatar = Avatar(image: nil, initials: message.sender.displayName)
        avatarView.set(avatar: avatar)
    }
}

// MARK: - MessageCellDelegate

extension ChatViewController: MessageCellDelegate {

    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("セルがタップされました")
    }
}

// MARK: - InputBarAccessoryViewDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        for component in inputBar.inputTextView.components {
            if let text = component as? String {
                let message = Message(sender: sender, messageId: "111", sentDate: Date(), kind: .text(text))
                messageList.append(message)
                messagesCollectionView.insertSections([messageList.count - 1])
            }
        }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToLastItem()
    }
}
