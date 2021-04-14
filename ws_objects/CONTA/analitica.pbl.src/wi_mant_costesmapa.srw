$PBExportHeader$wi_mant_costesmapa.srw
forward
global type wi_mant_costesmapa from wi_mvent_con_empresa
end type
type st_3 from statictext within wi_mant_costesmapa
end type
type uo_ejercicio from u_ejercicio within wi_mant_costesmapa
end type
type dw_lineas_asiento from datawindow within wi_mant_costesmapa
end type
type gb_1 from groupbox within wi_mant_costesmapa
end type
type pb_1 from picturebutton within wi_mant_costesmapa
end type
type pb_2 from picturebutton within wi_mant_costesmapa
end type
type st_cuenta from statictext within wi_mant_costesmapa
end type
type st_coste from statictext within wi_mant_costesmapa
end type
type uo_asiento from u_em_campo within wi_mant_costesmapa
end type
type dw_listado from datawindow within wi_mant_costesmapa
end type
type pb_3 from picturebutton within wi_mant_costesmapa
end type
end forward

global type wi_mant_costesmapa from wi_mvent_con_empresa
integer width = 2926
integer height = 1712
st_3 st_3
uo_ejercicio uo_ejercicio
dw_lineas_asiento dw_lineas_asiento
gb_1 gb_1
pb_1 pb_1
pb_2 pb_2
st_cuenta st_cuenta
st_coste st_coste
uo_asiento uo_asiento
dw_listado dw_listado
pb_3 pb_3
end type
global wi_mant_costesmapa wi_mant_costesmapa

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   uo_ejercicio.em_ejercicio.Text = String(f_ejercicio_activo(codigo_empresa))
	istr_parametros.s_titulo_ventana = "Mantenimiento de mapa de costes"
//	istr_parametros.s_listado        = "report_costesmapa"
//	istr_parametros.s_filtro         = "ejercicio = " + uo_ejercicio.em_ejercicio.Text
	
   This.title = istr_parametros.s_titulo_ventana
   dw_lineas_asiento.SetTransObject(Sqlca)
   
	dw_listado.SetTransObject(SQLCA)
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text=istr_parametros.s_argumentos[2]
      uo_asiento.text= f_nombre_contaplan(integer(uo_ejercicio.em_ejercicio.Text),codigo_empresa,uo_asiento.text)
      dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.Text),codigo_empresa,uo_asiento.text)
   END IF
   
	f_activar_campo(uo_asiento)

	
end event

on ue_actualiza_dw;
CALL super::ue_actualiza_dw
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
	dw_1.setitem(dw_1.getrow(),"ejercicio",integer(uo_ejercicio.em_ejercicio.text))
   dw_1.setitem(dw_1.getrow(),"cuenta",uo_asiento.text)
   dw_1.setitem(dw_1.getrow(),"coste",sle_valor.text)
  
end event

event ue_recuperar;// Valores Para Funcion de bloqueo


titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[2]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(uo_ejercicio.em_ejercicio.text))
criterio[1]   =  trim(uo_ejercicio.em_ejercicio.text)+space(20-longitud)
longitud      =  len(trim(uo_asiento.text))
criterio[3]   =  trim(uo_asiento.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "costesmapa"

dw_1.Retrieve(integer(uo_ejercicio.em_ejercicio.Text),codigo_empresa,uo_asiento.text,sle_valor.Text)



CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;
uo_asiento.enabled = TRUE
uo_ejercicio.enabled = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;
uo_asiento.enabled = FALSE
uo_ejercicio.enabled = FALSE
end event

on wi_mant_costesmapa.create
int iCurrent
call super::create
this.st_3=create st_3
this.uo_ejercicio=create uo_ejercicio
this.dw_lineas_asiento=create dw_lineas_asiento
this.gb_1=create gb_1
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_cuenta=create st_cuenta
this.st_coste=create st_coste
this.uo_asiento=create uo_asiento
this.dw_listado=create dw_listado
this.pb_3=create pb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.dw_lineas_asiento
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.st_cuenta
this.Control[iCurrent+8]=this.st_coste
this.Control[iCurrent+9]=this.uo_asiento
this.Control[iCurrent+10]=this.dw_listado
this.Control[iCurrent+11]=this.pb_3
end on

on wi_mant_costesmapa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.uo_ejercicio)
destroy(this.dw_lineas_asiento)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_cuenta)
destroy(this.st_coste)
destroy(this.uo_asiento)
destroy(this.dw_listado)
destroy(this.pb_3)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_costesmapa
integer x = 9
integer y = 384
integer width = 1742
integer height = 136
string dataobject = "dw_costesmapa"
end type

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"coste")
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_costesmapa
integer x = 82
integer y = 280
integer width = 192
integer height = 88
string text = "Coste:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_costesmapa
integer x = 2167
integer y = 648
end type

event cb_insertar::clicked;call super::clicked;dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.text)
F_ACTIVAR_CAMPO(uo_asiento)
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_costesmapa
integer x = 2167
integer y = 748
end type

event cb_borrar::clicked;call super::clicked;dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.text)

end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_costesmapa
integer x = 297
integer y = 276
integer width = 498
integer height = 88
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_costesplan"
ue_titulo      = "AYUDA SELECCION DE CUENTAS DE COSTE"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 



IF Trim(uo_asiento.text) = "" Then f_activar_campo(uo_asiento)
isle_campo    = This
end event

event sle_valor::modified;call super::modified;st_coste.text=f_nombre_costesplan(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.text)
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_costesmapa
integer x = 2167
integer y = 848
end type

event cb_salir::clicked;
Dec{2}	resto,dev
Integer	ene,xx


IF Trim(uo_asiento.Text) = "" THEN 
	Call Super::clicked
	RETURN
END IF

resto = 0
ene = dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.text)
FOR xx = 1 TO ene
	resto = resto + dw_lineas_asiento.GetItemDecimal(xx,"reparto")
NEXT
IF resto <> 100 THEN
	dev = MessageBox("Reparto erroneo","Total = " + String(resto,"##0.00")&
	                  + " %",Exclamation!,OKCancel!,2)
	IF dev = 2 THEN
		f_activar_campo(sle_valor)
	ELSE
		Call Super::clicked
	END IF
ELSE
	Call Super::clicked
END IF
	
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_costesmapa
integer taborder = 80
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_costesmapa
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_costesmapa
integer width = 2816
end type

type st_3 from statictext within wi_mant_costesmapa
integer x = 37
integer y = 172
integer width = 238
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cuenta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within wi_mant_costesmapa
integer x = 2171
integer y = 168
integer height = 288
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_lineas_asiento from datawindow within wi_mant_costesmapa
integer x = 5
integer y = 524
integer width = 2089
integer height = 928
boolean bringtotop = true
string dataobject = "dw_costesmapa_2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row =0 Then 
 f_activar_campo(uo_asiento)
 Return
END IF

sle_valor.text = This.GetItemString(row,"coste")
st_coste.text=f_nombre_costesplan(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.text)

Parent.TriggerEvent("ue_recuperar")

f_activar_campo(sle_valor)
end event

type gb_1 from groupbox within wi_mant_costesmapa
integer x = 2153
integer y = 608
integer width = 434
integer height = 344
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_1 from picturebutton within wi_mant_costesmapa
integer x = 805
integer y = 172
integer width = 110
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 3
lstr_param.s_argumentos[1]  = "wi_mant_costesmapa"

lstr_param.s_argumentos[2]  = uo_ejercicio.em_ejercicio.text
lstr_param.s_argumentos[3]=uo_asiento.Text
OpenWithParm(wi_mant_contaplan,lstr_param) 
end event

type pb_2 from picturebutton within wi_mant_costesmapa
integer x = 805
integer y = 276
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 3
lstr_param.s_argumentos[1]  = "wi_mant_costesmapa"

lstr_param.s_argumentos[2]  = uo_ejercicio.em_ejercicio.text
lstr_param.s_argumentos[3]=sle_valor.Text
OpenWithParm(wi_mant_costesplan,lstr_param) 
end event

type st_cuenta from statictext within wi_mant_costesmapa
integer x = 914
integer y = 180
integer width = 1248
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_coste from statictext within wi_mant_costesmapa
integer x = 914
integer y = 284
integer width = 1248
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_asiento from u_em_campo within wi_mant_costesmapa
integer x = 297
integer y = 176
integer width = 498
integer taborder = 10
end type

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_contaplan"
ue_titulo      = "AYUDA SELECCION DEL PLAN DE CUENTAS"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text + &
                 " AND analitica = 'S'"

isle_campo     = This

//valor_empresa = TRUE
//dw_1.reset()
//
//ue_titulo     = "AYUDA SELECCION FORMAS DE PAGO"
//ue_datawindow = "dw_ayuda_carforpag"
//ue_filtro     = ""		
//isle_campo    = this
//
//IF istr_parametros.i_nargumentos>1 THEN
//	  em_forma.text=istr_parametros.s_argumentos[2]
//     This.TriggerEvent("modificado")
//	  sle_valor.text=istr_parametros.s_argumentos[3]
//	  sle_valor.TriggerEvent("modificado")
//  	  istr_parametros.i_nargumentos=0
//     IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
//			Parent.TriggerEvent("ue_recuperar")
//			f_activar_campo(sle_valor)     
//			Return
//     END IF     
//     f_activar_campo(sle_valor)     
//END IF
//
//
end event

event modificado;call super::modificado;st_cuenta.text=f_nombre_contaplan(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.text)
IF Trim(uo_asiento.text)="" THEN 
 IF Trim(uo_asiento.text)<>"" Then uo_asiento.SetFocus()
 uo_asiento.text=""
 uo_asiento.text=""
END IF
dw_lineas_asiento.Retrieve(integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,uo_asiento.text)
end event

event tecla_tabulador;
ue_valor = This.Text
This.Text = ""
call super::tecla_tabulador
end event

type dw_listado from datawindow within wi_mant_costesmapa
boolean visible = false
integer x = 1979
integer y = 260
integer width = 494
integer height = 360
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_costesmapa"
boolean livescroll = true
end type

type pb_3 from picturebutton within wi_mant_costesmapa
integer x = 1902
integer y = 404
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "print!"
alignment htextalign = left!
end type

event clicked;dw_listado.retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa)
f_imprimir_datawindow(dw_listado)
end event

