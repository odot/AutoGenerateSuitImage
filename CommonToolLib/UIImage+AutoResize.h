//
//  UIImage+AutoResize.h
//  CommonToolLib
//
//  Created by to2dot@qq.com on 15/2/2.
//  Copyright (c) 2015年 todot. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *待缩放的图片 原始大小
 * DOTOriginImageType3x imageName@3x.png大小图片 默认
 * DOTOriginImageType2x imageName@2x.png大小图片
 * DOTOriginImageType1x imageName.png大小图片
 */
typedef NS_ENUM(NSInteger, DOTOriginImageType) {
    DOTOriginImageType3x    = 0,
    DOTOriginImageType2x    = 1,
    DOTOriginImageType1x    = 2
};

@interface UIImage(AutoResize)

+ (void)generateSuitImagesWithOriginImagePath:(NSString*)originPath
                                 newImagePath:(NSString*)newPath;

+ (void)generateSuitImagesWithOriginImagePath:(NSString*)originPath
                                 newImagePath:(NSString*)newPath
                              originImageType:(DOTOriginImageType)originImageType;

/*
 * 提供一套图片 自动生成多套图片 （如美工只提供了一套@3x图片，调用此函数自动生成@2x和最小倍率的图片）
 *
 * @param originPath        原始图片的路径
 * @param newPath           生成后的图片路径，可以为nil，为nil则生成后的图片自动保存在 originPath/newImages 下
 * @param originImageType   原始图片类型（@3x、@2x、@1x，当然@1x后缀是不存在的）
 * @param autoEnLarge       是否自动放大（当提供的图片类型不是@3x时，enLarge=YES会自动生成@3x类型的图片）
 *
 * @return 初始化成功则返回BMKActionPaopaoView,否则返回nil
 */

+ (void)generateSuitImagesWithOriginImagePath:(NSString*)originPath
                                 newImagePath:(NSString*)newPath
                              originImageType:(DOTOriginImageType)originImageType
                     autoGenerateEnLargeImage:(BOOL)enLarge;
@end
