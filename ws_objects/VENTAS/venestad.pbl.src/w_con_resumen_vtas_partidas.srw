$PBExportHeader$w_con_resumen_vtas_partidas.srw
forward
global type w_con_resumen_vtas_partidas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_resumen_vtas_partidas
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_partidas
end type
type em_fechadesde from u_em_campo within w_con_resumen_vtas_partidas
end type
type em_fechahasta from u_em_campo within w_con_resumen_vtas_partidas
end type
type dw_listado from datawindow within w_con_resumen_vtas_partidas
end type
type cb_1 from commandbutton within w_con_resumen_vtas_partidas
end type
type gb_1 from groupbox within w_con_resumen_vtas_partidas
end type
type uo_pais from u_em_campo_2 within w_con_resumen_vtas_partidas
end type
type gb_2 from groupbox within w_con_resumen_vtas_partidas
end type
type st_1 from statictext within w_con_resumen_vtas_partidas
end type
type gb_3 from groupbox within w_con_resumen_vtas_partidas
end type
type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_partidas
end type
type dw_detalle from datawindow within w_con_resumen_vtas_partidas
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_partidas
end type
type gb_4 from groupbox within w_con_resumen_vtas_partidas
end type
end forward

global type w_con_resumen_vtas_partidas from w_int_con_empresa
integer width = 2912
integer height = 1660
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
gb_1 gb_1
uo_pais uo_pais
gb_2 gb_2
st_1 st_1
gb_3 gb_3
uo_manejo uo_manejo
dw_detalle dw_detalle
uo_serie uo_serie
gb_4 gb_4
end type
global w_con_resumen_vtas_partidas w_con_resumen_vtas_partidas

type variables
string filtro,grafico = "N"
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);String pais1,pais2,serie1,serie2,sel,pais,nombre_pais,tunidad,articulo
String cliente,nomcli,tipo,familia,partida,nif
Integer r,c
dec{4} totalpts
dec cant,metros,peso
DateTime f1,f2

DataStore d
f1 = DateTime(Date(em_fechadesde.text))
f2 = DateTime(Date(em_fechahasta.text))
pais1 = "."
pais2= "Z"
IF Trim(uo_pais.em_codigo.text) <> "" Then
	pais1 = uo_pais.em_codigo.text
	pais2 = uo_pais.em_codigo.text
END IF

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)))
f_contador_procesos(0,100)

Sel = " SELECT peso,familia,cliente,articulo,tipo_unidad,cantidad,empresa,pais,((neto -impdtopp)*cambio) totalpts" +&
      " FROM   venlifac " +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
      " And    venlifac.pais     between '"+pais1+"'  and '"+pais2+"' "+&
      " And    venlifac.serie    between '"+serie1+"'  and '"+serie2+"' "+&
      " And    venlifac.ffactura between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "
		 
//		d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)


For r = 1 To d.RowCOunt()
	pais = d.GetItemString(r,"pais")
	if f_tipo_pais(pais) = "C" then
		tunidad  = d.GetItemString(r,"tipo_unidad")
		cant     = d.GetItemNumber(r,"cantidad")
		peso     = d.GetItemNumber(r,"peso")
		articulo = d.GetItemString(r,"articulo")
		cliente  = d.GetItemString(r,"cliente")
		nomcli   = f_nombre_cliente(codigo_empresa,"C",cliente)
		familia  = d.GetItemString(r,"familia")
		nif      = f_cif_genter(codigo_empresa,"C",cliente)
		
		if tunidad="0" then
			metros = f_convertir_piezas_metros(codigo_empresa,articulo,cant)
		  else
			metros = cant
		end if
		tipo    = f_partida_segun_familia(codigo_empresa,familia)
		partida = f_nombre_partida (codigo_empresa,tipo)
		nombre_pais = f_nombre_pais(pais)
		totalpts = d.GetItemNumber(r,"totalpts")
		
		if trim(partida)<>"" then 
				c = c +1
				data.InsertRow(c)
				data.SetItem(c,"cliente",cliente)
				data.SetItem(c,"nomcli",nomcli)
				data.SetItem(c,"total_pts",totalpts)
				data.SetItem(c,"pais",pais)
				data.SetItem(c,"nombre_pais",nombre_pais)
				data.SetItem(c,"tipo",tipo)
				data.SetItem(c,"kilos",peso)
				data.SetItem(c,"partida",partida)
				data.SetItem(c,"metros",metros)
				data.SetItem(c,"nif",nif)
		End if
		
		f_mensaje_proceso("Leyendo facturas",r,d.RowCount())	
	End if
	
Next


f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
data.SetSort("pais,cliente,partida")
data.sort()
data.groupcalc()
f_contador_procesos(1,1)
destroy d
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

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen Vtas partidas estadisticas"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(month(Today()),01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)

dw_listado.SetTransObject(SQLCA)

f_activar_campo(em_fechadesde)


end event

on w_con_resumen_vtas_partidas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.gb_1=create gb_1
this.uo_pais=create uo_pais
this.gb_2=create gb_2
this.st_1=create st_1
this.gb_3=create gb_3
this.uo_manejo=create uo_manejo
this.dw_detalle=create dw_detalle
this.uo_serie=create uo_serie
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.uo_pais
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.uo_manejo
this.Control[iCurrent+13]=this.dw_detalle
this.Control[iCurrent+14]=this.uo_serie
this.Control[iCurrent+15]=this.gb_4
end on

on w_con_resumen_vtas_partidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.uo_pais)
destroy(this.gb_2)
destroy(this.st_1)
destroy(this.gb_3)
destroy(this.uo_manejo)
destroy(this.dw_detalle)
destroy(this.uo_serie)
destroy(this.gb_4)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_partidas
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_partidas
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_partidas
integer width = 2359
integer height = 108
end type

type pb_1 from upb_salir within w_con_resumen_vtas_partidas
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_partidas
integer x = 2706
integer y = 184
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;dw_listado.visible = True
f_control(dw_listado)
f_imprimir_datawindow(dw_listado)
dw_listado.visible = False



end event

type em_fechadesde from u_em_campo within w_con_resumen_vtas_partidas
integer x = 27
integer y = 176
integer width = 320
integer taborder = 40
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_resumen_vtas_partidas
integer x = 398
integer y = 176
integer width = 320
integer taborder = 50
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_resumen_vtas_partidas
boolean visible = false
integer x = 2377
integer y = 68
integer width = 41
integer height = 36
string dataobject = "report_con_resumen_vtas_partidas"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_resumen_vtas_partidas
integer x = 1984
integer y = 184
integer width = 251
integer height = 84
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_control(dw_detalle)

end event

type gb_1 from groupbox within w_con_resumen_vtas_partidas
integer x = 5
integer y = 104
integer width = 736
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type uo_pais from u_em_campo_2 within w_con_resumen_vtas_partidas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 768
integer y = 176
integer width = 667
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)

If Trim(uo_pais.em_campo.text)="" then
	uo_pais.em_campo.text=""
	uo_pais.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;valor_empresa = FALSE
	ue_titulo = "Selección de Paises"
	ue_datawindow ="dw_ayuda_paises"
	ue_filtro = ""

end event

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event losefocus;call super::losefocus;valor_empresa = TRUE
end event

type gb_2 from groupbox within w_con_resumen_vtas_partidas
integer x = 745
integer y = 108
integer width = 713
integer height = 176
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pais"
end type

type st_1 from statictext within w_con_resumen_vtas_partidas
integer x = 352
integer y = 180
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_con_resumen_vtas_partidas
integer x = 1966
integer y = 140
integer width = 283
integer height = 140
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_manejo from u_manejo_datawindow within w_con_resumen_vtas_partidas
integer x = 2235
integer y = 136
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_detalle from datawindow within w_con_resumen_vtas_partidas
integer y = 304
integer width = 2848
integer height = 1124
string dataobject = "dw_con_resumen_vtas_partidas"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_partidas
event destroy ( )
integer x = 1481
integer y = 168
integer width = 462
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type gb_4 from groupbox within w_con_resumen_vtas_partidas
integer x = 1463
integer y = 108
integer width = 498
integer height = 176
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

