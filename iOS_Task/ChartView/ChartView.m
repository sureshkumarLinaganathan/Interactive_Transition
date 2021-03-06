//
//  ChartView.m
//  iOS Task
//
//  Created by Sureshkumar Linganathan on 4/5/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

#import "ChartView.h"

@implementation ChartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextSetLineWidth(context, 1.0f);
   
    CGContextMoveToPoint(context,30.0f, 160.0f);
    
    CGContextAddLineToPoint(context,350.0f, 160.0f);
    
    CGContextMoveToPoint(context,185.0f, 160.0f);
    
    CGContextAddLineToPoint(context,185.0f, 10.0f);
    
    //[self drawText:180 yPosition:73 width:50 height:50 withText:@"11"];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(178, 65,15,15)] CGPath]];
    [circleLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    [circleLayer setFillColor:[[UIColor colorWithRed:33.0/255.0 green:41.0/255.0 blue:51.0/255.0 alpha:0.9] CGColor]];
    [self.layer addSublayer:circleLayer];
    
    CATextLayer *label = [[CATextLayer alloc] init];
    [label setFont:@"Helvetica-Bold"];
    [label setFontSize:8];
    CGRect frame  =  CGRectMake(175, 70, 20, 20);
    [label setFrame:frame];
    [label setString:@"11"];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor whiteColor] CGColor]];
    [self.layer addSublayer:label];
    
    
    
    CGFloat xValue = 35;
    CGFloat yValue = 140;
    CGContextStrokePath(context);
    for(int i=0;i<=20;i=i+5){
    
        NSString *str = i == 0 ?@"1":[@(i) stringValue];
        str = i <10? [NSString stringWithFormat:@" %@",str]:str;
        [self drawText:xValue yPosition:yValue width:25 height:25 withText:str];
        yValue = yValue -35;
    }
    NSArray *array = [[NSArray alloc]initWithObjects:@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun", nil];
    xValue = 40;
    yValue = 165;
    for(int i=0;i<[array count];i++){
        
        [self drawText:xValue yPosition:yValue width:40 height:25 withText:[array objectAtIndex:i]];
        xValue = xValue+45;
    }
    
    NSArray *actualPoints = [[NSArray alloc]initWithObjects:[NSValue valueWithCGPoint:CGPointMake(50,90)],[NSValue valueWithCGPoint:CGPointMake(100,110)],[NSValue valueWithCGPoint:CGPointMake(110,105)],[NSValue valueWithCGPoint:CGPointMake(115,100)],[NSValue valueWithCGPoint:CGPointMake(120,95)],[NSValue valueWithCGPoint:CGPointMake(130,90)],[NSValue valueWithCGPoint:CGPointMake(140,85)],[NSValue valueWithCGPoint:CGPointMake(150,86)],[NSValue valueWithCGPoint:CGPointMake(180,80)],[NSValue valueWithCGPoint:CGPointMake(185,77)],[NSValue valueWithCGPoint:CGPointMake(200,70)],[NSValue valueWithCGPoint:CGPointMake(210,40)],[NSValue valueWithCGPoint:CGPointMake(250,15)],[NSValue valueWithCGPoint:CGPointMake(255,18)],[NSValue valueWithCGPoint:CGPointMake(260,20)],[NSValue valueWithCGPoint:CGPointMake(265,25)],[NSValue valueWithCGPoint:CGPointMake(300,130)],[NSValue valueWithCGPoint:CGPointMake(320,125)],nil];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:3.0];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    NSValue *value = [actualPoints objectAtIndex:0];
    CGPoint p1 = [value CGPointValue];
    [path moveToPoint:p1];
    
    for (int k=1; k<[actualPoints count];k++) {
        
        NSValue *value = [actualPoints objectAtIndex:k];
        CGPoint p2 = [value CGPointValue];
        
        CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
        
        if (p1.y<p2.y) {
            centerPoint = CGPointMake(centerPoint.x, centerPoint.y+(fabs(p2.y-centerPoint.y)));
        }else if(p1.y>p2.y){
            centerPoint = CGPointMake(centerPoint.x, centerPoint.y-(fabs(p2.y-centerPoint.y)));
        }
        
        [path addQuadCurveToPoint:p2 controlPoint:centerPoint];
        p1 = p2;
    }
    
    [[UIColor colorWithRed:47.0/255.0 green:188.0/255.0 blue:167.0/255.0 alpha:1.0]setStroke];
    [path stroke];
    
    
    
}


- (void)drawText:(CGFloat)xPosition yPosition:(CGFloat)yPosition width:(CGFloat)width height:(CGFloat)height withText:(NSString*)text{
    
    CGRect textRect = CGRectMake(xPosition, yPosition, width, height);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 10], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: textStyle};
    [text drawInRect:textRect withAttributes:textFontAttributes];

}

@end
