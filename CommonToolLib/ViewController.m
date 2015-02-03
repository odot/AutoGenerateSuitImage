//
//  ViewController.m
//  CommonToolLib
//
//  Created by to2dot@qq.com on 15/1/29.
//  Copyright (c) 2015年 todot. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+AutoResize.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 如果提供的切图是@3x的图片 newImagePath＝nil时生成的文件保存在 /Users/odot/Desktop/cut/newImages
    [UIImage generateSuitImagesWithOriginImagePath:@"/Users/todot/Desktop/cut" newImagePath:nil originImageType:DOTOriginImageType3x autoGenerateEnLargeImage:NO];
    
    /*
    // 如果提供的切图是@2x的图片 autoGenerateEnLargeImage＝YES 会自动生成其对应的@3x图片
    [UIImage generateSuitImagesWithOriginImagePath:@"/Users/odot/Desktop/cut2x" newImagePath:nil originImageType:DOTOriginImageType2x autoGenerateEnLargeImage:YES];
    
    // 如果提供的切图是最小倍率的图片 autoGenerateEnLargeImage＝YES 会自动生成其对应的@3x和@2x图片（图片效果不佳）
    [UIImage generateSuitImagesWithOriginImagePath:@"/Users/odot/Desktop/cut2x" newImagePath:nil originImageType:DOTOriginImageType1x autoGenerateEnLargeImage:YES];
     */
}



@end
