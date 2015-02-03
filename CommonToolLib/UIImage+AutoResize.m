//
//  UIImage+AutoResize.m
//  CommonToolLib
//
//  Created by to2dot@qq.com on 15/2/2.
//  Copyright (c) 2015年 todot. All rights reserved.
//

#import "UIImage+AutoResize.h"

@implementation UIImage(AutoResize)

// 创建目录
+ (BOOL)createDirectory:(NSString*)directory
{
    NSError* error = nil;
    BOOL isCreatDirSucc = [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
    if (!isCreatDirSucc && !error) {
        NSLog(@"创建%@目录失败：%@", directory, error);
        return NO;
    } else {
        NSLog(@"创建%@目录成功", directory);
        return YES;
    }
}

// 检测目录是否存在
+ (BOOL)isDirectoryExist:(NSString*)directory
{
    BOOL isDir = NO;
    
    // 如果目录不存在则创建目录
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:&isDir];
    if (!isDirExist && !isDir) {
        if ([self createDirectory:directory] == NO) {
            return NO;
        }
    }
    isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:directory];
    
    return isDirExist;
}

+ (UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

// 按照倍数缩放
+ (UIImage*)originImage:(UIImage *)image scaleWithMultiple:(CGFloat)multiple
{
    CGSize size = image.size;
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width * multiple, size.height * multiple)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (void)generateSuitImagesWithOriginImagePath:(NSString*)originPath
                                 newImagePath:(NSString*)newPath
{
    [self generateSuitImagesWithOriginImagePath:originPath newImagePath:newPath originImageType:DOTOriginImageType3x autoGenerateEnLargeImage:NO];
}

+ (void)generateSuitImagesWithOriginImagePath:(NSString*)originPath
                                 newImagePath:(NSString*)newPath
                              originImageType:(DOTOriginImageType)originImageType
{
    [self generateSuitImagesWithOriginImagePath:originPath newImagePath:newPath originImageType:originImageType autoGenerateEnLargeImage:NO];
}

/*
 * 提供一套图片 自动生成多套图片 （如美工只提供了一套@3x图片，调用此函数自动生成@2x和最小倍率的图片）
 *
 * @param originPath        原始图片的路径
 * @param newPath           生成后的图片路径，可以为nil，为nil则生成后的图片自动保存在 originPath/newImages 下
 * @param originImageType   原始图片类型（@3x、@2x、@1x，当然@1x后缀是不存在的）
 * @param autoEnLarge       是否自动放大（当提供的图片类型不是@3x时，enLarge=YES会自动生成@3x类型的图片）
 *
 * @return void
 */

+ (void)generateSuitImagesWithOriginImagePath:(NSString*)originPath
                                 newImagePath:(NSString*)newPath
                              originImageType:(DOTOriginImageType)originImageType
                     autoGenerateEnLargeImage:(BOOL)enLarge
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:originPath isDirectory:&isDir];
    if (isDir == NO || isDirExist == NO) {
        NSLog(@"%@ %@不存在", NSStringFromClass([self class]), originPath);
        return;
    }
    
    NSString* newImagePath = [NSString stringWithFormat:@"%@", newPath];
    
    if (newPath == nil || newPath.length == 0) {
        newImagePath = [originPath stringByAppendingPathComponent:@"newImages"];
    }
    
    // 判读目录是否存在 不存在则创建
    if ([self isDirectoryExist:newImagePath] == NO) {
        NSLog(@"%@ %@不存", NSStringFromClass([self class]), newImagePath);
        return;
    }
    
    NSString* tmpImagePath = [newImagePath stringByAppendingPathComponent:@"tmp"];
    if ([self isDirectoryExist:tmpImagePath] == NO) {
        NSLog(@"%@ 创建临时目录[%@]失败", NSStringFromClass([self class]), tmpImagePath);
        return;
    }
   
    // 遍历目录下的文件
    NSDirectoryEnumerator* direnum = [fileManager enumeratorAtPath:originPath];
    NSMutableArray *files = [NSMutableArray array];
    NSString *filename ;
    while (filename = [direnum nextObject]) {
        if ([[filename pathExtension] isEqualToString:@"png"]) {
            [files addObject: filename];
        }
    }
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), files);
    
    for (NSString* filename in files) {
        NSString* prefix = [[filename componentsSeparatedByString:@"."] objectAtIndex:0];
        
        
        NSString* filePrefix = [NSString stringWithString:prefix];
        NSRange range = [prefix rangeOfString:@"@"];
        if (range.length != 0) {
            //如果包含@符号 剔除 @3x, @2x等字符
            filePrefix = [[prefix componentsSeparatedByString:@"@"] objectAtIndex:0];
        }
        
        
        // 临时目录
        NSString* oldPath = [originPath stringByAppendingPathComponent:filename];
        NSString* tmpNewImagePath = [[tmpImagePath stringByAppendingPathComponent:filePrefix] stringByAppendingPathExtension:@"png"];
        
        NSString* bigPath = [[newImagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@3x", filePrefix]] stringByAppendingPathExtension:@"png"];
        NSString* middlePath = [[newImagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x", filePrefix]] stringByAppendingPathExtension:@"png"];
        NSString* smallPath = [[newImagePath stringByAppendingPathComponent:filePrefix] stringByAppendingPathExtension:@"png"];

        /*
         必须先将 图片名中包含@3x/@2x的图片移动并重命名为没有@3x/@2x的图片（如果不重命名，会导致计算加载正确的图片），然后再缩放
         
         涉及到UIImage加载行为
         */
        NSError* error = nil;
        
        BOOL copySucc = [[NSFileManager defaultManager] copyItemAtPath:oldPath toPath:tmpNewImagePath error:&error];
        if (copySucc && error == nil) {
            if (originImageType == DOTOriginImageType3x) {
                [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:bigPath WithMultiple:1.0];
                [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:middlePath WithMultiple:0.667];
                [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:smallPath WithMultiple:0.334];
                
            } else if (originImageType ==DOTOriginImageType2x) {
                [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:middlePath WithMultiple:1.0];
                [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:smallPath WithMultiple:0.5];
                if (enLarge == YES) {
                    [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:bigPath WithMultiple:1.5];
                }
                
            } else if (originImageType == DOTOriginImageType1x) {
                [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:smallPath WithMultiple:1.0];
                
                if (enLarge == YES) {
                    [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:middlePath WithMultiple:2.0];
                    [self saveResizedImageWithOriginPath:tmpNewImagePath toNewPath:bigPath WithMultiple:3.0];
                }
            }
        }
    }
}

+ (BOOL)saveResizedImageWithOriginPath:(NSString*)originPath toNewPath:(NSString*)newPath WithMultiple:(CGFloat)multiple
{
    UIImage* originImage = [UIImage imageNamed:originPath];
    
    CGSize newSize = CGSizeMake(originImage.size.width * multiple, originImage.size.height * multiple);
    UIImage* newImage = [self originImage:originImage scaleToSize:newSize];
    
    BOOL scaleSucc = [UIImagePNGRepresentation(newImage) writeToFile:newPath atomically:YES];
    if (scaleSucc == YES) {
        NSLog(@"%lf:%@---->%@成功", multiple, originPath, newPath);
    }
    return scaleSucc;
}

@end
