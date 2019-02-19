//
//  SCUpdateContactViewController.h
//  Contacts
//
//  Created by Stephen Cao on 18/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCNewContactPerson.h"
@class SCUpdateContactViewController;
NS_ASSUME_NONNULL_BEGIN
@protocol SCUpdateContactViewControllerDelegate <NSObject>
-(void)updateConcactWithController:(SCUpdateContactViewController *)controller andWithContact:(SCNewContactPerson *)person;
@end
@interface SCUpdateContactViewController : UIViewController
@property(nonatomic,strong)SCNewContactPerson *person;
@property(nonatomic,weak)id<SCUpdateContactViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
