//
//  ViewController.m
// iOS_Task
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

enum flag{
    
    increment,
    decrement
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

@property (weak, nonatomic) IBOutlet UILabel *plantInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *waterDropImageView;


@property (nonatomic,assign) int flag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *tabBar = [self.tabBarController.tabBar.items objectAtIndex:0];
    [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    _imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
    [self setupView];
}

-(void)setupView{
    
    _plantScreenSize = halfScreen;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(planetViewTapped)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.plantView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *detailViewTapGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(detailViewTapped:)];
    [_detailsView addGestureRecognizer:detailViewTapGesture];
    
    UITapGestureRecognizer *waterViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(waterViewTapped)];
    [_waterAnimationView addGestureRecognizer:waterViewTapGesture];
    [_waterAnimationView.layer setCornerRadius:15.0];
    
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


-(void)detailViewTapped:(UIPanGestureRecognizer*)recognizer{
    
    __block int height = 0 ;
    
    
   CGPoint point = [recognizer locationInView:self.detailsView];
    
    if(_detailViewScreenSize == halfScreen){
        _detailViewScreenSize = fullScreen;
        [self backgroundViewZoomInAnimation];
        height = 300;
        _detailViewHeightConstraint.constant = height;
        _nextWaterinLabeltopconstraint.constant = 150;
        [self resetAlphaValue];
         [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
              [self.view layoutIfNeeded];
         } completion:^(BOOL finished) {
        
        }];
        [self performSelector:@selector(contentAnimation) withObject:nil afterDelay:0.3];
    }else{
        height = 110;
        _detailViewScreenSize = halfScreen;
       _nextWaterinLabeltopconstraint.constant = 5;
      _detailViewHeightConstraint.constant = height;
      [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      [self changeDayAnimation:1 withFlag:increment];
        [self.view layoutIfNeeded];
     } completion:^(BOOL finished) {
        
    }];
    }
    NSLog(@"%f, %f",point.x,point.y);
//    if(_detailViewScreenSize == halfScreen){
//        [self backgroundViewZoomInAnimation];
//        _detailViewScreenSize = fullScreen;
//         height = 300;
//        _detailViewHeightConstraint.constant = height;
//        _nextWaterinLabeltopconstraint.constant = 150;
//        [self resetAlphaValue];
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//          [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//
//        }];
//        [self performSelector:@selector(contentAnimation) withObject:nil afterDelay:0.3];
//    }else{
//        NSArray *array =[[NSArray alloc]initWithObjects:@1,@0.7,@0.5,@0.3,@0.1,@0,nil];
//        [self resetPlanInfoViewAnimation];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [self showWaterInfoViewAnimation:array withAlphavalue:0.0];
//            _nextWaterinLabeltopconstraint.constant = 150;
//            [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//                        [self.view layoutIfNeeded];
//                        [self backgroundViewZoomOutAnimation];
//            } completion:^(BOOL finished) {
//            }];
//
//            _detailViewScreenSize = halfScreen;
//            height = 110;
//            _nextWaterinLabeltopconstraint.constant = 5;
//            _detailViewHeightConstraint.constant = height;
//            [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//                [self changeDayAnimation:1 withFlag:increment];
//                [self.view layoutIfNeeded];
//            } completion:^(BOOL finished) {
//
//            }];
//
//        });
//
//    }
    
}

-(void)waterViewTapped{
    
    //[self detailViewTapped];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self changeDayAnimation:7 withFlag:decrement];
    });
}

-(void)changeDayAnimation:(int) i withFlag:(int)flag {
    __block int value = i;
    
    if(flag == increment){
        value = value+1;
    }else{
        value = value -1;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSString *days = value == 1? @"day":@"days";
        _dayLabel.text = [NSString stringWithFormat:@"%d %@",value,days];
        if((value <= 6)&&(value >1)){
        [self changeDayAnimation:value withFlag:flag];
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                if(flag == increment){
                    _waterDropImageView.image = [UIImage imageNamed:@"check-mark_icon"];
                    _waterAnimationView.layer.borderColor = [UIColor colorWithRed:47.0/255.0 green:188.0/255.0 blue:167.0/255.0 alpha:1.0].CGColor;
                    UIColor *fromColor = [UIColor colorWithRed:47.0/255.0 green:188.0/255.0 blue:167.0/255.0 alpha:1.0];
                    _waterAnimationView.layer.borderWidth = 2.0;
                    [self backGroundColorAnimation:fromColor withToColor:[UIColor whiteColor]];
                    _waterAnimationView.backgroundColor = [UIColor whiteColor];
                    
                }else{
                    _waterDropImageView.image = [UIImage imageNamed:@"raindrop_icon"];
                    UIColor *toColor = [UIColor colorWithRed:47.0/255.0 green:188.0/255.0 blue:167.0/255.0 alpha:1.0];
                    _waterAnimationView.layer.borderColor = [UIColor whiteColor].CGColor;
                    _waterAnimationView.layer.borderWidth = 2.0;
                    [self backGroundColorAnimation:[UIColor whiteColor] withToColor:toColor];
                    _waterAnimationView.backgroundColor = toColor;
                }
            });
            
   }
    });
    
}

-(void)backGroundColorAnimation:(UIColor*)fromColor withToColor:(UIColor*)toColor{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = fromColor;
    animation.toValue = toColor;
    animation.duration = 1.0;
    [_waterAnimationView.layer addAnimation:animation forKey:@"backgroundColor"];
    
}

-(void)contentAnimation{
    
    _nextWaterinLabeltopconstraint.constant = 5;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self resetAlphaValue];
        NSArray *array =[[NSArray alloc]initWithObjects:@0,@0.1,@0.3,@0.5,@0.7,@1,nil];
        [self showWaterInfoViewAnimation:array withAlphavalue:1.0];
        [self performSelector:@selector(setPlanInfoAnimation) withObject:nil afterDelay:0.1];
       
    }];
}


-(void)setPlanInfoAnimation{
    NSArray *array =[[NSArray alloc]initWithObjects:@0,@0.1,@0.3,@0.5,@0.7,@1,nil];
    [self showPlantInfoViewAnimation:array withLayer:_plantInfoLabel.layer];
    _plantInfoLabel.alpha = 1.0;
    [self showPlantInfoViewAnimation:array withLayer:_temperatureLabel.layer];
    _temperatureLabel.alpha = 1.0;
    [self showPlantInfoViewAnimation:array withLayer:_humidityLabel.layer];
    _humidityLabel.alpha = 1.0;
    [self showPlantInfoViewAnimation:array withLayer:_lightLabel.layer];
    _lightLabel.alpha = 1.0;
    [self showPlantInfoViewAnimation:array withLayer:_segmentControl.layer];
    _segmentControl.alpha = 1.0;
}

-(void)resetPlanInfoViewAnimation{
    
    NSArray *array =[[NSArray alloc]initWithObjects:@1,@0.7,@0.5,@0.3,@0.1,@0,nil];
    [self showPlantInfoViewAnimation:array withLayer:_plantInfoLabel.layer];
    _plantInfoLabel.alpha = 0.0;
    [self showPlantInfoViewAnimation:array withLayer:_temperatureLabel.layer];
    _temperatureLabel.alpha = 0.0;
    [self showPlantInfoViewAnimation:array withLayer:_humidityLabel.layer];
    _humidityLabel.alpha = 0.0;
    [self showPlantInfoViewAnimation:array withLayer:_lightLabel.layer];
    _lightLabel.alpha = 0.0;
    [self showPlantInfoViewAnimation:array withLayer:_segmentControl.layer];
    _segmentControl.alpha = 0.0;
    
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

-(void)showPlantInfoViewAnimation:(NSArray*)value withLayer:(CALayer*)layer{
    [layer removeAllAnimations];
    CAKeyframeAnimation *plantInfoAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    plantInfoAnimation.values = value;
    plantInfoAnimation.duration = 0.3;
    plantInfoAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:plantInfoAnimation forKey:@"opacity"];
    
}


-(void)resetAlphaValue{
    
     _plantInfoLabel.alpha = 0;
     _waterInfoTextLabel.alpha = 0;
     _waterInfoTitleLabel.alpha = 0;
     _segmentControl.alpha = 0;
    _temperatureLabel.alpha = 0;
    _humidityLabel.alpha = 0;
    _lightLabel.alpha = 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
