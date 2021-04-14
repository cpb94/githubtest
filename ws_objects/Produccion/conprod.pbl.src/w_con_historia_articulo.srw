$PBExportHeader$w_con_historia_articulo.srw
forward
global type w_con_historia_articulo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_historia_articulo
end type
type st_1 from statictext within w_con_historia_articulo
end type
type dw_1 from datawindow within w_con_historia_articulo
end type
type dw_listado from datawindow within w_con_historia_articulo
end type
type pb_imprimir from upb_imprimir within w_con_historia_articulo
end type
type uo_1 from u_em_campo_2 within w_con_historia_articulo
end type
type cb_1 from u_boton within w_con_historia_articulo
end type
type cb_2 from commandbutton within w_con_historia_articulo
end type
type em_fdesde from u_em_campo within w_con_historia_articulo
end type
type em_fhasta from u_em_campo within w_con_historia_articulo
end type
type st_2 from statictext within w_con_historia_articulo
end type
type cbx_solo_terminadas from checkbox within w_con_historia_articulo
end type
type gb_1 from groupbox within w_con_historia_articulo
end type
type gb_2 from groupbox within w_con_historia_articulo
end type
type gb_3 from groupbox within w_con_historia_articulo
end type
type gb_4 from groupbox within w_con_historia_articulo
end type
end forward

global type w_con_historia_articulo from w_int_con_empresa
integer x = 315
integer y = 32
integer width = 4681
integer height = 3228
pb_1 pb_1
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_1 uo_1
cb_1 cb_1
cb_2 cb_2
em_fdesde em_fdesde
em_fhasta em_fhasta
st_2 st_2
cbx_solo_terminadas cbx_solo_terminadas
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_con_historia_articulo w_con_historia_articulo

type variables

end variables

on w_con_historia_articulo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_2=create st_2
this.cbx_solo_terminadas=create cbx_solo_terminadas
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.em_fdesde
this.Control[iCurrent+10]=this.em_fhasta
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.cbx_solo_terminadas
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_4
end on

on w_con_historia_articulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_2)
destroy(this.cbx_solo_terminadas)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;

istr_parametros.s_titulo_ventana =   "Consulta de la historia de un artículo"
//istr_parametros.s_listado        =   "report_formatos_articulos"
This.title                       =   istr_parametros.s_titulo_ventana


em_fdesde.text = '01-09-2006'//string(RelativeDate(today(), - 365),"dd-mm-yy")
em_fhasta.text = string(today(),"dd-mm-yy")

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;//string articulo

//if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el artículo")
//	f_activar_campo(uo_1.em_campo)
//	return
////	articulo = "%"
//else
//	articulo = uo_1.em_codigo.text
//end if
//dw_1.Retrieve(codigo_empresa,articulo)
dw_report =dw_1
Call Super::ue_listar
end event

event activate;call super::activate;w_con_historia_articulo = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_historia_articulo
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_historia_articulo
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_historia_articulo
integer width = 4608
integer height = 84
end type

type pb_1 from upb_salir within w_con_historia_articulo
integer x = 4466
integer y = 116
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_1 from statictext within w_con_historia_articulo
integer x = 55
integer y = 124
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_historia_articulo
integer x = 32
integer y = 228
integer width = 4562
integer height = 2756
boolean bringtotop = true
string dataobject = "dw_con_historia_articulo"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_listado from datawindow within w_con_historia_articulo
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_formatos_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_historia_articulo
event clicked pbm_bnclicked
integer x = 4343
integer y = 116
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


parent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type uo_1 from u_em_campo_2 within w_con_historia_articulo
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 325
integer y = 120
integer width = 1678
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_1.em_campo.text=f_nombre_articulo(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
else

end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_historia_articulo
integer x = 4018
integer y = 116
integer width = 315
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;str_escandallo escandallo[300]
datastore ds_operaciones
integer indice, k
string articulo, sel, formato, v_Articulo, v_tipooper, v_cliente, ot_terminada 
long actual, i, v_ordenoperacion
decimal factor, v_largo, v_ancho 
date v_fecha
integer nivel
decimal pzs_buenas, pzs_malas


nivel = 0
v_fecha = RelativeDate ( today(), -365 )
dw_1.setredraw(false)

dw_1.reset()

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
	f_mensaje("Consulta de Artículos","Introduzca el artículo")
	f_activar_campo(uo_1.em_campo)
	return
else
	articulo = uo_1.em_codigo.text
end if

select formatos.abreviado
into :formato
from formatos, articulos
where formatos.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and articulos.formato = formatos.codigo
and articulos.codigo = :uo_1.em_codigo.text;

dw_1.object.st_articulo.text = formato+"    "+uo_1.em_campo.text

indice = 1
factor = 1
f_escandallo_factores_con_sin_base(escandallo, articulo, indice, factor, nivel, false)

for k = 1 to indice
//	if not ftc_articulo_base(escandallo[k].articulo) then
		sel = " select art_ver_operaciones.articulo, art_ver_operaciones.orden, art_ver_operaciones.coste_mp, art_Ver_operaciones.coste_fab , "+& 
				" art_ver_operaciones.tipo_operacion as tipooper, articulos.descripcion, formatos.abreviado,  "+&
				" art_ver_tipooperacion.descripcion_abr, articulos.cliente, formatos.ancho, formatos.largo "+&
				" from art_ver_operaciones, art_ver_tipooperacion, articulos, art_versiones, formatos "+&
				" where art_ver_tipooperacion.empresa = '"+codigo_empresa+"' "+&
				" and art_ver_operaciones.empresa =  '"+codigo_empresa+"' "+&
				" and articulos.empresa =  '"+codigo_empresa+"' "+&
				" and art_ver_operaciones.empresa = formatos.empresa "+&
				" and art_ver_operaciones.formato = formatos.codigo "+&
				" and art_ver_operaciones.tipo_operacion = art_Ver_tipooperacion.codigo "+&
				" and art_ver_operaciones.articulo = '"+escandallo[k].articulo+"' "+&
				" and art_ver_operaciones.articulo = articulos.codigo "+&
				" and art_ver_operaciones.empresa = art_versiones.empresa "+&
				" and art_ver_operaciones.articulo = art_versiones.articulo "+&
				" and art_ver_operaciones.version = art_versiones.version " +&
				" and art_versiones.tipo_version = 'P' "+&
				" and articulos.uso <> '1' "+&
				" order by art_ver_operaciones.orden"
			
		f_cargar_cursor_nuevo(sel, ds_operaciones)
		
		for i = 1 to ds_operaciones.rowcount()
			v_articulo = ds_operaciones.object.art_ver_operaciones_articulo[i]
			v_ordenoperacion = long(ds_operaciones.object.art_ver_operaciones_orden[i])
			v_tipooper = ds_operaciones.object.art_ver_operaciones_tipooper[i]
			
			if cbx_solo_terminadas.checked then
				SELECT sum(prodpartes_ot.buenas) pzs_buenas, sum(prodpartes_ot.malas) pzs_malas
				INTO :pzs_buenas, :pzs_malas
				FROM prodpartes_ot
				WHERE prodpartes_ot.empresa = 1 AND 
				prodpartes_ot.fecha >= :em_fdesde.text AND  
				prodpartes_ot.fecha <= :em_fhasta.text AND  
				prodpartes_ot.articulo = :v_articulo AND
				prodpartes_ot.art_encajado = :articulo and  // añado esto para ver si así saco únicamente los partes asociados a ese encajado.
				prodpartes_ot.version = '1' and
				prodpartes_ot.ajuste <> 'S' and
				prodpartes_ot.ot_terminada = 'S' and
				prodpartes_ot.ordenoperacion = :v_ordenoperacion;	
			else
				SELECT sum(prodpartes_ot.buenas) pzs_buenas, sum(prodpartes_ot.malas) pzs_malas
				INTO :pzs_buenas, :pzs_malas
				FROM prodpartes_ot
				WHERE prodpartes_ot.empresa = 1 AND 
				prodpartes_ot.fecha >= :em_fdesde.text AND  
				prodpartes_ot.fecha <= :em_fhasta.text AND  
				prodpartes_ot.articulo = :v_articulo AND
				prodpartes_ot.art_encajado = :articulo and  // añado esto para ver si así saco únicamente los partes asociados a ese encajado.
				prodpartes_ot.version = '1' and
				prodpartes_ot.ajuste <> 'S' and
				prodpartes_ot.ordenoperacion = :v_ordenoperacion;	
			end if
	
			actual = dw_1.insertrow(0)
			dw_1.object.cod_articulo[actual] = v_articulo
			dw_1.object.des_articulo[actual] = ds_operaciones.object.articulos_descripcion[i]
			dw_1.object.formato[actual] = ds_operaciones.object.formatos_abreviado[i]
			dw_1.object.operacion[actual] = ds_operaciones.object.art_ver_tipooperacion_descripcion_abr[i]
			dw_1.object.pzs_buenas[actual] = pzs_buenas * escandallo[k].factor
			dw_1.object.pzs_malas[actual] = pzs_malas * escandallo[k].factor
			dw_1.object.m2_buenos[actual] = pzs_buenas * ds_operaciones.object.formatos_largo[i] * ds_operaciones.object.formatos_ancho[i] * escandallo[k].factor / 10000
			dw_1.object.m2_malos[actual] = pzs_malas * ds_operaciones.object.formatos_largo[i] * ds_operaciones.object.formatos_ancho[i] * escandallo[k].factor / 10000
			dw_1.object.orden[actual] = k
			if actual > 1 then
				if ( dw_1.object.pzs_buenas[actual - 1] <> 0 or isnull (dw_1.object.pzs_buenas[actual - 1])) then
					dw_1.object.porcentaje_error[actual] =  ( ( dw_1.object.total_pzs[actual] - dw_1.object.pzs_buenas[actual - 1] ) / dw_1.object.pzs_buenas[actual - 1] ) * 100
				end if
			else
				dw_1.object.porcentaje_error[actual] = 0
			end if
		
		next
		destroy ds_operaciones
	//end if
next

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if

dw_1.groupcalc()
dw_1.setredraw(true)

destroy ds_operaciones

end event

type cb_2 from commandbutton within w_con_historia_articulo
boolean visible = false
integer x = 1902
integer y = 128
integer width = 416
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coste Prueba"
end type

event clicked;dec coste_mp , coste_fab

f_calculo_coste_articulo_mp_fab (codigo_empresa, uo_1.em_codigo.text, coste_mp, coste_fab, true)

messagebox ("FIN",STRING ( coste_mp + coste_fab))
end event

type em_fdesde from u_em_campo within w_con_historia_articulo
integer x = 2286
integer y = 116
integer width = 352
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_historia_articulo
integer x = 2656
integer y = 116
integer width = 352
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_con_historia_articulo
integer x = 2048
integer y = 128
integer width = 238
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fechas:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type cbx_solo_terminadas from checkbox within w_con_historia_articulo
integer x = 3067
integer y = 128
integer width = 745
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 8388608
long backcolor = 12632256
string text = "Sólo OT~'s Terminadas"
end type

type gb_1 from groupbox within w_con_historia_articulo
integer x = 3995
integer y = 76
integer width = 599
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_2 from groupbox within w_con_historia_articulo
integer x = 37
integer y = 76
integer width = 1989
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_con_historia_articulo
integer x = 37
integer y = 76
integer width = 1989
integer height = 144
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_4 from groupbox within w_con_historia_articulo
integer x = 2034
integer y = 76
integer width = 1792
integer height = 144
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 8388608
long backcolor = 12632256
end type

