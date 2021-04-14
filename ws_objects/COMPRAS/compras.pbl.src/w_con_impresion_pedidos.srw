$PBExportHeader$w_con_impresion_pedidos.srw
forward
global type w_con_impresion_pedidos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_impresion_pedidos
end type
type pb_imprimir from upb_imprimir within w_con_impresion_pedidos
end type
type em_anyo from u_em_campo within w_con_impresion_pedidos
end type
type em_pedido from u_em_campo within w_con_impresion_pedidos
end type
type st_2 from statictext within w_con_impresion_pedidos
end type
type em_tipo_carta from u_em_campo within w_con_impresion_pedidos
end type
type em_carta from u_em_campo within w_con_impresion_pedidos
end type
type gb_6 from groupbox within w_con_impresion_pedidos
end type
type gb_5 from groupbox within w_con_impresion_pedidos
end type
type gb_4 from groupbox within w_con_impresion_pedidos
end type
type gb_2 from groupbox within w_con_impresion_pedidos
end type
type gb_1 from groupbox within w_con_impresion_pedidos
end type
type st_1 from statictext within w_con_impresion_pedidos
end type
type st_3 from statictext within w_con_impresion_pedidos
end type
type gb_3 from groupbox within w_con_impresion_pedidos
end type
type st_tip from statictext within w_con_impresion_pedidos
end type
type st_car from statictext within w_con_impresion_pedidos
end type
type dw_1 from datawindow within w_con_impresion_pedidos
end type
type st_4 from statictext within w_con_impresion_pedidos
end type
type st_p from statictext within w_con_impresion_pedidos
end type
type pb_preliminar from upb_imprimir within w_con_impresion_pedidos
end type
type pb_total from upb_imprimir within w_con_impresion_pedidos
end type
type pb_total_g from upb_imprimir within w_con_impresion_pedidos
end type
type pb_2 from picturebutton within w_con_impresion_pedidos
end type
type st_5 from statictext within w_con_impresion_pedidos
end type
type st_6 from statictext within w_con_impresion_pedidos
end type
type st_7 from statictext within w_con_impresion_pedidos
end type
type st_8 from statictext within w_con_impresion_pedidos
end type
end forward

shared variables
boolean se_ve=TRUE
end variables

global type w_con_impresion_pedidos from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 2889
integer height = 1716
string icon = "Application!"
pb_1 pb_1
pb_imprimir pb_imprimir
em_anyo em_anyo
em_pedido em_pedido
st_2 st_2
em_tipo_carta em_tipo_carta
em_carta em_carta
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
st_1 st_1
st_3 st_3
gb_3 gb_3
st_tip st_tip
st_car st_car
dw_1 dw_1
st_4 st_4
st_p st_p
pb_preliminar pb_preliminar
pb_total pb_total
pb_total_g pb_total_g
pb_2 pb_2
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
end type
global w_con_impresion_pedidos w_con_impresion_pedidos

type variables
string filtro
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Impresión de Cartas de Pedidos"
This.title=istr_parametros.s_titulo_ventana


//dw_fechas.SetRowFocusIndicator(Hand!)

   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      em_pedido.text=istr_parametros.s_argumentos[3]
      em_anyo.text=istr_parametros.s_argumentos[2]
		em_tipo_carta.text="1"
		st_tip.text=f_nombre_tipo_carta(codigo_empresa,em_tipo_carta.text)
		em_carta.text="1"
		st_car.text=f_nombre_carta(codigo_empresa,em_carta.text)
      IF Trim(em_pedido.text)<>"" and Not IsNull(em_pedido.text) Then
       f_activar_campo(em_carta)
		END IF
	END IF

end event

on w_con_impresion_pedidos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.em_anyo=create em_anyo
this.em_pedido=create em_pedido
this.st_2=create st_2
this.em_tipo_carta=create em_tipo_carta
this.em_carta=create em_carta
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.st_3=create st_3
this.gb_3=create gb_3
this.st_tip=create st_tip
this.st_car=create st_car
this.dw_1=create dw_1
this.st_4=create st_4
this.st_p=create st_p
this.pb_preliminar=create pb_preliminar
this.pb_total=create pb_total
this.pb_total_g=create pb_total_g
this.pb_2=create pb_2
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_pedido
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_tipo_carta
this.Control[iCurrent+7]=this.em_carta
this.Control[iCurrent+8]=this.gb_6
this.Control[iCurrent+9]=this.gb_5
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.st_tip
this.Control[iCurrent+17]=this.st_car
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.st_p
this.Control[iCurrent+21]=this.pb_preliminar
this.Control[iCurrent+22]=this.pb_total
this.Control[iCurrent+23]=this.pb_total_g
this.Control[iCurrent+24]=this.pb_2
this.Control[iCurrent+25]=this.st_5
this.Control[iCurrent+26]=this.st_6
this.Control[iCurrent+27]=this.st_7
this.Control[iCurrent+28]=this.st_8
end on

on w_con_impresion_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.em_anyo)
destroy(this.em_pedido)
destroy(this.st_2)
destroy(this.em_tipo_carta)
destroy(this.em_carta)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.gb_3)
destroy(this.st_tip)
destroy(this.st_car)
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.st_p)
destroy(this.pb_preliminar)
destroy(this.pb_total)
destroy(this.pb_total_g)
destroy(this.pb_2)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_impresion_pedidos
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_impresion_pedidos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_impresion_pedidos
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_impresion_pedidos
integer x = 64
integer y = 1124
integer taborder = 0
end type

type pb_imprimir from upb_imprimir within w_con_impresion_pedidos
integer x = 430
integer y = 920
integer taborder = 0
boolean bringtotop = true
end type

event clicked;call super::clicked;string firma
dw_1.settransobject(sqlca)
dw_1.Retrieve(codigo_empresa,em_carta.text,em_tipo_carta.text,em_anyo.text,em_pedido.text)

OpenWithParm(w_impresoras_v2,dw_1)

end event

type em_anyo from u_em_campo within w_con_impresion_pedidos
integer x = 302
integer y = 184
integer taborder = 10
end type

type em_pedido from u_em_campo within w_con_impresion_pedidos
integer x = 622
integer y = 184
integer taborder = 20
boolean bringtotop = true
end type

type st_2 from statictext within w_con_impresion_pedidos
integer x = 558
integer y = 172
integer width = 59
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Black"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_tipo_carta from u_em_campo within w_con_impresion_pedidos
integer x = 302
integer y = 408
integer taborder = 30
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_tipo_cartas"
ue_titulo     =  "AYUDA SELECCION TIPOS DE CARTAS"
ue_filtro     =  ""

end event

event modificado;call super::modificado;st_tip.text=f_nombre_tipo_carta(codigo_empresa,em_tipo_carta.text)
IF Trim(st_tip.text)="" THEN 
 IF Trim(em_tipo_carta.text)<>"" Then em_tipo_carta.SetFocus()
 st_tip.text=""
 em_tipo_carta.text=""
END IF

end event

type em_carta from u_em_campo within w_con_impresion_pedidos
integer x = 302
integer y = 620
integer taborder = 40
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_cartas"
ue_titulo     =  "AYUDA SELECCION CARTAS"
ue_filtro     =  ""

end event

event modificado;call super::modificado;st_car.text=f_nombre_carta(codigo_empresa,em_carta.text)
IF Trim(st_car.text)="" THEN 
 IF Trim(em_carta.text)<>"" Then em_carta.SetFocus()
 st_car.text=""
 em_carta.text=""
END IF

end event

type gb_6 from groupbox within w_con_impresion_pedidos
integer x = 293
integer y = 1056
integer width = 270
integer height = 308
integer taborder = 41
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_5 from groupbox within w_con_impresion_pedidos
integer x = 14
integer y = 1056
integer width = 270
integer height = 308
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_con_impresion_pedidos
integer x = 571
integer y = 1056
integer width = 599
integer height = 308
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_con_impresion_pedidos
integer x = 14
integer y = 316
integer width = 1157
integer height = 528
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Carta"
end type

type gb_1 from groupbox within w_con_impresion_pedidos
integer x = 14
integer y = 124
integer width = 1157
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pedido"
end type

type st_1 from statictext within w_con_impresion_pedidos
integer x = 105
integer y = 408
integer width = 178
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_impresion_pedidos
integer x = 46
integer y = 624
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Codigo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_con_impresion_pedidos
integer x = 14
integer y = 864
integer width = 1157
integer height = 172
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_tip from statictext within w_con_impresion_pedidos
integer x = 297
integer y = 504
integer width = 827
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_car from statictext within w_con_impresion_pedidos
integer x = 297
integer y = 716
integer width = 827
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_impresion_pedidos
integer x = 1207
integer y = 128
integer width = 1563
integer height = 1332
boolean bringtotop = true
string dataobject = "report_carta_compedidos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_con_impresion_pedidos
integer x = 110
integer y = 932
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Imprimir:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_p from statictext within w_con_impresion_pedidos
integer x = 567
integer y = 932
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Ver:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_preliminar from upb_imprimir within w_con_impresion_pedidos
event clicked pbm_bnclicked
integer x = 887
integer y = 920
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "c:\bmp\prelimi.bmp"
end type

event clicked;call super::clicked;string firma

dw_1.settransobject(sqlca)
dw_1.Retrieve(codigo_empresa,em_carta.text,em_tipo_carta.text,em_anyo.text,em_pedido.text)
firma=dw_1.getitemstring(dw_1.getrow(),"firma")
//firma="\firmas\"+firma
//dw_1.Object.p_firma.Filename = firma
dw_1.Object.DataWindow.print.Preview.Zoom	=29


end event

type pb_total from upb_imprimir within w_con_impresion_pedidos
event clicked pbm_bnclicked
integer x = 654
integer y = 1124
integer width = 183
integer height = 160
integer taborder = 0
boolean bringtotop = true
string picturename = "c:\bmp\peq.bmp "
end type

event clicked;call super::clicked;dw_1.Object.DataWindow.print.Preview.Zoom	=29


end event

type pb_total_g from upb_imprimir within w_con_impresion_pedidos
event clicked pbm_bnclicked
integer x = 905
integer y = 1124
integer width = 183
integer height = 160
integer taborder = 0
boolean bringtotop = true
string picturename = "c:\bmp\gran.bmp "
end type

event clicked;call super::clicked;dw_1.Object.DataWindow.print.Preview.Zoom	=100


end event

type pb_2 from picturebutton within w_con_impresion_pedidos
integer x = 343
integer y = 1124
integer width = 174
integer height = 152
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\colores_peq.bmp"
end type

event clicked;se_ve=not se_ve
dw_1.Object.cabecera.visible=se_ve
end event

type st_5 from statictext within w_con_impresion_pedidos
integer x = 887
integer y = 1284
integer width = 224
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Aumentar"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_impresion_pedidos
integer x = 640
integer y = 1284
integer width = 206
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Disminuir"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_con_impresion_pedidos
integer x = 315
integer y = 1284
integer width = 233
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Cabecera"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_con_impresion_pedidos
integer x = 64
integer y = 1284
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Salir"
alignment alignment = center!
boolean focusrectangle = false
end type

