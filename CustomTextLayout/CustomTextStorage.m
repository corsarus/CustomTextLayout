//
//  CustomTextStorage.m
//  CustomTextLayout
//
//  Created by Catalin (iMac) on 21/04/2015.
//  Copyright (c) 2015 corsarus. All rights reserved.
//

#import "CustomTextStorage.h"

@interface CustomTextStorage ()

@property (nonatomic, strong) NSTextStorage *textContent;

@end

@implementation CustomTextStorage

- (instancetype)init
{
    if (self = [super init]) {
        NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tempus condimentum mi, tempus ultrices diam vehicula ac. Suspendisse potenti. Etiam vel velit arcu. Aliquam ultricies malesuada elit. Integer diam magna, vehicula quis iaculis nec, efficitur sed nulla. Phasellus mattis, lectus efficitur tristique auctor, libero ligula facilisis sem, a aliquet arcu nisl ut orci. Ut placerat ligula id diam hendrerit consectetur. Vivamus varius justo vitae luctus dignissim.\n\nMauris augue nunc, elementum id mauris at, facilisis lobortis orci. Proin at dolor et est elementum imperdiet. Duis id augue bibendum, mollis turpis id, vulputate quam. Fusce laoreet varius ante, sed ullamcorper erat fermentum vel. Pellentesque vestibulum maximus tellus, vitae facilisis nunc tempor non. Phasellus aliquam enim urna, vel mollis elit scelerisque sed. Nunc luctus facilisis enim eu tristique. Praesent ultrices, libero eget mollis rhoncus, urna neque fringilla sem, tempus sagittis nibh ipsum in neque. Etiam cursus viverra nunc pharetra commodo. Morbi aliquam vel ligula a sodales. Ut elementum est at venenatis fringilla. Nam vitae facilisis dui, id sodales dolor. Sed massa urna, tincidunt sed elit ut, sollicitudin pulvinar turpis. Aliquam sed magna ac nisl pellentesque consectetur quis at velit. Donec egestas consectetur purus eget suscipit.\n\nInteger vitae odio nisi. Duis eget sem sagittis, venenatis quam vitae, luctus velit. Vestibulum vel mi ut neque dignissim aliquam. In rhoncus purus diam, eu bibendum enim ultricies sit amet. Etiam at mi massa. Donec dignissim gravida massa, eu ultricies erat tristique id. Morbi gravida erat vitae sem gravida porttitor. Praesent id lorem neque. Maecenas tincidunt finibus aliquet. Donec nunc nisi, finibus ac tellus sed, posuere aliquet erat. Phasellus sit amet sem tincidunt eros ullamcorper ornare. Praesent suscipit tellus a ante mattis condimentum.\n\nVivamus dictum urna elit, a pharetra augue hendrerit eu. Morbi ullamcorper mollis auctor. Nullam aliquet, elit non ultrices dapibus, mauris augue imperdiet ligula, finibus mollis magna magna at nulla. Fusce tempor nibh ac neque lacinia, sit amet consectetur elit posuere. Morbi ultrices sapien eu laoreet molestie. Maecenas ut justo aliquam enim aliquam hendrerit. Curabitur aliquet mauris vel nisi elementum bibendum. Sed nunc justo, tincidunt vel scelerisque at, sollicitudin ut lectus. Sed magna risus, rhoncus maximus finibus ac, fermentum et enim. Curabitur nec tortor non ligula iaculis feugiat ac ut quam. Quisque ut volutpat mauris. Vestibulum hendrerit lorem quis nisl interdum consectetur. Nam lacinia tristique tortor non dapibus. Cras vel fermentum felis, quis gravida nisi.\n\nCras a suscipit ipsum, at ultrices magna. Quisque vulputate consequat lorem, nec aliquam risus lobortis in. Mauris nec justo mauris. Vestibulum nec rhoncus lorem, non ultrices massa. Duis sit amet nisl commodo, pretium diam sed, malesuada turpis. Vestibulum vehicula risus nec erat lobortis, eget rutrum tellus scelerisque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis eget malesuada massa. ";
        
        self.textContent = [[NSTextStorage alloc] initWithString:text];
    }
    
    return self;
}

#pragma mark - NSTextStorage

- (NSString *)string
{
    return self.textContent.string;
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [self.textContent attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [self.textContent replaceCharactersInRange:range withString:str];
    
    // Notify the text layout manager abvout changes in the text storage
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    [self.textContent setAttributes:attrs range:range];
    
    // Notify the text layout manager abvout changes in the text storage
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:0];
}



@end
