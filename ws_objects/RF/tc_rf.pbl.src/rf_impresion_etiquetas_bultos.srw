$PBExportHeader$rf_impresion_etiquetas_bultos.srw
forward
global type rf_impresion_etiquetas_bultos from window
end type
type st_2 from statictext within rf_impresion_etiquetas_bultos
end type
type em_bulto from editmask within rf_impresion_etiquetas_bultos
end type
type pb_imprimir from picturebutton within rf_impresion_etiquetas_bultos
end type
type st_1 from statictext within rf_impresion_etiquetas_bultos
end type
type dw_etiquetas from datawindow within rf_impresion_etiquetas_bultos
end type
type cb_3 from commandbutton within rf_impresion_etiquetas_bultos
end type
type em_numero_bultos from editmask within rf_impresion_etiquetas_bultos
end type
end forward

global type rf_impresion_etiquetas_bultos from window
integer width = 1970
integer height = 2504
boolean titlebar = true
string title = "Impresion Etiquetas Bultos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
em_bulto em_bulto
pb_imprimir pb_imprimir
st_1 st_1
dw_etiquetas dw_etiquetas
cb_3 cb_3
em_numero_bultos em_numero_bultos
end type
global rf_impresion_etiquetas_bultos rf_impresion_etiquetas_bultos

on rf_impresion_etiquetas_bultos.create
this.st_2=create st_2
this.em_bulto=create em_bulto
this.pb_imprimir=create pb_imprimir
this.st_1=create st_1
this.dw_etiquetas=create dw_etiquetas
this.cb_3=create cb_3
this.em_numero_bultos=create em_numero_bultos
this.Control[]={this.st_2,&
this.em_bulto,&
this.pb_imprimir,&
this.st_1,&
this.dw_etiquetas,&
this.cb_3,&
this.em_numero_bultos}
end on

on rf_impresion_etiquetas_bultos.destroy
destroy(this.st_2)
destroy(this.em_bulto)
destroy(this.pb_imprimir)
destroy(this.st_1)
destroy(this.dw_etiquetas)
destroy(this.cb_3)
destroy(this.em_numero_bultos)
end on

event open;dw_etiquetas.Object.DataWindow.Zoom = 75
end event

type st_2 from statictext within rf_impresion_etiquetas_bultos
integer x = 9
integer y = 160
integer width = 1038
integer height = 144
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Repetir Bulto :"
boolean focusrectangle = false
end type

type em_bulto from editmask within rf_impresion_etiquetas_bultos
integer x = 1061
integer y = 160
integer width = 864
integer height = 144
integer taborder = 80
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##########"
boolean autoskip = true
end type

type pb_imprimir from picturebutton within rf_impresion_etiquetas_bultos
integer x = 1755
integer y = 8
integer width = 169
integer height = 144
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\PRINT.BMP"
alignment htextalign = left!
end type

event clicked;string  ls_ean_13
int     li_desde,li_hasta,li_row_etiqueta

str_alm_bultos lstr_alm_bultos

dw_etiquetas.reset()

if long(em_bulto.text) > 0 then
	lstr_alm_bultos.id = long(em_bulto.text)
	
	if f_cargar_str_alm_bultos(lstr_alm_bultos.id,lstr_alm_bultos) then
		ls_ean_13 = lstr_alm_bultos.ean13
		if isnull(ls_ean_13) then ls_ean_13 = ""
	
		if trim(ls_ean_13) = "" then
			ls_ean_13 = "25"+string(lstr_alm_bultos.id,"0000000000")
			ls_ean_13 = f_calcula_ean13(ls_ean_13)
		end if
		
		li_row_etiqueta = dw_etiquetas.insertrow(0)
	
		dw_etiquetas.object.codigo_barras[li_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)
		dw_etiquetas.object.descripcion[li_row_etiqueta]   = ls_ean_13//"B"+string(lstr_alm_bultos.id,"0000000000")
		dw_etiquetas.object.almacen[li_row_etiqueta]       = string(lstr_alm_bultos.id,"0000000000")
		dw_etiquetas.object.zona[li_row_etiqueta]          = ""
		dw_etiquetas.object.fila[li_row_etiqueta]          = ""
		dw_etiquetas.object.altura[li_row_etiqueta]        = ""
		dw_etiquetas.object.color_fondo[li_row_etiqueta]   = rgb(255,255,255)
		dw_etiquetas.object.color_texto[li_row_etiqueta]   = rgb(0,0,0)
		dw_etiquetas.object.texto_control[li_row_etiqueta] = "B"+string(lstr_alm_bultos.id,"0000000000")//ls_ean_13
	
		dw_etiquetas.object.flecha_abajo[li_row_etiqueta]  = 'N'
		dw_etiquetas.object.flecha_arriba[li_row_etiqueta] = 'N'												
	end if

else
	li_hasta = integer(em_numero_bultos.text)
	
	for li_desde = 1 to li_hasta
		//lstr_alm_bultos.id, 
		lstr_alm_bultos.empresa            = codigo_empresa
		lstr_alm_bultos.ean13              = "" 
		lstr_alm_bultos.tipo_pallet        = "" 
		lstr_alm_bultos.alto               = 0
		lstr_alm_bultos.usuario            = nombre_usuario 
		lstr_alm_bultos.fecha_hora_alta    = datetime(today(),now())
		lstr_alm_bultos.id_ubicacion       = 0
		lstr_alm_bultos.anyo_orden_carga   = 0 
		lstr_alm_bultos.codigo_orden_carga = ""
		lstr_alm_bultos.observaciones      = ""
		
		if f_insert_alm_bultos(lstr_alm_bultos) then
			commit;
			ls_ean_13 = lstr_alm_bultos.ean13
			if isnull(ls_ean_13) then ls_ean_13 = ""
		
			if trim(ls_ean_13) = "" then
				ls_ean_13 = "25"+string(lstr_alm_bultos.id,"0000000000")
				ls_ean_13 = f_calcula_ean13(ls_ean_13)
			end if
			
			li_row_etiqueta = dw_etiquetas.insertrow(0)
		
			dw_etiquetas.object.codigo_barras[li_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)
			dw_etiquetas.object.descripcion[li_row_etiqueta]   = ls_ean_13
			dw_etiquetas.object.almacen[li_row_etiqueta]       = ""
			dw_etiquetas.object.zona[li_row_etiqueta]          = ""
			dw_etiquetas.object.fila[li_row_etiqueta]          = ""
			dw_etiquetas.object.altura[li_row_etiqueta]        = ""
			dw_etiquetas.object.color_fondo[li_row_etiqueta]   = rgb(255,255,255)
			dw_etiquetas.object.color_texto[li_row_etiqueta]   = rgb(0,0,0)
			dw_etiquetas.object.texto_control[li_row_etiqueta] = ls_ean_13
		
			dw_etiquetas.object.flecha_abajo[li_row_etiqueta]  = 'N'
			dw_etiquetas.object.flecha_arriba[li_row_etiqueta] = 'N'											
		else
			rollback;
		end if
	next
end if

if li_row_etiqueta > 0 then
	dw_etiquetas.setredraw(false)
	dw_etiquetas.Object.DataWindow.Zoom = 100
	dw_etiquetas.groupcalc()
	f_imprimir_datawindow(dw_etiquetas)
	dw_etiquetas.Object.DataWindow.Zoom = 75
	dw_etiquetas.setredraw(true)
end if
end event

type st_1 from statictext within rf_impresion_etiquetas_bultos
integer x = 9
integer y = 8
integer width = 1312
integer height = 144
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bultos a imprimir :"
boolean focusrectangle = false
end type

type dw_etiquetas from datawindow within rf_impresion_etiquetas_bultos
integer y = 316
integer width = 1925
integer height = 1964
integer taborder = 50
string title = "none"
string dataobject = "dw_etiquetas_bultos_100x60"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within rf_impresion_etiquetas_bultos
boolean visible = false
integer y = 2284
integer width = 1925
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recalcular Ean 13 bultos"
end type

event clicked;string ls_sel
long   ll_indice,ll_total
str_alm_bultos lstr_alm_bultos

datastore ds_datos

ls_sel = "select id from alm_bultos order by id"

ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	f_mensaje_proceso("",ll_indice,ll_total)
	
	lstr_alm_bultos.id = ds_datos.object.id[ll_indice]

	lstr_alm_bultos.ean13 = "25"+string(ds_datos.object.id[ll_indice],"0000000000")
	lstr_alm_bultos.ean13 = f_calcula_ean13(lstr_alm_bultos.ean13)
	
	update alm_bultos
	set    alm_bultos.ean13 = :lstr_alm_bultos.ean13
	where  alm_bultos.id    = :lstr_alm_bultos.id;
	
	if sqlca.sqlcode <> 0 then
		rollback;
	else
		commit;
	end if
next

destroy ds_datos
end event

type em_numero_bultos from editmask within rf_impresion_etiquetas_bultos
integer x = 1326
integer y = 8
integer width = 357
integer height = 144
integer taborder = 60
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~999"
end type

