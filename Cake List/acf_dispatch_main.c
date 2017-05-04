//
//  acf_dispatch_main.c
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//  Copyright © 2017 Stewart Hart. All rights reserved.
//

#include "acf_dispatch_main.h"

void acf_dispatch_main(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
    
}

