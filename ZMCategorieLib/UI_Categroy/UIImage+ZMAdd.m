//
//  UIImage+ZMAdd.m
//  ZMArchitecture
//
//  Created by ZM on 16/5/11.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import "UIImage+ZMAdd.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (ZMAdd)

- (void)test {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"imageName" ofType:@"png"];
//    UIImage *image = [UIImage imageWithContentsOfFile:path];
//    // 压缩
//    NSData *imageData = UIImagePNGRepresentation(image);
//    image = [UIImage imageWithData:imageData];
}


#pragma mark -----------------------"  压缩_本地图片，不及时释放内存，加载的比较快  "--------------------
// 图片压缩：PNG
+ (UIImage *)zm_compressPngImageName:(NSString*)imageName
{
	UIImage *image = [UIImage imageNamed:imageName];
	NSData *imageData = UIImagePNGRepresentation(image);
	return [UIImage imageWithData:imageData];
}
// 图片压缩：JPEG		1.0
+ (UIImage *)zm_compressJPEGImageName:(NSString*)imageName {

	UIImage *image = [UIImage imageNamed:imageName];
	NSData *imageData = UIImageJPEGRepresentation(image, (CGFloat) 1.0);
	return [UIImage imageWithData:imageData];
}
// 图片压缩：JPEG  kCompressionQuality
+ (UIImage *)zm_compressImageName:(NSString*)imageName JPEGCompression:(CGFloat)kCompressionQuality {

	UIImage *image = [UIImage imageNamed:imageName];
	NSData *imageData = UIImageJPEGRepresentation(image, kCompressionQuality);
	return [UIImage imageWithData:imageData];
}


#pragma mark -----------------------"  压缩_本地图片，及时释放内存，加载的比较慢  "-----------------------
// PNG
+ (UIImage *)zm_compressBundlePathPngImageName:(NSString*)imageName
{
	NSData *imageData = [self zm_bundlePathImageName:imageName ofType:@"png" JPEGCompression:0];
	return [UIImage imageWithData:imageData];
}
// JPEG	 1.0
+ (UIImage *)zm_compressBundlePathJPEGImageName:(NSString*)imageName {

	NSData *imageData = [self zm_bundlePathImageName:imageName ofType:@"jpg" JPEGCompression:1.0f];
	return [UIImage imageWithData:imageData];
}
// JPEG  kCompressionQuality
+ (UIImage *)zm_compressBundlePathImageName:(NSString*)imageName JPEGCompression:(CGFloat)kCompressionQuality {

	NSData *imageData = [self zm_bundlePathImageName:imageName ofType:@"jpg" JPEGCompression:kCompressionQuality];
	return [UIImage imageWithData:imageData];
}
// 加载本地图片 选择压缩
+ (NSData *)zm_bundlePathImageName:(NSString*)imageName ofType:(nullable NSString *)type JPEGCompression:(CGFloat)kCompress {

	NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:type];
	UIImage *image = [UIImage imageWithContentsOfFile:path];
	NSData *imageData = nil;

	if ([type isEqualToString:@"png"]) {
		imageData = UIImagePNGRepresentation(image);
	}else if ([type isEqualToString:@"jpg"]){
		imageData = UIImageJPEGRepresentation(image, kCompress);
	}
	return imageData;
}

- (UIImage *)zm_bundlepathForResource:(nullable NSString *)imageName  {
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

#pragma mark ------------------"  UIImage 保存\读取_本地沙盒Path"---------------------------------
// 保存图片
- (void)zm_storageImage:(UIImage *)Image withImagePath:(NSString *)ImgPath{

	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSData* imageData= UIImagePNGRepresentation(Image);
	[fileManager createFileAtPath:ImgPath contents:imageData attributes:nil];
}
// 读取图片
- (UIImage *)zm_getImageWithPath:(NSString *)ImgPath{

	NSData*  readData=	[NSData dataWithContentsOfFile:ImgPath];
	UIImage* readImage= [UIImage imageWithData:readData];
	return readImage;
}



#pragma mark ------------------"  UIImage、Base64 互转 "---------------------------------
// UIImage ----> Base64字符
- (NSString *)zm_encodedImageToBase64WithImage:(UIImage *)_image{

	NSData *myData = UIImageJPEGRepresentation(_image, 1.0f);
	NSString *encodedImage = [myData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

	return encodedImage;
}
// Base64字符---> UIImage
- (UIImage *)zm_decodingBase64ToImageWithString:(NSString *)_imageString{

	NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:_imageString options:NSDataBase64DecodingIgnoreUnknownCharacters];
	UIImage* image = [UIImage imageWithData:decodedImageData];

	return image;
}

// 图片压缩
+ (NSData *)zm_compressImageToData:(UIImage *)myimage {
    NSData *imageData = UIImageJPEGRepresentation(myimage, 1.0);
    
    //NSLog(@"-----> data.length_11 = %ld ",(long)imageData.length);
    NSLog(@"----->压缩前大小:%fkb",(float)[imageData length]/1024.0f);
    if (imageData.length>200*1024) {
        
        if (imageData.length>1024*1024*5 && imageData.length<1024*1024*10) {//5M以及以上
            imageData = UIImageJPEGRepresentation(myimage, 0.00002f);
            NSLog(@"-----> //5M以及以上 ");
        }
        else if (imageData.length>1024*1024*3 && imageData.length<1024*1024*5) {//3~5M
            imageData = UIImageJPEGRepresentation(myimage, 0.0001f);
            NSLog(@"-----> //3M以及以上 ");
        }
        else if (imageData.length>1024*1024*1 && imageData.length<=1024*1024*3) {//1~3M
            imageData = UIImageJPEGRepresentation(myimage, 0.005f);
            NSLog(@"-----> //1~3M以及以上 ");
        }
        else if (imageData.length>1024*1024) {//1M以及以上
            imageData = UIImageJPEGRepresentation(myimage, 0.1);
            NSLog(@"-----> //1M以及以上 ");
        }else if (imageData.length>512*1024) {//0.5M-1M
            imageData = UIImageJPEGRepresentation(myimage, 0.2);
            NSLog(@"-----> //0.5M-1M ");
        }else if (imageData.length>216*1024) {//0.25M-0.5M
            imageData = UIImageJPEGRepresentation(myimage, 0.4);
            NSLog(@"-----> //0.25M-0.5M ");
        }
        NSLog(@"----->当前大小:%fkb",(float)[imageData length]/1024.0f);
        return imageData;
    }
    //NSLog(@"----->当前大小:%fkb",(float)[imageData length]/1024.0f);
    return imageData;
}

// 是否是 网络图片
+ (BOOL)zm_isImgURL:(NSString *)imgName {
    if (imgName >0 && imgName!= nil ) {
        if ([imgName hasPrefix:@"http"] | [imgName hasPrefix:@"https"]) {
            return YES;
        }else {
            return NO;
        }
    }else{
        return NO;
    }
}

//等比例压缩
+ (UIImage *)zm_imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {

	UIImage *newImage = nil;
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = size.width;
	CGFloat targetHeight = size.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
	if(CGSizeEqualToSize(imageSize, size) == NO){
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		if(widthFactor > heightFactor){
			scaleFactor = widthFactor;
		}
		else{
			scaleFactor = heightFactor;
		}
		scaledWidth = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		if(widthFactor > heightFactor){
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		}else if(widthFactor < heightFactor){
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}

	UIGraphicsBeginImageContext(size);
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	[sourceImage drawInRect:thumbnailRect];
	newImage = UIGraphicsGetImageFromCurrentImageContext();

	if(newImage == nil){
		NSLog(@"scale image fail");
	}
	UIGraphicsEndImageContext();
	return newImage;
}




/**
 *   采用平铺方式放大图片
 *
 *  @param imgName 图片名
 *  @return 放大后的图片
 */
+ (instancetype)zm_resizeImage:(NSString *) imgName
{
	UIImage *img = [UIImage imageNamed:imgName];
	return  [img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height * 0.5 , img.size.width * 0.5 , img.size.height * 0.5 , img.size.width * 0.5)];
}

#pragma mark 返回拉伸好的图片
+ (UIImage *)zm_stretchableImage:(NSString *)imgName {
    return [[UIImage imageNamed:imgName] zm_stretchableImage];
}

- (UIImage *)zm_stretchableImage
{
    CGFloat leftCap = self.size.width * 0.5f;
    CGFloat topCap = self.size.height * 0.5f;
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

/**
 */
+ (instancetype)zm_circleImageWithName:(NSString *) name borderWidth:(CGFloat) borderWidth borderColor:(UIColor *) borderColor
{
	// 1.加载原图
	UIImage *oldImage = [UIImage imageNamed:name];

	// 2.开启上下文
	CGFloat borderW = borderWidth;  // 圆环的宽度
	CGFloat imageW = oldImage.size.width + 2 *borderW;
	CGFloat imageH = oldImage.size.height + 2 * borderW;
	CGSize imageSize = CGSizeMake(imageW, imageH);
	UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);

	// 3.取得当前上下文
	CGContextRef ctx  = UIGraphicsGetCurrentContext();
	// 画边框(大圆)
	[borderColor set];
	CGFloat bigRadius = imageW * 0.5;
	CGFloat centerX = bigRadius;
	CGFloat centerY = bigRadius;
	// 4.绘制圆形
	CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
	CGContextFillPath(ctx);

	CGFloat smallRadius = bigRadius - borderW;
	CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
	// 裁剪
	CGContextClip(ctx);
	[oldImage drawInRect:CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height)];
	// 5.按照当前的路径形状(圆形)裁剪,超出这个形状以外的内容都不显示
	// CGContextClip(ctx);
	// 6. 画图
	// [oldImage drawInRect:circleRect];
	// 7. 取图
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	// 8.结束
	UIGraphicsEndImageContext();

	return newImage;
}

+ (instancetype)zm_captureWithView:(UIView *)view
{
	// 1.开启上下文
	UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
	// 2.将控制器的view的layer渲染到上下文
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	// 3.取出图片
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	// 4.结束上下文
	UIGraphicsEndImageContext();

	return newImage;
}


//重新绘制图片的尺寸
- (UIImage*)zm_imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	NSData *imageData = UIImageJPEGRepresentation(newImage, 0.05);
	UIImage *needImage = [[UIImage alloc] initWithData:imageData];
	
	return needImage;
}


// 视频根据url获取第一帧图片,获取任一帧图片
+ (UIImage*)zm_thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {

    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
        UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    return thumbnailImage;
}



@end
