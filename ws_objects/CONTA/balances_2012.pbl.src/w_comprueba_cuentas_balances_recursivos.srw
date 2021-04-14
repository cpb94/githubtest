$PBExportHeader$w_comprueba_cuentas_balances_recursivos.srw
forward
global type w_comprueba_cuentas_balances_recursivos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_comprueba_cuentas_balances_recursivos
end type
type uo_ejercicio_origen from u_ejercicio within w_comprueba_cuentas_balances_recursivos
end type
type uo_balance from u_em_campo_2 within w_comprueba_cuentas_balances_recursivos
end type
type em_cuentadesde from u_em_campo within w_comprueba_cuentas_balances_recursivos
end type
type em_cuentahasta from u_em_campo within w_comprueba_cuentas_balances_recursivos
end type
type cb_1 from commandbutton within w_comprueba_cuentas_balances_recursivos
end type
type dw_1 from datawindow within w_comprueba_cuentas_balances_recursivos
end type
type st_1 from statictext within w_comprueba_cuentas_balances_recursivos
end type
type gb_balance from groupbox within w_comprueba_cuentas_balances_recursivos
end type
type gb_cuentas from groupbox within w_comprueba_cuentas_balances_recursivos
end type
end forward

global type w_comprueba_cuentas_balances_recursivos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 1993
integer height = 2096
pb_2 pb_2
uo_ejercicio_origen uo_ejercicio_origen
uo_balance uo_balance
em_cuentadesde em_cuentadesde
em_cuentahasta em_cuentahasta
cb_1 cb_1
dw_1 dw_1
st_1 st_1
gb_balance gb_balance
gb_cuentas gb_cuentas
end type
global w_comprueba_cuentas_balances_recursivos w_comprueba_cuentas_balances_recursivos

type variables
integer ejercicio_origen,ejercicio_destino
end variables

event open;call super::open;This.title = "Chequeo Cuentas Balances"
f_activar_campo(uo_ejercicio_origen.em_ejercicio)

dw_1.settransobject(sqlca)

end event

on w_comprueba_cuentas_balances_recursivos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_ejercicio_origen=create uo_ejercicio_origen
this.uo_balance=create uo_balance
this.em_cuentadesde=create em_cuentadesde
this.em_cuentahasta=create em_cuentahasta
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.gb_balance=create gb_balance
this.gb_cuentas=create gb_cuentas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_ejercicio_origen
this.Control[iCurrent+3]=this.uo_balance
this.Control[iCurrent+4]=this.em_cuentadesde
this.Control[iCurrent+5]=this.em_cuentahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.gb_balance
this.Control[iCurrent+10]=this.gb_cuentas
end on

on w_comprueba_cuentas_balances_recursivos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_ejercicio_origen)
destroy(this.uo_balance)
destroy(this.em_cuentadesde)
destroy(this.em_cuentahasta)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.gb_balance)
destroy(this.gb_cuentas)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_comprueba_cuentas_balances_recursivos
integer x = 366
integer y = 24
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_comprueba_cuentas_balances_recursivos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_comprueba_cuentas_balances_recursivos
integer width = 1710
end type

type pb_2 from upb_salir within w_comprueba_cuentas_balances_recursivos
integer x = 1829
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
end type

type uo_ejercicio_origen from u_ejercicio within w_comprueba_cuentas_balances_recursivos
event destroy ( )
integer x = 1335
integer y = 152
integer width = 645
integer taborder = 70
end type

on uo_ejercicio_origen.destroy
call u_ejercicio::destroy
end on

type uo_balance from u_em_campo_2 within w_comprueba_cuentas_balances_recursivos
event destroy ( )
integer x = 27
integer y = 208
integer width = 1266
integer height = 80
integer taborder = 10
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_balance.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_balance.em_campo.text=f_conta_bal_cab_descripcion(codigo_empresa,uo_balance.em_codigo.text)

IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""

END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_conta_bal_cab"
ue_filtro     = ""

end event

type em_cuentadesde from u_em_campo within w_comprueba_cuentas_balances_recursivos
integer x = 27
integer y = 384
integer width = 384
integer taborder = 20
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#############"
string displaydata = ""
end type

type em_cuentahasta from u_em_campo within w_comprueba_cuentas_balances_recursivos
integer x = 503
integer y = 384
integer width = 407
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#############"
string displaydata = ""
end type

type cb_1 from commandbutton within w_comprueba_cuentas_balances_recursivos
integer x = 955
integer y = 384
integer width = 329
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string ls_cuenta_desde,ls_cuenta_hasta,ls_sel
int    li_ejercicio,li_digito
long   ll_total
str_contaparam lstr_contaparam

datastore ds_datos

li_ejercicio = integer(uo_ejercicio_origen.em_ejercicio.text)

if f_cargar_str_contaparam(li_ejercicio,codigo_empresa,lstr_contaparam) and uo_balance.em_codigo.text <> "" then
	
	if em_cuentadesde.text = "" then em_cuentadesde.text = "1"
	if em_cuentahasta.text = "" then 
		for li_digito = 1 to lstr_contaparam.digitos
			em_cuentahasta.text += "9"
		next			
	end if

	ls_cuenta_desde = em_cuentadesde.text
	ls_cuenta_hasta = em_cuentahasta.text

	//SELECT conta_bal_grup_ctas.empresa, conta_bal_grup_ctas.conta_bal_cab_codigo, conta_bal_grup_ctas.conta_bal_grup_codigo, conta_bal_grup_ctas.contaplan_cuenta, conta_bal_grup_ctas.ejercicio, conta_bal_grup_ctas.orden, conta_bal_grup_ctas.porcentaje FROM conta_bal_grup_ctas


	ls_sel = "select contaapun.cuenta,"+&
				"       isnull(contaplan.titulo,contaapun.cuenta) as titulo "+&
				"       sum(contaapun.debe - contaapun.haber) as saldo "+&
				"from   contaapun "+&
				"       LEFT OUTER JOIN contaplan ON contaapun.ejercicio = contaplan.ejercicio AND contaapun.empresa = contaplan.empresa AND contaapun.cuenta = contaplan.cuenta "+&
				"where  contaapun.empresa = '"+codigo_empresa+"' "+&
				"and    contaapun.cuenta between '"+ls_cuenta_desde+"' and '"+ls_cuenta_hasta+"' "+&
				"and    not exists (select conta_bal_grup_ctas.contaplan_cuenta "+&
				"                   from   conta_bal_grup_ctas "+&
				"                   where  conta_bal_grup_ctas.empresa              = contaapun.empresa "+&
				"                   and    conta_bal_grup_ctas.conta_bal_cab_codigo = '' "+&
				"                   and    conta_bal_grup_ctas.ejercicio            = contaapun.ejercicio "+&
				"                   where  conta_bal_grup_ctas.contaplan_cuenta     = substring(contaapun.cuenta,1,len(conta_bal_grup_ctas.contaplan_cuenta)) "+&
				") "+&
				"order by contaapun.cuenta "

	ls_sel = "select contaapun.cuenta, "+&
				"       isnull(contaplan.titulo,contaapun.cuenta) as titulo, "+&
				"       sum(contaapun.debe - contaapun.haber) as saldo "+&
				"from   contaapun "+&
				"       LEFT OUTER JOIN contaplan ON contaapun.ejercicio = contaplan.ejercicio AND contaapun.empresa = contaplan.empresa AND contaapun.cuenta = contaplan.cuenta "+&
				"where  contaapun.empresa = '"+codigo_empresa+"' "+&
				"and    contaapun.cuenta between '"+ls_cuenta_desde+"' and '"+ls_cuenta_hasta+"' "+&
				"and    contaapun.ejercicio = "+string(li_ejercicio,"###0")+" "+&
				"and    not exists (select conta_bal_grup_ctas.contaplan_cuenta "+&
				"                   from   conta_bal_grup_ctas "+&
				"                   where  conta_bal_grup_ctas.empresa              = contaapun.empresa "+&
				"                   and    conta_bal_grup_ctas.conta_bal_cab_codigo = '"+uo_balance.em_codigo.text+"' "+&
 				"                   and    conta_bal_grup_ctas.ejercicio            = contaapun.ejercicio "+&
				"                   and    isnull(conta_bal_grup_ctas.porcentaje,0) > 0 "+&
				"                   and    conta_bal_grup_ctas.contaplan_cuenta     = substring(contaapun.cuenta,1,len(conta_bal_grup_ctas.contaplan_cuenta)) ) "+&
				"group by contaapun.cuenta, "+&
				"         contaplan.titulo "+&
				"order by contaapun.cuenta"

	// Tencer tiene como ejercicio en conta_bal_grup_ctas el 0 para todos los años
	ls_sel = "select contaapun.cuenta, "+&
				"       isnull(contaplan.titulo,contaapun.cuenta) as titulo, "+&
				"       sum(contaapun.debe - contaapun.haber) as saldo "+&
				"from   contaapun "+&
				"       LEFT OUTER JOIN contaplan ON contaapun.ejercicio = contaplan.ejercicio AND contaapun.empresa = contaplan.empresa AND contaapun.cuenta = contaplan.cuenta "+&
				"where  contaapun.empresa = '"+codigo_empresa+"' "+&
				"and    contaapun.cuenta between '"+ls_cuenta_desde+"' and '"+ls_cuenta_hasta+"' "+&
				"and    contaapun.ejercicio = "+string(li_ejercicio,"###0")+" "+&
				"and    not exists (select conta_bal_grup_ctas.contaplan_cuenta "+&
				"                   from   conta_bal_grup_ctas "+&
				"                   where  conta_bal_grup_ctas.empresa              = contaapun.empresa "+&
				"                   and    conta_bal_grup_ctas.conta_bal_cab_codigo = '"+uo_balance.em_codigo.text+"' "+&
 				"                   and    conta_bal_grup_ctas.ejercicio            = 0 "+&
				"                   and    isnull(conta_bal_grup_ctas.porcentaje,0) > 0 "+&
				"                   and    conta_bal_grup_ctas.contaplan_cuenta     = substring(contaapun.cuenta,1,len(conta_bal_grup_ctas.contaplan_cuenta)) ) "+&
				"group by contaapun.cuenta, "+&
				"         contaplan.titulo "+&
				"order by contaapun.cuenta"

	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	if ll_total > 0 then
		dw_1.object.data = ds_datos.object.data
	else
		dw_1.reset()
		messagebox("Resultado","No hay cuentas en contabilidad no incluidas en el balance.")
	end if
else
	if uo_balance.em_codigo.text = "" then
		messagebox("¡Error!","Seleccione el balance a chequear.")
	else
		messagebox("¡Error!","Ejercicio no parametrizado.")
	end if
end if

destroy ds_datos 

end event

type dw_1 from datawindow within w_comprueba_cuentas_balances_recursivos
integer x = 9
integer y = 496
integer width = 1966
integer height = 1432
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Cuentas no incluidas en el balance"
string dataobject = "dw_comprueba_cuentas_balances_recursivos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_comprueba_cuentas_balances_recursivos
integer x = 434
integer y = 396
integer width = 46
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_balance from groupbox within w_comprueba_cuentas_balances_recursivos
integer x = 9
integer y = 152
integer width = 1307
integer height = 160
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Balance"
end type

type gb_cuentas from groupbox within w_comprueba_cuentas_balances_recursivos
integer x = 9
integer y = 328
integer width = 928
integer height = 160
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cuenta desde/hasta"
end type

