//
//  UHAlertviewSuperVC.h
//  Pods
//
//  Created by xiaoqy on 16/9/7.
//
//

#import <UIKit/UIKit.h>

@interface UHAlertviewSuperVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *coniew;

typedef void(^UHAlertClickBlock)(id  sender ,UIViewController *info);

@property(copy, nonatomic) UHAlertClickBlock clickBlock;

-(void)reloadViewWith:(NSDictionary*)dic;


- (IBAction)alertClicked:(UIButton *)sender forEvent:(UIEvent *)event;

@end
