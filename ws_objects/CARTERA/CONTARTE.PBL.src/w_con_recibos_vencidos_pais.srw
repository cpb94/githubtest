$PBExportHeader$w_con_recibos_vencidos_pais.srw
$PBExportComments$€
forward
global type w_con_recibos_vencidos_pais from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_vencidos_pais
end type
type uo_tipo from u_marca_lista within w_con_recibos_vencidos_pais
end type
type cb_consulta from u_boton within w_con_recibos_vencidos_pais
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_vencidos_pais
end type
type dw_listado from datawindow within w_con_recibos_vencidos_pais
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_vencidos_pais
end type
type uo_pais from u_em_campo_2 within w_con_recibos_vencidos_pais
end type
type gb_3 from groupbox within w_con_recibos_vencidos_pais
end type
type gb_2 from groupbox within w_con_recibos_vencidos_pais
end type
type gb_1 from groupbox within w_con_recibos_vencidos_pais
end type
type gb_cuenta from groupbox within w_con_recibos_vencidos_pais
end type
type gb_fecha from groupbox within w_con_recibos_vencidos_pais
end type
type dw_1 from datawindow within w_con_recibos_vencidos_pais
end type
type em_fecha from u_em_campo within w_con_recibos_vencidos_pais
end type
type detalle from radiobutton within w_con_recibos_vencidos_pais
end type
type resumen from radiobutton within w_con_recibos_vencidos_pais
end type
type rb_v from radiobutton within w_con_recibos_vencidos_pais
end type
type rb_n from radiobutton within w_con_recibos_vencidos_pais
end type
type rb_t from radiobutton within w_con_recibos_vencidos_pais
end type
type uo_1 from u_manejo_datawindow within w_con_recibos_vencidos_pais
end type
end forward

global type w_con_recibos_vencidos_pais from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2930
integer height = 2172
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_tipo uo_tipo
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
uo_pais uo_pais
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_cuenta gb_cuenta
gb_fecha gb_fecha
dw_1 dw_1
em_fecha em_fecha
detalle detalle
resumen resumen
rb_v rb_v
rb_n rb_n
rb_t rb_t
uo_1 uo_1
end type
global w_con_recibos_vencidos_pais w_con_recibos_vencidos_pais

type variables
String ante_articulo,retrasos,isle_campo
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_detalle (boolean bol)
public function string f_filtro ()
public function string f_calc_filtro ()
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
String cli1,cli2

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()

dw_data.SetFilter(f_calc_filtro())
dw_data.Filter()

iF Trim(uo_pais.em_codigo.text) = "" Then
   cli1 = "."
   cli2 = "Z"
ELSE
	cli1 = uo_pais.em_codigo.text
	cli2 = uo_pais.em_codigo.text
END IF

Datetime fecha
fecha=Datetime(Date(String(em_fecha.Text)))

dw_data.Retrieve(codigo_empresa,cli1,cli2,fecha)

registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

public subroutine f_detalle (boolean bol);IF bol Then
		dw_1.Modify("DataWindow.Detail.Height=69")
		dw_listado.DataObject= "report_carefectos_pais_vencidos"
ELSE
		dw_1.Modify("DataWindow.Detail.Height=0")
		dw_listado.DataObject= "report_carefectos_pais_vencidos_resumen"
END IF
end subroutine

public function string f_filtro ();string retorno
int cual
Datetime fecha
fecha=Datetime(Date(String(em_fecha.Text)))

if rb_v.checked then cual=1
if rb_n.checked then cual=2
if rb_t.checked then cual=3
choose case cual
	case 1
		retorno="( fvto < datetime('"+string(fecha)+"'))"		
	case 2
		retorno="( fvto >= datetime('"+string(fecha)+"'))"
	case 3
		retorno=""		
end choose

return retorno
end function

public function string f_calc_filtro ();string f="",fi="",fil=""


if tipo_vista="Nacional" then 
	fi=" (nacional='S')"
else
	if tipo_vista="Exportacion" then 
		fi=" (nacional='N')"
	else
		fi=" ((nacional='N') or (nacional='S'))"
	end if
end if

fil=f_filtro()
if fil="" then
	f=fi
else
	f="("+fi+" and "+fil+")"
end if

return f
end function

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " Consulta recibos vencidos por pais"

dw_1.Setfocus()


em_fecha.text = String(Today())



f_activar_campo(uo_pais.em_campo)


end event

on w_con_recibos_vencidos_pais.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_tipo=create uo_tipo
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.uo_pais=create uo_pais
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_cuenta=create gb_cuenta
this.gb_fecha=create gb_fecha
this.dw_1=create dw_1
this.em_fecha=create em_fecha
this.detalle=create detalle
this.resumen=create resumen
this.rb_v=create rb_v
this.rb_n=create rb_n
this.rb_t=create rb_t
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_tipo
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_tipo2
this.Control[iCurrent+7]=this.uo_pais
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_cuenta
this.Control[iCurrent+12]=this.gb_fecha
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.em_fecha
this.Control[iCurrent+15]=this.detalle
this.Control[iCurrent+16]=this.resumen
this.Control[iCurrent+17]=this.rb_v
this.Control[iCurrent+18]=this.rb_n
this.Control[iCurrent+19]=this.rb_t
this.Control[iCurrent+20]=this.uo_1
end on

on w_con_recibos_vencidos_pais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_tipo)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.uo_pais)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_cuenta)
destroy(this.gb_fecha)
destroy(this.dw_1)
destroy(this.em_fecha)
destroy(this.detalle)
destroy(this.resumen)
destroy(this.rb_v)
destroy(this.rb_n)
destroy(this.rb_t)
destroy(this.uo_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_vencidos_pais
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_vencidos_pais
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_vencidos_pais
integer x = 14
integer y = 20
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_con_recibos_vencidos_pais
integer x = 2734
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type uo_tipo from u_marca_lista within w_con_recibos_vencidos_pais
boolean visible = false
integer x = 1413
integer y = 316
integer width = 1449
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type cb_consulta from u_boton within w_con_recibos_vencidos_pais
integer x = 1303
integer y = 160
integer width = 256
integer height = 124
integer taborder = 50
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(uo_pais.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_con_recibos_vencidos_pais
integer x = 2715
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
dw_listado.visible = FALSE
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_pais.em_campo)
end event

type dw_listado from datawindow within w_con_recibos_vencidos_pais
boolean visible = false
integer y = 12
integer width = 46
integer height = 36
string dataobject = "report_carefectos_pais_vencidos"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_recibos_vencidos_pais
boolean visible = false
integer x = 242
integer y = 320
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type uo_pais from u_em_campo_2 within w_con_recibos_vencidos_pais
event destroy ( )
integer x = 457
integer y = 184
integer width = 805
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Paises"
ue_datawindow ="dw_ayuda_paises"
valor_empresa = FALSE

end event

event modificado;call super::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)
If Trim(uo_pais.em_campo.text)="" then
	uo_pais.em_campo.text=""
	uo_pais.em_codigo.text=""
	Return
end if 
dw_1.Reset()

end event

type gb_3 from groupbox within w_con_recibos_vencidos_pais
integer x = 1915
integer y = 88
integer width = 338
integer height = 208
integer taborder = 1
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_recibos_vencidos_pais
integer x = 1577
integer y = 88
integer width = 338
integer height = 208
integer taborder = 60
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_recibos_vencidos_pais
integer x = 1289
integer y = 124
integer width = 283
integer height = 172
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_cuenta from groupbox within w_con_recibos_vencidos_pais
integer x = 411
integer y = 124
integer width = 873
integer height = 172
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "País"
end type

type gb_fecha from groupbox within w_con_recibos_vencidos_pais
integer y = 124
integer width = 407
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Fecha"
end type

type dw_1 from datawindow within w_con_recibos_vencidos_pais
integer y = 308
integer width = 2853
integer height = 1628
boolean bringtotop = true
string dataobject = "dw_con_carefectos_vencidos_pais"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
End If
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenWithParm(w_detalle_agrupado,lstr_param)


End If
end event

type em_fecha from u_em_campo within w_con_recibos_vencidos_pais
integer x = 41
integer y = 184
integer width = 338
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type detalle from radiobutton within w_con_recibos_vencidos_pais
integer x = 1934
integer y = 152
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
end type

event clicked;f_detalle(TRUE)
end event

type resumen from radiobutton within w_con_recibos_vencidos_pais
integer x = 1934
integer y = 216
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Resum."
end type

event clicked;f_detalle(FALSE)
end event

type rb_v from radiobutton within w_con_recibos_vencidos_pais
integer x = 1595
integer y = 128
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Venc."
end type

event clicked;if checked then
	dw_1.SetFilter(f_calc_filtro())
	dw_1.Filter()
	dw_1.groupcalc()
end if
end event

type rb_n from radiobutton within w_con_recibos_vencidos_pais
integer x = 1595
integer y = 184
integer width = 311
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Venc."
end type

event clicked;if checked then
	dw_1.SetFilter(f_calc_filtro())
	dw_1.Filter()
	dw_1.groupcalc()
end if
end event

type rb_t from radiobutton within w_con_recibos_vencidos_pais
integer x = 1595
integer y = 240
integer width = 306
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
boolean checked = true
end type

event clicked;if checked then
	dw_1.SetFilter(f_calc_filtro())
	dw_1.Filter()
	dw_1.groupcalc()
end if
end event

type uo_1 from u_manejo_datawindow within w_con_recibos_vencidos_pais
integer x = 2245
integer y = 148
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

