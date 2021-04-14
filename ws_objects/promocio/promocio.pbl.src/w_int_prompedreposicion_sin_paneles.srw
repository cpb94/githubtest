$PBExportHeader$w_int_prompedreposicion_sin_paneles.srw
forward
global type w_int_prompedreposicion_sin_paneles from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_prompedreposicion_sin_paneles
end type
type dw_detalle from datawindow within w_int_prompedreposicion_sin_paneles
end type
type dw_1 from u_datawindow_consultas within w_int_prompedreposicion_sin_paneles
end type
type dw_proceso2 from datawindow within w_int_prompedreposicion_sin_paneles
end type
type st_1 from statictext within w_int_prompedreposicion_sin_paneles
end type
type sle_anyo from singlelineedit within w_int_prompedreposicion_sin_paneles
end type
type st_2 from statictext within w_int_prompedreposicion_sin_paneles
end type
type sle_pedido from singlelineedit within w_int_prompedreposicion_sin_paneles
end type
type st_3 from statictext within w_int_prompedreposicion_sin_paneles
end type
type sle_cliente from singlelineedit within w_int_prompedreposicion_sin_paneles
end type
type st_4 from statictext within w_int_prompedreposicion_sin_paneles
end type
type sle_serie from singlelineedit within w_int_prompedreposicion_sin_paneles
end type
type gb_1 from groupbox within w_int_prompedreposicion_sin_paneles
end type
end forward

global type w_int_prompedreposicion_sin_paneles from w_int_con_empresa
integer width = 2958
integer height = 1948
boolean minbox = false
boolean maxbox = false
windowtype windowtype = response!
pb_1 pb_1
dw_detalle dw_detalle
dw_1 dw_1
dw_proceso2 dw_proceso2
st_1 st_1
sle_anyo sle_anyo
st_2 st_2
sle_pedido sle_pedido
st_3 st_3
sle_cliente sle_cliente
st_4 st_4
sle_serie sle_serie
gb_1 gb_1
end type
global w_int_prompedreposicion_sin_paneles w_int_prompedreposicion_sin_paneles

type variables
String marcado,var_serie
Dec{0}  var_anyo,var_pedido
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_grabar_linea ()
public subroutine f_borrar_linea ()
end prototypes

public subroutine f_control ();dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido,var_serie)

//if dw_1.rowcount() > 0 then
//	dw_1.selectrow(0,false)
//	dw_1.selectrow(1,true)
//	dw_1.setrow(1)
//	dw_1.TriggerEvent("Rowfocuschanged!")
//end if

end subroutine

public subroutine f_grabar_linea ();Dec{0} var_anyoalb,var_albaran,var_lineaalb,var_linea,var_cantidad,var_orden
String var_tipo_panel,var_panel,var_articulo

var_anyoalb       = dw_detalle.GetItemNumber(dw_detalle.getRow(),"anyo")
var_albaran       = dw_detalle.GetItemNumber(dw_detalle.getRow(),"albaran")
var_lineaalb      = dw_detalle.GetItemNumber(dw_detalle.getRow(),"linea")
var_orden			= dw_detalle.GetItemNumber(dw_detalle.getRow(),"orden")
var_cantidad      = dw_detalle.GetItemNumber(dw_detalle.getRow(),"promlinalb_cantidad")
var_tipo_panel    = dw_detalle.GetItemString(dw_detalle.getRow(),"promlinalb_tipo_panel")
var_panel         = dw_detalle.GetItemString(dw_detalle.getRow(),"panel")
var_articulo		= dw_detalle.GetItemString(dw_detalle.getRow(),"articulo")
			
Select Max(prompedlinreposicion.linea) Into :var_linea 
From   prompedlinreposicion  
Where  prompedlinreposicion.empresa    = :codigo_empresa
And    prompedlinreposicion.anyo       = :var_anyo
And    prompedlinreposicion.pedido     = :var_pedido;

IF IsNull(var_linea)  Then var_linea = 0
var_linea = var_linea + 1
  INSERT INTO prompedlinreposicion  
         ( empresa,anyo,pedido,linea,orden,anyo_alb,albaran,linea_alb,tipo_panel,panel,cantidad,articulo )  
  VALUES ( :codigo_empresa,:var_anyo,:var_pedido,:var_linea,:var_orden, 
           :var_anyoalb,:var_albaran,:var_lineaalb,:var_tipo_panel,:var_panel,:var_cantidad,:var_articulo )  ;
			
COMMIT;


end subroutine

public subroutine f_borrar_linea ();Dec{0} var_anyoalb,var_albaran,var_lineaalb,var_linea,var_orden
string var_articulo

var_anyoalb       = dw_detalle.GetItemNumber(dw_detalle.getRow(),"anyo")
var_albaran       = dw_detalle.GetItemNumber(dw_detalle.getRow(),"albaran")
var_lineaalb      = dw_detalle.GetItemNumber(dw_detalle.getRow(),"linea")
var_orden         = dw_detalle.GetItemnumber(dw_detalle.getRow(),"orden")
			
Delete From   prompedlinreposicion  
Where  prompedlinreposicion.empresa      = :codigo_empresa
And    prompedlinreposicion.anyo_alb     = :var_anyoalb
And    prompedlinreposicion.albaran      = :var_albaran
And    prompedlinreposicion.linea_alb    = :var_lineaalb
And    prompedlinreposicion.orden        = :var_orden;
		
COMMIT;
end subroutine

on w_int_prompedreposicion_sin_paneles.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_detalle=create dw_detalle
this.dw_1=create dw_1
this.dw_proceso2=create dw_proceso2
this.st_1=create st_1
this.sle_anyo=create sle_anyo
this.st_2=create st_2
this.sle_pedido=create sle_pedido
this.st_3=create st_3
this.sle_cliente=create sle_cliente
this.st_4=create st_4
this.sle_serie=create sle_serie
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_detalle
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_proceso2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.sle_anyo
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.sle_pedido
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.sle_cliente
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.sle_serie
this.Control[iCurrent+13]=this.gb_1
end on

on w_int_prompedreposicion_sin_paneles.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_detalle)
destroy(this.dw_1)
destroy(this.dw_proceso2)
destroy(this.st_1)
destroy(this.sle_anyo)
destroy(this.st_2)
destroy(this.sle_pedido)
destroy(this.st_3)
destroy(this.sle_cliente)
destroy(this.st_4)
destroy(this.sle_serie)
destroy(this.gb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_abajo(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion Detalle Paneles(Pedidos a Reponer)"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
marcado= "N"
dw_detalle.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
  // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
		var_serie        = istr_parametros.s_argumentos[2]
      var_anyo         = Dec(istr_parametros.s_argumentos[3])
      var_pedido       = Dec(istr_parametros.s_argumentos[4])
		sle_serie.text   = String(var_serie)
		sle_pedido.text  = String(var_pedido)
		sle_anyo.text    = String(var_anyo)
		sle_cliente.text = f_razon_genter(codigo_empresa,"C",f_cliente_promped(codigo_empresa,var_anyo,var_pedido))
	END IF		
f_control()


end event

event activate;call super::activate;w_int_prompedreposicion_sin_paneles = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_prompedreposicion_sin_paneles
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_prompedreposicion_sin_paneles
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_prompedreposicion_sin_paneles
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_prompedreposicion_sin_paneles
integer x = 2720
integer y = 8
integer width = 123
integer height = 112
integer taborder = 0
end type

event clicked;CLosewithreturn(w_int_prompedreposicion_sin_paneles,"1")
end event

type dw_detalle from datawindow within w_int_prompedreposicion_sin_paneles
integer x = 18
integer y = 260
integer width = 2843
integer height = 1412
boolean bringtotop = true
string dataobject = "dw_int_prompedreposicion1_1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;Integer linea,lin,cantidad
String panel,controles
Dec{2}  pesomaterial,costematerial,ventamaterial
Dec{0} var_anyoalb,var_albaran,var_lineaalb

lin  =  This.getRow()

If lin =0 Then Return
   //panel     = dw_1.GetItemString(lin,"codigo")
   controles = trim(this.GetItemString(lin,"control"))
IF controles = "" Then
   f_grabar_linea()
ELSE
   f_borrar_linea()
   COMMIT;
END IF

f_control()
//var_anyoalb       = dw_1.GetItemNumber(dw_1.getRow(),"promlinalb_anyo")
//var_albaran       = dw_1.GetItemNumber(dw_1.getRow(),"promlinalb_albaran")
//var_lineaalb      = dw_1.GetItemNumber(dw_1.getRow(),"promlinalb_linea")
//
//dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido,var_anyoalb,var_albaran,var_lineaalb)
//
end event

type dw_1 from u_datawindow_consultas within w_int_prompedreposicion_sin_paneles
integer x = 9
integer y = 260
integer width = 2843
integer height = 916
integer taborder = 0
string dataobject = "dw_int_prompedreposicion_sin_paneles"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;Integer linea,lin,cantidad
String panel,controles
Dec{2}  pesomaterial,costematerial,ventamaterial
lin  =  This.getRow()

If lin =0 Then Return
   panel     = dw_1.GetItemString(lin,"codigo")
   controles = dw_1.GetItemString(lin,"control")
IF controles = "" Then
   f_grabar_linea()
ELSE
   f_borrar_linea()
   COMMIT;
END IF
dw_1.SetItem(dw_1.GetRow(),"empresa",codigo_empresa)

end event

event rowfocuschanged;call super::rowfocuschanged;IF dw_1.getRow() =  0 Then  Return

Dec{0} var_anyoalb,var_albaran,var_lineaalb
       var_anyoalb       = dw_1.GetItemNumber(dw_1.getRow(),"promlinalb_anyo")
       var_albaran       = dw_1.GetItemNumber(dw_1.getRow(),"promlinalb_albaran")
  	    var_lineaalb      = dw_1.GetItemNumber(dw_1.getRow(),"promlinalb_linea")

dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido,var_anyoalb,var_albaran,var_lineaalb)
end event

event ue_valores;call super::ue_valores;ue_marca_linea = FALSE
end event

event clicked;call super::clicked;TriggerEvent("Rowfocuschanged!")
end event

type dw_proceso2 from datawindow within w_int_prompedreposicion_sin_paneles
boolean visible = false
integer x = 229
integer width = 1335
integer height = 168
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_proceso_prommapapaneles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_int_prompedreposicion_sin_paneles
integer x = 27
integer y = 160
integer width = 146
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_anyo from singlelineedit within w_int_prompedreposicion_sin_paneles
integer x = 183
integer y = 160
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type st_2 from statictext within w_int_prompedreposicion_sin_paneles
integer x = 425
integer y = 160
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pedido:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_pedido from singlelineedit within w_int_prompedreposicion_sin_paneles
integer x = 672
integer y = 160
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type st_3 from statictext within w_int_prompedreposicion_sin_paneles
integer x = 928
integer y = 160
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_cliente from singlelineedit within w_int_prompedreposicion_sin_paneles
integer x = 1175
integer y = 156
integer width = 1198
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
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type st_4 from statictext within w_int_prompedreposicion_sin_paneles
integer x = 2382
integer y = 160
integer width = 178
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Serie:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_serie from singlelineedit within w_int_prompedreposicion_sin_paneles
integer x = 2565
integer y = 160
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type gb_1 from groupbox within w_int_prompedreposicion_sin_paneles
integer x = 14
integer y = 104
integer width = 2839
integer height = 148
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

