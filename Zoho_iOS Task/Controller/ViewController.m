//
//  ViewController.m
//  Zoho_iOS Task
//
//  Created by Suresh Kumar on 29/03/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

enum screenSize
{
    halfScreen,
    fullScreen
};


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *plantView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *planetViewHeightConstraint;
@property (strong, nonatomic) NSMutableArray *imageArray;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) int plantScreenSize;
@property (nonatomic, assign) int detailViewScreenSize;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (weak, nonatomic) IBOutlet UIView *waterAnimationView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *waterInfoViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *waterInfoView;
@property (weak, nonatomic) IBOutlet UILabel *waterInfoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *waterInfoTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextWaterinLabeltopconstraint;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *tabBar = [self.tabBarController.tabBar.items objectAtIndex:0];
    [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    _imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);

    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background Image"]];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
}

-(void)setupView{
    
    _plantScreenSize = halfScreen;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(planetViewTapped)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.plantView addGestureRecognizer:tapGesture];
    UITapGestureRecognizer *detailViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailViewTapped)];

    [detailViewTapGesture setNumberOfTapsRequired:1];
    [_detailsView addGestureRecognizer:detailViewTapGesture];
    
    [_waterAnimationView.layer setCornerRadius:10];
    
    [_plantView.layer setCornerRadius:5.0];
    [_detailsView.layer setCornerRadius:5.0];
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"image_1",@"image_2",@"image_3",@"image_4",@"image_5",nil];
}

-(void)planetViewTapped{
    int height = 0 ;
    
    if(_plantScreenSize == halfScreen){
        [self backgroundViewZoomInAnimation];
        _plantScreenSize = fullScreen;
         height = _plantView.frame.origin.y - (_headerView.frame.origin.y+48);
         height = _plantView.frame.size.height+height;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        [self backgroundViewZoomOutAnimation];
        _plantScreenSize = halfScreen;
        height = 300;
    }
    _planetViewHeightConstraint.constant = height;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];

    } completion:nil];
    
}

-(void)backgroundViewZoomInAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        _imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    } completion:^(BOOL finished) {
    }];
}

-(void)backgroundViewZoomOutAnimation{
    
    [UIView animateWithDuration:0.3  delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
    } completion:^(BOOL finished) {
        
    }];
}


-(void)detailViewTapped{
    
    __block int height = 0 ;
    
    if(_detailViewScreenSize == halfScreen){
        [self backgroundViewZoomInAnimation];
        _detailViewScreenSize = fullScreen;
         height = 300;
        _detailViewHeightConstraint.constant = height;
        _nextWaterinLabeltopconstraint.constant = 150;
        _waterInfoTextLabel.alpha = 0;
        _waterInfoTitleLabel.alpha = 0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
          [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
           
        }];
        [self performSelector:@selector(contentAnimation) withObject:nil afterDelay:0.3];
    }else{
        _nextWaterinLabeltopconstraint.constant = 150;
        NSArray *array =[[NSArray alloc]initWithObjects:@1,@0.7,@0.5,@0.3,@0.1,@0,nil];
        [self showWaterInfoViewAnimation:array withAlphavalue:0.0];
        [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.view layoutIfNeeded];
            [self backgroundViewZoomOutAnimation];
        } completion:^(BOOL finished) {
        }];
        
        _detailViewScreenSize = halfScreen;
         height = 110;
        _nextWaterinLabeltopconstraint.constant = 5;
        _detailViewHeightConstraint.constant = height;
        [UIView animateWithDuration:0.4 delay:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

-(void)contentAnimation{
    
    _nextWaterinLabeltopconstraint.constant = 5;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        _waterInfoTextLabel.alpha = 0;
        _waterInfoTextLabel.alpha = 0;
        NSArray *array =[[NSArray alloc]initWithObjects:@0,@0.1,@0.3,@0.5,@0.7,@1,nil];
        [self showWaterInfoViewAnimation:array withAlphavalue:1.0];
    }];
}

#pragma mark - Collection view data source and delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [_imageArray count];
    
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCellReuseIdentifier" forIndexPath:indexPath];
    [cell setupView:[_imageArray objectAtIndex:indexPath.row]];
    return  cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    int width = screenSize.width/5;
    return CGSizeMake(width,width);
}


#pragma mark - Animation

-(void)showWaterInfoViewAnimation:(NSArray*)value withAlphavalue:(CGFloat)alpha{
    [_waterInfoTitleLabel.layer removeAllAnimations];
    CAKeyframeAnimation *titlekeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    titlekeyFrameAnimation.values = value;
    titlekeyFrameAnimation.duration = 0.3;
    titlekeyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_waterInfoTitleLabel.layer addAnimation:titlekeyFrameAnimation forKey:@"opacity"];
    _waterInfoTitleLabel.alpha = alpha;

    
     [_waterInfoTextLabel.layer removeAllAnimations];
    CAKeyframeAnimation *detailKeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    detailKeyFrameAnimation.values = value;
    detailKeyFrameAnimation.duration = 0.3;
    detailKeyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_waterInfoTextLabel.layer addAnimation:detailKeyFrameAnimation forKey:@"opacity"];
    _waterInfoTextLabel.alpha = alpha;
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
