$PBExportHeader$w_comprueba_cuentasnpgc.srw
forward
global type w_comprueba_cuentasnpgc from w_int_con_empresa
end type
type pb_2 from upb_salir within w_comprueba_cuentasnpgc
end type
type uo_ejercicio_origen from u_ejercicio within w_comprueba_cuentasnpgc
end type
type uo_balance from u_em_campo_2 within w_comprueba_cuentasnpgc
end type
type st_1 from statictext within w_comprueba_cuentasnpgc
end type
type em_cuentadesde from u_em_campo within w_comprueba_cuentasnpgc
end type
type em_cuentahasta from u_em_campo within w_comprueba_cuentasnpgc
end type
type cb_1 from commandbutton within w_comprueba_cuentasnpgc
end type
type dw_proceso from datawindow within w_comprueba_cuentasnpgc
end type
type dw_1 from datawindow within w_comprueba_cuentasnpgc
end type
type st_2 from statictext within w_comprueba_cuentasnpgc
end type
type st_3 from statictext within w_comprueba_cuentasnpgc
end type
type cb_2 from commandbutton within w_comprueba_cuentasnpgc
end type
type st_4 from statictext within w_comprueba_cuentasnpgc
end type
type dw_listado from datawindow within w_comprueba_cuentasnpgc
end type
end forward

global type w_comprueba_cuentasnpgc from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2235
integer height = 1636
string title = "Consulta de Movimientos"
pb_2 pb_2
uo_ejercicio_origen uo_ejercicio_origen
uo_balance uo_balance
st_1 st_1
em_cuentadesde em_cuentadesde
em_cuentahasta em_cuentahasta
cb_1 cb_1
dw_proceso dw_proceso
dw_1 dw_1
st_2 st_2
st_3 st_3
cb_2 cb_2
st_4 st_4
dw_listado dw_listado
end type
global w_comprueba_cuentasnpgc w_comprueba_cuentasnpgc

type variables
integer ejercicio_origen,ejercicio_destino
end variables

event open;call super::open;This.title = "Integridad de Balances "
f_activar_campo(uo_ejercicio_origen.em_ejercicio)



dw_proceso.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_listado.settransobject(sqlca)
end event

on w_comprueba_cuentasnpgc.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_ejercicio_origen=create uo_ejercicio_origen
this.uo_balance=create uo_balance
this.st_1=create st_1
this.em_cuentadesde=create em_cuentadesde
this.em_cuentahasta=create em_cuentahasta
this.cb_1=create cb_1
this.dw_proceso=create dw_proceso
this.dw_1=create dw_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_2=create cb_2
this.st_4=create st_4
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_ejercicio_origen
this.Control[iCurrent+3]=this.uo_balance
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_cuentadesde
this.Control[iCurrent+6]=this.em_cuentahasta
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_proceso
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.dw_listado
end on

on w_comprueba_cuentasnpgc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_ejercicio_origen)
destroy(this.uo_balance)
destroy(this.st_1)
destroy(this.em_cuentadesde)
destroy(this.em_cuentahasta)
destroy(this.cb_1)
destroy(this.dw_proceso)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.dw_listado)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_comprueba_cuentasnpgc
integer x = 1527
integer y = 320
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_comprueba_cuentasnpgc
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_comprueba_cuentasnpgc
integer width = 1710
end type

type pb_2 from upb_salir within w_comprueba_cuentasnpgc
integer x = 1787
integer y = 24
integer width = 128
integer height = 112
integer taborder = 0
end type

type uo_ejercicio_origen from u_ejercicio within w_comprueba_cuentasnpgc
event destroy ( )
integer x = 1015
integer y = 152
integer width = 645
integer taborder = 70
end type

on uo_ejercicio_origen.destroy
call u_ejercicio::destroy
end on

type uo_balance from u_em_campo_2 within w_comprueba_cuentasnpgc
event destroy ( )
integer x = 343
integer y = 316
integer width = 1170
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

event modificado;
uo_balance.em_campo.text=f_nombre_contabalnpgc(codigo_empresa,uo_balance.em_codigo.text)

IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""

END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"

ue_datawindow = "dw_ayuda_contabalnpgc"

ue_filtro     = ""

end event

type st_1 from statictext within w_comprueba_cuentasnpgc
integer x = 18
integer y = 316
integer width = 306
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Balance : "
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cuentadesde from u_em_campo within w_comprueba_cuentasnpgc
integer x = 489
integer y = 412
integer width = 366
integer taborder = 20
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##########"
string displaydata = ""
end type

type em_cuentahasta from u_em_campo within w_comprueba_cuentasnpgc
integer x = 1134
integer y = 412
integer width = 379
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##########"
string displaydata = ""
end type

type cb_1 from commandbutton within w_comprueba_cuentasnpgc
integer x = 1531
integer y = 408
integer width = 329
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string sel,relacion,cuenta,cuenta_balance,cuenta_corta,cta_desde,cta_hasta
long reg,reg2,i,j,posicion
int longi
boolean encontrada
datastore d



relacion = "contaballinnpgc"	


 
if em_cuentadesde.text = "" then em_cuentadesde.text = "1"
if em_cuentahasta.text = "" then em_cuentahasta.text = "9999999999"	


cta_desde = em_cuentadesde.text
cta_hasta = em_cuentahasta.text

// Cuentas que se utilizan en contabilidad
reg = dw_proceso.retrieve(dec(uo_ejercicio_origen.em_ejercicio.text),codigo_empresa,cta_desde,cta_hasta)


dw_1.retrieve()



sel = "Select distinct cuenta " + &
		" From " + relacion + "" + &
		" Where empresa = '" +codigo_empresa +"'" + &
		" and codbal = '" + uo_balance.em_codigo.text + "'" + &
		" order by cuenta"

d = f_cargar_cursor(sel)
reg2 = d.rowcount()


for i  = 1 to reg
	f_mensaje_proceso("Procesando",i,reg)
	cuenta = trim(dw_proceso.getitemstring(i,"cuenta"))
	if isnull(cuenta) then cuenta = ""
	
	encontrada = false
	
	for j = 1 to reg2
		cuenta_balance = trim(d.getitemstring(j,"cuenta"))
		longitud = len(cuenta_balance)
		cuenta_corta = mid(cuenta,1,longitud)
		if cuenta_corta = cuenta_balance then 
			encontrada = true	
			exit
		end if
	next
	
	if not encontrada then
		posicion = dw_1.insertrow(0)
		dw_1.setitem(posicion,"cuenta",cuenta)
		dw_1.setitem(posicion,"nombre_cuenta",f_nombre_contaplan(dec(uo_ejercicio_origen.em_ejercicio.text),codigo_empresa,cuenta) )		
	end if
next
end event

type dw_proceso from datawindow within w_comprueba_cuentasnpgc
boolean visible = false
integer x = 23
integer y = 132
integer width = 169
integer height = 180
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_proceso_integridadnpgc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_comprueba_cuentasnpgc
integer x = 59
integer y = 668
integer width = 1394
integer height = 700
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_integridad_balancenpgc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_comprueba_cuentasnpgc
integer x = 18
integer y = 412
integer width = 466
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cuenta desde : "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_comprueba_cuentasnpgc
integer x = 901
integer y = 416
integer width = 219
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta : "
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_comprueba_cuentasnpgc
integer x = 1467
integer y = 944
integer width = 302
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;string tipo
long i,posicion

tipo = "1"



if dw_1.rowcount() >= 1 then
	dw_listado.retrieve(codigo_empresa,uo_balance.em_codigo.text,tipo)
	
	
	dw_listado.setredraw(false)
	
	for i =  1 to dw_1.rowcount()
		f_mensaje_proceso("Procesando",i,dw_1.rowcount())
		posicion = dw_listado.insertrow(0)
		dw_listado.setitem(posicion,"cuenta",trim(dw_1.getitemstring(i,"cuenta")))
		dw_listado.setitem(posicion,"nombre_cuenta",trim(dw_1.getitemstring(i,"nombre_cuenta")))
	next
	dw_listado.setredraw(true)
	
	f_imprimir_datawindow(dw_listado)	
end if
end event

type st_4 from statictext within w_comprueba_cuentasnpgc
integer x = 73
integer y = 580
integer width = 1527
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Cuentas en contabilidad que no están en el balance"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_comprueba_cuentasnpgc
boolean visible = false
integer x = 1678
integer y = 528
integer width = 494
integer height = 360
integer taborder = 90
boolean bringtotop = true
string dataobject = "report_integridad_balancenpgc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

