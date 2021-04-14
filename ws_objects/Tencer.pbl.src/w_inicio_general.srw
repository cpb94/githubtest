$PBExportHeader$w_inicio_general.srw
forward
global type w_inicio_general from window
end type
type mdi_1 from mdiclient within w_inicio_general
end type
end forward

global type w_inicio_general from window
integer width = 4754
integer height = 2056
boolean titlebar = true
string title = "Untitled"
string menuname = "mc_aplicaciones_desarrollo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event cambiar_ventana ( )
mdi_1 mdi_1
end type
global w_inicio_general w_inicio_general

type variables
Window w
Menu m
str_parametros entrada, salida
end variables

event cambiar_ventana();String titulo, menu
Long res
//ventana_padre = this
//ventana_activa = this

entrada = Message.PowerObjectParm
menu = String(entrada.s_argumentos[2])
titulo = String(entrada.s_argumentos[1])

//close(w)

m = CREATE USING menu
w_inicio_general.changemenu(m)

res = Openwithparm(w, salida, titulo)
end event

on w_inicio_general.create
if this.MenuName = "mc_aplicaciones_desarrollo" then this.MenuID = create mc_aplicaciones_desarrollo
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_inicio_general.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;String titulo, menu
Long res
//ventana_padre = this

entrada = Message.PowerObjectParm
menu = String(entrada.s_argumentos[2])
titulo = String(entrada.s_argumentos[1])

m = CREATE USING menu
w_inicio_general.changemenu(m)

res = Openwithparm(w, salida, titulo)

boolean bValid
window wSheet
wSheet = w_inicio_general.GetFirstSheet()
IF IsValid(wSheet) THEN   
	MessageBox("Debug",wSheet.Title)
	DO 
		wSheet = w_inicio_general.GetNextSheet(wSheet)   
		bValid = IsValid (wSheet)   
		IF bValid THEN MessageBox("Debug",wSheet.Title)  
	LOOP WHILE bValid
END IF
end event

type mdi_1 from mdiclient within w_inicio_general
long BackColor=268435456
end type

