$PBExportHeader$w_int_eti_porcelanite_pb.srw
$PBExportComments$Etiquetas Normales
forward
global type w_int_eti_porcelanite_pb from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_eti_porcelanite_pb
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_eti_porcelanite_pb
end type
type st_texto from statictext within w_int_eti_porcelanite_pb
end type
type gb_2 from groupbox within w_int_eti_porcelanite_pb
end type
type gb_1 from groupbox within w_int_eti_porcelanite_pb
end type
type st_666 from statictext within w_int_eti_porcelanite_pb
end type
type uo_articulo from u_em_campo_2 within w_int_eti_porcelanite_pb
end type
type uo_texto1 from u_em_campo_2 within w_int_eti_porcelanite_pb
end type
type st_66 from statictext within w_int_eti_porcelanite_pb
end type
type dw_1 from u_datawindow_consultas within w_int_eti_porcelanite_pb
end type
type sle_tc from singlelineedit within w_int_eti_porcelanite_pb
end type
type st_1 from statictext within w_int_eti_porcelanite_pb
end type
type sle_texto_cliente from singlelineedit within w_int_eti_porcelanite_pb
end type
type st_3 from statictext within w_int_eti_porcelanite_pb
end type
type mle_observaciones from multilineedit within w_int_eti_porcelanite_pb
end type
type dw_informe from datawindow within w_int_eti_porcelanite_pb
end type
type cb_1 from commandbutton within w_int_eti_porcelanite_pb
end type
type st_2 from statictext within w_int_eti_porcelanite_pb
end type
type sle_conjuntos from singlelineedit within w_int_eti_porcelanite_pb
end type
end forward

global type w_int_eti_porcelanite_pb from w_int_con_empresa
integer width = 1952
integer height = 1436
string title = "Etiquetas Porcelanite en Árabe (Pasta Blanca y Pasta Roja)"
pb_1 pb_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
st_texto st_texto
gb_2 gb_2
gb_1 gb_1
st_666 st_666
uo_articulo uo_articulo
uo_texto1 uo_texto1
st_66 st_66
dw_1 dw_1
sle_tc sle_tc
st_1 st_1
sle_texto_cliente sle_texto_cliente
st_3 st_3
mle_observaciones mle_observaciones
dw_informe dw_informe
cb_1 cb_1
st_2 st_2
sle_conjuntos sle_conjuntos
end type
global w_int_eti_porcelanite_pb w_int_eti_porcelanite_pb

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
end prototypes

public subroutine f_desactivar (boolean bool);uo_articulo.enabled  = bool



end subroutine

event ue_listar;CALL Super::ue_listar


 



end event

event open;call super::open;istr_parametros.s_titulo_ventana="Etiquetas Porcelanite en Árabe (Pasta Blanca y Pasta Roja)"
This.title=istr_parametros.s_titulo_ventana
f_desactivar(TRUE)
f_activar_campo(uo_articulo.em_campo)

dw_informe.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)



end event

on w_int_eti_porcelanite_pb.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.st_texto=create st_texto
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_666=create st_666
this.uo_articulo=create uo_articulo
this.uo_texto1=create uo_texto1
this.st_66=create st_66
this.dw_1=create dw_1
this.sle_tc=create sle_tc
this.st_1=create st_1
this.sle_texto_cliente=create sle_texto_cliente
this.st_3=create st_3
this.mle_observaciones=create mle_observaciones
this.dw_informe=create dw_informe
this.cb_1=create cb_1
this.st_2=create st_2
this.sle_conjuntos=create sle_conjuntos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir_etiquetas
this.Control[iCurrent+3]=this.st_texto
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.st_666
this.Control[iCurrent+7]=this.uo_articulo
this.Control[iCurrent+8]=this.uo_texto1
this.Control[iCurrent+9]=this.st_66
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.sle_tc
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.sle_texto_cliente
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.mle_observaciones
this.Control[iCurrent+16]=this.dw_informe
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.sle_conjuntos
end on

on w_int_eti_porcelanite_pb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.st_texto)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_666)
destroy(this.uo_articulo)
destroy(this.uo_texto1)
destroy(this.st_66)
destroy(this.dw_1)
destroy(this.sle_tc)
destroy(this.st_1)
destroy(this.sle_texto_cliente)
destroy(this.st_3)
destroy(this.mle_observaciones)
destroy(this.dw_informe)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.sle_conjuntos)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_eti_porcelanite_pb
integer x = 27
integer y = 1216
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_eti_porcelanite_pb
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_eti_porcelanite_pb
integer x = 32
integer y = 28
integer width = 1687
integer height = 84
integer textsize = -12
end type

type pb_1 from upb_salir within w_int_eti_porcelanite_pb
integer x = 1778
integer y = 44
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_eti_porcelanite_pb
integer x = 1783
integer y = 204
integer taborder = 70
end type

event clicked;string articulo, v_ean13, ce, cliente
string impresora_predeterminada, impresora

////////////////////////////////////////////////////////////////////////////////////////////////
// 								Etiquetas para el marcado CE
////////////////////////////////////////////////////////////////////////////////////////////////

//if rb_laser.checked then
//	dw_informe.dataobject = "dw_impresion_etiqueta_ce"
//end if
//if rb_etiquetadora.checked then
//	dw_informe.dataobject = "dw_impresion_etiqueta_ce_termica"
//end if

	
articulo = uo_articulo.em_codigo.text
impresora_predeterminada = f_impresora_predeterminada()
 

select ean13, etiqueta_ce, cliente
into :v_ean13, :ce, :cliente
from articulos
where empresa = :codigo_empresa
and codigo = :articulo;

impresora = ''

SELECT impresora_etiquetas2
INTO   :impresora
FROM   empresas
WHERE  empresa = :codigo_empresa;

if not f_cambia_impresora_predeterminada (impresora) then
	messagebox ("ERROR", "No se pudo definir la impresora de etiquetas")
	return
end if

if not isnull(ce) and ce <> '' then
	if messagebox ("Atención", "El artículo lleva maracado CE. ¿Desea imprimir etiquetas del marcado CE?", Question!, YesNo!) = 1 then
		dw_informe.Retrieve(codigo_empresa, cliente, ce )
		f_imprimir_datawindow(dw_informe)
	end if
end if


////////////////////////////////////////////////////////////////////////////////////////////////
// 								Fin Etiquetas para el marcado CE
////////////////////////////////////////////////////////////////////////////////////////////////


articulo = uo_articulo.em_codigo.text

dw_1.retrieve(codigo_empresa,articulo)	

v_ean13 = ""
select ean13
into :v_ean13
from articulos
where empresa = :codigo_empresa
and codigo = :articulo;
if isnull(v_ean13) then v_ean13 = ""

/*
if v_ean13 = "" then
	dw_1.Modify("almartcajas_piezascaja.X=4000")
	dw_1.Modify("t_pzs.X=5000")
	dw_1.Modify("tono.X=2500")
	dw_1.Modify("articulos_cod_cliente.X=4000")
else
	dw_1.Modify("almartcajas_piezascaja.X=3000")
	dw_1.Modify("t_pzs.X=4048")
	dw_1.Modify("tono.X=1508")
	dw_1.Modify("articulos_cod_cliente.X=3000")
end if
*/
dw_1.object.made.text = sle_texto_cliente.text

dw_1.retrieve(codigo_empresa,articulo)

if sle_tc.text <> "" and not isnull(sle_tc.text) then
	dw_1.object.tono[1] = sle_tc.text
else
	dw_1.object.tono[1] = ""
end if 

if sle_conjuntos.text <> "" and not isnull(sle_conjuntos.text) then
	dw_1.object.almartcajas_piezascaja[1] = Dec(sle_conjuntos.text)
	dw_1.object.t_pzs.text = "Conjuntos"
else
	dw_1.object.t_pzs.text = "Pzs."
end if 	


f_imprimir_datawindow(dw_1)

if not f_cambia_impresora_predeterminada (impresora_predeterminada) then
	messagebox ("ERROR", "No se pudo restablecer la impresora predeterminada")
end if
	





end event

type st_texto from statictext within w_int_eti_porcelanite_pb
boolean visible = false
integer x = 1088
integer y = 1092
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

type gb_2 from groupbox within w_int_eti_porcelanite_pb
integer x = 1765
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
long backcolor = 12632256
end type

type gb_1 from groupbox within w_int_eti_porcelanite_pb
integer x = 1765
integer y = 156
integer width = 151
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_666 from statictext within w_int_eti_porcelanite_pb
integer x = 37
integer y = 136
integer width = 1678
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_int_eti_porcelanite_pb
event destroy ( )
integer x = 41
integer y = 220
integer width = 1673
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;string v_texto_etiqueta, v_cliente, v_obs_etiqueta
uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)


//////////////////////////////////////////////////////////////////////////////////////
/////////////////				Extraemos el texto de la etiqueta    	////////////////////
//////////////////////////////////////////////////////////////////////////////////////

select cliente 
into :v_clientE 
from articulos
where empresa = :codigo_empresa
and codigo = :uo_articulo.em_codigo.text;
	
select texto_etiqueta, obs_etiqueta
into :v_texto_etiqueta, :v_obs_etiqueta
from venclientes
where empresa = :codigo_empresa
and codigo = :v_cliente;
	
sle_texto_cliente.text = v_texto_etiqueta
if v_obs_etiqueta <> '' then
	mle_observaciones.visible = true
	mle_observaciones.text = v_obs_etiqueta
else
	mle_observaciones.visible = false
	mle_observaciones.text = ''
end if
	

//////////////////////////////////////////////////////////////////////////////////////
/////////////////			Fin de extraer el texto de la etiqueta    	/////////////////
//////////////////////////////////////////////////////////////////////////////////////
	
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

type uo_texto1 from u_em_campo_2 within w_int_eti_porcelanite_pb
event destroy ( )
integer x = 37
integer y = 412
integer width = 1678
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_texto1.destroy
call u_em_campo_2::destroy
end on

type st_66 from statictext within w_int_eti_porcelanite_pb
integer x = 37
integer y = 328
integer width = 1678
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Otra Descripción del Artículo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_int_eti_porcelanite_pb
boolean visible = false
integer x = 1728
integer y = 352
integer width = 530
integer height = 408
integer taborder = 30
string dataobject = "report_eti_porcelanite_pb2"
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event retrieveend;call super::retrieveend;if dw_1.rowcount() > 0 then
	//dw_1.object.t_descripcion.text = uo_texto1.em_campo.text+" / "+dw_1.object.formatos_abreviado[1] 
	dw_1.object.t_descripcion.text = uo_texto1.em_campo.text
end if
end event

type sle_tc from singlelineedit within w_int_eti_porcelanite_pb
integer x = 462
integer y = 552
integer width = 475
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_int_eti_porcelanite_pb
integer x = 32
integer y = 556
integer width = 421
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tono / Calibre:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_texto_cliente from singlelineedit within w_int_eti_porcelanite_pb
integer x = 462
integer y = 628
integer width = 1253
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_int_eti_porcelanite_pb
integer x = 32
integer y = 628
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Texto Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type mle_observaciones from multilineedit within w_int_eti_porcelanite_pb
boolean visible = false
integer x = 18
integer y = 760
integer width = 1888
integer height = 496
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33481950
end type

type dw_informe from datawindow within w_int_eti_porcelanite_pb
boolean visible = false
integer x = 1042
integer y = 892
integer width = 320
integer height = 248
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_impresion_etiqueta_ce_termica"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within w_int_eti_porcelanite_pb
integer x = 46
integer y = 1304
integer width = 1074
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Impresora Predeterminada."
end type

event clicked;string impresora_predeterminada 

impresora_predeterminada = f_impresora_predeterminada()

messagebox("",impresora_predeterminada )
end event

type st_2 from statictext within w_int_eti_porcelanite_pb
integer x = 937
integer y = 552
integer width = 315
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Conjuntos:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_conjuntos from singlelineedit within w_int_eti_porcelanite_pb
integer x = 1239
integer y = 552
integer width = 475
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

