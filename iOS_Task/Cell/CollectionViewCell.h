//
//  CollectionViewCell.h
//  Zoho_iOS Task
//
//  Created by Suresh Kumar on 01/04/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cornerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
-(void)setupView:(NSString*)imageName;

@end
