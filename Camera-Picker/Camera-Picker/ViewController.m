//
//  ViewController.m
//  Camera-Picker
//
//  Created by Apple on 2017/1/10.
//  Copyright © 2017年 mgjr. All rights reserved.
//

#import "ViewController.h"
#import "ImagePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)touchButtonAction:(UIButton *)sender {
    [ImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        [sender setBackgroundImage:image forState:UIControlStateNormal];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
