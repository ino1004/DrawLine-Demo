//
//  ViewController.m
//  Demo
//
//  Created by Chui Kam Him on 2016/8/4.
//  Copyright © 2016年 Chui Kam Him. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGPoint lastPoint;
    CGPoint currentPoint;
    CGFloat brush;
    CGFloat opacity;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *drawImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    red = 0/255.0;
    green = 0/255.0;
    blue = 0/255.0;
    brush = 4.0;
    opacity = 1.0;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    currentPoint = [touch locationInView:self.view];
    
    // Draw line
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxt, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(ctxt, currentPoint.x, currentPoint.y);
    CGContextSetLineCap(ctxt, kCGLineCapRound);
    CGContextSetLineWidth(ctxt, brush);
    CGContextSetRGBStrokeColor(ctxt, red, green, blue, opacity);
    //CGContextSetBlendMode(ctxt, kCGBlendModeNormal);
    CGContextStrokePath(ctxt);
    self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    //[self.drawImage setAlpha:opacity];
        
    lastPoint = currentPoint;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    //[self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    [self.drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.drawImage.image = nil;
    UIGraphicsEndImageContext();
    
}

- (IBAction)clearBtnPressed:(id)sender {
    
    self.mainImage.image = nil;
    self.drawImage.image = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
