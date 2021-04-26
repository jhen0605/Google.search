//
//  CALayer+border_Color.m
//  Google search
//
//  Created by 簡吟真 on 2021/4/27.
//

#import "CALayer+border_Color.h"
#import <UIKit/UIKit.h>
@implementation CALayer (borderColor)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
 self.borderColor = color.CGColor;
}@end
