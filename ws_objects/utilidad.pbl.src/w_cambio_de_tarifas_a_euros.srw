$PBExportHeader$w_cambio_de_tarifas_a_euros.srw
forward
global type w_cambio_de_tarifas_a_euros from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cambio_de_tarifas_a_euros
end type
type st_texto from statictext within w_cambio_de_tarifas_a_euros
end type
type gb_2 from groupbox within w_cambio_de_tarifas_a_euros
end type
type uo_tarifa from u_em_campo_2 within w_cambio_de_tarifas_a_euros
end type
type st_6 from statictext within w_cambio_de_tarifas_a_euros
end type
type dw_1 from u_datawindow_consultas within w_cambio_de_tarifas_a_euros
end type
type cbx_codigobarras from checkbox within w_cambio_de_tarifas_a_euros
end type
type cb_1 from commandbutton within w_cambio_de_tarifas_a_euros
end type
end forward

global type w_cambio_de_tarifas_a_euros from w_int_con_empresa
integer width = 2011
integer height = 788
pb_1 pb_1
st_texto st_texto
gb_2 gb_2
uo_tarifa uo_tarifa
st_6 st_6
dw_1 dw_1
cbx_codigobarras cbx_codigobarras
cb_1 cb_1
end type
global w_cambio_de_tarifas_a_euros w_cambio_de_tarifas_a_euros

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
end prototypes

public subroutine f_desactivar (boolean bool);uo_tarifa.enabled   = bool




end subroutine

event ue_listar;CALL Super::ue_listar


 



end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Cambiar tarifas a euros"
This.title=istr_parametros.s_titulo_ventana
f_desactivar(TRUE)
f_activar_campo(uo_tarifa.em_campo)


end event

on w_cambio_de_tarifas_a_euros.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_texto=create st_texto
this.gb_2=create gb_2
this.uo_tarifa=create uo_tarifa
this.st_6=create st_6
this.dw_1=create dw_1
this.cbx_codigobarras=create cbx_codigobarras
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_texto
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.uo_tarifa
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cbx_codigobarras
this.Control[iCurrent+8]=this.cb_1
end on

on w_cambio_de_tarifas_a_euros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_texto)
destroy(this.gb_2)
destroy(this.uo_tarifa)
destroy(this.st_6)
destroy(this.dw_1)
destroy(this.cbx_codigobarras)
destroy(this.cb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cambio_de_tarifas_a_euros
integer x = 37
integer y = 736
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cambio_de_tarifas_a_euros
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cambio_de_tarifas_a_euros
integer x = 32
integer y = 28
integer width = 1687
integer height = 64
integer textsize = -8
end type

type pb_1 from upb_salir within w_cambio_de_tarifas_a_euros
integer x = 1545
integer y = 452
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_texto from statictext within w_cambio_de_tarifas_a_euros
boolean visible = false
integer x = 741
integer y = 388
integer width = 704
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_cambio_de_tarifas_a_euros
integer x = 1531
integer y = 400
integer width = 151
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_tarifa from u_em_campo_2 within w_cambio_de_tarifas_a_euros
event destroy ( )
integer x = 73
integer y = 264
integer width = 1678
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_tarifa

select descripcion
into :des_tarifa
from ventarifas
where empresa = :codigo_empresa
and codigo = :uo_tarifa.em_codigo.text;

uo_tarifa.em_campo.text = des_tarifa
IF Trim(uo_tarifa.em_campo.text)="" THEN 
 IF Trim(uo_tarifa.em_codigo.text)<>"" Then uo_tarifa.em_campo.SetFocus()
 uo_tarifa.em_campo.text=""
 uo_tarifa.em_codigo.text=""
 Return
END IF

end event

event getfocus;ue_titulo     = "Ayuda seleccion de tarifas"
ue_datawindow = "dw_ayuda_ventarifas"
ue_filtro     = ""


end event

type st_6 from statictext within w_cambio_de_tarifas_a_euros
integer x = 78
integer y = 184
integer width = 1682
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_cambio_de_tarifas_a_euros
boolean visible = false
integer x = 1737
integer y = 544
integer width = 530
integer height = 408
integer taborder = 30
string dataobject = "report_etiquetas_sin_ean"
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type cbx_codigobarras from checkbox within w_cambio_de_tarifas_a_euros
boolean visible = false
integer x = 439
integer y = 964
integer width = 576
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Código de barras"
boolean lefttext = true
end type

type cb_1 from commandbutton within w_cambio_de_tarifas_a_euros
integer x = 480
integer y = 448
integer width = 891
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Tarifa en Euros"
end type

event clicked;boolean hay_error

hay_error = false

update ventarifas 
set moneda = "7"
where empresa = :codigo_empresa
and codigo = :uo_tarifa.em_codigo.text;

if SQLCA.SQLCode <> 0 then
	hay_error = True
end if

update venlintarifas
set precio = round(precio / 166.386, 2)
where empresa = :codigo_empresa
and tarifa = :uo_tarifa.em_codigo.text;

if SQLCA.SQLCode <> 0 then
	hay_error = True
end if


if not hay_error then
	commit;
	messagebox ("Información","El proceso ha finalizado con éxito.")
else
	rollback;
	messagebox ("ERROR","Se ha producido un error generando actualizando la tarifa.")
end if		

end event

