//
//  CollectionViewCell.m
//  Zoho_iOS Task
//
//  Created by Suresh Kumar on 01/04/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(void)setupView:(NSString*)imageName{
    
    [self.cornerView.layer setCornerRadius:5.0];
    [self.imageView.layer setCornerRadius:5.0];
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
