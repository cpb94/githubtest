$PBExportHeader$w_vista_reclamaciones.srw
forward
global type w_vista_reclamaciones from window
end type
type st_5 from statictext within w_vista_reclamaciones
end type
type st_4 from statictext within w_vista_reclamaciones
end type
type st_3 from statictext within w_vista_reclamaciones
end type
type st_2 from statictext within w_vista_reclamaciones
end type
type cb_1 from commandbutton within w_vista_reclamaciones
end type
type dw_listado from datawindow within w_vista_reclamaciones
end type
type cb_excel from commandbutton within w_vista_reclamaciones
end type
type st_1 from statictext within w_vista_reclamaciones
end type
type pb_1 from upb_salir within w_vista_reclamaciones
end type
type pb_imprimir from upb_imprimir within w_vista_reclamaciones
end type
type dw_1 from u_datawindow_consultas within w_vista_reclamaciones
end type
end forward

global type w_vista_reclamaciones from window
integer x = 672
integer y = 264
integer width = 4635
integer height = 2604
boolean titlebar = true
string title = "Vista Reclamaciones"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_1 cb_1
dw_listado dw_listado
cb_excel cb_excel
st_1 st_1
pb_1 pb_1
pb_imprimir pb_imprimir
dw_1 dw_1
end type
global w_vista_reclamaciones w_vista_reclamaciones

on w_vista_reclamaciones.create
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_listado=create dw_listado
this.cb_excel=create cb_excel
this.st_1=create st_1
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.Control[]={this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_1,&
this.dw_listado,&
this.cb_excel,&
this.st_1,&
this.pb_1,&
this.pb_imprimir,&
this.dw_1}
end on

on w_vista_reclamaciones.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_listado)
destroy(this.cb_excel)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

dw_1.retrieve()
end event

type st_5 from statictext within w_vista_reclamaciones
integer x = 823
integer y = 168
integer width = 2158
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "(*) Click en los valores de los campos cuyas etiquetas están de color azul, para filtrar."
boolean focusrectangle = false
end type

type st_4 from statictext within w_vista_reclamaciones
integer x = 823
integer y = 120
integer width = 1646
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
string text = "(*) Click en las etiquetas que están de color azul, para ordenar."
boolean focusrectangle = false
end type

type st_3 from statictext within w_vista_reclamaciones
integer x = 827
integer y = 72
integer width = 1879
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "(*) Click en el codigo del cliente para seleccionar sus reclamaciones."
boolean focusrectangle = false
end type

type st_2 from statictext within w_vista_reclamaciones
integer x = 823
integer y = 24
integer width = 1879
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "(*) Doble click en el codigo de la reclamación enlaza con la reclamación"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_vista_reclamaciones
integer x = 3026
integer y = 120
integer width = 754
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Todas Las Reclamaciones"
end type

event clicked;string ls_filtro
	
if ls_filtro <> "?" then
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type dw_listado from datawindow within w_vista_reclamaciones
boolean visible = false
integer x = 2720
integer width = 293
integer height = 120
integer taborder = 40
string title = "none"
string dataobject = "report_vista_reclamaciones_gno"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_excel from commandbutton within w_vista_reclamaciones
integer x = 3872
integer y = 120
integer width = 361
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exp. Excel"
end type

event clicked;int li_valor
string ls_nomdoc,ls_nom
li_valor = GetFileSaveName("Imprimir formato Excel", ls_nomdoc, ls_nom, "XLS", "Imprime (*.XLS),*.XLS")
IF li_valor = 1 THEN
	uf_save_dw_as_excel(dw_1,ls_nomdoc)
//	report.SaveAs(ls_nomdoc, Excel!, TRUE)
	f_mensaje("Guardar fichero","Fichero guardado en "+ls_nomdoc)
ELSE
	return
END IF


end event

type st_1 from statictext within w_vista_reclamaciones
integer x = 9
integer y = 48
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "RECLAMACIONES"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_vista_reclamaciones
integer x = 4430
integer y = 100
integer width = 128
integer height = 124
integer taborder = 20
end type

type pb_imprimir from upb_imprimir within w_vista_reclamaciones
integer x = 4261
integer y = 100
integer width = 142
integer height = 124
integer taborder = 10
boolean bringtotop = true
boolean originalsize = false
string picturename = "\bmp\IMP32.BMP"
string disabledname = "\bmp\IMP32_no.BMP"
end type

event clicked;call super::clicked;long total
total = dw_1.rowcount()
if total > 0 then
	dw_1.rowscopy(1,total,Primary!,dw_listado,1,Primary!)
	f_imprimir_datawindow(dw_listado)
//	dw_report=dw_listado4
//	CALL Super:: ue_listar
end if
end event

type dw_1 from u_datawindow_consultas within w_vista_reclamaciones
integer y = 244
integer width = 4581
integer height = 2288
integer taborder = 10
string title = "RECLAMACIONES"
string dataobject = "dw_vista_reclamaciones"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;string ls_columna, ls_nombre,ls_filtro
long ll_columna,ll_fila
string ls_cliente,ls_usuario
datetime ld_fecha
string ls_tipo,ls_causa,ls_situacion,ls_responsable, ls_contacto


	ls_filtro =dw_1.Describe("DataWindow.Table.Filter")
	
	


if dwo.type = "text" then
	
	
	
	ls_nombre = dwo.name
	ll_columna = len(ls_nombre)
	

	ls_columna = mid(dwo.name,1,ll_columna - 2)
	
	choose case ls_columna
			
	case "cliente"
		
		dw_1.SetRedraw(false)
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("cliente A")
		dw_1.Sort( )
		
		dw_1.SetRedraw(true)
		
		
	case  "genter_razon"
		
		dw_1.SetRedraw(false)
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("genter_razon A")
		dw_1.Sort( )
		
		dw_1.SetRedraw(true)
		
		
	case "reclamacion"
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("reclamacion A")
		dw_1.Sort( )
		
		case "fecha"
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("fecha A")
		dw_1.Sort( )
		
		
		case "tipo"
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("codigo_ven_reclamaciones_tipos A")
		dw_1.Sort( )
		
		
		case "causa"
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("codigo_ven_reclamaciones_causa A")
		dw_1.Sort( )
		
		case "situacion"
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("cerrada A")
		dw_1.Sort( )
		
		
		case "responsable"
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("responsable A")
		dw_1.Sort( )
		
		
		
		case "telefonos_codigo"
		
		ll_fila = dw_1.getrow( )
		
		dw_1.SetSort("telefonos_codigo A")
		dw_1.Sort( )
		
		
		case "nombre_usuario"
		
			ll_fila = dw_1.getrow( )
		
			dw_1.SetSort("nombre_usuario A")
			dw_1.Sort( )
		
		
		
		
		
		
		
		
end choose


end if

if dwo.type = "column" or dwo.type = "compute" then
	
	ls_nombre = dwo.name
	
//	if ls_filtro <> "?" then
//		dw_1.setfilter("")
//		dw_1.filter()
//		
//		
//	else
		
	
	

	choose case ls_nombre
			
	case "cliente"
		
		
		ls_cliente = dw_1.object.cliente[row]
		
		
		ls_filtro =  " cliente = '" + string(ls_cliente) + "'"
			
		dw_1.SetRedraw(false)

		dw_1.SetFilter(ls_filtro)
		dw_1.Filter( )
		dw_1.sort()
	
		dw_1.SetRedraw(true)
		
		
	case "genter_razon"
		
		
		ls_cliente = dw_1.object.genter_razon[row]
		
		
		ls_filtro =  " genter_razon = '" + string(ls_cliente) + "'"
			
		dw_1.SetRedraw(false)

		dw_1.SetFilter(ls_filtro)
		dw_1.Filter( )
		dw_1.sort()
	
		dw_1.SetRedraw(true)
		
	case "fecha"
		
		ld_fecha = dw_1.object.fecha[row]
		
		if not ls_filtro = '?' then 
			
			ls_filtro = ls_filtro +  " and fecha = datetime('" + string(ld_fecha) + "')"
			
		else
		
			ls_filtro = "fecha = datetime('" + string(ld_fecha) + "')"
		
		end if
		dw_1.SetRedraw(false)

		dw_1.SetFilter(ls_filtro)
		dw_1.Filter( )
		dw_1.sort()
	
			
		dw_1.SetRedraw(true)
		
		case "tipo"
			
			
			ls_tipo = dw_1.object.codigo_ven_reclamaciones_tipos[row]
			
			if not ls_filtro = '?' then 
					ls_filtro = ls_filtro + " and codigo_ven_reclamaciones_tipos = '" + string(ls_tipo) + "'"
				else
					ls_filtro = "codigo_ven_reclamaciones_tipos = '" + string(ls_tipo) + "'"
			
			end if
			dw_1.SetRedraw(false)
	
			dw_1.SetFilter(ls_filtro)
			dw_1.Filter( )
			dw_1.sort()
		
				
			dw_1.SetRedraw(true)
		
		case "causa"
		
			ls_causa = dw_1.object.codigo_ven_reclamaciones_causa[row]
			
			 if not ls_filtro = '?' then 
				ls_filtro = ls_filtro + " and codigo_ven_reclamaciones_causa = '" + string(ls_causa) + "'"
			else
				
				ls_filtro = "codigo_ven_reclamaciones_causa = '" + string(ls_causa) + "'"
			end if
			
			dw_1.SetRedraw(false)
	
			dw_1.SetFilter(ls_filtro)
			dw_1.Filter( )
			dw_1.sort()
	
			dw_1.SetRedraw(true)
		
		case "situacion"
		
			ls_situacion = dw_1.object.cerrada[row]
			
			if not ls_filtro = '?' then 
					ls_filtro = ls_filtro + " and cerrada = '" + string(ls_situacion) + "'"
			else
				ls_filtro = "cerrada = '" + string(ls_situacion) + "'"
			end if
			
			dw_1.SetRedraw(false)
	
			dw_1.SetFilter(ls_filtro)
			dw_1.Filter( )
			dw_1.sort()
	
			dw_1.SetRedraw(true)
		
		case "responsable"
		
		ls_responsable = dw_1.object.responsable[row]
			
			ls_filtro = "responsable = '" + string(ls_responsable) + "'"
				
			
			dw_1.SetRedraw(false)
	
			dw_1.SetFilter(ls_filtro)
			dw_1.Filter( )
			dw_1.sort()
			
			dw_1.SetRedraw(true)
		
		
		case "telefonos_codigo"
		
			ls_contacto= dw_1.object.telefonos_codigo[row]
			
			ls_filtro = "telefonos_codigo = '" + string(ls_contacto) + "'"
						
			dw_1.SetRedraw(false)
	
			dw_1.SetFilter(ls_filtro)
			dw_1.Filter( )
			dw_1.sort()
	
			dw_1.SetRedraw(true)
			
		case "nombre_usuario"
		
			ls_usuario = dw_1.object.nombre_usuario[row]
			
			ls_filtro = "nombre_usuario = '" + string(ls_usuario) + "'"
				
			
			dw_1.SetRedraw(false)
	
			dw_1.SetFilter(ls_filtro)
			dw_1.Filter( )
			dw_1.sort()
			
			dw_1.SetRedraw(true)
		
	end choose	
	
//	end if
end if


end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
if row > 0 then
  lstr_param.i_nargumentos   = 3
  lstr_param.s_argumentos[2] = This.object.cliente[row]
  lstr_param.s_argumentos[3] = This.object.reclamacion[row]
  OpenSheetWithParm(w_mant_reclamaciones_gno,lstr_param,ventana_padre,5,Original!) 
end if
end event

