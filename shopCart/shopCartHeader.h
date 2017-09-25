//
//  shopCartHeader.h
//  shopCart
//
//  Created by 大碗豆 on 17/9/24.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#ifndef shopCartHeader_h
#define shopCartHeader_h


#endif /* shopCartHeader_h */

#import "MJExtension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define ANYColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])

/**随机颜色设置*/
#define ANYColorRandom ANYColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define IMG(name)       [UIImage imageNamed:name]
#define RGB_COLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define alert(text) UIAlertView *infoAlert = [[UIAlertView alloc] initWithTitle:nil message:text delegate:nil   cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];[infoAlert show]
