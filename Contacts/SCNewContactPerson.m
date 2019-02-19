//
//  SCNewContactPerson.m
//  Contacts
//
//  Created by Stephen Cao on 18/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "SCNewContactPerson.h"

@implementation SCNewContactPerson
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_tel forKey:@"tel"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _name = [aDecoder decodeObjectForKey:@"name"];
        _tel = [aDecoder decodeObjectForKey:@"tel"];
    }
    return self;
}
@end
