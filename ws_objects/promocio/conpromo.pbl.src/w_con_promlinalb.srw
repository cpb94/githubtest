$PBExportHeader$w_con_promlinalb.srw
forward
global type w_con_promlinalb from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_promlinalb
end type
type st_2 from statictext within w_con_promlinalb
end type
type em_albaran from u_em_campo within w_con_promlinalb
end type
type st_3 from statictext within w_con_promlinalb
end type
type st_22 from statictext within w_con_promlinalb
end type
type em_cliente from u_em_campo within w_con_promlinalb
end type
type st_nombre_cliente from statictext within w_con_promlinalb
end type
type em_anyo from u_em_campo within w_con_promlinalb
end type
type gb_1 from groupbox within w_con_promlinalb
end type
type gb_2 from groupbox within w_con_promlinalb
end type
type gb_3 from groupbox within w_con_promlinalb
end type
type em_situacion from u_em_campo within w_con_promlinalb
end type
type dw_detalle from datawindow within w_con_promlinalb
end type
type dw_articulo from datawindow within w_con_promlinalb
end type
end forward

global type w_con_promlinalb from w_int_con_empresa
integer width = 2944
integer height = 1688
boolean maxbox = false
windowtype windowtype = popup!
pb_1 pb_1
st_2 st_2
em_albaran em_albaran
st_3 st_3
st_22 st_22
em_cliente em_cliente
st_nombre_cliente st_nombre_cliente
em_anyo em_anyo
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
em_situacion em_situacion
dw_detalle dw_detalle
dw_articulo dw_articulo
end type
global w_con_promlinalb w_con_promlinalb

type variables
dec{0} var_albaran,var_anyo
String var_tipo_cliente

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();If dw_detalle.GetRow() = 0 Then
	dw_articulo.Reset()
	Return
END IF
dw_articulo.Retrieve(codigo_empresa,var_anyo,var_albaran,dw_detalle.GeTitemNumber(dw_detalle.GetRow(),"linea"))
end subroutine

event open;call super::open;istr_parametros = Message.PowerObjectParm
istr_parametros.s_titulo_ventana="Consulta lineas albaranes de promoción"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_articulo.SetTransObject(SQLCA)
dw_detalle.SetRowFocusIndicator(Hand!)

IF istr_parametros.i_nargumentos>1 THEN
     em_anyo.text=istr_parametros.s_argumentos[2]	
     em_albaran.text=istr_parametros.s_argumentos[3]	
     var_tipo_cliente=istr_parametros.s_argumentos[4]	
	  var_anyo   = Dec(em_anyo.text)
     var_albaran = Dec(em_albaran.text)
     IF Trim(em_anyo.text)<>"" and Trim(em_albaran.text)<>"" THEN
     END IF
     istr_parametros.i_nargumentos=0

   
END IF
em_cliente.text = f_cliente_promalb(codigo_empresa,var_anyo,var_albaran)
IF var_tipo_cliente = "S" Then
	st_nombre_cliente.text = f_razon_genter(codigo_empresa,"C",em_cliente.text)
ElSE
	st_nombre_cliente.text = f_nombre_vencliproforma(codigo_empresa,em_cliente.text)
END IF


dw_detalle.Retrieve(codigo_empresa,var_anyo,var_albaran)

end event

event ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

on w_con_promlinalb.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_albaran=create em_albaran
this.st_3=create st_3
this.st_22=create st_22
this.em_cliente=create em_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.em_anyo=create em_anyo
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.em_situacion=create em_situacion
this.dw_detalle=create dw_detalle
this.dw_articulo=create dw_articulo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_albaran
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_22
this.Control[iCurrent+6]=this.em_cliente
this.Control[iCurrent+7]=this.st_nombre_cliente
this.Control[iCurrent+8]=this.em_anyo
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.em_situacion
this.Control[iCurrent+13]=this.dw_detalle
this.Control[iCurrent+14]=this.dw_articulo
end on

on w_con_promlinalb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_albaran)
destroy(this.st_3)
destroy(this.st_22)
destroy(this.em_cliente)
destroy(this.st_nombre_cliente)
destroy(this.em_anyo)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.em_situacion)
destroy(this.dw_detalle)
destroy(this.dw_articulo)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;
	If dw_detalle.GetRow() = 0 Then Return
	If dw_detalle.GetRow() - 1 >= 0 Then
	   dw_detalle.ScrollToRow(dw_detalle.GetRow() - 1)
   END IF

end event

event ue_cursor_abajo;call super::ue_cursor_abajo;
	If dw_detalle.GetRow() = 0 Then Return
	If dw_detalle.GetRow() + 1 <= dw_detalle.RowCOunt() Then
	   dw_detalle.ScrollToRow(dw_detalle.GetRow() + 1)
   END IF

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_promlinalb
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_promlinalb
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_promlinalb
integer x = 32
integer y = 8
integer width = 2409
integer height = 112
end type

type pb_1 from upb_salir within w_con_promlinalb
integer x = 2711
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_con_promlinalb
integer x = 526
integer y = 140
integer width = 261
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Albaran:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_albaran from u_em_campo within w_con_promlinalb
integer x = 782
integer y = 148
integer width = 256
integer height = 72
integer taborder = 0
long textcolor = 128
boolean border = false
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

type st_3 from statictext within w_con_promlinalb
integer x = 59
integer y = 140
integer width = 174
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_22 from statictext within w_con_promlinalb
integer x = 1079
integer y = 140
integer width = 247
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cliente from u_em_campo within w_con_promlinalb
integer x = 1349
integer y = 148
integer width = 261
integer height = 76
integer taborder = 0
long textcolor = 128
boolean border = false
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

type st_nombre_cliente from statictext within w_con_promlinalb
integer x = 1577
integer y = 148
integer width = 910
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_con_promlinalb
integer x = 247
integer y = 148
integer width = 224
integer height = 72
integer taborder = 0
long textcolor = 128
boolean border = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

type gb_1 from groupbox within w_con_promlinalb
integer x = 37
integer y = 96
integer width = 453
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_con_promlinalb
integer x = 507
integer y = 96
integer width = 544
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_con_promlinalb
integer x = 1061
integer y = 96
integer width = 1719
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type em_situacion from u_em_campo within w_con_promlinalb
boolean visible = false
integer x = 23
integer y = 1448
integer width = 123
integer taborder = 130
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_detalle from datawindow within w_con_promlinalb
integer x = 14
integer y = 256
integer width = 1819
integer height = 1164
string dataobject = "dw_con_promlinalb1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;f_control()
end event

type dw_articulo from datawindow within w_con_promlinalb
event clicked pbm_dwnlbuttonclk
event rowfocuschanged pbm_dwnrowchange
integer x = 1842
integer y = 256
integer width = 992
integer height = 1164
integer taborder = 10
string dataobject = "dw_con_promlinalb2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

