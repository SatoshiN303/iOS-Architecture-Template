//
//  UserTableViewCell.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell, Reusable {
    static let rowHeight: CGFloat = 150
    private var task: URLSessionTask?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        task = nil
        nameLabel.text = nil
        iconImageView?.image = nil
    }
    
    func configure(with user: User) {
        
        nameLabel.text = user.login
        
        //NOTE: Don't use it in the product version. It reuses using the image cache.
        let completion: ((Data?, URLResponse?, Error?) -> Void) = { [weak self] data, response, error  in
            guard let imageData = data else { return }
            DispatchQueue.global().async {
                guard let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                    self?.setNeedsLayout()
                }
            }
        }
        
        task = {
            let url = user.avatarURL
            let task = URLSession.shared.dataTask(with: url, completionHandler: completion)
            task.resume()
            return task
        }()
    }
}
