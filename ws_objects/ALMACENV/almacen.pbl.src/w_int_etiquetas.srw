$PBExportHeader$w_int_etiquetas.srw
$PBExportComments$Etiquetas Normales
forward
global type w_int_etiquetas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas
end type
type st_texto from statictext within w_int_etiquetas
end type
type gb_2 from groupbox within w_int_etiquetas
end type
type gb_1 from groupbox within w_int_etiquetas
end type
type uo_cliente from u_em_campo_2 within w_int_etiquetas
end type
type st_6 from statictext within w_int_etiquetas
end type
type st_666 from statictext within w_int_etiquetas
end type
type uo_articulo from u_em_campo_2 within w_int_etiquetas
end type
type uo_texto1 from u_em_campo_2 within w_int_etiquetas
end type
type st_66 from statictext within w_int_etiquetas
end type
type dw_1 from u_datawindow_consultas within w_int_etiquetas
end type
type cbx_codigobarras from checkbox within w_int_etiquetas
end type
type sle_tc from singlelineedit within w_int_etiquetas
end type
type st_1 from statictext within w_int_etiquetas
end type
type cbx_made from checkbox within w_int_etiquetas
end type
type dw_informe from datawindow within w_int_etiquetas
end type
end forward

global type w_int_etiquetas from w_int_con_empresa
integer width = 2062
integer height = 1264
pb_1 pb_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
st_texto st_texto
gb_2 gb_2
gb_1 gb_1
uo_cliente uo_cliente
st_6 st_6
st_666 st_666
uo_articulo uo_articulo
uo_texto1 uo_texto1
st_66 st_66
dw_1 dw_1
cbx_codigobarras cbx_codigobarras
sle_tc sle_tc
st_1 st_1
cbx_made cbx_made
dw_informe dw_informe
end type
global w_int_etiquetas w_int_etiquetas

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
end prototypes

public subroutine f_desactivar (boolean bool);uo_cliente.enabled   = bool
uo_articulo.enabled  = bool



end subroutine

event ue_listar;CALL Super::ue_listar


 



end event

event open;call super::open;istr_parametros.s_titulo_ventana="Listado Etiquetas Normales"
This.title=istr_parametros.s_titulo_ventana
f_desactivar(TRUE)
f_activar_campo(uo_cliente.em_campo)


end event

on w_int_etiquetas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.st_texto=create st_texto
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.st_6=create st_6
this.st_666=create st_666
this.uo_articulo=create uo_articulo
this.uo_texto1=create uo_texto1
this.st_66=create st_66
this.dw_1=create dw_1
this.cbx_codigobarras=create cbx_codigobarras
this.sle_tc=create sle_tc
this.st_1=create st_1
this.cbx_made=create cbx_made
this.dw_informe=create dw_informe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir_etiquetas
this.Control[iCurrent+3]=this.st_texto
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.st_666
this.Control[iCurrent+9]=this.uo_articulo
this.Control[iCurrent+10]=this.uo_texto1
this.Control[iCurrent+11]=this.st_66
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.cbx_codigobarras
this.Control[iCurrent+14]=this.sle_tc
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.cbx_made
this.Control[iCurrent+17]=this.dw_informe
end on

on w_int_etiquetas.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.st_texto)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.st_6)
destroy(this.st_666)
destroy(this.uo_articulo)
destroy(this.uo_texto1)
destroy(this.st_66)
destroy(this.dw_1)
destroy(this.cbx_codigobarras)
destroy(this.sle_tc)
destroy(this.st_1)
destroy(this.cbx_made)
destroy(this.dw_informe)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas
integer x = 37
integer y = 736
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas
integer x = 32
integer y = 28
integer width = 1687
integer height = 84
integer textsize = -12
end type

type pb_1 from upb_salir within w_int_etiquetas
integer x = 1778
integer y = 56
integer width = 128
integer height = 108
integer taborder = 0
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas
integer x = 1783
integer y = 240
integer width = 119
integer height = 100
integer taborder = 70
boolean originalsize = false
end type

event clicked;string articulo, v_ean13, ce, cliente
string impresora_predeterminada, impresora


dw_informe.SetTransObject(SQLCA)
impresora_predeterminada = f_impresora_predeterminada()

// Etiquetas para el marcado CE
articulo = uo_articulo.em_codigo.text

select ean13, etiqueta_ce, cliente
into :v_ean13, :ce, :cliente
from articulos
where empresa = :codigo_empresa
and codigo = :articulo;

impresora = ''
if not isnull(ce) and ce <> '' then
	if messagebox ("Atención", "El artículo lleva maracado CE. ¿Desea imprimir etiquetas del marcado CE?", Question!, YesNo!) = 1 then
		SELECT impresora_etiquetas2
		INTO   :impresora
		FROM   empresas
		WHERE  empresa = :codigo_empresa;

		if f_cambia_impresora_predeterminada (impresora) then
			dw_informe.Retrieve(codigo_empresa, cliente, ce )
			f_imprimir_datawindow(dw_informe)
		END IF
	end if
end if


impresora = ''
SELECT impresora_etiquetas
INTO   :impresora
FROM   empresas
WHERE  empresa = :codigo_empresa;

if f_cambia_impresora_predeterminada (impresora) then

	articulo = uo_articulo.em_codigo.text
	
	v_ean13 = ""
	select ean13, etiqueta_ce, cliente
	into :v_ean13, :ce, :cliente
	from articulos
	where empresa = :codigo_empresa
	and codigo = :articulo;
	
// Etiquetas para el marcado CE
	if v_ean13 <> ""then
		dw_1.DataObject = 'report_etiquetas_con_ean'	
		if cbx_made.checked then
			dw_1.object.made.text = "MADE IN SPAIN"
		else
			dw_1.object.made.text = ""
		end if
	else
		dw_1.DataObject = 'report_etiquetas_sin_ean'	
	end if
	
	dw_1.SetTransObject(SQLCA)
	dw_1.retrieve(codigo_empresa,articulo)
	
	if sle_tc.text <> "" and not isnull(sle_tc.text) then
		if v_ean13 <> "" then
			dw_1.object.tono[1] = sle_tc.text
		else
			dw_1.object.tono[1] = " T/C: "+sle_tc.text
		end if
	else
		dw_1.object.tono[1] = ""
	end if 
	
	f_imprimir_datawindow(dw_1)
else	
	messagebox ("ERROR", "No se pudo definir la impresora de etiquetas")
end if


if not f_cambia_impresora_predeterminada (impresora_predeterminada) then
	messagebox ("ERROR", "No se pudo restablecer la impresora predeterminada")
end if
	

	




end event

type st_texto from statictext within w_int_etiquetas
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

type gb_2 from groupbox within w_int_etiquetas
integer x = 1765
integer y = 12
integer width = 151
integer height = 160
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

type gb_1 from groupbox within w_int_etiquetas
integer x = 1765
integer y = 192
integer width = 151
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_cliente from u_em_campo_2 within w_int_etiquetas
event destroy ( )
integer x = 37
integer y = 236
integer width = 1678
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
 Return
END IF

end event

event getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""


end event

type st_6 from statictext within w_int_etiquetas
integer x = 37
integer y = 160
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

type st_666 from statictext within w_int_etiquetas
integer x = 37
integer y = 348
integer width = 1678
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_int_etiquetas
event destroy ( )
integer x = 41
integer y = 432
integer width = 1673
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_descripcion_almcliartdesc(codigo_empresa,uo_cliente.em_codigo.text,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
   uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
END IF

uo_texto1.em_campo.text   = uo_articulo.em_campo.text
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 Return
END IF

end event

event getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""


end event

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type uo_texto1 from u_em_campo_2 within w_int_etiquetas
event destroy ( )
integer x = 37
integer y = 624
integer width = 1678
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_texto1.destroy
call u_em_campo_2::destroy
end on

type st_66 from statictext within w_int_etiquetas
integer x = 37
integer y = 540
integer width = 1678
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Otra Descripción del Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_int_etiquetas
boolean visible = false
integer x = 1737
integer y = 544
integer width = 530
integer height = 408
integer taborder = 20
string dataobject = "report_etiquetas_sin_ean"
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type cbx_codigobarras from checkbox within w_int_etiquetas
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

type sle_tc from singlelineedit within w_int_etiquetas
integer x = 549
integer y = 760
integer width = 567
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_int_etiquetas
integer x = 50
integer y = 772
integer width = 480
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Tono / Calibre:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_made from checkbox within w_int_etiquetas
integer x = 1225
integer y = 776
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "MADE IN SPAIN"
boolean lefttext = true
end type

type dw_informe from datawindow within w_int_etiquetas
boolean visible = false
integer x = 1248
integer y = 712
integer width = 320
integer height = 248
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_impresion_etiqueta_ce"
boolean border = false
boolean livescroll = true
end type

