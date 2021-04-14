$PBExportHeader$w_con_encajado.srw
forward
global type w_con_encajado from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_con_encajado
end type
type dw_1 from datawindow within w_con_encajado
end type
type gb_4 from groupbox within w_con_encajado
end type
type gb_3 from groupbox within w_con_encajado
end type
type cb_consulta from u_boton within w_con_encajado
end type
type pb_1 from upb_salir within w_con_encajado
end type
type gb_5 from groupbox within w_con_encajado
end type
type uo_caja from u_em_campo_2 within w_con_encajado
end type
type uo_formato from u_em_campo_2 within w_con_encajado
end type
type uo_cliente from u_em_campo_2 within w_con_encajado
end type
type uo_pallet from u_em_campo_2 within w_con_encajado
end type
type cb_2 from commandbutton within w_con_encajado
end type
type cb_3 from commandbutton within w_con_encajado
end type
type cb_4 from commandbutton within w_con_encajado
end type
type sle_cajas from singlelineedit within w_con_encajado
end type
type sle_alturas from singlelineedit within w_con_encajado
end type
type sle_planos from singlelineedit within w_con_encajado
end type
type st_1 from statictext within w_con_encajado
end type
type st_2 from statictext within w_con_encajado
end type
type st_3 from statictext within w_con_encajado
end type
type gb_1 from groupbox within w_con_encajado
end type
type gb_2 from groupbox within w_con_encajado
end type
type r_1 from rectangle within w_con_encajado
end type
type p_cursor from picture within w_con_encajado
end type
type uo_familia from u_em_campo_2 within w_con_encajado
end type
type cbx_acabado from checkbox within w_con_encajado
end type
type uo_tarifa from u_em_campo_2 within w_con_encajado
end type
type gb_7 from groupbox within w_con_encajado
end type
type gb_6 from groupbox within w_con_encajado
end type
end forward

global type w_con_encajado from w_int_con_empresa
integer x = 27
integer y = 4
integer width = 5431
integer height = 3628
string title = "Consumo de bases"
pb_imprimir pb_imprimir
dw_1 dw_1
gb_4 gb_4
gb_3 gb_3
cb_consulta cb_consulta
pb_1 pb_1
gb_5 gb_5
uo_caja uo_caja
uo_formato uo_formato
uo_cliente uo_cliente
uo_pallet uo_pallet
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
sle_cajas sle_cajas
sle_alturas sle_alturas
sle_planos sle_planos
st_1 st_1
st_2 st_2
st_3 st_3
gb_1 gb_1
gb_2 gb_2
r_1 r_1
p_cursor p_cursor
uo_familia uo_familia
cbx_acabado cbx_acabado
uo_tarifa uo_tarifa
gb_7 gb_7
gb_6 gb_6
end type
global w_con_encajado w_con_encajado

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string seccion, linea, turno, caja, formato, cliente, familia, pallet, tarifa
string filtro, articulos_tarifa , consulta, filtro_aux
datastore datos
long i


dw_1.reset()


if uo_caja.em_codigo.text = "" or isnull(uo_caja.em_codigo.text) then
	caja = "%"
else
	caja = uo_caja.em_codigo.text
end if

if uo_pallet.em_codigo.text = "" or isnull(uo_pallet.em_codigo.text) then
	pallet = "%"
else
	pallet = uo_pallet.em_codigo.text
end if

if uo_formato.em_codigo.text = "" or isnull(uo_formato.em_codigo.text) then
	formato = "%"
else
	formato = uo_formato.em_codigo.text
end if

//if uo_cliente.em_codigo.text = "" or isnull(uo_cliente.em_codigo.text) then
//	cliente = "%"
//else
//	cliente = uo_cliente.em_codigo.text
//end if

if uo_familia.em_codigo.text = "" or isnull(uo_familia.em_codigo.text) then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

if uo_tarifa.em_codigo.text <> '' then
	tarifa = uo_tarifa.em_codigo.text
else
	tarifa = 'VACIO'
end if

dw_1.Retrieve(codigo_empresa,caja, formato,  pallet , familia,  tarifa)

if uo_tarifa.em_codigo.text <> '' then
	consulta = " SELECT articulos_codigo "+&
				"  FROM ventarifas_precios"+&
				"  WHERE calidades_codigo = '1' "+&
				"  and empresa = '"+codigo_empresa+"' "+&
				"  and ventarifas_codigo = '"+tarifa+"' "
	
	f_cargar_cursor_trans (SQLCA, consulta, datos)
	
	for i = 1 to datos.rowcount()
		if i = 1 then 
			filtro_aux  = " palarticulo_articulo in ( '"+datos.object.articulos_codigo[i]+"'"
		else
			filtro_aux = filtro_aux +", '"+ datos.object.articulos_codigo[i]+"' "
		end if
	next 
	filtro = filtro_aux+") "
else
	filtro = ' 1 = 1 '
end if	

if cbx_acabado.checked then
	filtro = filtro + " and articulos_uso = '3' "
end if


if uo_cliente.em_codigo.text <> "" and not isnull(uo_cliente.em_codigo.text) then
	filtro = filtro + " and articulos_cliente = '"+uo_cliente.em_codigo.text+"' "
end if


dw_1.SetFilter(filtro)
dw_1.Filter( )


destroy datos


//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//else
//	if not isnull(uo_cliente.em_codigo.text)  and uo_cliente.em_codigo.text <> "" then
//		dw_1.setfilter("articulos_cliente = '"+uo_cliente.em_codigo.text+"' ")
//		dw_1.filter()
//	else
//		dw_1.setfilter("")
//		dw_1.filter()
//	end if
//end if
//
//








end subroutine

on w_con_encajado.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.cb_consulta=create cb_consulta
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_caja=create uo_caja
this.uo_formato=create uo_formato
this.uo_cliente=create uo_cliente
this.uo_pallet=create uo_pallet
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.sle_cajas=create sle_cajas
this.sle_alturas=create sle_alturas
this.sle_planos=create sle_planos
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.r_1=create r_1
this.p_cursor=create p_cursor
this.uo_familia=create uo_familia
this.cbx_acabado=create cbx_acabado
this.uo_tarifa=create uo_tarifa
this.gb_7=create gb_7
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_4
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.gb_5
this.Control[iCurrent+8]=this.uo_caja
this.Control[iCurrent+9]=this.uo_formato
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.uo_pallet
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.cb_4
this.Control[iCurrent+15]=this.sle_cajas
this.Control[iCurrent+16]=this.sle_alturas
this.Control[iCurrent+17]=this.sle_planos
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.r_1
this.Control[iCurrent+24]=this.p_cursor
this.Control[iCurrent+25]=this.uo_familia
this.Control[iCurrent+26]=this.cbx_acabado
this.Control[iCurrent+27]=this.uo_tarifa
this.Control[iCurrent+28]=this.gb_7
this.Control[iCurrent+29]=this.gb_6
end on

on w_con_encajado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.cb_consulta)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_caja)
destroy(this.uo_formato)
destroy(this.uo_cliente)
destroy(this.uo_pallet)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.sle_cajas)
destroy(this.sle_alturas)
destroy(this.sle_planos)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.r_1)
destroy(this.p_cursor)
destroy(this.uo_familia)
destroy(this.cbx_acabado)
destroy(this.uo_tarifa)
destroy(this.gb_7)
destroy(this.gb_6)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Encajados"
istr_parametros.s_listado        =   "dw_con_encajados"
This.title                       =   istr_parametros.s_titulo_ventana

uo_caja.setfocus()

dw_1.SetTransObject(SQLCA)
//dw_1.SetRowFocusIndicator(Hand!)
dw_1.SetRowFocusIndicator(p_cursor)




end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

event activate;call super::activate;w_con_encajado = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_encajado
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_encajado
integer x = 55
integer y = 12
integer width = 320
integer height = 52
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_encajado
integer y = 4
integer width = 5243
integer textsize = -8
end type

type pb_imprimir from upb_imprimir within w_con_encajado
event clicked pbm_bnclicked
integer x = 5111
integer y = 164
integer taborder = 0
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type dw_1 from datawindow within w_con_encajado
integer x = 27
integer y = 280
integer width = 5335
integer height = 3136
string dataobject = "dw_con_encajado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

type gb_4 from groupbox within w_con_encajado
integer x = 1097
integer y = 84
integer width = 905
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_3 from groupbox within w_con_encajado
integer x = 786
integer y = 84
integer width = 311
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Formato"
end type

type cb_consulta from u_boton within w_con_encajado
integer x = 4805
integer y = 160
integer width = 297
integer height = 104
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_encajado
integer x = 5230
integer y = 164
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within w_con_encajado
integer x = 23
integer y = 84
integer width = 763
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Caja"
end type

type uo_caja from u_em_campo_2 within w_con_encajado
event destroy ( )
integer x = 46
integer y = 140
integer width = 713
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_caja

select descripcion
into :des_caja
from almcajas
where empresa = :codigo_empresa
and codigo = :uo_caja.em_codigo.text;

uo_caja.em_campo.text = des_caja
IF Trim(uo_caja.em_campo.text)="" THEN 
 IF Trim(uo_caja.em_codigo.text)<>"" Then uo_caja.em_campo.SetFocus()
 uo_caja.em_campo.text=""
 uo_caja.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_cajas"
ue_filtro     = ""

end event

type uo_formato from u_em_campo_2 within w_con_encajado
event destroy ( )
integer x = 805
integer y = 144
integer width = 274
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

IF Trim(uo_formato.em_campo.text)="" THEN 
 	IF Trim(uo_formato.em_codigo.text)<>"" Then 
		uo_formato.em_campo.SetFocus()
	END IF
 	uo_formato.em_campo.text=""
 	uo_formato.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de formatos"
ue_datawindow = "dw_ayuda_formatos"
ue_filtro     = ""

end event

type uo_cliente from u_em_campo_2 within w_con_encajado
event destroy ( )
integer x = 1115
integer y = 144
integer width = 864
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)

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

type uo_pallet from u_em_campo_2 within w_con_encajado
event destroy ( )
integer x = 2066
integer y = 144
integer width = 649
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pallet.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_pallet.em_campo.text=f_nombre_pallet(codigo_empresa,uo_pallet.em_codigo.text)

IF Trim(uo_pallet.em_campo.text)="" THEN 
 	IF Trim(uo_pallet.em_codigo.text)<>"" Then 
		uo_pallet.em_campo.SetFocus()
	END IF
 	uo_pallet.em_campo.text=""
 	uo_pallet.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Pallets"
ue_datawindow = "dw_ayuda_pallets"
ue_filtro     = ""

end event

type cb_2 from commandbutton within w_con_encajado
boolean visible = false
integer x = 3429
integer y = 3288
integer width = 521
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcar Todos"
end type

event clicked;long i

for i=1 to dw_1.rowcount()
	dw_1.object.articulos_marca[i] = 'S'
next
end event

type cb_3 from commandbutton within w_con_encajado
boolean visible = false
integer x = 3959
integer y = 3288
integer width = 521
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Desmarcar Todos"
end type

event clicked;long i

for i=1 to dw_1.rowcount()
	dw_1.object.articulos_marca[i] = 'N'
next
end event

type cb_4 from commandbutton within w_con_encajado
boolean visible = false
integer x = 1915
integer y = 3288
integer width = 343
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;long i
string articulo, codigo, caja
int cajaspallet, planospallet, alturas

IF MessageBox("Atención", "Seguro que deseea Modificar los paletizados?", Exclamation!, OKCancel!, 2) = 1 THEN
	for i = 1 to dw_1.rowcount()
		if dw_1.object.articulos_marca[i] = 'S' then
			articulo = dw_1.object.palarticulo_articulo[i]
			codigo = dw_1.object.pallets_codigo[i]
			caja = dw_1.object.palarticulo_caja[i]
			cajaspallet = dw_1.object.palarticulo_cajaspallet[i]
			planospallet = dw_1.object.palarticulo_planospallet[i]
			alturas = dw_1.object.palarticulo_alturas[i]
			
			if sle_cajas.text <> '' and not isnull(sle_cajas.text) then
				cajaspallet = integer(sle_cajas.text)
			end if
			if sle_planos.text <> '' and not isnull(sle_planos.text) then
				planospallet = integer(sle_planos.text)
			end if
			if sle_alturas.text <> '' and not isnull(sle_alturas.text) then
				alturas = integer(sle_alturas.text)
			end if
			
			update palarticulo
			set cajaspallet = :cajaspallet, planospallet = :planospallet, alturas = :alturas
			where empresa = :codigo_empresa
			and articulo = :articulo
			and codigo = :codigo
			and caja = :caja
			using SQLCA;
			
			if SQLCA.SQLCode = 0 then
				commit;
			else
				rollback;
				messagebox("Aviso", "Se ha producido un error durante el proceso")
			end if		
		end if
	next
ELSE

 // Process CANCEL.

END IF

cb_consulta.TriggerEvent(clicked!)
end event

type sle_cajas from singlelineedit within w_con_encajado
boolean visible = false
integer x = 315
integer y = 3288
integer width = 343
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_alturas from singlelineedit within w_con_encajado
boolean visible = false
integer x = 1531
integer y = 3288
integer width = 343
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_planos from singlelineedit within w_con_encajado
boolean visible = false
integer x = 914
integer y = 3288
integer width = 343
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_encajado
boolean visible = false
integer x = 91
integer y = 3300
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Cajas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_encajado
boolean visible = false
integer x = 1307
integer y = 3304
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Alturas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_encajado
boolean visible = false
integer x = 686
integer y = 3304
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Planos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_encajado
integer x = 2048
integer y = 84
integer width = 690
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pallet"
end type

type gb_2 from groupbox within w_con_encajado
integer x = 1097
integer y = 84
integer width = 937
integer height = 160
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type r_1 from rectangle within w_con_encajado
boolean visible = false
integer linethickness = 4
long fillcolor = 15780518
integer x = 41
integer y = 3280
integer width = 1851
integer height = 104
end type

type p_cursor from picture within w_con_encajado
integer x = 2533
integer y = 1684
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Next!"
boolean focusrectangle = false
end type

type uo_familia from u_em_campo_2 within w_con_encajado
event destroy ( )
integer x = 2770
integer y = 144
integer width = 622
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_familia.em_campo.text=f_nombre_familia(codigo_empresa,uo_familia.em_codigo.text)

IF Trim(uo_familia.em_campo.text)="" THEN 
 	IF Trim(uo_familia.em_codigo.text)<>"" Then 
		uo_familia.em_campo.SetFocus()
	END IF
 	uo_familia.em_campo.text=""
 	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type cbx_acabado from checkbox within w_con_encajado
integer x = 4795
integer y = 80
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Acabado"
borderstyle borderstyle = styleraised!
end type

type uo_tarifa from u_em_campo_2 within w_con_encajado
event destroy ( )
integer x = 3483
integer y = 148
integer width = 622
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_tarifa.em_campo.text=f_nombre_ventarifa_abr(codigo_empresa, uo_tarifa.em_codigo.text)

IF Trim(uo_tarifa.em_campo.text)="" THEN 
 	IF Trim(uo_tarifa.em_codigo.text)<>"" Then 
		uo_tarifa.em_campo.SetFocus()
	END IF
 	uo_tarifa.em_campo.text=""
 	uo_tarifa.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tarifas"
ue_datawindow = "dw_ayuda_ventarifas"
ue_filtro     = ""

end event

type gb_7 from groupbox within w_con_encajado
integer x = 2752
integer y = 84
integer width = 663
integer height = 160
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Familia"
end type

type gb_6 from groupbox within w_con_encajado
integer x = 3465
integer y = 88
integer width = 663
integer height = 160
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tarifa"
end type

