;;FOR AHK_X11-v1.0.4.  BASED ON AUTOHOTKEY-v1.0.24.  FOR DVORAK ON LINUX.  TESTED ON DEBIAN-MATE-12.6.  CONVERT THE SYSTEM KEYBOARD FIRST!  WINDOW SPY REQUIRES OFFICIAL ahk_x11.AppImage INSTALLATION.  PRESS CTRL/ALT AGAIN IF IT FAILS TO RELEASE DUE TO LAGGY SEND.  
;;HOTKEYS:  DUPLICATE !d  TRANSPARENCY #t  ALWAYSONTOP #SPACE  SUSPEND ^!SPACE(DOUBLE-TAP)  WINDOW-LIST F11  HIDDEN-WINDOW-LIST +F11  RENAME !r  EXPLORER !e.  
;;NO <! FOR LALT,  NOR MOUSE ALTS.  LINUX CAPSLOCK REGISTERS DIFFERENTLY, SO USE * WHEREVER POSSIBLE.  EXAMPLES: CAPPED F12 & SPACE ARE DIFFERENT TO F12 & SPACE, ETC.  MAPPING QWERTY→DVORAK TOO RISKY. BUT IN PRINCIPLE AHK SHOULD MAP THE WHOLE KEYBOARD.  THIS SCRIPT GENERALLY CLONES CTRL WITH ALT (!c/!v FOR COPY/PASTE, ETC).  V1 CONTROLS NEED SEND SINCE PROPER REMAPPING WAS DEVELOPED FOR V2.
;;~200 LINES & ~1000 WORDS.

TRANSPARENT = 128       ;SCRIPT-OPTIONS.  ALPHA LEVEL FOR TRANSPARENCY.  BIGGER MEANS MORE OPAQUE.   
NPP         = notepad++ ;NO-DUPLICATE FOR THIS APP. ^d PASSTHROUGH.  NPP COULD BE RENAMED ADVANCEDTEXTEDITOR.  SET ^D=SCI_SELECTIONDUPLICATE.  SCI=SCINTILLA.  ALSO SET ^!D=SCI_LINEDELETE.  REMOVE SCI_LINEDUPLICATE BECAUSE SCI_SELECTIONDUPLICATE ALREADY DUPLICATES LINES IF NOTHING IS SELECTED.  CAN ALSO SET !~/!1 FOR LOWER/UPPERCASE TOGGLING.
EXPLORERS   = explorer caja nautilus dolphin thunar nemo finder deepin pcmanfm  ;WINDOWS MATE GNOME KDE XFCE CINNAMON MACOS...  CASE SENSITIVE.  BOTH `n & .exe ARE STRIPPED FOR LINUX.  DUPLICATE PASTES ONLY ONCE INSIDE THESE APPS.  

MENU TRAY,TIP,AhkVersion %A_AHKVERSION%
MENU TRAY,ADD                                           ;DIVIDER.
MENU TRAY,ADD 
MENU TRAY,ADD,DUPLICATE/DOUBLE-PASTE `t ^d    ,^*d     ;`t,`n,#,^,!,+ = TAB,LINE,WIN,CTRL,ALT,SHIFT.  `=ESCAPE-CHAR.  TRIVIAL EXAMPLES CAN ALSO BE ADDED, LIKE !r & !e.
MENU TRAY,ADD
MENU TRAY,ADD,TOGGLE ALWAYSONTOP     `t #SPACE,#*SPACE ;IDEALLY BOTH THESE WOULD HAVE CHECKBOXES (FUTURE VERSION?).
MENU TRAY,ADD,TOGGLE TRANSPARENCY    `t #t    ,#*t
MENU TRAY,ADD                                  
MENU TRAY,ADD,WINGETLIST             `t  F11  , *F11   ;SIMPLE LIST OF WINDOWS.
MENU TRAY,ADD,WINDOW LISTS`, FULL    `t +F11  ,+*F11   ;FULL LIST.
MENU TRAY,ADD                               

#SINGLEINSTANCE
STRINGREPLACE NPP      ,NPP      ,`n  ;LINUX USES `n INSTEAD OF .exe.  
STRINGREPLACE NPP      ,NPP      ,.exe 
STRINGREPLACE EXPLORERS,EXPLORERS,`n 
STRINGREPLACE EXPLORERS,EXPLORERS,.exe 

  !*WHEELUP::SEND {CTRL DOWN}{WHEELUP}{CTRL UP}  ;MOUSE SECTION, !MOUSE=^MOUSE.  ALT-ZOOM.  SEND IS MORE RELIABLE WHEN COMBINED WITH CTRL, TOO.
!*WHEELDOWN::SEND {CTRL DOWN}{WHEELDOWN}{CTRL UP} 
  !*LBUTTON::SEND {CTRL DOWN}{LBUTTON}{CTRL UP}  ;{CTRL DOWN} IS MORE RELIABLE IN LINUX & NPP.  ALT FILE SELECTIONS & MULTI-LINE EDIT, LIKE CTRL.  ALT ALREADY APPLIES TO RBUTTON IN ITS OWN WAY.  IN LINUX RELEASE ALT BTWN FILE SELECTIONS (IN CAJA).

    !+*LEFT::SEND ^+{LEFT}  ;JUMPS SELECTION LEFT OR RIGHT.  UNFORTUNATELY THESE SENDS ARE SLOW!
     !*LEFT::SEND  ^{LEFT}  ;JUMPS BY A WORD LEFT OR RIGHT.  THIS STOPS FLIPPING WORDS AROUND.  MOUSE ALTS AREN'T WORTH THE EFFORT.
   !+*RIGHT::SEND ^+{RIGHT}
    !*RIGHT::SEND  ^{RIGHT}

    !*SPACE::                            ;BUG: !SPACE ALSO OPENS A TOP-LEFT MENU IN LINUX.
    ^*SPACE::
    #*SPACE::WINSET ALWAYSONTOP,TOGGLE,A ;A ACTIVE WINDOW.
   ^!*SPACE::SUSPEND                     ;DOUBLE-TAP REQUIRED.  IMMUNE TO SUSPENSION.  THIS GOES BEFORE ^SPACE.

       !+*'::          
       ^+*'::SEND ^+q  ;TOP ROW.  +* SHIFTS GO FIRST.  SEND ALWAYS REQUIRED.  ALL SHIFTS OTHER THAN REDO ARE OPTIONAL.  THERE'S A BUG IF ALT/CTRL ARE RELEASED BEFORE THE SEND IS COMPLETED (LAG BUG). MUST PUSH ALT AGAIN TO RELEASE IT.  AN ALTERNATIVE IS TO ALSO SEND {ALT} TO FORCE RELEASE, WHICH BLOCKS DOUBLE-PASTE AS A SIDE-EFFECT.
        !*'::        
        ^*'::SEND ^q   ;q QUIT, COMMENT TOGGLE. ^ IS CTRL.  SEND REQUIRED FOR THE ALTS, BUT NOT ON V2. 
        ^*.::
        !*.::          
        #*.::SEND #e   ;e EXPLORER.
        !*p::          
        ^*p::SEND {F2} ;r RENAME.
       !+*g::      
       ^+*g::SEND ^+u 
        !*g::      
        ^*g::SEND ^u   ;u URL OPEN (SMPLAYER).
       !+*r::          
       ^+*r::SEND ^+o
        !*r::          
        ^*r::SEND ^o   ;o OPEN.
                       
       !+*a::SEND ^+a
        !*a::SEND ^a   ;a ALL.  HOME ROW. 
       ^+*o::          
       !+*o::          
       !+*s::SEND ^+s
        ^*o::          
        !*o::          
        !*s::SEND ^s   ;s SAVE.  DVORAK USERS ALSO COPY/PASTE WITH 2 HANDS. APPLIES TO s d f z x c v.
       ^+*u::          
       !+*u::          
       !+*f::SEND ^+f 
        ^*u::
        !*u::
        !*f::SEND ^f   ;f FIND.
        #*n::SEND #l   ;l LOCK.  ACCIDENTAL RWIN-LOCK IS TOO ANNOYING IF A PASSWORD IS LONG OR UNKNOWN. BUT IT COULD ALSO PREVENT SEIZURE OF A SYSTEM WHICH IS TOO DIFFICULT TO LOCK.
             
    ^*COLON::          
    !*COLON::          
       !+*z::SEND ^+z  ;+z REDO.  BOTTOM ROW.  
        ^*;::          
        !*;::          
        !*z::SEND ^z   ;z UNDO.
       ^+*q::          
       !+*q::          
       !+*x::SEND ^+x
        ^*q::          
        !*q::          
        !*x::SEND ^x   ;x CUT.
       ^+*j::          
       !+*j::          
       !+*c::SEND ^+c 
        ^*j::          
        !*j::          
        !*c::SEND ^c   ;c COPY.
       ^+*k::          
       !+*k::          
       !+*v::SEND ^+v
        ^*k::          
        !*k::          
        !*v::SEND ^v   ;v PASTE.
        
        ^*e::
        !*e::
        !*d::
        ^*d::          ;d DUPLICATE.  
             WINGET        PROCESSNAME,PROCESSNAME,A
             STRINGREPLACE PROCESSNAME,PROCESSNAME,`n  
             STRINGREPLACE PROCESSNAME,PROCESSNAME,.exe
             IFEQUAL       PROCESSNAME,%NPP%    ;SPREADSHEET/EXCEL MAY ALSO NEED A SECTION.
             {
                SEND ^d   ;WIN98 INFINITE LOOPS INSIDE NPP, WITHOUT MORE LINES.
                RETURN
             }
             
             SEND    ^c    ;2 SENDS MORE RELIABLE. 
             PASTE = ^{v 2}  
             LOOP PARSE, EXPLORERS  ,%A_SPACE%     ; =DELIMITER.  LOOP PARSE CONTINUES FROM PRIOR LOOP PARSE.
             {
                IFEQUAL PROCESSNAME,%A_LOOPFIELD% ;A_LOOPFIELD=EXPLORER.  EXPLORERS PASTE ONCE ONLY.
                    PASTE = ^v
             }
             SEND  %PASTE%
             RETURN
        
        ^*y::
        !*y::              
        #*y::
        #*t::  ;t TRANSPARENCY.  TOGGLE USES UNIQUE MEMORY FOR EACH WINDOW.
             WINGET HWND,ID,A
             ALPHA       := ALPHA%HWND% ? "OFF" : TRANSPARENT  ;""="OFF"=255 (BUT MORE EFFICIENT).  INVERTS TRANSPARENCY.
             ALPHA%HWND% := ALPHA
             WINSET TRANSPARENT,%ALPHA%,A  ;%... INVALID ON LINUX.
             RETURN
        
      !*F11::SEND {F11} ;!F11 CAN DO WHATEVER F11 SHOULD DO, LIKE A PASSTHROUGH.  F12 RESERVED FOR TITLEBAR TOGGLE.
      +*F11::           ;HIDDEN WINDOW LIST.  LINUX SLOW.  V2 HAS CONTROLLIST (^F11).  
             DETECTHIDDENWINDOWS ON
             MSG  = 
             MSG2 = 
             WINGET LIST ,LIST ,,,""
             WINGET COUNT,COUNT,,,""
             LOOP  %COUNT% 
             {
                 HWND   := LIST%A_INDEX%
                 ahk_id  = ahk_id %HWND%  ;LOWERCASE FOR LINUX.
                 WINGETCLASS               CLASS      ,%ahk_id% 
                 WINGET        PROCESSNAME,PROCESSNAME,%ahk_id% 
                 STRINGREPLACE PROCESSNAME,PROCESSNAME,`n
                 MSG  = %MSG%%A_INDEX% %PROCESSNAME%  %%  ;%%=NULL CHAR.
                 MSG2 = %MSG2%%A_INDEX% %CLASS%  %%
             }
             MSGBOX %COUNT% WINDOWS TOTAL. PROCESSES BELOW. CLICK OK FOR CLASSES.`n%MSG%
             MSGBOX %COUNT% WINDOWS TOTAL. CLASSES BELOW.                        `n%MSG2%
             RETURN
            
      *F11::  ;WINDOW LIST.  LINUX SLOW.
            MSG = 
            DETECTHIDDENWINDOWS ON  
            WINGET FULLCOUNT ,COUNT,,,""  ;HIDDEN COUNT.  ~270 IN DEBIAN-MATE.  MINIMIZED COUNTS AS HIDDEN, ON LINUX.
            DETECTHIDDENWINDOWS OFF
            WINGET COUNT     ,COUNT,,,""
            WINGET LIST      ,LIST ,,,""
            WINGET ACTIVEHWND,ID   ,A
            LOOP  %COUNT% 
            {
                HWND   := LIST%A_INDEX%
                ACTIVE := HWND==ACTIVEHWND ? "ACTIVE`t " : ""  ;SPECIAL FLAG.
                ahk_id  = ahk_id %HWND%
                WINGETPOS     X,Y,W,H                ,%ahk_id%
                WINGETCLASS   CLASS                  ,%ahk_id%
                WINGETTITLE   WINTITLE               ,%ahk_id%
                WINGET        PID        ,PID        ,%ahk_id% 
                WINGET        PROCESSNAME,PROCESSNAME,%ahk_id%  ;PROCESSPATH INVALID. MINMAX=-1.
                STRINGREPLACE PROCESSNAME,PROCESSNAME,`n
                MSG     = %MSG%`n`n%A_INDEX%: %ACTIVE%%WINTITLE%`n %PROCESSNAME%`t CLASS=%CLASS%`t PID=%PID%`t X,Y,W,H=%X%,%Y%,%W%,%H%`t HWND=%HWND%  ;CAPS ARE LIKE FLAGS.
            }
            MSGBOX %COUNT% WINDOWS, +%FULLCOUNT%-%COUNT% HIDDEN.  MINIMIZED=HIDDEN. %MSG%
            RETURN


;;A DIFFERENT VERSION COULD COMBINE THE 3 OPTIONS INTO CLASS/OBJECT O.
;;FUTURE VERSION SHOULD RETURN CLIPBOARD MEMORY AFTER DUPLICATE.

   