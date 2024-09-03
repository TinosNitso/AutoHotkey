;;FOR AHK-V1.0.48.05, DVORAK, WIN98, WIN9X, WINXP & WIN10.  CONVERT THE SYSTEM KEYBOARD FIRST!  WINDOW SPY REQUIRES AU3_Spy.exe.  
;;HOTKEYS:  DUPLICATE !d  ALWAYSONTOP #SPACE  SUSPEND ^!SPACE(DOUBLE-TAP)  WINDOW-LIST F11  HIDDEN-WINDOW-LIST +F11  RENAME !r  EXPLORER !e.  THERE'S MORE ON WIN10.
;;MAPPING QWERTY→DVORAK TOO RISKY ON V1.0. BUT IN PRINCIPLE AHK SHOULD MAP THE WHOLE KEYBOARD.  THIS SCRIPT GENERALLY EMULATES CTRL WITH ALT (!c/!v FOR COPY/PASTE, ETC).  BUT !MOUSE=^MOUSE DOESN'T WORK IN WIN98.  V1 CONTROLS NEED SEND SINCE PROPER REMAPPING WAS DEVELOPED FOR V2.
;;~200 LINES & ~1000 WORDS.

NPP         = notepad++.exe ;SCRIPT-OPTIONS.  NO-DUPLICATE FOR NPP (^d PASSTHROUGH).  COULD BE RENAMED ADVANCEDTEXTEDITOR.  IN NPP CAN SET ^D=SCI_SELECTIONDUPLICATE.  SCI=SCINTILLA.  ALSO SET ^!D=SCI_LINEDELETE.  REMOVE SCI_LINEDUPLICATE BECAUSE SCI_SELECTIONDUPLICATE ALREADY DUPLICATES LINES IF NOTHING IS SELECTED.  CAN ALSO SET !~/!1 FOR LOWER/UPPERCASE TOGGLING.
EXPLORERS   = explorer.exe  ;NOT CASE SENSITIVE.  EXAMPLE: APPEND explorer++.exe.  DUPLICATE PASTES ONLY ONCE INSIDE THESE APPS.  

MENU TRAY,TIP,AhkVersion %A_AHKVERSION% (FOR WIN98)
MENU TRAY,ADD  ;DIVIDERS.  
MENU TRAY,ADD
MENU TRAY,ADD,DUPLICATE/DOUBLE-PASTE `t ^d    ,DUPLICATE ;`t,`n,#,^,!,+ = TAB,LINE,WIN,CTRL,ALT,SHIFT.  `=ESCAPE-CHAR.  TRIVIAL EXAMPLES CAN ALSO BE ADDED, LIKE !e & !r.
MENU TRAY,ADD
MENU TRAY,ADD,TOGGLE ALWAYSONTOP     `t #SPACE,TOGGLE_ALWAYSONTOP 
MENU TRAY,ADD                        
MENU TRAY,ADD,WINGETLIST             `t  F11  , F11  ;SIMPLE LIST OF WINDOWS.
MENU TRAY,ADD,WINDOW LISTS`, FULL    `t +F11  ,+F11  ;FULL LIST.
MENU TRAY,ADD                                                     
#SINGLEINSTANCE

       F12::WINSET STYLE,^0XC40000,A ;THESE ARE INVALID ON WIN98, BUT THE SAME .EXE RUNS FINE IN WIN10.  TOGGLE GRIP & TITLEBAR.  
      +F12::
      ^F12::WINSET STYLE, ^0X40000,A ;INVALID ON WIN98.  F12 TOGGLES VIDEO TITLE-BAR, BUT ^F12 TOGGLES GRIP.  F12 IS POST-IT IN NOTEPAD++.  #g FOR WIN-GRIP IS ALREADY TAKEN!
      !F12::SEND {F12}               ;!F11/!F12 CAN DO WHATEVER F11/F12 SHOULD DO, LIKE A PASSTHROUGH. SEND REQUIRED IN V1.              

  !WHEELUP::SEND ^{WHEELUP}  ;MOUSE SECTION. THESE ARE INVALID ON WIN98. !MOUSE=^MOUSE.
!WHEELDOWN::SEND ^{WHEELDOWN} 
  !LBUTTON::SEND  {CTRL DOWN}{LBUTTON}{CTRL UP}  ;{CTRL DOWN} IS MORE RELIABLE IN LINUX & NPP.  ALT FILE SELECTIONS & MULTI-LINE EDIT, LIKE CTRL. COMPATIBLE WITH EXPLORER & NOTEPAD++.  ALT ALREADY APPLIES TO RBUTTON IN ITS OWN WAY.  

       !UP::SEND  ^{UP}   ;ALT+SHIFT+UP IS ALREADY DEFINED IN NOTEPAD++, BUT NOT REALLY ALT+UP.   
     !DOWN::SEND  ^{DOWN}  
     !LEFT::SEND  ^{LEFT} ;JUMPS BY A WORD LEFT & RIGHT. 
    !+LEFT::SEND ^+{LEFT} ;JUMPS SELECTION BY A WORD LEFT & RIGHT.
    !RIGHT::SEND  ^{RIGHT} 
   !+RIGHT::SEND ^+{RIGHT}

       ^+'::
       !+'::SEND ^+q  ;QWERTY ROW OUT.  +* SHIFTS GO FIRST.  V1.0 ALWAYS REQUIRES SEND.  ALL SHIFTS OTHER THAN REDO ARE OPTIONAL.
        ^'::
        !'::SEND ^q   ;q QUIT, COMMENT TOGGLE. ^ IS CTRL.  SEND REQUIRED FOR THE ALTS, BUT NOT ON V2. 
        ^.::
        !.::          
        #.::SEND #e   ;e EXPLORER.
        ^p::          
        !p::SEND {F2} ;r RENAME.
       ^+g::
       !+g::SEND ^+u
        ^g::
        !g::SEND ^u   ;u URL OPEN (SMPLAYER).
       ^+r::
       !+r::SEND ^+o
        ^r::
        !r::SEND ^o   ;o OPEN.
        
       !+a::SEND ^+a
        !a::SEND ^a   ;a ALL.  HOME ROW. 
       ^+o::
       !+o::          
       !+s::SEND ^+s
        ^o::
        !o::          
        !s::SEND ^s   ;s SAVE.  DVORAK USERS ALSO COPY/PASTE WITH 2 HANDS. APPLIES TO s d f z x c v.
       ^+u::
       !+u::          
       !+f::SEND ^+f 
        ^u::
        !u::          
        !f::SEND ^f   ;f FIND.
        #n::SEND #l   ;l LOCK.  INVALID ON WIN98.  

       ^+;::
       !+;::          
       !+z::SEND ^+z  ;+z REDO.  BOTTOM ROW.  
        ^;::
        !;::          
        !z::SEND ^z   ;z UNDO.
       ^+q::
       !+q::          
       !+x::SEND ^+x
        ^q::
        !q::          
        !x::SEND ^x   ;x CUT.
       ^+j::
       !+j::          
       !+c::SEND ^+c 
        ^j::
        !j::          
        !c::SEND ^c   ;c COPY.
       ^+k::
       !+k::          
       !+v::SEND ^+v
        ^k::
        !k::          
        !v::SEND ^v   ;v PASTE.

        !y::            
        ^y::
        #y::
        #t::          ;t TRANSPARENCY.  INVALID ON WIN98.
            WINGET ALPHA,TRANSPARENT,A                     
            WINSET TRANSPARENT , % ALPHA ? "OFF" : 128 , A ;A ACTIVE WINDOW.  "OFF"=255 (BUT MORE EFFICIENT).  ""=0.  INVERT TRANSPARENCY STATE.
            RETURN

ALTTAB()   {  
            SEND {BLIND}!{TAB}{ALTTABMENUDISMISS} ;{BLIND} MORE RELIABLE!  THIS RESTORES A MINIMIZED WIN IF THEY'RE ALL MINIMIZED, FOR SIMPLICITY.  BUG ON WIN-XP/98: ALTTABS AWAY FROM ALREADY ALWAYSONTOP WINDOW!  INVALID ON LINUX, SINCE ITS TASKBAR DOESN'T STEAL FOCUS.
            WINWAITACTIVE ,,,,Task Switching      ;SKIP Task Switching.
}

TOGGLE_ALWAYSONTOP:
            ALTTAB()
    !SPACE:: 
    ^SPACE::
    #SPACE::WINSET ALWAYSONTOP,TOGGLE,A ;ALSO VALID ON WIN98.
   ^!SPACE::SUSPEND                     ;DOUBLE-TAP REQUIRED.  IMMUNE TO SUSPENSION.

  DUPLICATE:
            ALTTAB()
        ^e::
        !e::
        !d::
        ^d::  ;d DUPLICATE OUTSIDE NOTEPAD++.  
            WINGET  PROCESSNAME,PROCESSNAME,A
            IFEQUAL PROCESSNAME,%NPP%         ;SPREADSHEET/EXCEL MAY ALSO NEED A SECTION.  LINUX USES `n INSTEAD OF .exe.
            {
                HOTKEY ^d,OFF  ;INVALID ON LINUX.  DVORAK CAN ALSO BE MAPPED THIS WAY IN V1.0, BUT IT'D BE UGLY.
                SEND   ^d
                HOTKEY ^d,ON
                RETURN
            }
            
            SEND    ^c    ;2 SENDS MORE RELIABLE. 
            PASTE = ^{v 2}
            LOOP PARSE, EXPLORERS  ,%A_SPACE%     ; =DELIMITER.  LOOP PARSE CONTINUES FROM PRIOR LOOP PARSE.
            {
                IFEQUAL PROCESSNAME,%A_LOOPFIELD% ;A_LOOPFIELD=EXPLORER.  EXPLORERS PASTE ONCE ONLY.
                    PASTE = ^v
            }
            SEND   %PASTE%
            RETURN
    
      !F11::SEND {F11} ;PASSTHROUGH.
       F11::           ;WINDOW LIST.
            MSG = 
            DETECTHIDDENWINDOWS ON  
            WINGET FULLCOUNT   ,COUNT  ;HIDDEN COUNT.  ~40 IN WIN98.
            DETECTHIDDENWINDOWS OFF
            WINGET COUNT       ,COUNT
            WINGET LIST        ,LIST 
            WINGET ACTIVEHWND  ,ID,A
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
                MSG = %MSG%`n`n%A_INDEX%: %ACTIVE%%WINTITLE%`n %PROCESSNAME%`t CLASS=%CLASS%`t PID=%PID%`t X,Y,W,H=%X%,%Y%,%W%,%H%`t HWND=%HWND%  ;CAPS ARE LIKE FLAGS.
            }
            MSGBOX ,,%COUNT% WINDOWS`, +%FULLCOUNT%-%COUNT% HIDDEN , % SUBSTR(MSG,3)  ;REMOVE LEADING `n`n.
            RETURN
      
      +F11::    ;HIDDEN WINDOW LIST. 
            DETECTHIDDENWINDOWS ON
            MSG  = 
            MSG2 = 
            WINGET LIST ,LIST
            WINGET COUNT,COUNT 
            LOOP  %COUNT% 
            {
                ahk_id := "ahk_id " . LIST%A_INDEX%  ;LOWERCASE FOR LINUX.
                WINGETCLASS        CLASS      ,%ahk_id% 
                WINGET PROCESSNAME,PROCESSNAME,%ahk_id% 
                MSG  = %MSG%  %A_INDEX% %PROCESSNAME%
                MSG2 = %MSG2%  %A_INDEX% %CLASS%
            }
            MSGBOX ,, %COUNT% WINDOWS TOTAL. PROCESSES BELOW. CLICK OK FOR CLASSES. , %MSG%  ;A SEPARATE THREAD WOULD BE MORE ELEGANT.
            MSGBOX ,, %COUNT% WINDOWS TOTAL. CLASSES BELOW.                         , %MSG2%
            RETURN


;;A DIFFERENT VERSION COULD COMBINE THE 2 OPTIONS INTO CLASS/OBJECT O.
;;FUTURE VERSION SHOULD RETURN CLIPBOARD MEMORY AFTER DUPLICATE.
;;EXPLORER BUG: !d THEN DEL FAILS TO DELETE.

