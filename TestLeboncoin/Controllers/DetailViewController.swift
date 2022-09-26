//
//  DetailViewController.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 25/09/2022.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    let defaultImage = DefaultImage()
    let imageView = UIImageView()
    let titleLabel = TitleLabel()
    let priceLabel = TitleLabel()
    let urgentView = UrgentView()
    let categoryLabel = UILabel()
    let dateLabel = UILabel()
    let descriptionLabel = UILabel()
    
    var detailViewModel: DetailViewModel = DetailViewModel()
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        configure()
        setupListeners()
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor,
                                  leading: view.safeAreaLayoutGuide.leadingAnchor,
                                  trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        let contentStackView = UIStackView()
        contentStackView.backgroundColor = .white
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        scrollView.addSubview(contentStackView)
        contentStackView.setConstraints(top: scrollView.topAnchor,
                                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                                        trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                        bottom: scrollView.bottomAnchor,
                                        padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        
        contentStackView.addArrangedSubview(defaultImage)
        defaultImage.setConstraintHeight(heightConstraint: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
        
        contentStackView.addArrangedSubview(imageView)
        imageView.setConstraintHeight(heightConstraint: defaultImage.widthAnchor)
        
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        contentStackView.addArrangedSubview(imageView)
        
        
        titleLabel.numberOfLines = 0
        contentStackView.addArrangedSubview(titleLabel)
        
        let priceStackView = UIStackView()
        priceStackView.axis = .horizontal
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(urgentView)
        contentStackView.addArrangedSubview(priceStackView)
        
        categoryLabel.textColor = .secondaryLabel
        contentStackView.addArrangedSubview(categoryLabel)
        
        contentStackView.addArrangedSubview(dateLabel)
        
        let descriptionTitleLabel = TitleLabel()
        descriptionTitleLabel.text = "Description"
        contentStackView.addArrangedSubview(descriptionTitleLabel)
        
        descriptionLabel.numberOfLines = 0
        contentStackView.addArrangedSubview(descriptionLabel)
        
        contentStackView.setCustomSpacing(30, after: descriptionLabel)
        
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = Constants.appTintColor
        button.setTitle("Acheter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.boldFontName, size: 20)
        button.setConstraintSize(size: CGSize(width: 0, height: 40))
        contentStackView.addArrangedSubview(button)
    }
    
    func setupListeners() {
        detailViewModel.imageView
            .sink { [weak self] image in
                if image != nil {
                    self?.defaultImage.isHidden = true
                    self?.imageView.isHidden = false
                    self?.imageView.image = image
                }
            }.store(in: &subscriptions)
    }
    
    func configure() {
        guard let classifiedAD = detailViewModel.classifiedAD else { return }
        
        titleLabel.text = classifiedAD.title
        priceLabel.text = detailViewModel.priceString
        categoryLabel.text = detailViewModel.categoryName
        urgentView.isHidden = !classifiedAD.isUrgent
        dateLabel.text = detailViewModel.dateCreationString
        descriptionLabel.text = classifiedAD.description
    }
}
