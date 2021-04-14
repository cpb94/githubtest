$PBExportHeader$ventana_base_rf.srw
forward
global type ventana_base_rf from window
end type
type dw_etiquetas from datawindow within ventana_base_rf
end type
type cb_1 from commandbutton within ventana_base_rf
end type
type uo_2 from u_sle_codbar within ventana_base_rf
end type
type uo_1 from u_sle_codbar within ventana_base_rf
end type
type cb_3 from commandbutton within ventana_base_rf
end type
end forward

global type ventana_base_rf from window
integer width = 4718
integer height = 2504
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_etiquetas dw_etiquetas
cb_1 cb_1
uo_2 uo_2
uo_1 uo_1
cb_3 cb_3
end type
global ventana_base_rf ventana_base_rf

on ventana_base_rf.create
this.dw_etiquetas=create dw_etiquetas
this.cb_1=create cb_1
this.uo_2=create uo_2
this.uo_1=create uo_1
this.cb_3=create cb_3
this.Control[]={this.dw_etiquetas,&
this.cb_1,&
this.uo_2,&
this.uo_1,&
this.cb_3}
end on

on ventana_base_rf.destroy
destroy(this.dw_etiquetas)
destroy(this.cb_1)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.cb_3)
end on

type dw_etiquetas from datawindow within ventana_base_rf
integer x = 3365
integer y = 240
integer width = 1307
integer height = 2148
integer taborder = 50
string title = "none"
string dataobject = "dw_etiquetas_bultos_100"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within ventana_base_rf
integer x = 3365
integer y = 128
integer width = 1307
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Etiquetas Bultos"
end type

event clicked;string  ls_sel,ls_ean_13
long    ll_desde,ll_hasta,ll_row_etiqueta
boolean lb_actualizar_ubicaciones = false

datastore ds_datos

//ls_sel = "select alm_bultos.id,alm_bultos.ean13 from alm_bultos,alm_bultos_lineas where alm_bultos.id = alm_bultos_lineas.id_alm_bultos and alm_bultos.id_ubicacion = "+string(uo_1.il_id_ubicacion,"#########0")+" group by alm_bultos.id,alm_bultos.ean13 order by alm_bultos.id" 

ls_sel =  "select 65911 as id,'' as ean13 from empresas where empresa = '1' union select 65912 as id,'' as ean13 from empresas where empresa = '1' union select 65913 as id,'' as ean13 from empresas where empresa = '1'"

ll_hasta = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

dw_etiquetas.reset()

for ll_desde = 1 to ll_hasta
	ls_ean_13 = ds_datos.object.ean13[ll_desde]
	if isnull(ls_ean_13) then ls_ean_13 = ""

	if trim(ls_ean_13) = "" then
		ls_ean_13 = "25"+string(ds_datos.object.id[ll_desde],"0000000000")
		ls_ean_13 = f_calcula_ean13(ls_ean_13)
	end if
	
	ll_row_etiqueta = dw_etiquetas.insertrow(0)

	dw_etiquetas.object.codigo_barras[ll_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)//f_ean_13(ls_ean_13)
	dw_etiquetas.object.descripcion[ll_row_etiqueta]   = "B"+string(ds_datos.object.id[ll_desde],"0000000000")
	dw_etiquetas.object.almacen[ll_row_etiqueta]       = ""
	dw_etiquetas.object.zona[ll_row_etiqueta]          = ""
	dw_etiquetas.object.fila[ll_row_etiqueta]          = ""
	dw_etiquetas.object.altura[ll_row_etiqueta]        = ""
	dw_etiquetas.object.color_fondo[ll_row_etiqueta]   = rgb(255,255,255)
	dw_etiquetas.object.color_texto[ll_row_etiqueta]   = rgb(0,0,0)
	dw_etiquetas.object.texto_control[ll_row_etiqueta] = ls_ean_13

	dw_etiquetas.object.flecha_abajo[ll_row_etiqueta]  = 'N'
	dw_etiquetas.object.flecha_arriba[ll_row_etiqueta] = 'N'									
next

if ll_row_etiqueta > 0 then
	dw_etiquetas.setredraw(false)
	dw_etiquetas.Object.DataWindow.Zoom = 100
	dw_etiquetas.groupcalc()
	f_imprimir_datawindow(dw_etiquetas)
	dw_etiquetas.Object.DataWindow.Zoom = 50
	dw_etiquetas.setredraw(true)
end if

destroy ds_datos
end event

type uo_2 from u_sle_codbar within ventana_base_rf
integer x = 5
integer y = 1236
integer taborder = 30
string is_tipo_codigo = "EAN128"
end type

on uo_2.destroy
call u_sle_codbar::destroy
end on

type uo_1 from u_sle_codbar within ventana_base_rf
integer x = 5
integer y = 4
integer taborder = 20
end type

on uo_1.destroy
call u_sle_codbar::destroy
end on

type cb_3 from commandbutton within ventana_base_rf
boolean visible = false
integer x = 3365
integer y = 4
integer width = 1307
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ean 13 bultos"
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

