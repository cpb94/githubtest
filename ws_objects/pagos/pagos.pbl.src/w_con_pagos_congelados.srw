$PBExportHeader$w_con_pagos_congelados.srw
forward
global type w_con_pagos_congelados from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_congelados
end type
type uo_1 from u_manejo_datawindow within w_con_pagos_congelados
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_congelados
end type
type dw_listado from datawindow within w_con_pagos_congelados
end type
type dw_1 from datawindow within w_con_pagos_congelados
end type
type cb_1 from commandbutton within w_con_pagos_congelados
end type
type uo_tipo2 from u_marca_lista within w_con_pagos_congelados
end type
end forward

global type w_con_pagos_congelados from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 2148
pb_2 pb_2
uo_1 uo_1
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
cb_1 cb_1
uo_tipo2 uo_tipo2
end type
global w_con_pagos_congelados w_con_pagos_congelados

type variables
String situacion= "0"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros

dw_data.reset()
uo_tipo2.visible   = FALSE
dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()

dw_data.Retrieve(codigo_empresa)


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " Consulta pagos congelados"

f_cargar(dw_1)







end event

on w_con_pagos_congelados.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_tipo2=create uo_tipo2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_tipo2
end on

on w_con_pagos_congelados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_tipo2)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_congelados
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_congelados
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_congelados
integer x = 78
integer y = 16
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_congelados
integer x = 2734
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type uo_1 from u_manejo_datawindow within w_con_pagos_congelados
integer x = 2240
integer y = 148
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_imprimir_preli from picturebutton within w_con_pagos_congelados
integer x = 2720
integer y = 192
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_pagos_congelados
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_banco"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_pagos_congelados
integer x = 5
integer y = 308
integer width = 2853
integer height = 1616
string dataobject = "dw_con_pagos_congelados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
    dec anyo,orden
	 anyo  = This.GetItemNumber(Row,"anyo")
	 orden = This.GetItemNumber(Row,"orden")

     UPDATE carpagos  
     SET    asignar_banco = 'S'  
     WHERE  (carpagos.empresa = :codigo_empresa ) AND  
            (carpagos.anyo = :anyo ) AND  
            (carpagos.orden = :orden )   

     commit;
	  f_cargar(dw_1)
End If
end event

event rbuttondown;long anyo,orden

if row > 0 then
	anyo  = this.object.anyo[row]
	orden = this.object.orden[row]
	f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
end if
end event

type cb_1 from commandbutton within w_con_pagos_congelados
integer x = 5
integer y = 212
integer width = 622
integer height = 88
integer taborder = 1
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Descongelar todos"
end type

event clicked;integer registros,Xx
dec{0} anyo,orden

registros = dw_1.RowCount()

if registros<>0 then 
  for Xx=1 to registros
    
	   anyo  = dw_1.GetItemNumber(Xx,"anyo")
	   orden = dw_1.GetItemNumber(Xx,"orden")

     UPDATE carpagos  
     SET    asignar_banco = 'S'  
     WHERE  (carpagos.empresa = :codigo_empresa ) AND  
            (carpagos.anyo    = :anyo ) AND  
            (carpagos.orden   = :orden ) ;  
     
  next
  commit;    
  f_cargar(dw_1)
  
End if

end event

type uo_tipo2 from u_marca_lista within w_con_pagos_congelados
boolean visible = false
integer x = 873
integer y = 664
integer width = 1371
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

