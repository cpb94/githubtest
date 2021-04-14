$PBExportHeader$w_int_stock_sugerido.srw
forward
global type w_int_stock_sugerido from wi_mant_ventanas
end type
type uo_cliente from u_em_campo_2 within w_int_stock_sugerido
end type
type gb_5 from groupbox within w_int_stock_sugerido
end type
type gb_4 from groupbox within w_int_stock_sugerido
end type
end forward

global type w_int_stock_sugerido from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2391
integer height = 744
uo_cliente uo_cliente
gb_5 gb_5
gb_4 gb_4
end type
global w_int_stock_sugerido w_int_stock_sugerido

event open;call super::open;istr_parametros.s_titulo_ventana = "Introducción de Stock Sugerido"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

tipo_mantenimiento='C'
 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(codigo_empresa,sle_valor.text)
     END IF
END IF



end event

event ue_activa_claves;call super::ue_activa_claves;//pb_calculadora.visible = TRUE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "subfamilias"

 dw_1.Retrieve(codigo_empresa,sle_valor.Text)
 CALL Super::ue_recuperar






end event

on w_int_stock_sugerido.create
int iCurrent
call super::create
this.uo_cliente=create uo_cliente
this.gb_5=create gb_5
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.gb_5
this.Control[iCurrent+3]=this.gb_4
end on

on w_int_stock_sugerido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_cliente)
destroy(this.gb_5)
destroy(this.gb_4)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;//pb_calculadora.visible = FALSE
end event

type dw_1 from wi_mant_ventanas`dw_1 within w_int_stock_sugerido
integer x = 69
integer y = 196
integer width = 1801
integer height = 280
string dataobject = "dw_subfamilias"
borderstyle borderstyle = stylelowered!
end type

type st_1 from wi_mant_ventanas`st_1 within w_int_stock_sugerido
boolean visible = false
integer x = 1947
integer y = 56
integer width = 302
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within w_int_stock_sugerido
integer x = 1911
integer y = 188
integer width = 311
end type

event cb_insertar::clicked;
if dw_1.rowcount() < 1 then
	f_activar_campo(sle_valor)
	return
else
	dw_1.object.fechastocksugerido[dw_1.getrow()] = date(string(date(today()), "dd-mm-yy"))
	CALL Super::clicked
end if

end event

type cb_borrar from wi_mant_ventanas`cb_borrar within w_int_stock_sugerido
boolean visible = false
integer x = 1893
integer y = 408
end type

event cb_borrar::clicked;call super::clicked;uo_cliente.setfocus()
end event

type sle_valor from wi_mant_ventanas`sle_valor within w_int_stock_sugerido
integer x = 1157
integer y = 76
integer width = 704
integer height = 68
integer taborder = 20
fontcharset fontcharset = ansi!
long textcolor = 0
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "Ayuda Artículos"
ue_datawindow     = "dw_ayuda_articulos"
if uo_cliente.em_codigo.text = "" or isnull(uo_cliente.em_codigo.text) then
	ue_filtro = ""
else
	ue_filtro         =  "cliente = '"+uo_cliente.em_codigo.text+"'"
end if
valor_empresa     = true
isle_campo        = This

end event

event sle_valor::losefocus;call super::losefocus;//if trim(sle_valor.text) = "" or isnull(sle_valor.text ) then
//	f_activar_campo(sle_valor)
//end if


end event

type cb_salir from wi_mant_ventanas`cb_salir within w_int_stock_sugerido
integer x = 1911
integer y = 284
integer width = 311
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within w_int_stock_sugerido
integer taborder = 30
end type

type uo_cliente from u_em_campo_2 within w_int_stock_sugerido
event destroy ( )
integer x = 105
integer y = 76
integer width = 992
integer height = 68
integer taborder = 10
boolean bringtotop = true
boolean border = true
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type gb_5 from groupbox within w_int_stock_sugerido
integer x = 1143
integer y = 24
integer width = 731
integer height = 140
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "Artículo"
end type

type gb_4 from groupbox within w_int_stock_sugerido
integer x = 87
integer y = 20
integer width = 1029
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "Cliente"
end type

