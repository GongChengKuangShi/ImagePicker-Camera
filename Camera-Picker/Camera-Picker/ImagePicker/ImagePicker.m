//
//  ImagePicker.m
//  Camera-Picker
//
//  Created by Apple on 2017/1/10.
//  Copyright © 2017年 mgjr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePicker.h"

@interface ImagePicker ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) UIViewController *viewController;
@property (copy, nonatomic) ImagePickerFinishAction finishAction;
@property (assign, nonatomic) BOOL allowsEditing;

@end

static ImagePicker *bdImagePickerInstance = nil;

@implementation ImagePicker

+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(ImagePickerFinishAction)finishAction {
    
    if (bdImagePickerInstance == nil) {
        bdImagePickerInstance = [[ImagePicker alloc] init];
    }
    
    [bdImagePickerInstance showImagePickerFromViewController:viewController
                                               allowsEditing:allowsEditing finishAction:finishAction];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(ImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self setAlertAction:alertController title:@"取消" style:UIAlertActionStyleCancel];
        [self setAlertAction:alertController title:@"拍照" style:UIAlertActionStyleDefault];
        [self setAlertAction:alertController title:@"从相册选择" style:UIAlertActionStyleDefault];
    } else {
        [self setAlertAction:alertController title:@"取消" style:UIAlertActionStyleCancel];
        [self setAlertAction:alertController title:@"从相册选择" style:UIAlertActionStyleDefault];
    }
    [_viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)setAlertAction:(UIAlertController *)alertController title:(NSString *)title  style:(UIAlertActionStyle)style{
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
        [self setImagePickerController:title];
    }];
    [alertController addAction:action];
}

- (void)setImagePickerController:(NSString *)title {
    if ([title isEqualToString:@"从相册选择"]) {
        
        [self isCamere:NO];
        
    } else if ([title isEqualToString:@"拍照"]) {
        
        [self isCamere:YES];
        
    } else {
        bdImagePickerInstance = nil;
    }
}

- (void)isCamere:(BOOL)isCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if (isCamera) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = _allowsEditing;
    } else {
        picker.allowsEditing = YES;
    }
    [_viewController presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    if (_finishAction) {
        _finishAction(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    bdImagePickerInstance = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (_finishAction) {
        _finishAction(nil);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    bdImagePickerInstance = nil;
}

@end
