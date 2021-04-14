$PBExportHeader$w_int_bloqueo_material_ubi.srw
forward
global type w_int_bloqueo_material_ubi from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_bloqueo_material_ubi
end type
type dw_proceso from datawindow within w_int_bloqueo_material_ubi
end type
type dw_listado from datawindow within w_int_bloqueo_material_ubi
end type
type pb_imprimir_preli from picturebutton within w_int_bloqueo_material_ubi
end type
type dw_1 from datawindow within w_int_bloqueo_material_ubi
end type
type uo_1 from u_manejo_datawindow within w_int_bloqueo_material_ubi
end type
type st_1 from statictext within w_int_bloqueo_material_ubi
end type
type em_1 from u_em_campo within w_int_bloqueo_material_ubi
end type
type cb_1 from u_boton within w_int_bloqueo_material_ubi
end type
type dw_observaciones from datawindow within w_int_bloqueo_material_ubi
end type
type em_observaciones from u_em_campo within w_int_bloqueo_material_ubi
end type
type cb_2 from u_boton within w_int_bloqueo_material_ubi
end type
type cb_3 from u_boton within w_int_bloqueo_material_ubi
end type
type st_2 from statictext within w_int_bloqueo_material_ubi
end type
type ddlb_1 from dropdownlistbox within w_int_bloqueo_material_ubi
end type
end forward

global type w_int_bloqueo_material_ubi from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2903
integer height = 1632
pb_2 pb_2
dw_proceso dw_proceso
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
uo_1 uo_1
st_1 st_1
em_1 em_1
cb_1 cb_1
dw_observaciones dw_observaciones
em_observaciones em_observaciones
cb_2 cb_2
cb_3 cb_3
st_2 st_2
ddlb_1 ddlb_1
end type
global w_int_bloqueo_material_ubi w_int_bloqueo_material_ubi

type variables
String ante_articulo,retrasos,variable
String marcado = "1"
end variables

forward prototypes
public subroutine f_observaciones (integer reg)
public subroutine f_control ()
public subroutine f_insertar_observaciones (string empresa, string ubicacion, decimal linea, string observaciones, string referencia, string tipo_pallet)
end prototypes

public subroutine f_observaciones (integer reg);IF reg = 0 Then Return
IF dw_1.RowCount() =0 Then Return
String ubicacion,zona,almacen
Dec    fila,altura
almacen = dw_1.GetItemString(reg,"almlinubica_almacen")
zona    = dw_1.GetItemString(reg,"zona")
fila    = dw_1.GetItemNumber(reg,"almlinubica_fila")
altura  = dw_1.GetItemNumber(reg,"almlinubica_altura")

Dec linea
ubicacion = f_componer_ubicacion(almacen,zona,fila,altura)
linea    = dw_1.GetItemNumber(reg,"almlinubica_linea")
dw_observaciones.Retrieve(codigo_empresa,ubicacion,linea)
end subroutine

public subroutine f_control ();dw_1.Setredraw(False)

CHOOSE CASE variable
	CASE "T"
     dw_1.Setfilter("")
     dw_1.filter()
	CASE "I"
     dw_1.Setfilter("")
     dw_1.filter()
     dw_1.Setfilter("numero <> 0")
     dw_1.filter()
	CASE "B"
     dw_1.Setfilter("")
     dw_1.filter()
	  dw_1.Setfilter("bloqueo <>0")
     dw_1.filter()
END CHOOSE

dw_1.Retrieve(codigo_empresa,"%"+String(em_1.text)+"%")
dw_1.Setredraw(True)



end subroutine

public subroutine f_insertar_observaciones (string empresa, string ubicacion, decimal linea, string observaciones, string referencia, string tipo_pallet);Integer orden
DateTime   fecha
Select Max(orden) Into :orden From almlinubica_observaciones
Where  almlinubica_observaciones.empresa   = :codigo_empresa
And    almlinubica_observaciones.ubicacion = :ubicacion
And    almlinubica_observaciones.linea     = :linea;
IF IsNull(orden) Then orden = 0
orden = orden +1
fecha = DateTime(Today(),Now())
  INSERT INTO almlinubica_observaciones  
         ( empresa,   
           ubicacion,   
           linea,   
           orden,   
           fecha,   
           usuario,   
           observaciones,
			  referencia,
			  tipo_pallet)  
  VALUES ( :empresa,   
           :ubicacion,   
           :linea,   
           :orden,   
           :fecha,   
           :nombre_usuario,   
           :observaciones,
			  :referencia,
			  :tipo_pallet)  ;
		




end subroutine

event open;call super::open;String mascara

dw_1.SetTransObject(sqlca)
dw_observaciones.SetTransObject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)
This.title = " Introducción bloqueo de material por ubicacion"

ddlb_1.text = "Todos"
variable = "T"
f_activar_campo(em_1)


end event

on w_int_bloqueo_material_ubi.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_1=create st_1
this.em_1=create em_1
this.cb_1=create cb_1
this.dw_observaciones=create dw_observaciones
this.em_observaciones=create em_observaciones
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.em_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_observaciones
this.Control[iCurrent+11]=this.em_observaciones
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.ddlb_1
end on

on w_int_bloqueo_material_ubi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.dw_observaciones)
destroy(this.em_observaciones)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_2)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_bloqueo_material_ubi
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_bloqueo_material_ubi
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_bloqueo_material_ubi
integer x = 27
integer y = 20
integer width = 2574
end type

type pb_2 from upb_salir within w_int_bloqueo_material_ubi
integer x = 2693
integer y = 16
integer width = 123
integer height = 108
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type dw_proceso from datawindow within w_int_bloqueo_material_ubi
boolean visible = false
integer x = 27
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_almtipomov"
boolean livescroll = true
end type

type dw_listado from datawindow within w_int_bloqueo_material_ubi
boolean visible = false
integer x = 526
integer width = 160
integer height = 92
boolean bringtotop = true
string dataobject = "report_con_ubicaciones_bloqueo"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_int_bloqueo_material_ubi
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
string picturename = "\bmp\print.bmp"
end type

event clicked;CHOOSE CASE ddlb_1.text
		CASE "Todos"
			variable="T"
		CASE "Bloqueados"
			variable="B"
		CASE "Incidencias"
			variable="I"
END CHOOSE

dw_listado.SetTransObject(SQLCA)

CHOOSE CASE variable
	CASE "T"
     dw_listado.Setfilter("")
     dw_listado.filter()
	CASE "I"
     dw_listado.Setfilter("")
     dw_listado.filter()
     dw_listado.Setfilter("cnumero <> 0")
     dw_listado.filter()
	CASE "B"
     dw_listado.Setfilter("")
     dw_listado.filter()
	  dw_listado.Setfilter("cbloqueo <>0")
     dw_listado.filter()
END CHOOSE

dw_listado.Retrieve(codigo_empresa)
f_imprimir_datawindow(dw_listado)

end event

type dw_1 from datawindow within w_int_bloqueo_material_ubi
integer x = 14
integer y = 280
integer width = 2811
integer height = 816
string dataobject = "dw_w_int_bloqueo_material_ubi1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;f_observaciones(row)
IF f_objeto_datawindow(This)= "marcado" Then
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

event rowfocuschanged;f_observaciones(currentrow)
		


end event

type uo_1 from u_manejo_datawindow within w_int_bloqueo_material_ubi
integer x = 2222
integer y = 116
integer width = 613
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type st_1 from statictext within w_int_bloqueo_material_ubi
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

type em_1 from u_em_campo within w_int_bloqueo_material_ubi
integer x = 311
integer y = 160
integer width = 905
integer taborder = 10
end type

type cb_1 from u_boton within w_int_bloqueo_material_ubi
integer x = 1221
integer y = 156
integer width = 411
integer height = 92
integer taborder = 20
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

type dw_observaciones from datawindow within w_int_bloqueo_material_ubi
integer x = 18
integer y = 1100
integer width = 2272
integer height = 220
boolean bringtotop = true
string dataobject = "dw_w_int_bloqueo_material_ubi2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_observaciones from u_em_campo within w_int_bloqueo_material_ubi
integer x = 489
integer y = 1336
integer width = 1806
integer taborder = 0
end type

type cb_2 from u_boton within w_int_bloqueo_material_ubi
integer x = 2336
integer y = 1332
integer width = 334
integer height = 92
integer taborder = 0
string text = "&Grabar"
end type

event clicked;call super::clicked;IF dw_1.GetRow() = 0 Then
	f_mensaje("Error en introducción de datos","Marcar una linea")
	f_activar_campo(em_observaciones)
	Return
END IF
IF IsNUll(em_observaciones.text) Or Trim(em_observaciones.text) = "" Then
	f_mensaje("Error en introducción de datos","Introduzca las observaciones a grabar")
	f_activar_campo(em_observaciones)
	Return
END IF
STring ubicacion,referencia,tipo_pallet
Dec linea
ubicacion     = dw_1.GetItemstring(dw_1.GetRow(),"almlinubica_ubicacion")
linea         = dw_1.GetItemNumber(dw_1.GetRow(),"almlinubica_linea")
referencia    = dw_1.GetItemString(dw_1.GetRow(),"almlinubica_referencia")
tipo_pallet   = dw_1.GetItemString(dw_1.GetRow(),"almlinubica_tipo_pallet")
f_insertar_observaciones(codigo_empresa,ubicacion,linea,em_observaciones.text,referencia,tipo_pallet)
f_observaciones(dw_1.GetRow())
dw_1.SetItem(dw_1.GetRow(),"almlinubica_ubicacion",ubicacion)
dw_1.SetItem(dw_1.GetRow(),"numero",1)
em_observaciones.text =""
f_activar_campo(em_1)
end event

type cb_3 from u_boton within w_int_bloqueo_material_ubi
integer x = 2341
integer y = 1152
integer width = 448
integer height = 92
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
Select Count(*) Into :numero From almlinubica_bloqueo
Where almlinubica_bloqueo.empresa     = :codigo_empresa
And   almlinubica_bloqueo.ubicacion   = :ubicacion
And   almlinubica_bloqueo.linea       = :linea;
IF IsNull(numero) Then numero = 0
If numero = 0 Then
		fecha = DateTime(Today(),Now())
		  INSERT INTO almlinubica_bloqueo  
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
	Delete from almlinubica_bloqueo
	Where almlinubica_bloqueo.empresa     = :codigo_empresa
	And   almlinubica_bloqueo.ubicacion   = :ubicacion
	And   almlinubica_bloqueo.linea       = :linea;
END IF
COMMIT;
dw_1.SetItem(dw_1.GetRow(),"almlinubica_ubicacion",ubicacion)
f_activar_campo(em_1)
end event

type st_2 from statictext within w_int_bloqueo_material_ubi
integer x = 41
integer y = 1340
integer width = 453
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Observaciones:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_int_bloqueo_material_ubi
integer x = 1655
integer y = 156
integer width = 453
integer height = 324
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Incidencias","Bloqueados","Todos"}
borderstyle borderstyle = stylelowered!
end type

