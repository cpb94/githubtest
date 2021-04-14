$PBExportHeader$w_cambia_caja.srw
forward
global type w_cambia_caja from w_int_con_empresa
end type
type pb_2 from upb_salir within w_cambia_caja
end type
type cb_buscar from u_boton within w_cambia_caja
end type
type dw_tablas_a_cambiar from u_datawindow within w_cambia_caja
end type
type cb_updatear_tablas from commandbutton within w_cambia_caja
end type
type st_pallet from statictext within w_cambia_caja
end type
type uo_tipo_pallet from u_em_campo_2 within w_cambia_caja
end type
type uo_caja from u_em_campo_2 within w_cambia_caja
end type
type st_caja from statictext within w_cambia_caja
end type
type st_formato from statictext within w_cambia_caja
end type
type st_articulo from statictext within w_cambia_caja
end type
type uo_articulo from u_em_campo_2 within w_cambia_caja
end type
type st_nueva_caja from statictext within w_cambia_caja
end type
type uo_nueva_caja from u_em_campo_2 within w_cambia_caja
end type
end forward

global type w_cambia_caja from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2441
integer height = 2128
pb_2 pb_2
cb_buscar cb_buscar
dw_tablas_a_cambiar dw_tablas_a_cambiar
cb_updatear_tablas cb_updatear_tablas
st_pallet st_pallet
uo_tipo_pallet uo_tipo_pallet
uo_caja uo_caja
st_caja st_caja
st_formato st_formato
st_articulo st_articulo
uo_articulo uo_articulo
st_nueva_caja st_nueva_caja
uo_nueva_caja uo_nueva_caja
end type
global w_cambia_caja w_cambia_caja

type variables
//str_contaparam istr_contaparam
end variables

event open;call super::open;This.title = "CAMBIO CUENTAS NPGC"
end event

on w_cambia_caja.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_buscar=create cb_buscar
this.dw_tablas_a_cambiar=create dw_tablas_a_cambiar
this.cb_updatear_tablas=create cb_updatear_tablas
this.st_pallet=create st_pallet
this.uo_tipo_pallet=create uo_tipo_pallet
this.uo_caja=create uo_caja
this.st_caja=create st_caja
this.st_formato=create st_formato
this.st_articulo=create st_articulo
this.uo_articulo=create uo_articulo
this.st_nueva_caja=create st_nueva_caja
this.uo_nueva_caja=create uo_nueva_caja
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_buscar
this.Control[iCurrent+3]=this.dw_tablas_a_cambiar
this.Control[iCurrent+4]=this.cb_updatear_tablas
this.Control[iCurrent+5]=this.st_pallet
this.Control[iCurrent+6]=this.uo_tipo_pallet
this.Control[iCurrent+7]=this.uo_caja
this.Control[iCurrent+8]=this.st_caja
this.Control[iCurrent+9]=this.st_formato
this.Control[iCurrent+10]=this.st_articulo
this.Control[iCurrent+11]=this.uo_articulo
this.Control[iCurrent+12]=this.st_nueva_caja
this.Control[iCurrent+13]=this.uo_nueva_caja
end on

on w_cambia_caja.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_buscar)
destroy(this.dw_tablas_a_cambiar)
destroy(this.cb_updatear_tablas)
destroy(this.st_pallet)
destroy(this.uo_tipo_pallet)
destroy(this.uo_caja)
destroy(this.st_caja)
destroy(this.st_formato)
destroy(this.st_articulo)
destroy(this.uo_articulo)
destroy(this.st_nueva_caja)
destroy(this.uo_nueva_caja)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cambia_caja
integer x = 59
integer y = 88
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cambia_caja
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cambia_caja
integer width = 2267
end type

type pb_2 from upb_salir within w_cambia_caja
integer x = 2295
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_buscar from u_boton within w_cambia_caja
integer x = 9
integer y = 308
integer width = 2414
integer height = 92
integer taborder = 50
boolean bringtotop = true
string text = "Buscar Tablas"
end type

event clicked;call super::clicked;long   ll_indice,ll_total,ll_coincidencias,ll_indice2,ll_total2,ll_donde
int    li_tiene_pallet
string ls_sel,ls_tabla,ls_columna,ls_cuenta_actual,ls_titulo_actual,ls_cuenta_npgc,ls_titulo_npgc	
string ls_pallet,ls_filtro_pallet,ls_columna_pallet
boolean lb_correcto
string  ls_articulo_a_updatear,ls_pallet_a_updatear,ls_caja_a_updatear
datastore ds_datos,ds_datos2

dw_tablas_a_cambiar.reset()

ls_articulo_a_updatear = uo_articulo.em_codigo.text
ls_pallet_a_updatear   = uo_tipo_pallet.em_codigo.text
ls_caja_a_updatear     = uo_caja.em_codigo.text

ls_sel = "SELECT sysobjects.name,"+&
         "       syscolumns.name,"+&
         "       systypes.name "+&
    		"FROM syscolumns, "+&
         "     sysobjects, "+&
         "     systypes "+&
   		"WHERE ( sysobjects.id = syscolumns.id ) "+&
			"AND   ( syscolumns.xtype = systypes.xtype ) "+&
			"AND   ( upper(syscolumns.name) like '%CAJA%' ) "+&
			"AND   ( systypes.name = 'char' or systypes.name = 'varchar') "+&
			"AND   ( sysobjects.id in (select syscolumns.id from syscolumns where upper(syscolumns.name) = 'EMPRESA') )"+&
			"AND   ( sysobjects.id in (select syscolumns.id from syscolumns where upper(syscolumns.name) = 'ARTICULO') )"+&
			"AND   ( sysobjects.name not in ('almartcajas','palarticulo') ) "+& 
			"AND   ( sysobjects.type <> 'V' ) "+&
			"GROUP BY sysobjects.name,syscolumns.name,systypes.name "+&
			"ORDER BY sysobjects.name,syscolumns.name,systypes.name "
			
ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	ls_tabla   = ds_datos.object.sysobjects_name[ll_indice]
	
	f_mensaje_proceso(ls_tabla,ll_indice,ll_total)
	
	ls_columna = ds_datos.object.syscolumns_name[ll_indice]

	li_tiene_pallet = 0
	
	select count(*)
	into   :li_tiene_pallet 
	from   syscolumns,sysobjects,systypes
	where  sysobjects.id    = syscolumns.id
	and    syscolumns.xtype = systypes.xtype 
	and  ( systypes.name = 'char' or systypes.name = 'varchar') 
	and    sysobjects.name  = :ls_tabla
	and    syscolumns.name like '%pallet%';
	
	if isnull(li_tiene_pallet) then li_tiene_pallet = 0
	
	if li_tiene_pallet = 1 and ls_pallet_a_updatear <> '' then
		
		ls_columna_pallet = ''
		
		select isnull(syscolumns.name,'') 
		into   :ls_columna_pallet 
		from   syscolumns,sysobjects,systypes
		where  sysobjects.id    = syscolumns.id
		and    syscolumns.xtype = systypes.xtype 
		and  ( systypes.name = 'char' or systypes.name = 'varchar') 
		and    sysobjects.name  = :ls_tabla
		and    syscolumns.name like '%pallet%';			
		
		ls_pallet = "S"
		ls_filtro_pallet = "and "+ls_columna_pallet+" = '"+ls_pallet_a_updatear+"' "
	else
		ls_pallet = "N"
		ls_filtro_pallet = ""
	end if								
	
	ls_sel = "select "+ls_columna+" "+&
				"from "+ls_tabla+" "+&
				"where empresa = '"+codigo_empresa+"' "+&
				ls_filtro_pallet+&
				"and articulo = '"+ls_articulo_a_updatear+"' "+&
				"and "+ls_columna+" = '"+ls_caja_a_updatear+"' "+&
				"group by "+ls_columna
		
	ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos2,ls_sel)
	
	if ll_total2 > 0 then			
			ll_donde = dw_tablas_a_cambiar.insertrow(0)
			dw_tablas_a_cambiar.object.tabla[ll_donde]                = ls_tabla
			dw_tablas_a_cambiar.object.pallet[ll_donde]               = ls_pallet
			dw_tablas_a_cambiar.object.updatear[ll_donde]             = 'S'
			dw_tablas_a_cambiar.object.campo[ll_donde]                = ls_columna					
			dw_tablas_a_cambiar.object.campo_pallet[ll_donde]         = ls_columna_pallet					
	end if

	destroy ds_datos2

next

dw_tablas_a_cambiar.sort()

destroy ds_datos
end event

type dw_tablas_a_cambiar from u_datawindow within w_cambia_caja
integer x = 9
integer y = 400
integer width = 2414
integer height = 1468
integer taborder = 0
boolean bringtotop = true
boolean titlebar = true
string title = "Tablas a modificar"
string dataobject = "dw_cambia_caja2"
boolean vscrollbar = true
end type

event clicked;call super::clicked;string ls_tabla,ls_campo

this.selectrow(0,false)

if row > 0 then
	this.selectrow(row,true)
	ls_tabla = this.object.tabla[row]
	ls_campo = this.object.campo[row]
	
else

end if

end event

type cb_updatear_tablas from commandbutton within w_cambia_caja
integer x = 9
integer y = 1876
integer width = 2414
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Modificar Tablas"
end type

event clicked;string ls_tabla,ls_columna,ls_filtro_pallet,ls_caja_vieja,ls_caja_nueva,ls_sel_modificacion,ls_articulo,ls_pallet
long   ll_indice,ll_total,ll_indice2,ll_total2

ls_articulo   = uo_articulo.em_codigo.text
ls_caja_vieja = uo_caja.em_codigo.text
ls_pallet     = uo_tipo_pallet.em_codigo.text
ls_caja_nueva = uo_nueva_caja.em_codigo.text

if ls_articulo = "" then
	messagebox("Error","No ha seleccionado Articulo")
	return
end if

if ls_caja_vieja = "" then
	messagebox("Error","No ha seleccionado Caja")
	return
end if

if ls_caja_nueva = "" then
	messagebox("Error","No ha seleccionado Caja Nueva")
	return
end if

if messagebox("Confirmación!","¿Desea modificar la caja?",Question!,YesNo!,2) = 1 then
	
	dw_tablas_a_cambiar.setredraw(false)
	
	dw_tablas_a_cambiar.setfilter("updatear = 'S'")
	dw_tablas_a_cambiar.filter()
	
	ll_total = dw_tablas_a_cambiar.rowcount()
	
	for ll_indice = 1 to ll_total	
		ls_tabla = dw_tablas_a_cambiar.object.tabla[ll_indice]
		ls_columna = dw_tablas_a_cambiar.object.campo[ll_indice]
		
		if dw_tablas_a_cambiar.object.pallet[ll_indice] = "S" then
			ls_filtro_pallet = " and "+dw_tablas_a_cambiar.object.campo_pallet[ll_indice]+" = '"+ls_pallet+"' "
		else
			ls_filtro_pallet = ""
		end if
				
		f_mensaje_proceso("Procesando",ll_indice,ll_total)
		
		ls_sel_modificacion = "update "+ls_tabla+" ~n"+&
									 "set "+ls_columna+" = '"+ls_caja_nueva+"' ~n"+&
									 "where empresa      = '"+codigo_empresa+"' ~n"+&
									 "and   articulo     = '"+ls_articulo+"' ~n"+&
									 "and "+ls_columna+" = '"+ls_caja_vieja+"' ~n"+&	
									 ls_filtro_pallet
		
		//messagebox("",ls_sel_modificacion)
		
		EXECUTE IMMEDIATE :ls_sel_modificacion USING sqlca ;
		
		if sqlca.sqlcode <> 0 then 
			rollback;
			messagebox("Atención","Error al modificar la tabla "+ls_tabla+" campo "+ls_columna)				
		else
			commit;
		end if		

	next
	
	dw_tablas_a_cambiar.setfilter("")
	dw_tablas_a_cambiar.filter()
	dw_tablas_a_cambiar.sort()
	dw_tablas_a_cambiar.setredraw(true)
	dw_tablas_a_cambiar.selectrow(0,false)
	
	messagebox("Atención","Proceso Finalizado")	
end if
end event

type st_pallet from statictext within w_cambia_caja
integer x = 1714
integer y = 140
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Pallet"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_tipo_pallet from u_em_campo_2 within w_cambia_caja
event destroy ( )
integer x = 1714
integer y = 216
integer width = 279
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tipo_pallet.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_tipo_pallet.em_campo.text=f_nombre_palarticulocaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_tipo_pallet.em_campo.text)=""  or IsNull(uo_tipo_pallet.em_campo.text)THEN 
	IF Trim(uo_tipo_pallet.em_codigo.text)<>"" Then 
		uo_tipo_pallet.em_campo.SetFocus()
	END IF
	uo_tipo_pallet.em_campo.text=""
	uo_tipo_pallet.em_codigo.text=""
	st_pallet.text = 'Pallet'
else
	st_pallet.text = 'Pallet '+this.em_codigo.text	
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_palarticulo_abr"
ue_filtro     = "(palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "') and "+&
                "(palarticulo_caja = '" + uo_caja.em_codigo.text + "')" 

end event

type uo_caja from u_em_campo_2 within w_cambia_caja
event destroy ( )
integer x = 1431
integer y = 216
integer width = 279
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text = f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text)=""  or IsNull(uo_caja.em_campo.text)THEN 
	IF Trim(uo_caja.em_codigo.text)<>"" Then 
		uo_caja.em_campo.SetFocus()
	END IF
	uo_caja.em_campo.text  = ""
	uo_caja.em_codigo.text = ""
	
	st_caja.text = 'Caja'
else
	st_caja.text = 'Caja '+uo_caja.em_codigo.text
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas_sin_pallet"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"

end event

type st_caja from statictext within w_cambia_caja
integer x = 1431
integer y = 140
integer width = 279
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Caja"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_formato from statictext within w_cambia_caja
integer x = 494
integer y = 140
integer width = 933
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_articulo from statictext within w_cambia_caja
integer x = 9
integer y = 140
integer width = 480
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_articulos, lstr_param)
end event

type uo_articulo from u_em_campo_2 within w_cambia_caja
event destroy ( )
integer x = 9
integer y = 216
integer width = 1417
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;String var_tipo_unidad,var_cliente,var_formato, v_uso,cod_sector
long   lineas_compuesto

uo_articulo.em_campo.text = Trim( f_nombre_articulo( codigo_empresa,uo_articulo.em_codigo.text ) )

IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then 
		uo_articulo.em_campo.SetFocus()
	END IF
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	
	st_articulo.text = "Articulo"
	
	Return
END IF

st_articulo.text = "Articulo "+uo_articulo.em_codigo.text

// Selecciono abreviado del la unidad del articulo
string  codigo_articulo,texto_unidad,cod_familia

codigo_articulo = uo_articulo.em_codigo.text


// Selecciono si la familia tiene tono y calibre
string cod_tono,cod_calibre
SELECT articulos.familia,articulos.unidad,articulos.tono,articulos.calibre,articulos.sector,articulos.formato, uso
INTO :cod_familia,:var_tipo_unidad,:cod_tono,:cod_calibre,:cod_sector,:var_formato, :v_uso
FROM articulos  
WHERE articulos.empresa = :codigo_empresa
AND   articulos.codigo  = :codigo_articulo;

st_formato.text = f_nombre_formato(codigo_empresa,var_formato)

IF cod_sector = "S" THEN
	uo_tipo_pallet.enabled = TRUE
	uo_tipo_pallet.em_codigo.text = ""
	uo_tipo_pallet.em_campo.text  = "" 

	uo_caja.enabled = TRUE
	uo_caja.em_codigo.text = ""
	uo_caja.em_campo.text  = "" 

ELSE
	uo_tipo_pallet.enabled = FALSE
	uo_tipo_pallet.em_codigo.text = ""
	uo_tipo_pallet.em_campo.text  = ""
	
	uo_caja.enabled = FALSE
	uo_caja.em_codigo.text = ""
	uo_caja.em_campo.text  = "" 	
END IF

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

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type st_nueva_caja from statictext within w_cambia_caja
integer x = 1998
integer y = 140
integer width = 425
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Nueva Caja"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_nueva_caja from u_em_campo_2 within w_cambia_caja
integer x = 1998
integer y = 216
integer width = 425
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas_sin_pallet"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"

end event

event modificado;call super::modificado;this.em_campo.text = f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,this.em_codigo.text)

IF Trim(this.em_campo.text)=""  or IsNull(this.em_campo.text)THEN 
	IF Trim(this.em_codigo.text)<>"" Then 
	this.em_campo.SetFocus()
	END IF
	this.em_campo.text  = ""
	this.em_codigo.text = ""
	st_nueva_caja.text = 'Nueva Caja'
else
	st_nueva_caja.text = 'Nueva Caja '+this.em_codigo.text		
END IF

end event

on uo_nueva_caja.destroy
call u_em_campo_2::destroy
end on

