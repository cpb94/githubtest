$PBExportHeader$w_con_trabajos_cliente.srw
forward
global type w_con_trabajos_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_trabajos_cliente
end type
type pb_2 from upb_imprimir within w_con_trabajos_cliente
end type
type cb_1 from commandbutton within w_con_trabajos_cliente
end type
type gb_6 from groupbox within w_con_trabajos_cliente
end type
type em_fdesde from u_em_campo within w_con_trabajos_cliente
end type
type em_fhasta from u_em_campo within w_con_trabajos_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_trabajos_cliente
end type
type gb_4 from groupbox within w_con_trabajos_cliente
end type
type sle_mes1 from singlelineedit within w_con_trabajos_cliente
end type
type sle_mes2 from singlelineedit within w_con_trabajos_cliente
end type
type sle_anyo1 from singlelineedit within w_con_trabajos_cliente
end type
type gb_3 from groupbox within w_con_trabajos_cliente
end type
type gb_5 from groupbox within w_con_trabajos_cliente
end type
type sle_anyo2 from singlelineedit within w_con_trabajos_cliente
end type
type dw_con_trabajos_cliente from datawindow within w_con_trabajos_cliente
end type
end forward

global type w_con_trabajos_cliente from w_int_con_empresa
integer width = 4462
integer height = 2676
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
em_fdesde em_fdesde
em_fhasta em_fhasta
uo_cliente uo_cliente
gb_4 gb_4
sle_mes1 sle_mes1
sle_mes2 sle_mes2
sle_anyo1 sle_anyo1
gb_3 gb_3
gb_5 gb_5
sle_anyo2 sle_anyo2
dw_con_trabajos_cliente dw_con_trabajos_cliente
end type
global w_con_trabajos_cliente w_con_trabajos_cliente

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string mes, cliente


data.SetTransObject(SQLCA)
data.Reset()

if uo_cliente.em_codigo.text = "" or isnull(uo_cliente.em_codigo.text) then
	cliente = "%"
else 
	cliente = uo_cliente.em_codigo.text	
end if


data.retrieve(codigo_empresa, cliente, long(sle_anyo1.text), long(sle_anyo2.text), long(sle_mes1.text), long(sle_mes2.text))
data.setredraw(false)		
//data.object.T1.text = "Desde "+sle_mes1.text+'-'+sle_anyo1.text+" Hasta "+sle_mes2.text+'-'+sle_anyo2.text
//data.object.T2.text = uo_cliente.em_campo.text


data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event open;call super::open;string mes


istr_parametros.s_titulo_ventana="Trabajos Cliente"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-01-01"
em_fhasta.text = string(today(),"dd-mm-yy")

sle_anyo1.text = '2001'
sle_anyo2.text = string (year(today()))
sle_mes1.text = '1'
sle_mes2.text =  string ( month(today()) - 1 )


end event

on w_con_trabajos_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.uo_cliente=create uo_cliente
this.gb_4=create gb_4
this.sle_mes1=create sle_mes1
this.sle_mes2=create sle_mes2
this.sle_anyo1=create sle_anyo1
this.gb_3=create gb_3
this.gb_5=create gb_5
this.sle_anyo2=create sle_anyo2
this.dw_con_trabajos_cliente=create dw_con_trabajos_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.em_fdesde
this.Control[iCurrent+6]=this.em_fhasta
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.gb_4
this.Control[iCurrent+9]=this.sle_mes1
this.Control[iCurrent+10]=this.sle_mes2
this.Control[iCurrent+11]=this.sle_anyo1
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.gb_5
this.Control[iCurrent+14]=this.sle_anyo2
this.Control[iCurrent+15]=this.dw_con_trabajos_cliente
end on

on w_con_trabajos_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.uo_cliente)
destroy(this.gb_4)
destroy(this.sle_mes1)
destroy(this.sle_mes2)
destroy(this.sle_anyo1)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.sle_anyo2)
destroy(this.dw_con_trabajos_cliente)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_trabajos_cliente
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_trabajos_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_trabajos_cliente
integer y = 8
integer width = 4379
integer height = 84
end type

type pb_1 from upb_salir within w_con_trabajos_cliente
integer x = 4229
integer y = 156
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_trabajos_cliente
integer x = 4087
integer y = 156
integer taborder = 0
end type

event clicked;

 
f_imprimir_datawindow(dw_con_trabajos_cliente)

end event

type cb_1 from commandbutton within w_con_trabajos_cliente
integer x = 3758
integer y = 156
integer width = 288
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;
f_control(dw_con_trabajos_cliente)

end event

type gb_6 from groupbox within w_con_trabajos_cliente
integer x = 3739
integer y = 108
integer width = 635
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type em_fdesde from u_em_campo within w_con_trabajos_cliente
boolean visible = false
integer x = 960
integer y = 172
integer width = 288
integer height = 76
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_trabajos_cliente
boolean visible = false
integer x = 1202
integer y = 172
integer width = 288
integer height = 76
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type uo_cliente from u_em_campo_2 within w_con_trabajos_cliente
event destroy ( )
integer x = 951
integer y = 164
integer width = 1330
integer height = 80
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select razon
into :des_cliente
from genter
where empresa = :codigo_empresa
and codigo = :uo_cliente.em_codigo.text
and tipoter = 'C';

uo_cliente.em_campo.text = des_cliente

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow  = "dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_4 from groupbox within w_con_trabajos_cliente
integer x = 933
integer y = 112
integer width = 1367
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type sle_mes1 from singlelineedit within w_con_trabajos_cliente
integer x = 494
integer y = 168
integer width = 192
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type sle_mes2 from singlelineedit within w_con_trabajos_cliente
integer x = 695
integer y = 168
integer width = 192
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type sle_anyo1 from singlelineedit within w_con_trabajos_cliente
integer x = 46
integer y = 168
integer width = 192
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_con_trabajos_cliente
integer x = 475
integer y = 112
integer width = 439
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mes"
end type

type gb_5 from groupbox within w_con_trabajos_cliente
integer x = 27
integer y = 112
integer width = 439
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Año"
end type

type sle_anyo2 from singlelineedit within w_con_trabajos_cliente
integer x = 247
integer y = 168
integer width = 192
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_con_trabajos_cliente from datawindow within w_con_trabajos_cliente
integer x = 27
integer y = 296
integer width = 4361
integer height = 2120
integer taborder = 100
string title = "none"
string dataobject = "dw_con_trabajos_cliente"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

