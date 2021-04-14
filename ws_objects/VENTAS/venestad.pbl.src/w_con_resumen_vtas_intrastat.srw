$PBExportHeader$w_con_resumen_vtas_intrastat.srw
forward
global type w_con_resumen_vtas_intrastat from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_vtas_intrastat
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_intrastat
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_intrastat
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_intrastat
end type
type dw_listado from datawindow within w_con_resumen_vtas_intrastat
end type
type cb_1 from commandbutton within w_con_resumen_vtas_intrastat
end type
type gb_3 from groupbox within w_con_resumen_vtas_intrastat
end type
type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_intrastat
end type
type dw_detalle from datawindow within w_con_resumen_vtas_intrastat
end type
type ddlb_1 from dropdownlistbox within w_con_resumen_vtas_intrastat
end type
type cbx_totalizar_por_pais from checkbox within w_con_resumen_vtas_intrastat
end type
type cbx_metros from checkbox within w_con_resumen_vtas_intrastat
end type
type uo_partidas from u_marca_lista within w_con_resumen_vtas_intrastat
end type
type cb_partidas from commandbutton within w_con_resumen_vtas_intrastat
end type
type gb_1 from groupbox within w_con_resumen_vtas_intrastat
end type
type gb_2 from groupbox within w_con_resumen_vtas_intrastat
end type
end forward

shared variables
boolean detalle=true
end variables

global type w_con_resumen_vtas_intrastat from w_int_con_empresa
integer width = 3643
integer height = 2096
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
gb_3 gb_3
uo_manejo uo_manejo
dw_detalle dw_detalle
ddlb_1 ddlb_1
cbx_totalizar_por_pais cbx_totalizar_por_pais
cbx_metros cbx_metros
uo_partidas uo_partidas
cb_partidas cb_partidas
gb_1 gb_1
gb_2 gb_2
end type
global w_con_resumen_vtas_intrastat w_con_resumen_vtas_intrastat

type variables
string filtro,grafico = "N"
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);DateTime f1,f2
string serie,t1,t2,ls_partida_estadistica,ls_partida,ls_filtro_partidas
integer li_metros
long anyo,factura,indice,total,ll_indice

if cbx_totalizar_por_pais.checked then
	data.dataobject = 'dw_con_resumen_vtas_intrastat_2015_agrupado'
else
	data.dataobject = 'dw_con_resumen_vtas_intrastat_2015'
end if

data.settransobject(sqlca)

if em_fechadesde.text <> "00-00-00" then
	if em_fechahasta.text <> "00-00-00" then
		f1 = DateTime(Date(em_fechadesde.text))
		f2 = DateTime(Date(em_fechahasta.text))
		if f1 > f2 then
			messagebox("Atención","La fecha fin debe ser mayor que la de inicio")
			em_fechahasta.setfocus()
		else			
//			if em_serie.text <> "" then
				serie = '%'//em_serie.text
				
				IF ddlb_1.text='Nacional' Then
					t1 = "N"
					t2 = "N"
					serie = '1'
				end if
				IF ddlb_1.text='Exportación' Then
					t1 = "E"
					t2 = "E"
					serie ='2'
				end if
				IF ddlb_1.text='Intracomunitario' Then
					t1 = "C"
					t2 = "C"
					
				end if
				
	if cbx_metros.checked then
		 
		 li_metros = 1
	else 
		li_metros = 0
		
	end if
								
				data.setredraw(false)
				data.setfilter('')
				data.retrieve(codigo_empresa,f1,f2,t1,t2, li_metros)
				total = data.rowcount()
				
				if total > 0 then
					for indice = 1 to total
						anyo                   = data.object.anyo[indice]
						factura                = data.object.factura[indice]
						ls_partida_estadistica = data.object.partida_estadistica[indice]
						
						data.object.venfac_metros_factura[indice] = f_metros_factura(codigo_empresa,anyo,factura)
						data.object.metros_partida_estadistica[indice] = f_metros_factura_partida_estadistica(codigo_empresa,anyo,factura,ls_partida_estadistica)
						
						if f_factura_con_lineas_concepto(codigo_empresa,anyo,factura) then
							data.object.venfac_linea_concepto[indice] = "*"
						else
							data.object.venfac_linea_concepto[indice] = ""
						end if
					next

				end if
				
				for ll_indice = 1 to uo_partidas.dw_marca.rowcount()
					if uo_partidas.dw_marca.getitemstring(ll_indice,"marca")="S" then
						ls_partida = uo_partidas.dw_marca.getitemstring(ll_indice,"texto")
						if ls_filtro_partidas = "" then
							ls_filtro_partidas = "'"+ls_partida+"'"
						else
							ls_filtro_partidas += ",'"+ls_partida+"'"
						end if

					end if
				next
				if trim(ls_filtro_partidas) <> "" then
					ls_filtro_partidas = "partida_estadistica in("+ls_filtro_partidas+")"
					data.setfilter(ls_filtro_partidas)
					data.filter()
				end if
				data.sort()
				data.groupcalc()
				data.setredraw(true)				
//			else
//				messagebox("Atención","Introduzca la serie")
//				em_serie.setfocus()			
//			end if
		end if
	else	
		messagebox("Atención","Introduzca la fecha fin")
		em_fechahasta.setfocus()
	end if	
else	
	messagebox("Atención","Introduzca la fecha origen")
	em_fechadesde.setfocus()
end if

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen Ventas: facturas por cliente(INTRASTAT)"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"total",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts1",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts2",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts3",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"tot_pts4",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"total",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"porcentaje",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"total_pts",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts1",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts2",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts3",f_mascara_decimales(0))
f_mascara_columna(dw_listado,"tot_pts4",f_mascara_decimales(0))
f_activar_campo(em_fechadesde)

uo_partidas.f_cargar_datos("dw_ayuda_venpartidas","%","","Codigo","Descripción")

uo_partidas.dw_marca.InsertRow(1)
uo_partidas.dw_marca.object.marca[1]  = 'S'
uo_partidas.dw_marca.object.codigo[1] = ''
uo_partidas.dw_marca.object.texto[1]  = 'SIN PARTIDA'

//ddlb_1.text='Nacional'



end event

on w_con_resumen_vtas_intrastat.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.gb_3=create gb_3
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
this.ddlb_1=create ddlb_1
this.cbx_totalizar_por_pais=create cbx_totalizar_por_pais
this.cbx_metros=create cbx_metros
this.uo_partidas=create uo_partidas
this.cb_partidas=create cb_partidas
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.uo_manejo
this.Control[iCurrent+9]=this.dw_detalle
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.cbx_totalizar_por_pais
this.Control[iCurrent+12]=this.cbx_metros
this.Control[iCurrent+13]=this.uo_partidas
this.Control[iCurrent+14]=this.cb_partidas
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_2
end on

on w_con_resumen_vtas_intrastat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
destroy(this.ddlb_1)
destroy(this.cbx_totalizar_por_pais)
destroy(this.cbx_metros)
destroy(this.uo_partidas)
destroy(this.cb_partidas)
destroy(this.gb_1)
destroy(this.gb_2)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_intrastat
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_intrastat
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_intrastat
integer x = 9
integer y = 8
integer width = 2359
integer height = 108
end type

type pb_1 from upb_salir within w_con_resumen_vtas_intrastat
integer x = 3511
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_intrastat
integer x = 3502
integer y = 192
integer taborder = 60
end type

event clicked;call super::clicked;//f_control(dw_listado)
//if cbx_resumen.checked then
//	
//	dw_listado.modify("datawindow.detail.height=80")
//	detalle = TRUE
//else
//	
//	dw_listado.modify("datawindow.detail.height=0")
//	detalle = FALSE
//end if
//
//f_imprimir_datawindow(dw_listado)
//
//
u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = "Desde '"+em_fechadesde.text +"' Hasta '"+em_fechahasta.text+"'"
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_detalle)

destroy u_imp
end event

type em_fechadesde from u_em_campo within w_con_resumen_vtas_intrastat
integer x = 9
integer y = 176
integer width = 302
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_resumen_vtas_intrastat
integer x = 311
integer y = 176
integer width = 283
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_resumen_vtas_intrastat
boolean visible = false
integer x = 3406
integer y = 12
integer width = 105
integer height = 96
string dataobject = "report_con_resumen_vtas_intrastat"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_resumen_vtas_intrastat
integer x = 2633
integer y = 192
integer width = 389
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_control(dw_detalle)
//if cbx_resumen.checked then
//	dw_detalle.modify("datawindow.detail.height=80")	
//	
//	detalle = TRUE
//else
//	dw_detalle.modify("datawindow.detail.height=0")
//	
//	detalle = FALSE
//end if
//

end event

type gb_3 from groupbox within w_con_resumen_vtas_intrastat
integer x = 2610
integer y = 148
integer width = 434
integer height = 144
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_intrastat
integer x = 3031
integer y = 144
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_con_resumen_vtas_intrastat
integer x = 5
integer y = 296
integer width = 3625
integer height = 1640
string dataobject = "dw_con_resumen_vtas_intrastat_2015_agrupado"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//this.Object.elgrafico.visible = 0
//grafico = "N"
end event

event clicked;//IF f_objeto_datawindow(This)= "grafico" Then
//	IF grafico = "N" Then
//		grafico = "S"
//		this.Object.elgrafico.x = 0
//		this.Object.elgrafico.y = 0
//		this.Object.elgrafico.height = 1100
//		this.Object.elgrafico.width = 3031
//		this.Object.elgrafico.visible = 1
//	ELSE
//		grafico = "N"
//		this.Object.elgrafico.visible = 0
//	END IF
//
//END IF
end event

event sqlpreview;//messagebox("SQL", sqlsyntax)
end event

type ddlb_1 from dropdownlistbox within w_con_resumen_vtas_intrastat
integer x = 667
integer y = 172
integer width = 512
integer height = 400
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Intracomunitario"
string item[] = {"Nacional","Exportación","Intracomunitario"}
borderstyle borderstyle = stylelowered!
end type

type cbx_totalizar_por_pais from checkbox within w_con_resumen_vtas_intrastat
integer x = 1929
integer y = 196
integer width = 613
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Totalizar partida por pais"
boolean checked = true
end type

event clicked;
//if this.checked then
//	dw_detalle.modify("datawindow.header.3.height=80")	
//	dw_detalle.modify("datawindow.detail.height=80")	
//	detalle = TRUE
//else
//	dw_detalle.modify("datawindow.header.3.height=0")
//	dw_detalle.modify("datawindow.detail.height=0")
//	detalle = FALSE
//end if

end event

type cbx_metros from checkbox within w_con_resumen_vtas_intrastat
boolean visible = false
integer x = 1925
integer y = 112
integer width = 357
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Metros/Peso"
boolean checked = true
end type

type uo_partidas from u_marca_lista within w_con_resumen_vtas_intrastat
event destroy ( )
boolean visible = false
integer x = 562
integer y = 308
integer width = 1349
integer taborder = 120
boolean bringtotop = true
boolean border = false
end type

on uo_partidas.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;long ll_indice
string ls_filtro_partidas

for ll_indice = 1 to this.dw_marca.rowcount()
	if (this.dw_marca.getitemstring(ll_indice,"marca") = "S" or (row = ll_indice and data = 'S')) and not(row = ll_indice and data = 'N') then
		if trim(ls_filtro_partidas) = "" then
			ls_filtro_partidas = "'"+this.dw_marca.getitemstring(ll_indice,"texto")+"'"			
		else
			ls_filtro_partidas = ls_filtro_partidas+",'"+this.dw_marca.getitemstring(ll_indice,"texto")+"'"
		end if
	end if
next

if trim(ls_filtro_partidas) <> "" then
	ls_filtro_partidas = "partida_estadistica in ("+ls_filtro_partidas+")"
end if
end event

type cb_partidas from commandbutton within w_con_resumen_vtas_intrastat
integer x = 1239
integer y = 172
integer width = 672
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Partidas"
end type

event clicked;uo_partidas.visible = not(uo_partidas.visible)
end event

type gb_1 from groupbox within w_con_resumen_vtas_intrastat
integer y = 112
integer width = 613
integer height = 180
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_2 from groupbox within w_con_resumen_vtas_intrastat
integer x = 613
integer y = 112
integer width = 613
integer height = 180
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo País"
end type

