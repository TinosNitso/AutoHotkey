;;FOR AHK-V1.1; DVORAK ON WINDOWS XP & WINDOWS 10.  V2 BROKE GOTO/GOSUB.  V1 CONTROLS NEED SEND SINCE TRUE CONTROL REMAPPING WAS DEVELOPED FOR V2 INSTEAD.  V2 IS OBJECT-ORIENTED, WHILE V1 IS MORE LIKE A .BAT SCRIPT.
;;HOTKEYS:  DUPLICATE ^d  DVORAK ^!+d  TRANSPARENCY #t  ALWAYSONTOP #SPACE  SUSPEND ^!SPACE(DOUBLE-TAP)  TITLEBAR F12  GRIP ^F12  WINDOW-LIST F11  HIDDEN-WINDOW-LIST +F11  RENAME !r  EXPLORER !e.
;;THIS SCRIPT GENERALLY EMULATES CTRL WITH ALT (!c/!v FOR COPY/PASTE, ETC). MOUSE TOO!
;;~300 LINES & ~1000 WORDS.  AHK2EXE SENDS STRIPPED SCRIPT TO RESOURCES AutoHotkeyU32.exe\.rsrc\RCDATA\1.  USE 7-ZIP TO EXTRACT ALL DATA TO A FOLDER TO VERIFY CRC SHA.

DVORAK      = TRUE          ;SCRIPT-OPTIONS.  SWITCH TO FALSE FOR NO-DVORAK BY DEFAULT.
TRANSPARENT = 128           ;ALPHA LEVEL FOR TRANSPARENCY.  BIGGER MEANS MORE OPAQUE.   
NPP         = notepad++.exe ;NO-DUPLICATE FOR NPP (^d PASSTHROUGH).  COULD BE RENAMED ADVANCEDTEXTEDITOR.  IN NPP CAN SET ^D=SCI_SELECTIONDUPLICATE.  SCI=SCINTILLA.  ALSO SET ^!D=SCI_LINEDELETE.  REMOVE SCI_LINEDUPLICATE BECAUSE SCI_SELECTIONDUPLICATE ALREADY DUPLICATES LINES IF NOTHING IS SELECTED.  CAN ALSO SET !~/!1 FOR LOWER/UPPERCASE TOGGLING.
EXPLORERS   = explorer.exe  ;NOT CASE SENSITIVE.  EXAMPLE: APPEND explorer++.exe.  DUPLICATE PASTES ONLY ONCE INSIDE THESE APPS.  

A = A                               ;ABBREV. ACTIVE WINDOW. 
#SINGLEINSTANCE                     ;AHK      DIRECTIVE .
;@AHK2EXE-BASE    AutoHotkeyU32.exe ;COMPILER DIRECTIVES.
;@AHK2EXE-EXENAME AutoHotkeyU32..exe

MENU TRAY,MAINWINDOW                                           ;FOR COMPILATION. 
MENU TRAY,TIP,AhkVersion %A_AHKVERSION%
MENU TRAY,ADD                                                  ;DIVIDERS. 
MENU TRAY,ADD
MENU TRAY,ADD,DUPLICATE/DOUBLE-PASTE       `t ^d    ,DUPLICATE ;`t,`n,#,^,!,+ = TAB,LINE,WIN,CTRL,ALT,SHIFT.  `=ESCAPE-CHAR.  TRIVIAL EXAMPLES CAN ALSO BE ADDED, LIKE !e & !r.
MENU TRAY,ADD                                                           
MENU TRAY,ADD,TOGGLE DVORAK                `t ^!+d  ,^!+d      ;HAS CHECKBOX.
MENU TRAY,ADD,TOGGLE ALWAYSONTOP           `t #SPACE,TOGGLE_ALWAYSONTOP  
MENU TRAY,ADD,TOGGLE TRANSPARENCY          `t #t    ,TOGGLE_TRANSPARENCY
MENU TRAY,ADD,TOGGLE WS_SIZEBOX|WS_CAPTION `t  F12  ,TOGGLE_TITLEBAR
MENU TRAY,ADD,TOGGLE WS_SIZEBOX            `t ^F12  ,TOGGLE_WS_SIZEBOX  ;WINDOWSTYLE SIZEBOX ALLOWS RESIZING WITHOUT ANNOYING TITLEBAR.
MENU TRAY,ADD                                                            
MENU TRAY,ADD,WINGETLIST                   `t  F11  , F11  ;SIMPLE LIST OF WINDOWS.
MENU TRAY,ADD,WINDOW LISTS`, FULL          `t +F11  ,+F11  ;ALL WINDOWS.
MENU TRAY,ADD                                                            

      ^!+d:: 
            MENU TRAY,TOGGLECHECK,TOGGLE DVORAK                `t ^!+d  ;TOGGLE_DVORAK.  V1 IGNORES TRAILING SPACES.
            DVORAK := !DVORAK                                           ;:= EVALUATES.
            RETURN
          
ALTTAB()   {
            SEND {BLIND}!{TAB}{ALTTABMENUDISMISS} ;{BLIND} MORE RELIABLE!  UNFORTUNATELY THIS IS STILL A GLITCH (ALTTAB MENU).  THIS RESTORES A MINIMIZED WIN IF THEY'RE ALL MINIMIZED, FOR SIMPLICITY.  BUG ON WIN-XP/98: ALTTABS AWAY FROM ALREADY ALWAYSONTOP WINDOW! 
            WINWAITACTIVE ,,,,Task Switching      ;SKIP Task Switching.
}

  DUPLICATE:
            ALTTAB()  ;FAILS TO DUPLICATE DESKTOP SHORTCUTS @A_TRAYMENU.
        !d::  
        ^d::  ;d DUPLICATE OUTSIDE NOTEPAD++.  
            WINGET  PROCESSNAME,PROCESSNAME,A
            IFEQUAL PROCESSNAME,%NPP%  ;SPREADSHEET/EXCEL MAY ALSO NEED A SECTION.  LINUX USES `n INSTEAD OF .exe.
            {
                SEND ^d
                RETURN
            }
            
            SEND ^c    ;2 SENDS MORE RELIABLE ON LINUX.  LINUX CHANGES HOW ALL THESE SCRIPTS ARE WRITTEN.  
            PASTE = ^{v 2}  
            LOOP PARSE, EXPLORERS  ,%A_SPACE%     ; =DELIMITER. LOOP PARSE CONTINUES FROM PRIOR LOOP PARSE.
            {
                IFEQUAL PROCESSNAME,%A_LOOPFIELD% ;A_LOOPFIELD=EXPLORER.  EXPLORERS PASTE ONCE ONLY.
                    PASTE = ^v
            }
            SEND   %PASTE%
            RETURN
     
TOGGLE_ALWAYSONTOP:
            ALTTAB()
    !SPACE:: 
    ^SPACE::
    #SPACE::WINSET ALWAYSONTOP,TOGGLE,A ;A IS ACTIVE WINDOW.
   ^!SPACE::SUSPEND                     ;IMMUNE TO SUSPENSION.  ^ IS CTRL.

TOGGLE_TRANSPARENCY:  
            ALTTAB()
        !t::  ;t TRANSPARENCY.  A DIFFERENT CONCEPT IS TO RUN THIS ON AN AUTO-TIMER.
        ^t::
        #t::
            WINGET ALPHA,TRANSPARENT,A
            WINSET TRANSPARENT , % ALPHA ? "OFF" : TRANSPARENT , A  ;"OFF"=255 (BUT MORE EFFICIENT).  INVERT TRANSPARENCY STATE.  ""=0 IN V1.
            RETURN
       
TOGGLE_TITLEBAR:
            ALTTAB()
       F12::WINSET STYLE,^0XC40000,A ;TOGGLE GRIP & TITLEBAR.  F12 IS POST-IT IN NOTEPAD++.  ^ TOGGLES (BIT-FLIPS).  C BEATS 8 IN MY TESTS, BUT EITHER WORKS. 0XC00000==WS_CAPTION==WS_BORDER|WS_DLGFRAME   WS_SIZEBOX==WS_THICKFRAME TOGGLES SIZING.  0X800000 IS WS_BORDER. ^0X# IS XOR (BINARY FLAG TOGGLE).
      !F11::SEND {F11}               ;!F11/F12 CAN DO WHATEVER F11/F12 SHOULD DO, LIKE A PASSTHROUGH. SEND REQUIRED IN V1.
      !F12::SEND {F12}                 

TOGGLE_WS_SIZEBOX:
            ALTTAB()
      +F12::
      ^F12::WINSET STYLE, ^0X40000,A ;#g FOR WIN-GRIP IS ALREADY TAKEN!  WS_SIZEBOX IS A WINDOW CONTROL.
      
       F11::  ;WINDOW LIST.  V2 HAS CONTROLLIST (^F11).  A DIFFERENT CONCEPT IS TO UPDATE THIS USING A TIMER (WINDOW MONITOR).
            DETECTHIDDENWINDOWS ON  
            WINGET FULLCOUNT   ,COUNT  ;HIDDEN COUNT.  ~50 IN WIN-XP.
            DETECTHIDDENWINDOWS OFF
            WINGET COUNT       ,COUNT 
            WINGET LIST        ,LIST
            ACTIVEHWND := WINACTIVE(A)
            MSG         = 
            LOOP  %COUNT% 
            {
                HWND  := LIST%A_INDEX%
                ahk_id = ahk_id %HWND%  ;LOWERCASE FOR LINUX.
                WINGET      PROCESSPATH,PROCESSPATH,%ahk_id% 
                WINGET      PROCESSNAME,PROCESSNAME,%ahk_id% 
                WINGET      PID        ,PID        ,%ahk_id% 
                WINGET      MINMAX     ,MINMAX     ,%ahk_id% 
                WINGETTITLE WINTITLE               ,%ahk_id%
                WINGETCLASS CLASS                  ,%ahk_id%
                WINGETPOS   X,Y,W,H                ,%ahk_id%  
                
                ACTIVE := HWND  !=ACTIVEHWND ? "" : "ACTIVE`t "             ;SPECIAL FLAG.
                XY     := MINMAX==-1         ? "" : FORMAT("X,Y={},{}",X,Y) ;X & Y NONSENSE IF MINIMIZED.  FORMAT INVALID ON V1.0.
                MINMAX := ["MINIMIZED","","MAXIMIZED"][MINMAX+2]
                MSG     = %MSG%`n`n%A_INDEX%: %ACTIVE%%WINTITLE%`t %PROCESSPATH%`n %PROCESSNAME%`t CLASS=%CLASS%`t PID=%PID%`t %MINMAX% %XY%  W,H=%W%,%H%`t HWND=%HWND%  ;CAPS ARE LIKE FLAGS.
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
      
  !WHEELUP::SEND ^{WHEELUP}  ;MOUSE SECTION, !MOUSE=^MOUSE.  ALT-ZOOM.  SEND IS MORE RELIABLE WHEN COMBINED WITH CTRL, TOO.
!WHEELDOWN::SEND ^{WHEELDOWN} 
  !LBUTTON::SEND  {CTRL DOWN}{LBUTTON}{CTRL UP}  ;{CTRL DOWN} IS MORE RELIABLE IN LINUX & NPP.  ALT FILE SELECTIONS & MULTI-LINE EDIT, LIKE CTRL. COMPATIBLE WITH EXPLORER & NOTEPAD++.  ALT ALREADY APPLIES TO RBUTTON IN ITS OWN WAY.  

       !UP::SEND  ^{UP}   ;ALT+SHIFT+UP IS ALREADY DEFINED IN NOTEPAD++, BUT NOT REALLY ALT+UP.   
     !DOWN::SEND  ^{DOWN}  
     !LEFT::SEND  ^{LEFT} ;JUMPS BY A WORD LEFT & RIGHT. 
    !+LEFT::SEND ^+{LEFT} ;JUMPS SELECTION BY A WORD LEFT & RIGHT. NOTEPAD++ BUG: IMPOSSIBLE TO SELECT A SINGLE SPACEBAR UP/DOWN OVER SEVERAL LINES, USING LALT & NO MOUSE. I CAN'T THINK OF A SOLUTION.
    !RIGHT::SEND  ^{RIGHT} 
   !+RIGHT::SEND ^+{RIGHT}

        !q::SEND  ^q  ;q COMMENT TOGGLE (NPP).  TOP ROW ALTS.  RHS IS CASE SENSITIVE.  FAILS ^+q BLOCK COMMENT.  AN ALTERNATIVE IS TO MAKE ALL THESE LEFTIES, <!. BUT ON LINUX < NOTATION INVALID.
       !+q::SEND ^+q  ;SHIFTED VERSIONS RARELY USED. V2 DOESN'T HAVE THIS PROBLEM.
        !e::
        ^e::SEND  #e  ;e EXPLORER.
        !r::
        ^r::SEND {F2} ;r RENAME.
        !u::SEND  ^u  ;u URL OPEN (SMPLAYER).
       !+u::SEND ^+u
        !o::SEND  ^o  ;o OPEN.
       !+o::SEND ^+o
       
        !a::SEND  ^a  ;a ALL.  MIDDLE ROW.
       !+a::SEND ^+a 
        !s::SEND  ^s  ;s SAVE.  DVORAK USERS ALSO COPY/PASTE WITH 2 HANDS.  APPLIES TO s d f z c x v.
       !+s::SEND ^+s 
        !f::SEND  ^f  ;f FIND.
       !+f::SEND ^+f 
       
        !z::SEND  ^z  ;z UNDO/REDO.  BOTTOM ROW.
       !+z::SEND ^+z
        !x::SEND  ^x  ;x CUT.  
       !+x::SEND ^+x 
        !c::SEND  ^c  ;c COPY. 
       !+c::SEND ^+c 
        !v::SEND  ^v  ;v PASTE.
       !+v::SEND ^+v 
       
#IF DVORAK            ;V2 USES HOTIF.  #IF ALTS COULD BE ANOTHER OPTION, TOO.  DVORAK USERS COPY/PASTE WITH 2 HANDS. MAY APPLY TO s d f z x c v.
        ^;::^s        ;s SAVE.  HOME ROW OUT, BUT NOT IN!
        !;::SEND ^s   ;  V1 ALTS REQUIRE SEND.
        !h::          
        ^h::GOTO ^d   ;d DUPLICATE, SHIFTED TOO, +LINEDELETE.
        ^y::^f        ;f FIND.
        !y::SEND ^f   
        #p::#l        ;l LOCK.  DVORAK-LOCK.  ~#*p::l ALSO WORKS.
             
        ^/::^z        
        !/::SEND ^z   ;z  UNDO.  BOTTOM ROW.  / INVALID ON LINUX.  
       !+/::SEND ^+z  ;+z REDO.  SEND REQUIRES EXPLICIT SHIFTS.
        ^b::^x        ;x CUT.  REMOVE THIS LINE FOR ^b=BOLD. 
        !b::SEND ^x  
        ^i::^c        ;c COPY. REMOVE THIS LINE FOR ^i=ITALIC, IN WORDPAD.
        !i::SEND ^c   
        ^.::^v        ;v PASTE.
        !.::SEND ^v   
        
#IF DVORAK AND NOT(GETKEYSTATE("CTRL") OR GETKEYSTATE("ALT") OR GETKEYSTATE("LWIN") OR GETKEYSTATE("RWIN"))  ;DON'T CORRUPT CONTROLS, EXCEPT FOR DVORAK-COPY/PASTE ETC.
         -::[  ;DIGITS ROW IN.
         =::]
          
         q::'  ;QWERTY ROW. CASE SENSITIVE.
         w::,
         e::.
         r::p  ;Р=R & ТУ NEXT TO EACH OTHER, LIKE RUSSIAN: АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ.
         t::y
         y::f
         u::g
         i::c
         o::r
         p::l  ;L=Л≈П=P, LIKE RUSSIAN.  DVORAK PLACES LR THE OPPOSITE WAY AROUND.
         [::/
         ]::=
          
       ; a::a  ;HOME ROW. 
         s::o
         d::e
         f::u
         g::i
         h::d
         j::h
         k::t
         l::n
        `;::s 
         '::-
          
         z::;  ;BOTTOM ROW. 
         x::q
         c::j
         v::k
         b::x
         n::b
       ; m::m
         ,::w
         .::v
         /::z


;;A DIFFERENT VERSION COULD COMBINE THE 4 OPTIONS INTO CLASS/OBJECT O.
;;FUTURE VERSION SHOULD RETURN CLIPBOARD MEMORY AFTER DUPLICATE.
;;EXPLORER BUG: !d THEN DEL FAILS TO DELETE.  USE !d THEN ALT ALT DEL.

; *RWIN::DLLCALL("LockWorkStation")          ;USER32.DLL ENTRIES ARE CASE SENSITIVE.  INVALID ON LINUX, BUT #l IS DODGY.  * (WILDCARD MOD) IS NECESSARY FOR SHIFT+RWIN TO TRIGGER, ALONG WITH OTHER MODS.  ACCIDENTAL RWIN-LOCK IS TOO ANNOYING IF A PASSWORD IS LONG OR UNKNOWN. BUT IT COULD ALSO PREVENT SEIZURE OF A SYSTEM WHICH IS TOO DIFFICULT TO LOCK. 
; *RWIN::RUN RUNDLL32 USER32 LockWorkStation ;ALTERNATIVE CMD, TO RUNDLL32.EXE.

