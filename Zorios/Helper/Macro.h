//
//  Macro.h
//  Zorios
//
//  Created by iGitScor on 26/11/2013.
//  Copyright (c) 2013 FlipFlopCrew. All rights reserved.
//

#ifndef Zorios_Macro_h
#define Zorios_Macro_h

#define echo(x) NSLog(@"%@", x)
#define description(x) NSLog(@"(?) Description : %@", x)

#define infolog(x) NSLog(@"→ INFO [%s : line %d] : %@", __PRETTY_FUNCTION__, __LINE__, x)
#define faillog(x) NSLog(@"✗ FAIL [%s : line %d] :%@", __PRETTY_FUNCTION__, __LINE__, x)
#define todolog(x) NSLog(@"☐ TODO [%s : line %d] : %@", __PRETTY_FUNCTION__, __LINE__, x)
#define upgdlog(x) NSLog(@"☑ UPGRADE [%s : line %d] : %@", __PRETTY_FUNCTION__, __LINE__, x)
#define tryclog(x) NSLog(@"↔ TRY/CATCH [%s : %d] : %@", __PRETTY_FUNCTION__, __LINE__, x)
#define datalog(x) NSLog(@"Δ DATABASE [%s : line %d] : %@", __PRETTY_FUNCTION__, __LINE__, x)
#define docslog(x) NSLog(@"# DOCS [%s : line %d] : %@", __PRETTY_FUNCTION__, __LINE__, x)

#define stacktrace faillog([NSThread callStackSymbols])

#endif
