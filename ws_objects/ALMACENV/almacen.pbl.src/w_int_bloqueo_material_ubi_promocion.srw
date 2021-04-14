$PBExportHeader$w_int_bloqueo_material_ubi_promocion.srw
forward
global type w_int_bloqueo_material_ubi_promocion from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_bloqueo_material_ubi_promocion
end type
type dw_listado from datawindow within w_int_bloqueo_material_ubi_promocion
end type
type pb_imprimir_preli from picturebutton within w_int_bloqueo_material_ubi_promocion
end type
type dw_1 from datawindow within w_int_bloqueo_material_ubi_promocion
end type
type uo_1 from u_manejo_datawindow within w_int_bloqueo_material_ubi_promocion
end type
type st_1 from statictext within w_int_bloqueo_material_ubi_promocion
end type
type em_1 from u_em_campo within w_int_bloqueo_material_ubi_promocion
end type
type cb_1 from u_boton within w_int_bloqueo_material_ubi_promocion
end type
type cb_3 from u_boton within w_int_bloqueo_material_ubi_promocion
end type
type ddlb_1 from dropdownlistbox within w_int_bloqueo_material_ubi_promocion
end type
end forward

global type w_int_bloqueo_material_ubi_promocion from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2912
integer height = 1632
pb_2 pb_2
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
uo_1 uo_1
st_1 st_1
em_1 em_1
cb_1 cb_1
cb_3 cb_3
ddlb_1 ddlb_1
end type
global w_int_bloqueo_material_ubi_promocion w_int_bloqueo_material_ubi_promocion

type variables
String ante_articulo,retrasos,variable
String marcado = "1"
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Setredraw(False)

CHOOSE CASE variable
	CASE "T"
     dw_1.Setfilter("")
     dw_1.filter()
	CASE "B"
     dw_1.Setfilter("")
     dw_1.filter()
	  dw_1.Setfilter("numero <>0")
     dw_1.filter()
END CHOOSE

dw_1.Retrieve(codigo_empresa,"%"+String(em_1.text)+"%")
dw_1.Setredraw(True)



end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(codigo_empresa)
CALL Super::ue_listar
end event

event open;call super::open;String mascara

dw_1.SetTransObject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)
This.title = " Introducción bloqueo de material (Promocion) por ubicacion"

ddlb_1.text = "Todos"
variable = "T"
f_activar_campo(em_1)


end event

on w_int_bloqueo_material_ubi_promocion.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_1=create st_1
this.em_1=create em_1
this.cb_1=create cb_1
this.cb_3=create cb_3
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_1
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.ddlb_1
end on

on w_int_bloqueo_material_ubi_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.ddlb_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_bloqueo_material_ubi_promocion
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_bloqueo_material_ubi_promocion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_bloqueo_material_ubi_promocion
integer x = 27
integer y = 20
integer width = 2574
end type

type pb_2 from upb_salir within w_int_bloqueo_material_ubi_promocion
integer x = 2693
integer y = 16
integer width = 123
integer height = 108
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type dw_listado from datawindow within w_int_bloqueo_material_ubi_promocion
boolean visible = false
integer x = 526
integer width = 160
integer height = 92
boolean bringtotop = true
string dataobject = "report_con_ubicaciones_bloqueo_promocion"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_int_bloqueo_material_ubi_promocion
integer x = 2697
integer y = 160
integer width = 105
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;Parent.TriggerEvent("ue_listar")
end event

type dw_1 from datawindow within w_int_bloqueo_material_ubi_promocion
integer x = 18
integer y = 280
integer width = 2811
integer height = 1060
string dataobject = "dw_w_int_bloqueo_material_ubi1_promocion"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This)= "marcado" Then
	IF marcado = "1" Then
		marcado = "0"
		This.SetFilter("marca= '*'")
		This.Filter()
	ELSE
		This.SetFilter("")
		This.Reset()
		marcado = "1"
		f_control()
	END IF

END IF
end event

type uo_1 from u_manejo_datawindow within w_int_bloqueo_material_ubi_promocion
integer x = 2222
integer y = 116
integer width = 613
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type st_1 from statictext within w_int_bloqueo_material_ubi_promocion
integer x = 23
integer y = 160
integer width = 270
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Material:"
boolean focusrectangle = false
end type

type em_1 from u_em_campo within w_int_bloqueo_material_ubi_promocion
integer x = 311
integer y = 160
integer width = 905
integer taborder = 10
end type

type cb_1 from u_boton within w_int_bloqueo_material_ubi_promocion
integer x = 1234
integer y = 164
integer width = 411
integer height = 80
integer taborder = 30
string text = "&Continuar"
end type

event clicked;call super::clicked;CHOOSE CASE ddlb_1.text
		CASE "Todos"
			variable="T"
		CASE "Bloqueados"
			variable="B"
		CASE "Incidencias"
			variable="I"
END CHOOSE

f_control()
f_activar_campo(em_1)
end event

type cb_3 from u_boton within w_int_bloqueo_material_ubi_promocion
integer x = 2395
integer y = 1344
integer width = 448
integer height = 72
integer taborder = 0
string text = "&Des/Bloquear"
end type

event clicked;call super::clicked;STring ubicacion,referencia,tipo_pallet
Dec linea,numero
DateTime fecha
ubicacion   = dw_1.GetItemstring(dw_1.GetRow(),"almlinubica_ubicacion")
linea       = dw_1.GetItemNumber(dw_1.GetRow(),"almlinubica_linea")
referencia    = dw_1.GetItemString(dw_1.GetRow(),"almlinubica_referencia")
tipo_pallet   = dw_1.GetItemString(dw_1.GetRow(),"almlinubica_tipo_pallet")
Select Count(*) Into :numero From almlinubica_bloqueo_promocion
Where almlinubica_bloqueo_promocion.empresa     = :codigo_empresa
And   almlinubica_bloqueo_promocion.ubicacion   = :ubicacion
And   almlinubica_bloqueo_promocion.linea       = :linea;
IF IsNull(numero) Then numero = 0
If numero = 0 Then
		fecha = DateTime(Today(),Now())
		  INSERT INTO almlinubica_bloqueo_promocion  
         ( empresa,ubicacion,linea,   
           fecha,   
           usuario,
			  referencia,
			  tipo_pallet)  
  VALUES ( :codigo_empresa,   
           :ubicacion,   
           :linea,   
           :fecha,   
           :nombre_usuario,
			  :referencia,
			  :tipo_pallet)  ;

Else
	Delete from almlinubica_bloqueo_promocion
	Where almlinubica_bloqueo_promocion.empresa     = :codigo_empresa
	And   almlinubica_bloqueo_promocion.ubicacion   = :ubicacion
	And   almlinubica_bloqueo_promocion.linea       = :linea;
END IF
COMMIT;
dw_1.SetItem(dw_1.GetRow(),"almlinubica_ubicacion",ubicacion)
f_activar_campo(em_1)
end event

type ddlb_1 from dropdownlistbox within w_int_bloqueo_material_ubi_promocion
integer x = 1751
integer y = 156
integer width = 453
integer height = 324
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Bloqueados","Todos"}
end type

