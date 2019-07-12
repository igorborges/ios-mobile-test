//
//  Initializer.m
//  ShoppingAppUITests
//
//  Created by Igor Borges Resende on 11/07/19.
//  Copyright © 2019 Shyam Pindoria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingAppUITests-Swift.h"

__attribute__((constructor))
void CucumberishInit()
{
    [CucumberishInitializer CucumberishSwiftInit];
}
