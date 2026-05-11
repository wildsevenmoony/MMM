#define ARR_SELECT(ARRAY,INDEX,DEFAULT) (if (count ARRAY > INDEX) then {ARRAY select INDEX} else {DEFAULT})
#define ANY_OF(ARRAY,CONDITION) (ARRAY findIf {CONDITION} != -1)

#define POS_X(val) "(GUI_GRID_X + (GUI_GRID_W * (val)))"
#define POS_Y(val) "(GUI_GRID_Y + (GUI_GRID_H * (val)))"
#define POS_W(val) "(GUI_GRID_W * (val))"
#define POS_H(val) "(GUI_GRID_H * (val))"

#define DIALOG_W 27
#define DIALOG_H 20
#define DIALOG_X CENTER_DIALOG_X(DIALOG_W)
#define DIALOG_Y CENTER_DIALOG_Y(DIALOG_H)

#define GUI_THEME_RGB_R "(profileNamespace getVariable ['GUI_BCG_RGB_R',0.13])"
#define GUI_THEME_RGB_G "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.54])"
#define GUI_THEME_RGB_B "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.21])"
#define GUI_THEME_ALPHA "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.8])"

#define GUI_THEME_COLOR {GUI_THEME_RGB_R,GUI_THEME_RGB_G,GUI_THEME_RGB_B,GUI_THEME_ALPHA}
#define GUI_BG_COLOR {0,0,0,0.7}

#define COLOR_SETTING_SYS(SETTING,VALUE1,VALUE2) QUOTE(with missionNamespace do {if (SETTING) then {VALUE2} else {VALUE1}})
#define COLOR_SETTING(SETTING,R1,G1,B1,A1,R2,G2,B2,A2) {COLOR_SETTING_SYS(SETTING,R1,R2),COLOR_SETTING_SYS(SETTING,G1,G2),COLOR_SETTING_SYS(SETTING,B1,B2),COLOR_SETTING_SYS(SETTING,A1,A2)}

#define COLOR_BACKGROUND_SETTING COLOR_SETTING(EGVAR(common,darkMode),1,1,1,0.1,0,0,0,0.2)

#define SELECTED_OBJECTS (curatorSelected select 0)
#define SELECTED_GROUPS (curatorSelected select 1)
#define SELECTED_WAYPOINTS (curatorSelected select 2)
#define SELECTED_MARKERS (curatorSelected select 3)

#define QUOTE(var1) #var1

#define DOUBLES(var1,var2) var1##_##var2
#define TRIPLES(var1,var2,var3) var1##_##var2##_##var3

#define ADDON DOUBLES(PREFIX,COMPONENT)
#define QADDON QUOTE(ADDON)

#define FUNC(var1) TRIPLES(PREFIX,fnc,var1)
#define FUNCMAIN(var1) TRIPLES(PREFIX,fnc,var1)
#define FUNC_INNER(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)
#define EFUNC(var1,var2) FUNC_INNER(var1,var2)
#define QFUNC(var1) QUOTE(FUNC(var1))
#define QFUNCMAIN(var1) QUOTE(FUNCMAIN(var1))
#define QFUNC_INNER(var1,var2) QUOTE(FUNC_INNER(var1,var2))
#define QEFUNC(var1,var2) QUOTE(EFUNC(var1,var2))
#define QQFUNC(var1) QUOTE(QFUNC(var1))
#define QQFUNCMAIN(var1) QUOTE(QFUNCMAIN(var1))
#define QQFUNC_INNER(var1,var2) QUOTE(QFUNC_INNER(var1,var2))
#define QQEFUNC(var1,var2) QUOTE(QEFUNC(var1,var2))

#define GVAR(var1) DOUBLES(ADDON,var1)
#define EGVAR(var1,var2) TRIPLES(PREFIX,var1,var2)
#define QGVAR(var1) QUOTE(GVAR(var1))
#define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))
#define SQGVAR(var1) 'GVAR(var1)'
#define VAR(var1) TRIPLES(PREFIX,var,var1)
#define QVAR(var1) QUOTE(VAR(var1))
#define SQVAR(var1) 'VAR(var1)'

#define ARR_2(var1,var2) var1, var2
#define ARR_3(var1,var2,var3) var1, var2, var3

#define PATHTOF_SYS(var1,var2,var3) \z\var1\addons\var2\var3
#define PATHTOF(var1) QUOTE(PATHTOF_SYS(mmm,COMPONENT,var1))
#define PATHTOEF_SYS(var1,var2,var3) \z\var1\addons\var2\var3
#define PATHTOEF(var1,var2) QUOTE(PATHTOEF_SYS(mmm,var1,var2))
