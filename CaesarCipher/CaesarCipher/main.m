//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaesarCipher : NSObject
// Methods
- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;


//Mike said to make this... WHYYyyy
-(BOOL) codeBreaker:(NSString *) firstString with:(NSString *) secondString;
@end


@implementation CaesarCipher //Class

- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";

    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);

        result[i] = allchars[new_idx];
    }

    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}

-(BOOL) codeBreaker:(NSString *) firstString with:(NSString *) secondString;{
    
    for (int i = 1; i < 25; i++) {
        
        NSString * decode = [self decode: firstString offset:(i)];
        
        for (int a = 1; a < 25; a++) {
            NSString * decoded = [self decode: secondString offset:(a)];
            
            if ([decode isEqualToString:decoded]){
                NSLog(@"%@ = '%@' offset: %d", firstString, decode, i);
                NSLog(@"%@ = '%@' offset: %d", secondString, decoded, a);
                return YES;
        }
    }
}
    return 0;
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        CaesarCipher *c = [[CaesarCipher alloc] init];
        [c codeBreaker:@"chris" with:@"David"];
        
        NSString *test = @"My name is Chris";
        
        NSLog(@"%@",test);
    }
}
