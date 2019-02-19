//
//  SCNewContactPerson.h
//  Contacts
//
//  Created by Stephen Cao on 18/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCNewContactPerson : NSObject <NSCoding>
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* tel;
@end

NS_ASSUME_NONNULL_END
