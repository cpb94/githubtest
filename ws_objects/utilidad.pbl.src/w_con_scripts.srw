$PBExportHeader$w_con_scripts.srw
forward
global type w_con_scripts from w_int_con_empresa
end type
type dw_1 from datawindow within w_con_scripts
end type
type cb_1 from commandbutton within w_con_scripts
end type
type dw_2 from datawindow within w_con_scripts
end type
type cb_2 from commandbutton within w_con_scripts
end type
end forward

global type w_con_scripts from w_int_con_empresa
integer width = 3433
integer height = 2152
dw_1 dw_1
cb_1 cb_1
dw_2 dw_2
cb_2 cb_2
end type
global w_con_scripts w_con_scripts

on w_con_scripts.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_2
end on

on w_con_scripts.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.cb_2)
end on

event open;call super::open;title='Consulta de scripts'
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_scripts
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_scripts
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_scripts
end type

type dw_1 from datawindow within w_con_scripts
integer x = 23
integer y = 264
integer width = 3291
integer height = 896
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_scripts"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_con_scripts
integer x = 306
integer y = 152
integer width = 306
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string cadena,libreria,todo
long pos_ini,pos_fin,cont,linea,ultima

cadena=profilestring('c:\archivos de programa\sybase\pb6\pb.ini','Application','$D:\jobers\equipe\equipe.pbl(equipe)','')


pos_ini=1
pos_fin=0
ultima=1
pos_fin=pos(cadena,';',1)

DO WHILE pos_fin<>0
	libreria=mid(cadena,pos_ini,pos_fin  - pos_ini)
	todo=librarydirectory(libreria,dirall!)
	dw_1.importstring(todo)		
	for cont=ultima to dw_1.rowcount()
		dw_1.object.libreria[cont]=libreria
	next
	ultima=dw_1.rowcount()
	pos_ini=pos_fin+1
	pos_fin=pos(cadena,';',pos_ini)
LOOP

dw_1.setsort("nombre")
dw_1.sort()

for cont=1 to dw_1.rowcount() - 1
	if dw_1.object.nombre[cont]=dw_1.object.nombre[cont+1] then
		//f_mensaje("Repetido!",dw_1.object.nombre[cont])
		linea=dw_2.insertrow(0)
		dw_2.object.nombre[linea]=dw_1.object.nombre[cont]
		dw_2.object.libreria[linea]=mid(dw_1.object.libreria[cont],4,200)
		dw_2.object.libreria2[linea]=mid(dw_1.object.libreria[cont+1],4,200)
	end if
next
end event

type dw_2 from datawindow within w_con_scripts
integer x = 27
integer y = 1164
integer width = 3287
integer height = 688
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_scripts2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within w_con_scripts
integer x = 1175
integer y = 144
integer width = 302
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;dw_2.print()
end event

