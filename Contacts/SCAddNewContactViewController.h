//
//  SCAddNewContactViewController.h
//  Contacts
//
//  Created by Stephen Cao on 18/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCNewContactPerson.h"
@class SCAddNewContactViewController;
NS_ASSUME_NONNULL_BEGIN
@protocol SCAddNewContactViewControllerDelegate <NSObject>
-(void)addNewContactWithController:(SCAddNewContactViewController *)controller andWithNewContactPerson:(SCNewContactPerson *)person;
@end
@interface SCAddNewContactViewController : UIViewController
@property(nonatomic,weak)id<SCAddNewContactViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
