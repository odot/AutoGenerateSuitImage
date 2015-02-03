# AutoGenerateSuitImage
iOS 美工只提供了一套切图，一个一个改图片大小&amp;改名？ 太麻烦 ！ 适用于提供一套@3x/@2x切图，自动生成其他2套(@2x和最小倍率 @3x和最小倍率)图片


    // 如果提供的切图是@3x的图片 newImagePath＝nil时生成的文件保存在 /Users/odot/Desktop/cut/newImages
    [UIImage generateSuitImagesWithOriginImagePath:@"/Users/todot/Desktop/cut" newImagePath:nil originImageType:DOTOriginImageType3x autoGenerateEnLargeImage:NO];
    
    /*
    // 如果提供的切图是@2x的图片 autoGenerateEnLargeImage＝YES 会自动生成其对应的@3x图片
    [UIImage generateSuitImagesWithOriginImagePath:@"/Users/odot/Desktop/cut2x" newImagePath:nil originImageType:DOTOriginImageType2x autoGenerateEnLargeImage:YES];
    
    // 如果提供的切图是最小倍率的图片 autoGenerateEnLargeImage＝YES 会自动生成其对应的@3x和@2x图片（图片效果不佳）
    [UIImage generateSuitImagesWithOriginImagePath:@"/Users/odot/Desktop/cut2x" newImagePath:nil originImageType:DOTOriginImageType1x autoGenerateEnLargeImage:YES];
     */
