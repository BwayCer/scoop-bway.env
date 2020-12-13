鍵盤布局登入文件
=======


修改登入文件已變更鍵盤布局。


## 使用方式


將下述寫法說明並以副檔名 `.reg` 文件儲存，
然後執行該文件即可變更鍵盤布局。



### 寫法


範例：

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
"Scancode Map"=hex:00,00,00,00,\
                   00,00,00,00,\
                   03,00,00,00,\
                   38,00,1d,00,\
                   38,e0,1d,e0,\
                   00,00,00,00
```

16 進位設定：
  * 第 1 行： `00,00,00,00` 表示 header version (always 00000000)
  * 第 2 行： `00,00,00,00` 表示 header flags (always 00000000)
  * 第 3 行： `03,00,00,00` 以一個位元組表示設定項目的數量 (含空白的結尾終止符)
  * 第 4 行： `38,00,1d,00` 表示 Left  CTRL -> Left  ALT
  * 第 5 行： `38,e0,1d,e0` 表示 Right CTRL -> Right ALT
  * 第 6 行： `00,00,00,00` 表示結尾終止符


還原鍵盤預設設定：

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
"Scancode Map"=hex:00,00,00,00,\
                   00,00,00,00,\
                   01,00,00,00,\
                   00,00,00,00
```



### 按鍵對應表:


```text
(ARK = Arrow Keys)
(ApK = Application Keys)
(FLK = F-Lock Keys)
(MK = Media Keys)
(MsK = Microsoft Natural Multimedia Keyboard)
(NK = Number Pad Keys)
(SC = Scan Code)
(SC = Scan Code)
(SK = Special Keyse)
(WK = Web Keys)

SC    Key              SC    Key                SC    Key
                       20 00 D                  40 00 F6
01 00 Escape           21 00 F                  41 00 F7
02 00 1 !              22 00 G                  42 00 F8
03 00 2 @              23 00 H                  43 00 F9
04 00 3 #              24 00 J                  44 00 F10
05 00 4 $              25 00 K                  45 00 Num Lock (SK)
06 00 5 %              26 00 L                  46 00 Scroll Lock (SK)
07 00 6 ^              27 00 ; :                47 00 7 (NK)
08 00 7 &              28 00 ' "                48 00 8 (NK)
09 00 8 *              29 00 ` ~                49 00 9 (NK)
0A 00 9 (              2A 00 Left Shift (SK)    4A 00 - (NK)
0B 00 0 )              2B 00 \ |                4B 00 4 (NK)
0C 00 - _              2C 00 Z                  4C 00 5 (NK)
0D 00 = +              2D 00 X                  4D 00 6 (NK)
0E 00 Backspace (SK)   2E 00 C                  4E 00 + (NK)
0F 00 Tab              2F 00 V                  4F 00 1 (NK)
10 00 Q                30 00 B                  50 00 2 (NK)
11 00 W                31 00 N                  51 00 3 (NK)
12 00 E                32 00 M                  52 00 0 (NK)
13 00 R                33 00 , <                53 00 . (NK)
14 00 T                34 00 . >                57 00 F11
15 00 Y                35 00 / ?                58 00 F12
16 00 U                36 00 Right Shift (SK)
17 00 I                37 00 * (NK)
18 00 O                38 00 Left Alt (SK)
19 00 P                39 00 Space (SK)
1A 00 [ {              3A 00 Caps Lock (SK)
1B 00 ] }              3B 00 F1
1C 00 Enter            3C 00 F2                 64 00 F13
1D 00 Left Ctrl (SK)   3D 00 F3                 65 00 F14
1E 00 A                3E 00 F4                 66 00 F15
1F 00 S                3F 00 F5                 7D 00 (Non-English Keyboard)

SC    Key                        SC    Key                       SC    Key
07 E0 Redo (FLK)                 50 E0 Down Arrow (ArK)          05 E0 Messenger (MsK)
08 E0 Undo (FLK)                 51 E0 Page Down (SK)            07 E0 Redo (on F3 key) (MsK)
10 E0 Prev Track (MK)            52 E0 Insert (SK)               08 E0 Undo (on F2 key) (MsK)
11 E0 Messenger (ApK)            53 E0 Delete (SK)               10 E0 |<< (Previous) (MsK)
19 E0 Next Track (MK)            56 E0 (Nternational Keyboard)   16 E0 Log Off (MsK)
1C E0 Enter (NK)                 57 E0 Save (FLK)                19 E0 >>| (Next) (MsK)
1D E0 Right Ctrl (SK)            58 E0 Print (FLK)               20 E0 Mute (MsK)
20 E0 Mute (MK)                  5B E0 Left Windows (SK)         21 E0 Calculator (MsK)
21 E0 Calculator (ApK)           5C E0 Right Windows (SK)        22 E0 Play/Pause (MsK)
22 E0 Play/Pause (MK)            5D E0 Application (SK)          23 E0 Spell (on F10 key) (MsK)
23 E0 Spell (FLK)                5E E0 Power (SK)                24 E0 Stop (MsK)
24 E0 Stop (MK)                  5F E0 Sleep (SK)                2E E0 - (Volume down) (MsK)
2B E0 (Nternational Keyboard)    63 E0 Wake (SK)                 30 E0 + (Volume up) (MsK)
2E E0 Volume Down (MK)           65 E0 Search (WK)               32 E0 Web/Home (MsK)
30 E0 Volume Up (MK)             66 E0 Favorites (WK)            3B E0 Help (on F1 key) (MsK)
32 E0 HOME (WK)                  67 E0 Refresh (WK)              3C E0 My Music (MsK)
35 E0 / (NK)                     68 E0 Stop (WK)                 42 E0 Fwd (on F8 key) (MsK)
37 E0 PrtSc (SK)                 69 E0 Forward (WK)              43 E0 Send (on F9 key) (MsK)
38 E0 Right Alt (SK)             6A E0 Back (WK)                 57 E0 Save (on F11 key) (MsK)
3B E0 Help (FLK)                 6B E0 My Computer (ApK)         58 E0 Print (on F12 key) (MsK)
3C E0 Office Home (FLK)          6C E0 E-Mail (ApK)              5F E0 Sleep (MsK)
3D E0 Task Pane (FLK)            6D E0 Media Select (ApK)        64 E0 My Pictures (MsK)
3E E0 New (FLK)                  70 E0 (Far East Keyboard)       6C E0 Mail (MsK)
3F E0 Open (FLK)                 73 E0 (Brazilian Keyboard)      6D E0 Media (MsK)
40 E0 Close (FLK)                77 E0 (Far East Keyboard)
41 E0 Reply (FLK)                79 E0 (Far East Keyboard)
42 E0 Fwd (FLK)                  7B E0 (Far East Keyboard)
43 E0 Send (FLK)
45 E0 (Non-English Keyboard)
47 E0 HOME (SK)
48 E0 Up Arrow (ArK)
49 E0 Page Up (SK)
4B E0 Left Arrow (ArK)
4D E0 Right Arrow (ArK)
4F E0 End (SK)
```



## 參考


* https://superuser.com/questions/1190329
* 按鍵對應表
  * https://wiki.edgarbv.com/index.php/Remapping_Keyboard_Keys

