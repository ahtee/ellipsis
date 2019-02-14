//
//  ViewController.swift
//  Ellipses
//
//  Created by Benjamin Otte on 2/14/19.
//  Copyright © 2019 Benjamin Otte. All rights reserved.
//

import UIKit
import MessageKit

class ViewController: MessagesViewController  {
    var messages: [Message] = []
    var member: Member!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        member = Member(name: "ahtee", color: .blue)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
}

extension ViewController: MessagesDataSource {
    func numberOfSections(
        in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: member.name, displayName: member.name)
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> MessageType {
            return messages[indexPath.section]
    }
    
    func messageTopLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {
            return 12
    }
    
    func messageTopLabelAttributedText(
        for message: MessageType,
        at indexPath: IndexPath) -> NSAttributedString? {
            return NSAttributedString(
                string: message.sender.displayName,
                attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
}

extension ViewController: MessagesLayoutDelegate {
    func heightForLocation(
        message: MessageType,
        at indexPath: IndexPath,
        with maxWidth: CGFloat,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {
            return 0
    }
}

extension ViewController: MessagesDisplayDelegate {
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) {
            let message = messages[IndexPath]
            let color = message.member.color
            avatarView.backgroundColor = color
    }
}

extension ViewController: MessageInputBarDelegate {
    func messageInputBar(
        _ inputBar: MessageInputBar,
        didPressSendButtonWith text: String) {
            let newMessage = Message(
                member: member,
                text: text,
                messageId: UUID().uuidString)
            messages.append(newMessage)
            inputBar.inputTextView.text = ""
            messagesCollectionView.reloadData()
            messagesCollectionView.scrollToBottom(animated: true)
    }
}
