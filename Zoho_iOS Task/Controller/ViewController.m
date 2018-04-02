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

@property (nonatomic, assign) int plantScreenSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *tabBar = [self.tabBarController.tabBar.items objectAtIndex:0];
    [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background Image"]];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
}

-(void)setupView{
    
    _plantScreenSize = halfScreen;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(planetViewTapped)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.plantView addGestureRecognizer:tapGesture];
    [_plantView.layer setCornerRadius:5.0];
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"image_1",@"image_2",@"image_3",@"image_4",@"image_5",nil];
}

-(void)planetViewTapped{
    int height = 0 ;
    if(_plantScreenSize == halfScreen){
        _plantScreenSize = fullScreen;
     height = _plantView.frame.origin.y - (_headerView.frame.origin.y+48);
     height = _plantView.frame.size.height+height;
    }else{
        _plantScreenSize = halfScreen;
        height = 300;
    }
    _planetViewHeightConstraint.constant = height;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
        
    } completion:nil];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
