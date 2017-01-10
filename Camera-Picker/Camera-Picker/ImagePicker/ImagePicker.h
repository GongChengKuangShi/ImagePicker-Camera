//
//  ImagePicker.h
//  Camera-Picker
//
//  Created by Apple on 2017/1/10.
//  Copyright © 2017年 mgjr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ImagePickerType){
    ImagePickerTypeCamera = 1,
    ImagePickerTypeNone,
};

typedef void (^ImagePickerFinishAction)(UIImage *image);

@interface ImagePicker : NSObject

@property (assign, nonatomic) ImagePickerType type;



/**
 @param viewController  用于present UIImagePickerController对象
 @param allowsEditing   是否允许用户编辑图像
 */
+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(ImagePickerFinishAction)finishAction;
@end
