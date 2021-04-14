$PBExportHeader$w_con_recibos_factura.srw
$PBExportComments$€
forward
global type w_con_recibos_factura from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_factura
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_factura
end type
type dw_listado from datawindow within w_con_recibos_factura
end type
type dw_1 from datawindow within w_con_recibos_factura
end type
type dw_proceso2 from datawindow within w_con_recibos_factura
end type
type em_factura from u_em_campo within w_con_recibos_factura
end type
type gb_cuenta from groupbox within w_con_recibos_factura
end type
type dw_2 from datawindow within w_con_recibos_factura
end type
type em_anyofactura from u_em_campo within w_con_recibos_factura
end type
type st_1 from statictext within w_con_recibos_factura
end type
type st_2 from statictext within w_con_recibos_factura
end type
type gb_anyo from groupbox within w_con_recibos_factura
end type
type cb_consulta from u_boton within w_con_recibos_factura
end type
end forward

global type w_con_recibos_factura from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2917
integer height = 2092
string title = "Consulta de Movimientos"
pb_2 pb_2
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
dw_proceso2 dw_proceso2
em_factura em_factura
gb_cuenta gb_cuenta
dw_2 dw_2
em_anyofactura em_anyofactura
st_1 st_1
st_2 st_2
gb_anyo gb_anyo
cb_consulta cb_consulta
end type
global w_con_recibos_factura w_con_recibos_factura

type variables
String ante_articulo,retrasos,isle_campo
long conta
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros

dw_data.reset()
dw_data.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()

string f="",fi=""

if tipo_vista="Nacional" then 
	fi=" (nacional='S')"
else
	if tipo_vista="Exportacion" then 
		fi=" (nacional='N')"
	else
		fi=" ((nacional='N') or (nacional='S'))"
	end if
end if

//if tipo_vista="Nacional" then fi="(nacional='S')"
//if tipo_vista="Exportacion" then fi="(nacional='N')"
//if tipo_vista="Ambos" then fi="((nacional='N') or (nacional='S'))"
//f=f_filtro()
IF f="" then
	f=fi
end if
dw_data.SetFilter(f)
dw_data.Filter()

dw_data.Retrieve(codigo_empresa,em_factura.text,Dec(em_anyofactura.text))

registros = dw_data.RowCount()


dw_data.visible   = TRUE
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA EFECTOS POR FACTURA"

dw_1.Setfocus()

em_anyofactura.text=string(year(today()))
f_activar_campo(em_anyofactura)


end event

on w_con_recibos_factura.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.dw_proceso2=create dw_proceso2
this.em_factura=create em_factura
this.gb_cuenta=create gb_cuenta
this.dw_2=create dw_2
this.em_anyofactura=create em_anyofactura
this.st_1=create st_1
this.st_2=create st_2
this.gb_anyo=create gb_anyo
this.cb_consulta=create cb_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_imprimir_preli
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_proceso2
this.Control[iCurrent+6]=this.em_factura
this.Control[iCurrent+7]=this.gb_cuenta
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.em_anyofactura
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.gb_anyo
this.Control[iCurrent+13]=this.cb_consulta
end on

on w_con_recibos_factura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.dw_proceso2)
destroy(this.em_factura)
destroy(this.gb_cuenta)
destroy(this.dw_2)
destroy(this.em_anyofactura)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_anyo)
destroy(this.cb_consulta)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_factura
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_factura
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_factura
integer x = 14
integer y = 24
integer width = 2642
integer height = 108
end type

type pb_2 from upb_salir within w_con_recibos_factura
integer x = 2725
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_imprimir_preli from picturebutton within w_con_recibos_factura
integer x = 2725
integer y = 152
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type dw_listado from datawindow within w_con_recibos_factura
boolean visible = false
integer x = 5
integer width = 46
integer height = 40
string dataobject = "report_carefectos_situacion_factura"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_recibos_factura
boolean visible = false
integer x = 18
integer y = 284
integer width = 2834
integer height = 840
string dataobject = "dw_con_carefectos_situacion_factura"
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

type dw_proceso2 from datawindow within w_con_recibos_factura
boolean visible = false
integer x = 1147
integer y = 8
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type em_factura from u_em_campo within w_con_recibos_factura
integer x = 910
integer y = 172
integer width = 370
integer taborder = 20
alignment alignment = right!
end type

event modificado;call super::modificado;if match("AGRUPADO",em_factura.text) then em_factura.text="AGRUPADO"
end event

type gb_cuenta from groupbox within w_con_recibos_factura
integer x = 658
integer y = 132
integer width = 645
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_2 from datawindow within w_con_recibos_factura
boolean visible = false
integer x = 18
integer y = 1144
integer width = 2834
integer height = 724
string dataobject = "dw_con_carhistorico_factura"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  lstr_param.s_argumentos[4]=String(This.GetItemNumber(Row,"linea"))
  OpenWithParm(wi_mant_carhistorico,lstr_param) 
End If
end event

type em_anyofactura from u_em_campo within w_con_recibos_factura
event modificado pbm_custom02
integer x = 421
integer y = 172
integer width = 206
integer taborder = 10
long textcolor = 0
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###"
string displaydata = ""
end type

event modificado;call super::modificado;if match("AGRUPADO",em_factura.text) then em_factura.text="AGRUPADO"
end event

type st_1 from statictext within w_con_recibos_factura
integer x = 681
integer y = 188
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Factura:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_recibos_factura
integer x = 37
integer y = 180
integer width = 370
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Anyo Factura:"
boolean focusrectangle = false
end type

type gb_anyo from groupbox within w_con_recibos_factura
integer x = 14
integer y = 132
integer width = 645
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type cb_consulta from u_boton within w_con_recibos_factura
integer x = 1362
integer y = 148
integer width = 416
integer height = 116
integer taborder = 30
boolean bringtotop = true
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_cargar(dw_2)

f_activar_campo(em_factura)

end event

