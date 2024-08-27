;;THIS SCRIPT IS FOR LINUX + DVORAK.  AUTOHOTKEY-v1.0.  TESTED ON DEBIAN-MATE-12.6.  CONVERT THE SYSTEM KEYBOARD FIRST!
;;HOTKEYS:  LockWorkStation RWIN  TRANSPARENCY #t  RENAME !r  EXPLORER !e  DUPLICATE ^d  ALWAYSONTOP ^SPACE  SUSPEND (^!SPACE DOUBLE-TAP)  WINDOW-LIST F11  HIDDEN-WINDOWS +F11  .  
;;NO <! FOR LALT,  NOR MOUSE ALTS.  LINUX CAPSLOCK REGISTERS DIFFERENTLY, SO USE * WHEREVER POSSIBLE.  EXAMPLES: CAPPED F12 & SPACE ARE DIFFERENT TO F12 & SPACE, ETC.  MAPPING QWERTY→DVORAK TOO RISKY. BUT IN PRINCIPLE AHK SHOULD MAP THE WHOLE KEYBOARD.  THIS SCRIPT GENERALLY CLONES CTRL WITH ALT (!c/!v FOR COPY/PASTE, ETC).  PRESS CTRL/ALT AGAIN IF IT FAILS TO RELEASE DUE TO LAGGY SEND.
;;~70 LINES & ~500 WORDS.

#SINGLEINSTANCE
MENU TRAY,ADD  ;DIVIDER.
MENU TRAY,ADD
MENU TRAY,ADD,ALWAYSONTOP TOGGLE `t ^SPACE,^*SPACE ;A MONOSPACE FONT WOULD BE PREFERRED, LIKE COURIER NEW.  TRAY,DEFAULT INVALID.
MENU TRAY,ADD,TRANSPARENCY       `t #t    ,#*t  
MENU TRAY,ADD,TRANSPARENCY OFF   `t #+t   ,#+*t
MENU TRAY,ADD 
MENU TRAY,ADD,WINGETLIST         `t  F11  , F11    ;SIMPLE LIST OF WINDOWS.
MENU TRAY,ADD,WINGETLIST`, FULL  `t +F11  ,+F11    ;FULL LIST.
MENU TRAY,ADD
MENU TRAY,ADD,LockWorkStation    `t  RWIN ,*RWIN

     !*'::                         ;TOP ROW.  THERE'S A BUG IF ALT/CTRL ARE RELEASED BEFORE THE SEND IS COMPLETED (LAG BUG). MUST PUSH ALT AGAIN TO RELEASE IT.  AN ALTERNATIVE IS TO ALSO SEND {ALT} TO FORCE RELEASE, WHICH BLOCKS DOUBLE-PASTE AS A SIDE-EFFECT.
     ^*'::SEND ^q                  ;q QUIT, COMMENT TOGGLE. ^ IS CTRL.  SEND REQUIRED FOR THE ALTS, BUT NOT ON V2. 
     !*.::
     ^*.::SEND #e                  ;e EXPLORER.
     !*p::                        
     ^*p::SEND {F2}                ;r RENAME.
    !+*y::              
    ^+*y::
    #+*y::
    #+*t::WINSET TRANSPARENT,OFF,A ;+t !TRANSPARENCY.  +* GO FIRST.  A ACTIVE WINDOW.
     !*y::            
     ^*y::
     #*y::
     #*t::WINSET TRANSPARENT,128,A ;t TRANSPARENCY.
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
     
 !*COLON::                         ;BOTTOM ROW.  INVALID ON WIN98.
 ^*COLON::
    !+*z::SEND ^+z                 ;z REDO.  
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

^!*SPACE::SUSPEND                  ;DOUBLE-TAP REQUIRED.  IMMUNE TO SUSPENSION.  THIS GOES BEFORE ^SPACE.
 !*SPACE::                         ;BUG: !SPACE ACTIVATES IN LINUX.
 ^*SPACE::WINSET ALWAYSONTOP,TOGGLE,A  ;ALSO VALID ON WINDOWS 98.
     #*n::
   *RWIN::SEND #l                  ;RWIN LOCKWORKSTATION.  RWIN-LOCK CAN BE ANNOYING IF A PASSWORD IS LONG OR UNKNOWN. BUT IT COULD ALSO PREVENT SEIZURE OF A SYSTEM WHICH IS TOO DIFFICULT TO LOCK.

 !+*LEFT::SEND ^+{LEFT}            ;JUMPS SELECTION LEFT OR RIGHT.  UNFORTUNATELY ALTS ARE SLOW!
  !*LEFT::SEND  ^{LEFT}            ;JUMPS BY A WORD LEFT OR RIGHT.  THIS STOPS FLIPPING WORDS AROUND.  MOUSE ALTS AREN'T WORTH THE EFFORT ON v1.0.
!+*RIGHT::SEND ^+{RIGHT}
 !*RIGHT::SEND  ^{RIGHT}

F11::  ;WINDOW LIST.  V2 HAS CONTROLLIST (^F11).  LINUX VERY SLOW.  F12 RESERVED FOR TITLEBAR TOGGLE.
    DETECTHIDDENWINDOWS ON  
    WINGET FULLCOUNT,COUNT,,,""  ;HIDDEN COUNT.  ~270 IN DEBIAN-MATE.
    DETECTHIDDENWINDOWS OFF
    WINGET LIST     ,LIST ,,,""
    WINGET COUNT    ,COUNT,,,""
    MSG = %COUNT% WINDOWS, + %FULLCOUNT%-%COUNT% HIDDEN
    LOOP  %COUNT% 
    {
        ahk_id := LIST%A_INDEX%  ;EVALUATES.
        ahk_id  = ahk_id %ahk_id%
        WINGETTITLE WINTITLE               ,%ahk_id%  ;V2 HAS SIZE, COORDS & MIN/MAX.
        WINGETCLASS CLASS                  ,%ahk_id%
        WINGET      PID        ,PID        ,%ahk_id%    ;V2 HAS WINDOW ID.
        WINGET      PROCESSNAME,PROCESSNAME,%ahk_id%    ;V2 HAS PROCESS PATH.
        MSG = %MSG%`n`nPID=%PID%  %PROCESSNAME%  CLASS=%CLASS%  TITLE=%WINTITLE%
    }
    MSGBOX %MSG%
    RETURN

+F11::  ;HIDDEN WINDOW LIST.  LINUX VERY SLOW.
    DETECTHIDDENWINDOWS ON
    WINGET LIST ,LIST ,,,""
    WINGET COUNT,COUNT,,,""
    MSG = %COUNT% WINDOWS TOTAL. CLASSES BELOW.`n
    LOOP  %COUNT% 
    {
        ahk_id := LIST%A_INDEX%
        WINGETCLASS CLASS,ahk_id %ahk_id%
        MSG = %MSG%  %A_INDEX% %CLASS%  ;TOO MANY.
    }
    MSGBOX %MSG%
    RETURN

