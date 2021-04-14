$PBExportHeader$w_con_reservas_especificaciones.srw
forward
global type w_con_reservas_especificaciones from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_reservas_especificaciones
end type
type pb_1 from upb_imprimir within w_con_reservas_especificaciones
end type
type dw_listado from datawindow within w_con_reservas_especificaciones
end type
type uo_1 from u_manejo_datawindow within w_con_reservas_especificaciones
end type
type gb_2 from groupbox within w_con_reservas_especificaciones
end type
type cb_1 from commandbutton within w_con_reservas_especificaciones
end type
type cb_2 from commandbutton within w_con_reservas_especificaciones
end type
type cb_3 from commandbutton within w_con_reservas_especificaciones
end type
type uo_familia from u_marca_lista within w_con_reservas_especificaciones
end type
type uo_formato from u_marca_lista within w_con_reservas_especificaciones
end type
type uo_subfamilia from u_marca_lista within w_con_reservas_especificaciones
end type
type uo_subformato from u_marca_lista within w_con_reservas_especificaciones
end type
type dw_1 from u_datawindow_consultas within w_con_reservas_especificaciones
end type
type cb_4 from commandbutton within w_con_reservas_especificaciones
end type
type cb_5 from commandbutton within w_con_reservas_especificaciones
end type
end forward

global type w_con_reservas_especificaciones from w_int_con_empresa
integer x = 5
integer y = 792
integer width = 2930
integer height = 1688
string title = "Consulta de Movimientos"
pb_2 pb_2
pb_1 pb_1
dw_listado dw_listado
uo_1 uo_1
gb_2 gb_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
uo_familia uo_familia
uo_formato uo_formato
uo_subfamilia uo_subfamilia
uo_subformato uo_subformato
dw_1 dw_1
cb_4 cb_4
cb_5 cb_5
end type
global w_con_reservas_especificaciones w_con_reservas_especificaciones

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_caja
Integer   var_calibre
String  devolver,var_tono
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string formatos[],familias[]
string subformatos[],subfamilias[]
long   i,indice_for,indice_fam,total,donde,indice
long   indice_subfam,indice_subfor
string nombre_formatos,nombre_subformatos
string nombre_familias,nombre_subfamilias

for i=1 to 50
	familias[i]=""
	subfamilias[i]=""
	formatos[i]=""
	subformatos[i]=""
next

indice_fam = 1
nombre_familias = ""
for i=1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
		familias[indice_fam] = uo_familia.dw_marca.getitemstring(i,"codigo")
		indice_fam ++
		if nombre_familias = "" then
			nombre_familias = f_nombre_familia(codigo_empresa,familias[indice_fam -1])
		else
			nombre_familias = nombre_familias+","+f_nombre_familia(codigo_empresa,familias[indice_fam -1])
		end if
	end if	
next
if (indice_fam -1) = uo_familia.dw_marca.rowcount() then
	nombre_familias = "todas las familias"
end if

indice_subfam = 1
nombre_subfamilias = ""
for i=1 to uo_subfamilia.dw_marca.rowcount()
	if uo_subfamilia.dw_marca.getitemstring(i,"marca")="S" then
		subfamilias[indice_subfam] = uo_subfamilia.dw_marca.getitemstring(i,"codigo")
		indice_subfam ++
		if nombre_subfamilias = "" then
			nombre_subfamilias = f_nombre_subfamilia_abr(codigo_empresa,subfamilias[indice_subfam -1])
		else
			nombre_subfamilias = nombre_subfamilias+","+f_nombre_subfamilia_abr(codigo_empresa,subfamilias[indice_subfam -1])
		end if
	end if	
next
if (indice_subfam -1) = uo_subfamilia.dw_marca.rowcount() then
	nombre_subfamilias = "todas las Subfamilias"
end if

indice_for = 1
nombre_formatos = ""
for i=1 to uo_formato.dw_marca.rowcount()
	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
		formatos[indice_for] = uo_formato.dw_marca.getitemstring(i,"codigo")
		indice_for ++
		if nombre_formatos = "" then
			nombre_formatos = f_nombre_formato_abr(codigo_empresa,formatos[indice_for -1])
		else
			nombre_formatos = nombre_formatos+","+f_nombre_formato_abr(codigo_empresa,formatos[indice_for -1])
		end if		
	end if
next
if (indice_for -1) = uo_formato.dw_marca.rowcount() then
	nombre_formatos = "todos los Formatos"
end if

indice_subfor = 1
nombre_subformatos = ""
for i=1 to uo_subformato.dw_marca.rowcount()
	if uo_subformato.dw_marca.getitemstring(i,"marca")="S" then
		subformatos[indice_subfor] = uo_subformato.dw_marca.getitemstring(i,"codigo")
		indice_subfor ++
		if nombre_subformatos = "" then
			nombre_subformatos = f_nombre_subformato_abr(codigo_empresa,subformatos[indice_subfor -1])
		else
			nombre_subformatos = nombre_subformatos+","+f_nombre_subformato_abr(codigo_empresa,subformatos[indice_subfor -1])
		end if		
	end if
next
if (indice_subfor -1) = uo_subformato.dw_marca.rowcount() then
	nombre_subformatos = "todos los Subformatos"
end if

uo_familia.visible    = False
uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False

data.retrieve(codigo_empresa,familias,subfamilias,formatos,subformatos,nombre_familias,nombre_subfamilias,nombre_formatos,nombre_subformatos)


end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = "Consulta reservas por especificaciones"

uo_familia.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
uo_subfamilia.f_cargar_datos("dw_ayuda_subfamilias","","","Subfamilia","Descripción")
uo_formato.f_cargar_datos("dw_ayuda_formatos","","","Formato","Descripción")
uo_subformato.f_cargar_datos("dw_ayuda_subformatos","","","Subformato","Descripción")


end event

on w_con_reservas_especificaciones.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.uo_1=create uo_1
this.gb_2=create gb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.uo_familia=create uo_familia
this.uo_formato=create uo_formato
this.uo_subfamilia=create uo_subfamilia
this.uo_subformato=create uo_subformato
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.uo_familia
this.Control[iCurrent+10]=this.uo_formato
this.Control[iCurrent+11]=this.uo_subfamilia
this.Control[iCurrent+12]=this.uo_subformato
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.cb_4
this.Control[iCurrent+15]=this.cb_5
end on

on w_con_reservas_especificaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.uo_1)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.uo_familia)
destroy(this.uo_formato)
destroy(this.uo_subfamilia)
destroy(this.uo_subformato)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_5)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.triggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.triggerEvent("linea_arriba")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.triggerEvent("pagina_arriba")

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.triggerEvent("pagina_abajo")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_reservas_especificaciones
integer taborder = 120
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_reservas_especificaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_reservas_especificaciones
integer y = 20
integer width = 2587
end type

type pb_2 from upb_salir within w_con_reservas_especificaciones
integer x = 2697
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type pb_1 from upb_imprimir within w_con_reservas_especificaciones
integer x = 2734
integer y = 164
integer width = 96
integer height = 84
integer taborder = 20
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_con_reservas_especificaciones
boolean visible = false
integer x = 9
integer width = 494
integer height = 236
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_con_reservas_especificaciones"
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_con_reservas_especificaciones
integer x = 2254
integer y = 116
end type

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

event valores;call super::valores;dw_data=dw_1

end event

type gb_2 from groupbox within w_con_reservas_especificaciones
integer x = 343
integer y = 120
integer width = 1902
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_con_reservas_especificaciones
integer x = 1454
integer y = 160
integer width = 366
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubFormatos"
end type

event clicked;uo_familia.visible    = False
uo_subfamilia.visible = False
uo_formato.visible    = False
if uo_subformato.visible = True then
   uo_subformato.visible = False
else
	uo_subformato.visible = True
End if
end event

type cb_2 from commandbutton within w_con_reservas_especificaciones
integer x = 1879
integer y = 160
integer width = 352
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_control(dw_1)
end event

type cb_3 from commandbutton within w_con_reservas_especificaciones
integer x = 722
integer y = 160
integer width = 366
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubFamilias"
end type

event clicked;uo_familia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
if uo_subfamilia.visible = True then
   uo_subfamilia.visible = False
else
	uo_subfamilia.visible = True
End if
end event

type uo_familia from u_marca_lista within w_con_reservas_especificaciones
event destroy ( )
boolean visible = false
integer x = 357
integer y = 288
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

type uo_formato from u_marca_lista within w_con_reservas_especificaciones
event destroy ( )
boolean visible = false
integer x = 1083
integer y = 288
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on uo_formato.destroy
call u_marca_lista::destroy
end on

type uo_subfamilia from u_marca_lista within w_con_reservas_especificaciones
event destroy ( )
boolean visible = false
integer x = 722
integer y = 288
integer taborder = 80
boolean border = false
end type

on uo_subfamilia.destroy
call u_marca_lista::destroy
end on

type uo_subformato from u_marca_lista within w_con_reservas_especificaciones
event destroy ( )
boolean visible = false
integer x = 1458
integer y = 288
integer taborder = 90
boolean border = false
end type

on uo_subformato.destroy
call u_marca_lista::destroy
end on

type dw_1 from u_datawindow_consultas within w_con_reservas_especificaciones
integer x = 5
integer y = 296
integer width = 2848
integer height = 1164
integer taborder = 130
string dataobject = "dw_con_reservas_especificaciones"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_4 from commandbutton within w_con_reservas_especificaciones
integer x = 357
integer y = 160
integer width = 366
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
if uo_familia.visible = True then
   uo_familia.visible = False
else
	uo_familia.visible = True
End if
end event

type cb_5 from commandbutton within w_con_reservas_especificaciones
integer x = 1088
integer y = 160
integer width = 366
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;uo_familia.visible    = False
uo_subfamilia.visible = False
uo_subformato.visible = False
if uo_formato.visible = True then
   uo_formato.visible = False
else
	uo_formato.visible = True
End if
end event

