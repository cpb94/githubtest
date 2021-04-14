$PBExportHeader$w_con_clientes.srw
forward
global type w_con_clientes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes
end type
type dw_listado4 from datawindow within w_con_clientes
end type
type dw_distribuidores from datawindow within w_con_clientes
end type
type st_2 from statictext within w_con_clientes
end type
type rb_razon from radiobutton within w_con_clientes
end type
type rb_codigo from radiobutton within w_con_clientes
end type
type rb_pais from radiobutton within w_con_clientes
end type
type cb_1 from u_boton within w_con_clientes
end type
type cb_paises from u_boton within w_con_clientes
end type
type uo_paises from u_marca_lista within w_con_clientes
end type
type pb_imprimir from upb_imprimir within w_con_clientes
end type
type gb_1 from groupbox within w_con_clientes
end type
end forward

global type w_con_clientes from w_int_con_empresa
integer width = 2962
integer height = 1696
pb_1 pb_1
dw_listado4 dw_listado4
dw_distribuidores dw_distribuidores
st_2 st_2
rb_razon rb_razon
rb_codigo rb_codigo
rb_pais rb_pais
cb_1 cb_1
cb_paises cb_paises
uo_paises uo_paises
pb_imprimir pb_imprimir
gb_1 gb_1
end type
global w_con_clientes w_con_clientes

type variables
string tipo
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);String orden,pais[]
int i,indice_pais
orden = ""
data.SetSort(orden)
uo_paises.visible=false

CHOOSE CASE tipo
CASE "R"
   orden = " razon Asc"
CASE "P"
   orden = " paises_nombre Asc"
CASE "C"
   orden = " codigo_nu Asc"
END CHOOSE

indice_pais = 1
for i=1 to uo_paises.dw_marca.rowcount()
	if uo_paises.dw_marca.getitemstring(i,"marca")="S" then
		pais[indice_pais] = uo_paises.dw_marca.getitemstring(i,"codigo")
		indice_pais ++
	end if	
next

	
data.SetSort(orden)
data.Sort()
data.retrieve(codigo_empresa,pais)
end subroutine

event open;call super::open;boolean ante_valor_empresa
istr_parametros.s_titulo_ventana="Clientes por Paises"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_distribuidores.SetRowFocusIndicator(Hand!)
dw_listado4.SetTransObject(SQLCA)
ante_valor_empresa=valor_empresa
valor_empresa=false
uo_paises.f_cargar_datos("dw_ayuda_paises","","","Pais","Descripción")
valor_empresa=ante_valor_empresa
tipo = "R"
end event

on w_con_clientes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado4=create dw_listado4
this.dw_distribuidores=create dw_distribuidores
this.st_2=create st_2
this.rb_razon=create rb_razon
this.rb_codigo=create rb_codigo
this.rb_pais=create rb_pais
this.cb_1=create cb_1
this.cb_paises=create cb_paises
this.uo_paises=create uo_paises
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado4
this.Control[iCurrent+3]=this.dw_distribuidores
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.rb_razon
this.Control[iCurrent+6]=this.rb_codigo
this.Control[iCurrent+7]=this.rb_pais
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_paises
this.Control[iCurrent+10]=this.uo_paises
this.Control[iCurrent+11]=this.pb_imprimir
this.Control[iCurrent+12]=this.gb_1
end on

on w_con_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado4)
destroy(this.dw_distribuidores)
destroy(this.st_2)
destroy(this.rb_razon)
destroy(this.rb_codigo)
destroy(this.rb_pais)
destroy(this.cb_1)
destroy(this.cb_paises)
destroy(this.uo_paises)
destroy(this.pb_imprimir)
destroy(this.gb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_distribuidores)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_distribuidores)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes
integer x = 544
integer y = 620
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes
integer y = 8
integer width = 1893
end type

type pb_1 from upb_salir within w_con_clientes
integer x = 2688
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_listado4 from datawindow within w_con_clientes
boolean visible = false
integer y = 8
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes"
boolean livescroll = true
end type

type dw_distribuidores from datawindow within w_con_clientes
event doubleclicked pbm_dwnlbuttondblclk
integer y = 400
integer width = 2857
integer height = 1040
integer taborder = 50
string dataobject = "dw_con_clientes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]="C"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clipro,lstr_param) 


end event

type st_2 from statictext within w_con_clientes
integer x = 41
integer y = 168
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Orden:"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_razon from radiobutton within w_con_clientes
integer x = 311
integer y = 168
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Razon"
boolean checked = true
end type

event clicked;tipo = "R"
end event

type rb_codigo from radiobutton within w_con_clientes
integer x = 311
integer y = 312
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Codigo"
end type

event clicked;tipo = "C"
end event

type rb_pais from radiobutton within w_con_clientes
integer x = 311
integer y = 240
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pais"
end type

event clicked;tipo = "P"
end event

type cb_1 from u_boton within w_con_clientes
integer x = 818
integer y = 176
integer height = 92
integer taborder = 10
string text = "&Paises"
end type

event clicked;if uo_paises.visible = True then
   uo_paises.visible = False
else
	uo_paises.visible = True
End if
end event

type cb_paises from u_boton within w_con_clientes
integer x = 1326
integer y = 172
integer height = 92
integer taborder = 20
string text = "&Continuar"
end type

event clicked;f_cargar(dw_distribuidores)
end event

type uo_paises from u_marca_lista within w_con_clientes
event destroy ( )
boolean visible = false
integer x = 818
integer y = 272
integer taborder = 30
boolean border = false
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

type pb_imprimir from upb_imprimir within w_con_clientes
integer x = 1737
integer y = 176
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado4)
f_imprimir_datawindow(dw_listado4)
end event

type gb_1 from groupbox within w_con_clientes
integer x = 1312
integer y = 128
integer width = 544
integer height = 144
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

