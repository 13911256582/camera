//
//  ViewController.m
//  camera
//
//  Created by ShaoLing on 5/1/14.
//  Copyright (c) 2014 dastone.cn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (IBAction)takeImage:(id) sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.allowsEditing = YES;
        
        _imagePicker.cameraOverlayView = [self customOverlayerView];
        _imagePicker.showsCameraControls = NO;
        
        CGFloat camScaleup = 1.8;
        
        _imagePicker.cameraViewTransform = CGAffineTransformScale(_imagePicker.cameraViewTransform, camScaleup, camScaleup);
        
        [self presentViewController:_imagePicker animated:YES completion: nil];
    }
    else{
        NSLog(@"camer is not available");
    }
}


- (UIView *)customOverlayerView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,568)];
    
    UIButton *shootPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(180, 500, 120, 44)];
    
    shootPictureButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    
    [shootPictureButton setTitle:@"拍摄"  forState: UIControlStateNormal];
    [shootPictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shootPictureButton addTarget:_imagePicker action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:shootPictureButton];
     
     
    return view;
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageView.image = originalImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"selector is ending");
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"selector is starting");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
