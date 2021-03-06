$PBExportHeader$w_planificacion_tencer_promocion.srw
forward
global type w_planificacion_tencer_promocion from w_int_con_empresa
end type
type r_1 from rectangle within w_planificacion_tencer_promocion
end type
type dw_listado_ficha from datawindow within w_planificacion_tencer_promocion
end type
type dw_listado_ficha2 from datawindow within w_planificacion_tencer_promocion
end type
type st_mensajes from statictext within w_planificacion_tencer_promocion
end type
type p_imagen from picture within w_planificacion_tencer_promocion
end type
type dw_estructura_planificada from datawindow within w_planificacion_tencer_promocion
end type
type dw_2 from datawindow within w_planificacion_tencer_promocion
end type
type st_piezas from statictext within w_planificacion_tencer_promocion
end type
type st_m2 from statictext within w_planificacion_tencer_promocion
end type
type st_1 from statictext within w_planificacion_tencer_promocion
end type
type st_2 from statictext within w_planificacion_tencer_promocion
end type
type dw_aplicaciones from datawindow within w_planificacion_tencer_promocion
end type
type dw_imagen from u_dw_imagen within w_planificacion_tencer_promocion
end type
type dw_imagenes_extra from datawindow within w_planificacion_tencer_promocion
end type
type tv_1 from treeview within w_planificacion_tencer_promocion
end type
type uo_1 from u_em_campo_2 within w_planificacion_tencer_promocion
end type
type cbx_ver_imagen from checkbox within w_planificacion_tencer_promocion
end type
type cbx_estructura from checkbox within w_planificacion_tencer_promocion
end type
type cbx_aplicaciones from checkbox within w_planificacion_tencer_promocion
end type
type cbx_arbol from checkbox within w_planificacion_tencer_promocion
end type
type cbx_mostrar_asignar_fecha from checkbox within w_planificacion_tencer_promocion
end type
type st_titulo from statictext within w_planificacion_tencer_promocion
end type
type dw_1 from u_datawindow within w_planificacion_tencer_promocion
end type
end forward

global type w_planificacion_tencer_promocion from w_int_con_empresa
integer width = 8773
integer height = 4056
string menuname = "menu_planificacion_promocion"
boolean resizable = true
r_1 r_1
dw_listado_ficha dw_listado_ficha
dw_listado_ficha2 dw_listado_ficha2
st_mensajes st_mensajes
p_imagen p_imagen
dw_estructura_planificada dw_estructura_planificada
dw_2 dw_2
st_piezas st_piezas
st_m2 st_m2
st_1 st_1
st_2 st_2
dw_aplicaciones dw_aplicaciones
dw_imagen dw_imagen
dw_imagenes_extra dw_imagenes_extra
tv_1 tv_1
uo_1 uo_1
cbx_ver_imagen cbx_ver_imagen
cbx_estructura cbx_estructura
cbx_aplicaciones cbx_aplicaciones
cbx_arbol cbx_arbol
cbx_mostrar_asignar_fecha cbx_mostrar_asignar_fecha
st_titulo st_titulo
dw_1 dw_1
end type
global w_planificacion_tencer_promocion w_planificacion_tencer_promocion

type variables

end variables

forward prototypes
public subroutine f_ocultar_controles ()
public subroutine f_mostrar_controles ()
end prototypes

public subroutine f_ocultar_controles ();dw_imagen.visible = false
p_imagen.visible = false
tv_1.visible = false
dw_aplicaciones.visible = false
dw_estructura_planificada.visible = false

//uo_1.visible = false
r_1.visible = false

cbx_ver_imagen.visible = false
cbx_estructura.visible = false
cbx_aplicaciones.visible = false
cbx_arbol.visible = false

cbx_mostrar_asignar_fecha.visible = false
end subroutine

public subroutine f_mostrar_controles ();
cbx_ver_imagen.visible = true
cbx_estructura.visible = true
cbx_aplicaciones.visible = true
cbx_arbol.visible = true
//uo_1.visible = true
r_1.visible = true

if cbx_ver_imagen.checked then
	dw_imagen.visible = true
	p_imagen.visible = true
end if

if cbx_estructura.checked then
	dw_estructura_planificada.visible = true
end if

if cbx_aplicaciones.checked then
	dw_aplicaciones.visible = true
end if

if cbx_arbol.checked then
	tv_1.visible = true
end if

cbx_mostrar_asignar_fecha.visible = true
end subroutine

on w_planificacion_tencer_promocion.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "menu_planificacion_promocion" then this.MenuID = create menu_planificacion_promocion
this.r_1=create r_1
this.dw_listado_ficha=create dw_listado_ficha
this.dw_listado_ficha2=create dw_listado_ficha2
this.st_mensajes=create st_mensajes
this.p_imagen=create p_imagen
this.dw_estructura_planificada=create dw_estructura_planificada
this.dw_2=create dw_2
this.st_piezas=create st_piezas
this.st_m2=create st_m2
this.st_1=create st_1
this.st_2=create st_2
this.dw_aplicaciones=create dw_aplicaciones
this.dw_imagen=create dw_imagen
this.dw_imagenes_extra=create dw_imagenes_extra
this.tv_1=create tv_1
this.uo_1=create uo_1
this.cbx_ver_imagen=create cbx_ver_imagen
this.cbx_estructura=create cbx_estructura
this.cbx_aplicaciones=create cbx_aplicaciones
this.cbx_arbol=create cbx_arbol
this.cbx_mostrar_asignar_fecha=create cbx_mostrar_asignar_fecha
this.st_titulo=create st_titulo
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_1
this.Control[iCurrent+2]=this.dw_listado_ficha
this.Control[iCurrent+3]=this.dw_listado_ficha2
this.Control[iCurrent+4]=this.st_mensajes
this.Control[iCurrent+5]=this.p_imagen
this.Control[iCurrent+6]=this.dw_estructura_planificada
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.st_piezas
this.Control[iCurrent+9]=this.st_m2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.dw_aplicaciones
this.Control[iCurrent+13]=this.dw_imagen
this.Control[iCurrent+14]=this.dw_imagenes_extra
this.Control[iCurrent+15]=this.tv_1
this.Control[iCurrent+16]=this.uo_1
this.Control[iCurrent+17]=this.cbx_ver_imagen
this.Control[iCurrent+18]=this.cbx_estructura
this.Control[iCurrent+19]=this.cbx_aplicaciones
this.Control[iCurrent+20]=this.cbx_arbol
this.Control[iCurrent+21]=this.cbx_mostrar_asignar_fecha
this.Control[iCurrent+22]=this.st_titulo
this.Control[iCurrent+23]=this.dw_1
end on

on w_planificacion_tencer_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.r_1)
destroy(this.dw_listado_ficha)
destroy(this.dw_listado_ficha2)
destroy(this.st_mensajes)
destroy(this.p_imagen)
destroy(this.dw_estructura_planificada)
destroy(this.dw_2)
destroy(this.st_piezas)
destroy(this.st_m2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_aplicaciones)
destroy(this.dw_imagen)
destroy(this.dw_imagenes_extra)
destroy(this.tv_1)
destroy(this.uo_1)
destroy(this.cbx_ver_imagen)
destroy(this.cbx_estructura)
destroy(this.cbx_aplicaciones)
destroy(this.cbx_arbol)
destroy(this.cbx_mostrar_asignar_fecha)
destroy(this.st_titulo)
destroy(this.dw_1)
end on

event open;call super::open;string des_empresa
long ll_donde

istr_parametros.s_titulo_ventana = "Planificación"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_estructura_planificada.SetTransObject(SQLCA)
dw_aplicaciones.SetTransObject(SQLCA)


f_activar_campo(uo_1.em_codigo)
uo_1.em_codigo.text = "1"

select nombre
into :des_empresa
from empresas 
where empresa = :codigo_empresa;

st_titulo.text = des_empresa

//dw_1.SetRowFocusIndicator(FocusRect!)
end event

event ue_recuperar;

dw_1.Retrieve(codigo_empresa, uo_1.em_codigo.Text)

CALL Super::ue_recuperar
end event

event close;call super::close;string v_usuario

v_usuario = nombre_usuario

update planificacion 
set usuario = "", ordenmarcado = 0
where empresa = :codigo_empresa
and usuario = :v_usuario;

if SQLCA.SQLCode = 0 then
	commit;
else
	rollback;
end if


//dw_1.Retrieve(codigo_empresa,w_planificacion.sle_valor.text)








end event

event activate;call super::activate;//Control desde el modulo de menus
//if nombre_usuario = 'IFABREGAT' OR nombre_usuario = 'MFERNANDEZ' OR nombre_usuario = 'VGUIMERA' OR nombre_usuario = 'AMALLEN' then
//	permiso_ventana = 2
//end if

w_planificacion_tencer_promocion = ventanas_activas[id_ventana_activa].ventana


//Messagebox("Debug",id_ventana_activa)
//PERMISOS NUEVOS
if permiso_ventana <> 2 then
	//Solo lectura y casos no contemplados
	menu_planificacion_promocion.m_archivo.m_grabar.disable()
	//menu_planificacion_tencer_wide.m_herramientas.m_borrarseleccin.disable()
	menu_planificacion_promocion.m_herramientas.m_moverantes.disable()
	menu_planificacion_promocion.m_herramientas.m_moverdespus.disable()
//	menu_planificacion_promocion.m_herramientas.m_borrarot.disable()
	menu_planificacion_promocion.m_herramientas.m_moverdespus.disable()
	menu_planificacion_promocion.m_procesos.disable()
	menu_planificacion_promocion.m_procesos.m_generar1.disable()
//	menu_planificacion_promocion.m_seleccionar.disable()
	menu_planificacion_promocion.m_herramientas.m_borrarOT2.disable()
//	menu_planificacion_promocion.m_herramientas.m_consultas.m_enviarainkcid.disable()
end if
end event

event timer;call super::timer;/*
string ruta_pendiente = "\\AMAZONAS\HOTFOLDERS\CONVERSION\CONVERTIDO\PENDIENTE\"
string ruta_ink02 = "\\AMAZONAS\HOTFOLDERS\INK-02\"

//st_mensajes_envio.text = "MOVIENDO A PROVISIONAL ..."

ftc_ejecutar_concurrente  ('C:\TENCER_PB12\mover.bat', 2, true)

//st_mensajes_envio.text = "ENVIANDO MODELOS MATE ..."

//ftc_ejecutar_concurrente  ("xcopy /y "+ruta_pendiente+"*MEM*.* "+ruta_ink02+"INK02_MEM_ALTA_160714\", 2, TRUE)

//st_mensajes_envio.text = "ENVIANDO MODELOS BRILLO ..."

ftc_ejecutar_concurrente  ("xcopy /y "+ruta_pendiente+"*BEB*.* "+ruta_ink02+"INK02_BEB_ALTA_160714\", 2, TRUE)

st_mensajes_envio.visible = false

timer (0)

*/
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_planificacion_tencer_promocion
integer y = 804
integer height = 144
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_planificacion_tencer_promocion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_planificacion_tencer_promocion
boolean visible = false
integer x = 709
integer y = 28
integer width = 261
integer height = 88
end type

type r_1 from rectangle within w_planificacion_tencer_promocion
integer linethickness = 8
long fillcolor = 8388608
integer x = 46
integer y = 24
integer width = 544
integer height = 104
end type

type dw_listado_ficha from datawindow within w_planificacion_tencer_promocion
boolean visible = false
integer x = 864
integer y = 928
integer width = 718
integer height = 1076
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_ficha2 from datawindow within w_planificacion_tencer_promocion
boolean visible = false
integer x = 2235
integer y = 948
integer width = 1093
integer height = 1004
integer taborder = 100
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_mensajes from statictext within w_planificacion_tencer_promocion
boolean visible = false
integer x = 6615
integer y = 36
integer width = 1422
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33471187
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type p_imagen from picture within w_planificacion_tencer_promocion
integer x = 7895
integer y = 3448
integer width = 786
integer height = 340
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_estructura_planificada from datawindow within w_planificacion_tencer_promocion
integer x = 50
integer y = 3352
integer width = 2587
integer height = 492
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_estructura_planificada"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
This.SetRow ( currentrow)
end event

event doubleclicked;long v_ot, fila_seleccionada
string linea, cod_linea
if dw_1.RowCount() > 0 then
	
//	dw_1.setfilter("")
//	dw_1.filter()	
//	dw_1.sort()
//	dw_1.groupcalc()
	
	v_ot = dw_estructura_planificada.object.planificacion_ot[row]
	linea = dw_estructura_planificada.object.prodlineas_resumido[row]
	
	select codigo 
	into :cod_linea
	from prodlineas
	where resumido = :linea
	and empresa = :codigo_empresa;
	
	dw_1.retrieve(codigo_empresa,cod_linea)
	fila_seleccionada = Dw_1.Find ("ot = "+string(v_ot), 1, dw_1.RowCount() )
	dw_1.SelectRow ( fila_seleccionada, true )
	dw_1.ScrollToRow ( fila_seleccionada)
	
	uo_1.em_codigo.text = cod_linea
	uo_1.em_campo.text  = linea



end if

end event

event clicked;window lw_ventana
str_parametros lstr_param

integer n_argumentos = 1
string argumentos [1]

if dwo.name = 'b_coste' then //cambiar por nombre del objeto 
	
	argumentos[1] = string(dw_estructura_planificada.object.planificacion_cod_articulo[row])
	
	lstr_param.i_nargumentos = n_argumentos
	
	lstr_param.s_argumentos = argumentos
	
	OpenWithParm(lw_ventana,lstr_param,"w_con_coste_articulo2")
	
	
end if
end event

type dw_2 from datawindow within w_planificacion_tencer_promocion
boolean visible = false
integer x = 32
integer y = 3876
integer width = 3360
integer height = 816
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dw_art_ver_op_aplicaciones_reducido"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_piezas from statictext within w_planificacion_tencer_promocion
integer x = 7072
integer y = 36
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_m2 from statictext within w_planificacion_tencer_promocion
integer x = 7557
integer y = 36
integer width = 334
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_planificacion_tencer_promocion
integer x = 6821
integer y = 36
integer width = 247
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Piezas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_planificacion_tencer_promocion
integer x = 7383
integer y = 36
integer width = 165
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "M2:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_aplicaciones from datawindow within w_planificacion_tencer_promocion
integer x = 2670
integer y = 3356
integer width = 3538
integer height = 492
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_art_ver_op_aplicaciones_reducido"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;long v_ot, fila_seleccionada
string linea, cod_linea
if dw_1.RowCount() > 0 then
	v_ot = dw_estructura_planificada.object.planificacion_ot[row]
	linea = dw_estructura_planificada.object.prodlineas_resumido[row]
	
	select codigo 
	into :cod_linea
	from prodlineas
	where resumido = :linea
	and empresa = :codigo_empresa;
	
	dw_1.retrieve(codigo_empresa,cod_linea)
	fila_seleccionada = Dw_1.Find ("ot = "+string(v_ot), 1, dw_1.RowCount() )
	dw_1.SelectRow ( fila_seleccionada, true )
	dw_1.ScrollToRow ( fila_seleccionada)
	
	uo_1.em_codigo.text = cod_linea
//	des_linea.text = linea

//	close(parent)
end if

end event

event rowfocuschanged;This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
This.SetRow ( currentrow)
end event

type dw_imagen from u_dw_imagen within w_planificacion_tencer_promocion
integer x = 6921
integer y = 3340
integer width = 960
integer height = 520
integer taborder = 200
boolean bringtotop = true
end type

type dw_imagenes_extra from datawindow within w_planificacion_tencer_promocion
boolean visible = false
integer x = 2418
integer y = 340
integer width = 1051
integer height = 432
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_imagen_encajado"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tv_1 from treeview within w_planificacion_tencer_promocion
boolean visible = false
integer x = 6213
integer y = 1728
integer width = 2459
integer height = 1276
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event rightclicked;Long id_ventana
str_parametros lstr_param 
string codigo_nuevo
Treeviewitem tvi


this.getitem(handle,tvi)

codigo_nuevo = Mid(tvi.label, Pos (tvi.label, "[") + 1,  ( Pos (tvi.label, "]") - Pos (tvi.label, "[")) - 1)  	

lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="w_planificacion_tencer_wide"
lstr_param.s_argumentos[2]=codigo_nuevo
OpenWithParm(w_mant_altas_intermedios_nuevo,lstr_param)
end event

type uo_1 from u_em_campo_2 within w_planificacion_tencer_promocion
integer x = 59
integer y = 32
integer width = 512
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_1.em_campo.text=f_nombre_linea_abr(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

dw_1.setfilter("")
dw_1.filter()
cbx_mostrar_asignar_fecha.checked = false

dw_1.Retrieve(codigo_empresa, uo_1.em_codigo.text)	


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Líneas de Producción"
ue_datawindow ="dw_ayuda_prodlineas"
ue_filtro = "activo = 'S'" 
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cbx_ver_imagen from checkbox within w_planificacion_tencer_promocion
integer x = 640
integer y = 40
integer width = 402
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ver Imagen"
boolean checked = true
end type

event clicked;p_imagen.visible = cbx_ver_imagen.checked

//cbx_aplicaciones.checked = not cbx_ver_imagen.checked 
//dw_aplicaciones.visible = not cbx_ver_imagen.checked 

if cbx_ver_imagen.checked then
//	cbx_aplicaciones.checked = false
	dw_aplicaciones.visible = false
end if
end event

type cbx_estructura from checkbox within w_planificacion_tencer_promocion
integer x = 1111
integer y = 40
integer width = 379
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Estructura"
boolean checked = true
end type

event clicked;dw_estructura_planificada.visible = cbx_estructura.checked

end event

type cbx_aplicaciones from checkbox within w_planificacion_tencer_promocion
integer x = 1536
integer y = 40
integer width = 430
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Aplicaciones"
boolean checked = true
end type

event clicked;dw_aplicaciones.visible = cbx_aplicaciones.checked
//cbx_ver_imagen.checked = not cbx_aplicaciones.checked
//p_imagen.visible = not cbx_aplicaciones.checked

if cbx_aplicaciones.checked then
//	cbx_ver_imagen.checked = false
	p_imagen.visible = false
end if
end event

type cbx_arbol from checkbox within w_planificacion_tencer_promocion
integer x = 2007
integer y = 40
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Arbol"
end type

type cbx_mostrar_asignar_fecha from checkbox within w_planificacion_tencer_promocion
integer x = 2537
integer y = 44
integer width = 919
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar sin fecha fabricación"
end type

event clicked;

if this.checked then
	dw_1.setfilter("")
	dw_1.filter()		
	dw_1.Retrieve(codigo_empresa, uo_1.em_codigo.text)	
	dw_1.setfilter("asignar_fecha = 'S'")
	dw_1.filter()		
else
	dw_1.setfilter("")
	dw_1.filter()	
end if

dw_1.sort()
dw_1.groupcalc()
end event

type st_titulo from statictext within w_planificacion_tencer_promocion
integer x = 3794
integer y = 40
integer width = 1893
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within w_planificacion_tencer_promocion
integer y = 160
integer width = 8635
integer height = 3168
integer taborder = 140
string dataobject = "dw_planificacion_promocion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

event doubleclicked;dec v_ot
dec v_ordenmarcado
long i, seleccionados, v_orden, fila_inicial
decimal m2, piezas

v_ot = dw_1.object.ot[Row]

if  dw_1.object.planificacion_promocion_usuario[Row]  = nombre_usuario then
	dw_1.object.planificacion_promocion_usuario[Row] = ""
	update planificacion
	set usuario = ""
	where ot = :v_ot;
	
	if SQLCA.SQLCode = 0 then
		commit;
	else
		messagebox ("ERROR","No se puede desmarcar el registro")
		rollback;
	end if
else
	v_ordenmarcado = 0
	select max (ordenmarcado)
	into :v_ordenmarcado
	from planificacion;
	v_ordenmarcado = v_ordenmarcado+1
	
	dw_1.object.planificacion_promocion_usuario[Row] = nombre_usuario
	dw_1.object.planificacion_promocion_ordenmarcado[Row] = int(v_ordenmarcado)
	dw_1.object.planificacion_promocion_usuario.Color = RGB(0, 0, 255)

	update planificacion
	set usuario = :nombre_usuario, ordenmarcado = :v_ordenmarcado
	where ot = :v_ot;
	
	if SQLCA.SQLCode = 0 then
		commit;
	else
		messagebox ("ERROR","No se puede marcar el registro")
		rollback;
	end if
end if

piezas = 0
m2 = 0
for i=1 to w_planificacion_tencer_promocion.dw_1.rowcount()
	if w_planificacion_tencer_promocion.dw_1.object.planificacion_promocion_usuario[i]  = nombre_usuario then
		piezas += w_planificacion_tencer_promocion.dw_1.object.planificacion_promocion_cantidad[i]
		m2 += w_planificacion_tencer_promocion.dw_1.object.planificacion_promocion_m2[i]
	end if		
next

m2 = round (m2, 2)


w_planificacion_tencer_promocion.st_piezas.text = string(piezas)
w_planificacion_tencer_promocion.st_m2.text = string(m2)
end event

event clicked;call super::clicked;This.SelectRow(0, false)
This.SelectRow(row, TRUE)
this.SetRow(row)




end event

event rowfocuschanged;call super::rowfocuschanged;long pedido, linped, anyo
str_escandallo escandallo[50]
long v_ot, fila_seleccionada
string linea, cod_linea, v_Articulo, ver, ordenoperacion
string v_operacion, base
string pieza_origen = "", coleccion_origen = "", modelo_origen = "", articulo, ruta
	

This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
This.SetRow ( currentrow)

if cbx_ver_imagen.checked then
	p_imagen.visible = true
	p_imagen.PictureName = ""
	IF dw_1.GetRow() > 0 then
		p_imagen.PictureName = f_cargar_imagen_nuevo(string(dw_1.object.articulos_codigo_pantallas[dw_1.GetRow()]))
		//NUEVO
		articulo = dw_1.object.planificacion_promocion_cod_articulo[dw_1.getrow()]
		
		if not isnull(articulo) and articulo <> "" then
			ruta = ftc_imagen_articulo_ruta("5", articulo)	
			if ruta <> "" then
				dw_imagen.Object.datawindow.picture.File =  ruta
				p_imagen.PictureName = ""
				dw_imagen.visible = true
			else
				if ftc_articulo_base2(articulo, base) then
					ruta = ftc_imagen_articulo_ruta("1", base)
					if ruta <> "" then
						dw_imagen.Object.datawindow.picture.File = ruta
						p_imagen.PictureName = ""
						dw_imagen.visible = true
					else
						dw_imagen.visible = false
					end if
				else
					dw_imagen.visible = false
				end if
			end if
		else
			dw_imagen.visible = false
		end if
	else
		p_imagen.PictureName = ""
		dw_imagen.visible = false
	END IF
else
	p_imagen.visible = false
end if

if currentrow > 0 then
	v_ot = dw_1.object.planificacion_promocion_ot[currentrow]
end if

if cbx_estructura.checked and  dw_1.rowcount() > 0 then
	dw_estructura_planificada.visible = true
	pedido = dw_1.object.planificacion_promocion_pedido[currentrow]
	linped = dw_1.object.planificacion_promocion_linped[currentrow]
	anyo = dw_1.object.planificacion_promocion_anyo[currentrow]
	
	if dw_estructura_planificada.visible then
		dw_estructura_planificada.retrieve (codigo_empresa, anyo, pedido, linped)
	end if
	if dw_estructura_planificada.RowCount() > 0 then		
		fila_seleccionada = dw_estructura_planificada.Find ("planificacion_ot = "+string(v_ot), 1, dw_estructura_planificada.RowCount() )
		dw_estructura_planificada.SelectRow ( fila_seleccionada, true )
		dw_estructura_planificada.ScrollToRow ( fila_seleccionada)
	end if
	
else
	dw_estructura_planificada.visible = false
end if

if cbx_aplicaciones.checked and dw_1.rowcount() > 0 then
	
	dw_aplicaciones.visible = true
	v_articulo = dw_1.object.planificacion_promocion_cod_articulo[currentrow]
	ver = dw_1.object.planificacion_promocion_version[currentrow]
	ordenoperacion = string (dw_1.object.planificacion_promocion_ordenoperacion[currentrow])

	select operacion
	into :v_operacion
	from art_ver_operaciones 
	where articulo = :v_articulo
	and version = :ver
	and orden = :ordenoperacion
	and empresa = :codigo_empresa;
	
	if dw_aplicaciones.visible then
		dw_aplicaciones.retrieve (codigo_empresa, v_articulo, ver, v_operacion, v_ot)
	end if
else
	dw_aplicaciones.visible = false
end if

// Mostramos el escandallo
if cbx_arbol.checked then
	tv_1.visible = true
	if currentrow <> 0 then
		if this.object.cod_articulo[currentrow] <> "" then
			tv_1.deleteitem(0)
			f_escandallo_treeview( this.object.cod_articulo[currentrow], 0, tv_1)
		end if
		this.selectrow(0,false)
		this.selectrow(currentrow,true)
	else
		if this.rowcount() > 0 then
			this.selectrow(0,false)
			this.selectrow(1,true)
			tv_1.deleteitem(0)
			f_escandallo_treeview( this.object.cod_articulo[1], 0, tv_1)
		else
			tv_1.deleteitem(0)
		end if
	end if
else
	tv_1.visible = false
end if


end event

event rbuttondown;/*
m_prueba1 m

m = CREATE m_prueba1

m.popmenu(w_planificacion_tencer_wide.pointerx(), w_planificacion_tencer_wide.pointery())

destroy m
*/


menu_planificacion_tencer_wide.m_herramientas.m_consultas.popmenu(Parent.pointerx(), Parent.pointery())

//Messagebox("Aviso", "Botón secundario deshabilitado temporalmente en planificación. Para realizar las acciones de este menú haga clic en Herramientas -> Consultas del menú superior.")
end event

event buttonclicked;call super::buttonclicked;String planificado 
Dec pedido 
Int anyo, linea
this.accepttext()


if row > 0 then
	if dwo.name = "b_pedido" then
		planificado = this.object.venliped_planificado[row]
		anyo = this.object.planificacion_promocion_anyo[row]
		pedido = this.object.planificacion_promocion_pedido[row]
		linea = this.object.planificacion_promocion_linped[row]
		if planificado = 'S' then
			UPDATE venliped SET planificado = 'N' WHERE anyo = :anyo AND pedido = :pedido AND linea = :linea;
		elseif planificado = 'N' then
			UPDATE venliped SET planificado = 'S' WHERE anyo = :anyo AND pedido = :pedido AND linea = :linea;
		end if
		
		SELECT planificado INTO :planificado FROM venliped WHERE anyo = :anyo AND pedido = :pedido AND linea = :linea;
		this.object.venliped_planificado[row] = planificado
		
	end if
end if

this.accepttext()
end event

event key; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE	
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "cod_caja"
 		bus_datawindow = "dw_ayuda_almartcajas"
		bus_titulo     = "Ayuda seleccion de cajas"
		bus_filtro     =  "almartcajas_articulo = '" + GetItemString(This.GetRow(),"cod_articulo")+ "'"
		//valor_empresa = FALSE
   CASE "cod_pallet"		
      bus_datawindow = "dw_ayuda_palarticulo_abr"
      bus_filtro     = "(palarticulo_articulo = '" + GetItemString(This.GetRow(),"cod_articulo")+ "') and (palarticulo_caja = '" +GetItemString(This.GetRow(),"cod_caja") + "')"		
		bus_titulo = "Ayuda seleccion de pallets"
		//valor_empresa = FALSE
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
end event

