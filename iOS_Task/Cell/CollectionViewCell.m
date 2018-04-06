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
    
    [self.layer setCornerRadius:10.0];
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
