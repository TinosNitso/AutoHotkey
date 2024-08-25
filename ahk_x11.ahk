;;THIS SCRIPT IS FOR LINUX + DVORAK.  AUTOHOTKEY-v1.0.  TESTED IN FULL ON DEBIAN-MATE-12.6.  CONVERT THE SYSTEM KEYBOARD FIRST!  
;;PRESS RWIN FOR LOCKWORKSTATION, !r RENAME, !e EXPLORER, !d DUPLICATE, ^t TRANSPARENCY, ^SPACE ALWAYSONTOP & ^!SPACE DOUBLE-TAP FOR SUSPEND.  THIS SCRIPT GENERALLY CLONES CTRL WITH ALT (!c/!v FOR COPY/PASTE, ETC).  PRESS ALT AGAIN IF IT FAILS TO RELEASE DUE TO LAGGY SEND.
;;NO <! FOR LALT,  NOR MOUSE ALTS.  LINUX CAPSLOCK REGISTERS DIFFERENTLY, SO USE * WHEREVER POSSIBLE.  EXAMPLE: CAPPED F12 & SPACE ARE DIFFERENT TO F12 & SPACE, ETC.  MAPPING QWERTY→DVORAK TOO RISKY. BUT IN PRINCIPLE AHK SHOULD MAP THE WHOLE KEYBOARD.
;;~70 LINES & ~500 WORDS.  COMMENTS DON'T EXIST IN FINAL EXECUTABLE, BUT EVERY COMMAND IS IN FULL.  

#SINGLEINSTANCE
MENU TRAY,ADD,ALWAYSONTOP TOGGLE`t^SPACE,^*SPACE ;A MONOSPACE FONT WOULD BE PREFERRED, LIKE CONSOLAS OR COURIER NEW.  `t TABS ARE TOO MUCH.  THE LINUX CODE IS SIMPLER, BUT TRAY,DEFAULT INVALID.
MENU TRAY,ADD,TRANSPARENCY      `t^t    , ^*t    ;THESE INVALID ON WINDOWS!  
MENU TRAY,ADD,TRANSPARENCY OFF  `t^+t   ,^+*t
MENU TRAY,ADD,LockWorkStation   `t RWIN ,*RWIN
     
     !*'::                         ;TOP ROW.  THERE'S A BUG IF ALT IS RELEASED BEFORE THE SEND IS COMPLETED (LAG BUG). MUST PUSH ALT AGAIN TO RELEASE IT.  AN ALTERNATIVE IS TO ALSO SEND {ALT} TO FORCE RELEASE, WHICH CAUSES DOUBLE-PASTE BUG.
     ^*'::SEND ^q                  ;q QUIT, COMMENT TOGGLE. ^ IS CTRL.  SEND REQUIRED FOR THE ALTS, BUT NOT ON V2. 
     !*.::
     ^*.::SEND #e                  ;e EXPLORER.
     !*p::                        
     ^*p::SEND {F2}                ;r RENAME.
    !+*y::              
    ^+*y::
    ^+*t::WINSET TRANSPARENT,255,A ;+t !TRANSPARENCY.  +* GO FIRST.
     !*y::            
     ^*y::
     ^*t::WINSET TRANSPARENT,128,A ;t TRANSPARENCY.
     !*g::      
     ^*g::SEND ^u                  ;u URL OPEN (SMPLAYER).
     !*r::                      
     ^*r::SEND ^o                  ;o OPEN.
     
     !*a::SEND ^a                  ;a ALL.  HOME ROW. 
     !*o::                     
     ^*o::
     !*s::SEND ^s                  ;s SAVE.  DVORAK USERS ALSO COPY/PASTE WITH 2 HANDS. APPLIES TO s d f z c v. POSSIBLY x.
     !*e::                         
     ^*e::
     !*d::
     ^*d::SEND ^c^v^v              ;D DUPLICATE.  ALT PREFERRED.  CUT MAY BE MORE RELIABLE THAN COPY.
     !*u::                      
     ^*u::
     !*f::SEND ^f                  ;f FIND.
     
 !*COLON::                       
 ^*COLON::
    !+*z::SEND ^+z                 ;z REDO.  BOTTOM ROW.  
     !*;::
     ^*;::
     !*z::SEND ^z                  ;z UNDO.  
     !*q::                       
     ^*q::SEND ^x                  ;x CUT.
     !*j::                       
     ^*j::
     !*c::SEND ^c                  ;c COPY.
     !*k::
     ^*k::
     !*v::SEND ^v                  ;v PASTE.
 
!^*SPACE::SUSPEND                  ;DOUBLE-TAP REQUIRED.  IMMUNE TO SUSPENSION.  THIS GOES BEFORE ^SPACE.
 !*SPACE::                         ;BUG: !SPACE ACTIVATES IN LINUX.
 ^*SPACE::WINSET ALWAYSONTOP,TOGGLE,A  ;A ACTIVE WINDOW.
   *RWIN::SEND #l                  ;L LOCKWORKSTATION.

 !+*LEFT::SEND ^+{LEFT}            ;JUMPS SELECTION LEFT OR RIGHT.  UNFORTUNATELY THIS IS SLOW!
  !*LEFT::SEND  ^{LEFT}            ;JUMPS BY A WORD LEFT OR RIGHT.  THIS STOPS FLIPPING WORDS AROUND.  MOUSE ALTS AREN'T WORTH THE EFFORT ON v1.0.
!+*RIGHT::SEND ^+{RIGHT}
 !*RIGHT::SEND  ^{RIGHT}

