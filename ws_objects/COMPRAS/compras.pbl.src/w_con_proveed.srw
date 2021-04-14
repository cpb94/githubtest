$PBExportHeader$w_con_proveed.srw
forward
global type w_con_proveed from w_int_con_empresa
end type
type gb_1 from groupbox within w_con_proveed
end type
type pb_1 from upb_salir within w_con_proveed
end type
type st_fpedido1 from statictext within w_con_proveed
end type
type st_fpedido2 from statictext within w_con_proveed
end type
type cb_1 from commandbutton within w_con_proveed
end type
type dw_fechas from datawindow within w_con_proveed
end type
type em_desde from u_em_campo within w_con_proveed
end type
type em_hasta from u_em_campo within w_con_proveed
end type
type pb_4 from upb_imprimir within w_con_proveed
end type
end forward

global type w_con_proveed from w_int_con_empresa
integer x = 27
integer y = 4
integer width = 3762
integer height = 3168
gb_1 gb_1
pb_1 pb_1
st_fpedido1 st_fpedido1
st_fpedido2 st_fpedido2
cb_1 cb_1
dw_fechas dw_fechas
em_desde em_desde
em_hasta em_hasta
pb_4 pb_4
end type
global w_con_proveed w_con_proveed

type variables
string filtro

int ins_orden
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Proveedores"
This.title=istr_parametros.s_titulo_ventana


dw_fechas.SetTransObject(SQLCA)


ins_orden	=	2

long min,max
select min(convert(int,genter.codigo)) into :min
from genter
where (genter.tipoter='P') and (genter.empresa =:codigo_empresa);
select max(convert(int,genter.codigo)) into :max
from genter
where (genter.tipoter ='P') and (genter.empresa =:codigo_empresa);
em_desde.text = string(min)
em_hasta.text = string(max)


end event

on w_con_proveed.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_1=create pb_1
this.st_fpedido1=create st_fpedido1
this.st_fpedido2=create st_fpedido2
this.cb_1=create cb_1
this.dw_fechas=create dw_fechas
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.pb_4=create pb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_fpedido1
this.Control[iCurrent+4]=this.st_fpedido2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_fechas
this.Control[iCurrent+7]=this.em_desde
this.Control[iCurrent+8]=this.em_hasta
this.Control[iCurrent+9]=this.pb_4
end on

on w_con_proveed.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.st_fpedido1)
destroy(this.st_fpedido2)
destroy(this.cb_1)
destroy(this.dw_fechas)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.pb_4)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_fechas)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_fechas)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proveed
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proveed
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_proveed
integer x = 73
integer width = 3415
end type

type gb_1 from groupbox within w_con_proveed
integer x = 41
integer y = 88
integer width = 1015
integer height = 164
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
end type

type pb_1 from upb_salir within w_con_proveed
integer x = 3520
integer width = 123
integer height = 116
integer taborder = 0
end type

type st_fpedido1 from statictext within w_con_proveed
integer x = 55
integer y = 152
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_fpedido2 from statictext within w_con_proveed
integer x = 567
integer y = 152
integer width = 197
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_proveed
integer x = 3104
integer y = 160
integer width = 379
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Continuar"
end type

event clicked;dw_fechas.Retrieve(codigo_empresa,trim(em_desde.text),trim(em_hasta.text))
//dw_fechas.Retrieve(codigo_empresa)

end event

type dw_fechas from datawindow within w_con_proveed
integer x = 23
integer y = 284
integer width = 3621
integer height = 2644
string dataobject = "dw_con_proveed"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)

CASE "codigo_t"
	dw_fechas.setsort("codigo_int")
	dw_fechas.sort()
	// para ordenar también el listado
	ins_orden	=	1
	
case "razon_t"
	dw_fechas.setsort("razon")
	dw_fechas.sort()
	ins_orden	=	2
end choose
end event

type em_desde from u_em_campo within w_con_proveed
integer x = 279
integer y = 152
integer width = 270
integer taborder = 10
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

event modificado;call super::modificado;//st_proveedor.text = f_nombre_proveedor(codigo_empresa,This.text)
//iF Trim(st_proveedor.text) = "" Then
//	IF Trim(em_proveedor.text)<>"" Then
//	f_activar_campo(em_proveedor)
//END IF
//em_proveedor.text = ""
//END iF

em_hasta.text = em_desde.text

end event

type em_hasta from u_em_campo within w_con_proveed
integer x = 768
integer y = 152
integer width = 270
integer taborder = 20
boolean bringtotop = true
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

event modificado;call super::modificado;//st_proveedor.text = f_nombre_proveedor(codigo_empresa,This.text)
//iF Trim(st_proveedor.text) = "" Then
//	IF Trim(em_proveedor.text)<>"" Then
//	f_activar_campo(em_proveedor)
//END IF
//em_proveedor.text = ""
//END iF

end event

type pb_4 from upb_imprimir within w_con_proveed
integer x = 3515
integer y = 160
integer taborder = 60
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_fechas)

/*
integer i
string impresora, impresora_predeterminada


string articulo, v_ean13

impresora_predeterminada = f_impresora_predeterminada()

SELECT impresora_etiquetas
INTO   :impresora
FROM   empresas
WHERE  empresa = :codigo_empresa;

if f_cambia_impresora_predeterminada (impresora) then
	for i = 1 to dw_fechas.rowcount() 
		dw_etiquetas.retrieve(codigo_empresa,trim(dw_fechas.object.codigo[i]),trim(dw_fechas.object.codigo[i]))
				dw_etiquetas.Print(TRUE)
	next 
	if not f_cambia_impresora_predeterminada (impresora_predeterminada) then
		messagebox ("ERROR", "No se pudo restablecer la impresora predeterminada.")

	end if
		

else
	messagebox ("ERROR", "No se pudo restablecer la impresora de etiquetas.")
end if



*/
end event

