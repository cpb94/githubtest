$PBExportHeader$w_mant_versiones_tencer.srw
forward
global type w_mant_versiones_tencer from wi_mvent_con_empresa
end type
type st_descripcion_articulo from statictext within w_mant_versiones_tencer
end type
type pb_calculadora from u_calculadora within w_mant_versiones_tencer
end type
type cb_añadir from commandbutton within w_mant_versiones_tencer
end type
type cb_eliminar from commandbutton within w_mant_versiones_tencer
end type
type cb_intercalar from commandbutton within w_mant_versiones_tencer
end type
type dw_operaciones from u_datawindow within w_mant_versiones_tencer
end type
type st_2 from statictext within w_mant_versiones_tencer
end type
type dw_aplicaciones from u_datawindow within w_mant_versiones_tencer
end type
type st_3 from statictext within w_mant_versiones_tencer
end type
type cb_añadir2 from commandbutton within w_mant_versiones_tencer
end type
type cb_eliminar2 from commandbutton within w_mant_versiones_tencer
end type
type cb_intercalar2 from commandbutton within w_mant_versiones_tencer
end type
type r_1 from rectangle within w_mant_versiones_tencer
end type
type r_2 from rectangle within w_mant_versiones_tencer
end type
type dw_escandallo from u_datawindow within w_mant_versiones_tencer
end type
type st_50 from statictext within w_mant_versiones_tencer
end type
type cb_añadir3 from commandbutton within w_mant_versiones_tencer
end type
type cb_eliminar3 from commandbutton within w_mant_versiones_tencer
end type
type uo_articulo from u_em_campo_2 within w_mant_versiones_tencer
end type
type st_4 from statictext within w_mant_versiones_tencer
end type
type pb_duplicar from picturebutton within w_mant_versiones_tencer
end type
type r_3 from rectangle within w_mant_versiones_tencer
end type
type r_4 from rectangle within w_mant_versiones_tencer
end type
type dw_obs_largas from datawindow within w_mant_versiones_tencer
end type
end forward

global type w_mant_versiones_tencer from wi_mvent_con_empresa
integer x = 5
integer y = 16
integer width = 4507
integer height = 2604
st_descripcion_articulo st_descripcion_articulo
pb_calculadora pb_calculadora
cb_añadir cb_añadir
cb_eliminar cb_eliminar
cb_intercalar cb_intercalar
dw_operaciones dw_operaciones
st_2 st_2
dw_aplicaciones dw_aplicaciones
st_3 st_3
cb_añadir2 cb_añadir2
cb_eliminar2 cb_eliminar2
cb_intercalar2 cb_intercalar2
r_1 r_1
r_2 r_2
dw_escandallo dw_escandallo
st_50 st_50
cb_añadir3 cb_añadir3
cb_eliminar3 cb_eliminar3
uo_articulo uo_articulo
st_4 st_4
pb_duplicar pb_duplicar
r_3 r_3
r_4 r_4
dw_obs_largas dw_obs_largas
end type
global w_mant_versiones_tencer w_mant_versiones_tencer

type variables
boolean volver_a_descripcion_abr
string articulo
end variables

forward prototypes
public function string f_buscar_descripcion_articulo ()
end prototypes

public function string f_buscar_descripcion_articulo ();string descripcion_articulo

SELECT descripcion 
INTO :descripcion_Articulo
FROM articulos
WHERE codigo = :articulo;

RETURN descripcion_articulo
end function

on w_mant_versiones_tencer.create
int iCurrent
call super::create
this.st_descripcion_articulo=create st_descripcion_articulo
this.pb_calculadora=create pb_calculadora
this.cb_añadir=create cb_añadir
this.cb_eliminar=create cb_eliminar
this.cb_intercalar=create cb_intercalar
this.dw_operaciones=create dw_operaciones
this.st_2=create st_2
this.dw_aplicaciones=create dw_aplicaciones
this.st_3=create st_3
this.cb_añadir2=create cb_añadir2
this.cb_eliminar2=create cb_eliminar2
this.cb_intercalar2=create cb_intercalar2
this.r_1=create r_1
this.r_2=create r_2
this.dw_escandallo=create dw_escandallo
this.st_50=create st_50
this.cb_añadir3=create cb_añadir3
this.cb_eliminar3=create cb_eliminar3
this.uo_articulo=create uo_articulo
this.st_4=create st_4
this.pb_duplicar=create pb_duplicar
this.r_3=create r_3
this.r_4=create r_4
this.dw_obs_largas=create dw_obs_largas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_descripcion_articulo
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.cb_añadir
this.Control[iCurrent+4]=this.cb_eliminar
this.Control[iCurrent+5]=this.cb_intercalar
this.Control[iCurrent+6]=this.dw_operaciones
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_aplicaciones
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.cb_añadir2
this.Control[iCurrent+11]=this.cb_eliminar2
this.Control[iCurrent+12]=this.cb_intercalar2
this.Control[iCurrent+13]=this.r_1
this.Control[iCurrent+14]=this.r_2
this.Control[iCurrent+15]=this.dw_escandallo
this.Control[iCurrent+16]=this.st_50
this.Control[iCurrent+17]=this.cb_añadir3
this.Control[iCurrent+18]=this.cb_eliminar3
this.Control[iCurrent+19]=this.uo_articulo
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.pb_duplicar
this.Control[iCurrent+22]=this.r_3
this.Control[iCurrent+23]=this.r_4
this.Control[iCurrent+24]=this.dw_obs_largas
end on

on w_mant_versiones_tencer.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_descripcion_articulo)
destroy(this.pb_calculadora)
destroy(this.cb_añadir)
destroy(this.cb_eliminar)
destroy(this.cb_intercalar)
destroy(this.dw_operaciones)
destroy(this.st_2)
destroy(this.dw_aplicaciones)
destroy(this.st_3)
destroy(this.cb_añadir2)
destroy(this.cb_eliminar2)
destroy(this.cb_intercalar2)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.dw_escandallo)
destroy(this.st_50)
destroy(this.cb_añadir3)
destroy(this.cb_eliminar3)
destroy(this.uo_articulo)
destroy(this.st_4)
destroy(this.pb_duplicar)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.dw_obs_largas)
end on

event open;call super::open;integer permiso


istr_parametros.s_titulo_ventana = "Mantenimiento de verisones de articulos"
This.title=istr_parametros.s_titulo_ventana


permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;
		This.cb_añadir.visible = false;
		This.cb_añadir2.visible = false;
		This.cb_añadir3.visible = false;
		This.cb_eliminar.visible = false;
		This.cb_eliminar2.visible = false;
		This.cb_eliminar3.visible = false;
		This.cb_intercalar.visible = false;
		This.cb_intercalar2.visible = false;
end choose

if istr_parametros.i_nargumentos > 1 then
   articulo=istr_parametros.s_argumentos[2]
	istr_parametros.i_nargumentos = 0
end if

st_descripcion_articulo.text = f_buscar_descripcion_Articulo(articulo)

dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_valor)

dw_operaciones.SetTransObject(SQLCA)
dw_aplicaciones.SetTransObject(SQLCA)
dw_obs_largas.SetTransObject(SQLCA)
dw_escandallo.SetTransObject(SQLCA)
dw_1.sharedata(dw_obs_largas)





end event

event ue_recuperar;string operacion, aplicacion

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(articulo))
criterio[2]   =  trim(articulo)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "art_versiones"

dw_1.Retrieve(codigo_empresa,articulo,sle_valor.Text)
if sle_valor.Text <> "" then
	dw_operaciones.retrieve(codigo_empresa,articulo,sle_valor.text)
	If dw_operaciones.GetRow() > 0 Then 
	  dw_operaciones.SetRow(1)
	end if
	dw_escandallo.retrieve(codigo_empresa,articulo,sle_valor.text)
	If dw_escandallo.GetRow() > 0 Then 
	  dw_escandallo.SetRow(1)
	end if

end if
CALL Super::ue_recuperar



end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
cb_añadir.enabled = false
cb_eliminar.enabled = false
cb_intercalar.enabled = false
cb_añadir2.enabled = false
cb_eliminar2.enabled = false
cb_intercalar2.enabled = false
cb_añadir3.enabled = false
cb_eliminar3.enabled = false

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE

cb_añadir.enabled = true
cb_eliminar.enabled = true
cb_intercalar.enabled = true
cb_añadir2.enabled = true
cb_eliminar2.enabled = true
cb_intercalar2.enabled = true
cb_añadir3.enabled = true
cb_eliminar3.enabled = true

end event

event ue_actualiza_dw;call super::ue_actualiza_dw;boolean error_actualizando

error_actualizando = false

if not error_actualizando then
	dw_aplicaciones.setfilter("")
	dw_aplicaciones.filter()
	if dw_aplicaciones.update() <> 1 then
		error_actualizando = True
	end if
end if

if not error_actualizando then
	dw_operaciones.setfilter("")
	dw_operaciones.filter()
	if dw_operaciones.update() <> 1 then
		error_actualizando = True
	end if
end if

if not error_actualizando then
	dw_escandallo.setfilter("")
	dw_escandallo.filter()
	if dw_escandallo.update() <> 1 then
		error_actualizando = True
	end if
end if


if error_actualizando then
	rollback;
end if


end event

event ue_borra_fila;call super::ue_borra_fila;boolean error_borrando

error_borrando = False
//Borramos las Aplicaciones
if not error_borrando then
	delete from art_ver_op_aplicaciones
	where empresa  = :codigo_empresa
	and	articulo = :articulo
	and	version  = :sle_valor.text;
	
	if SQLCA.SQLCode = -1 then
		error_borrando = True
	end if
end if

//Borramos las operaciones
if not error_borrando then
	delete from art_ver_operaciones
	where empresa  = :codigo_empresa
	and	articulo = :articulo
	and	version  = :sle_valor.text;
	
	if SQLCA.SQLCode = -1 then
		error_borrando = True
	end if
end if

//Borramos el escandallo
if not error_borrando then
	delete from art_escandallo
	where empresa  = :codigo_empresa
	and	articulo = :articulo
	and	version  = :sle_valor.text;
	
	if SQLCA.SQLCode = -1 then
		error_borrando = True
	end if
end if



if error_borrando then
	rollback;
end if

dw_operaciones.reset()
dw_aplicaciones.reset()
dw_escandallo.reset()




end event

event ue_inserta_fila;call super::ue_inserta_fila;DW_1.setitem(DW_1.getrow(),"version",sle_valor.text)
DW_1.setitem(DW_1.getrow(),"empresa",codigo_empresa)
DW_1.setitem(DW_1.getrow(),"articulo",articulo)
DW_1.setitem(DW_1.getrow(),"tipo_version",'P')

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_versiones_tencer
integer x = 32
integer y = 204
integer width = 1682
integer height = 324
integer taborder = 30
string dataobject = "dw_versiones_tencer"
end type

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "base"
	valor_empresa = TRUE
	bus_titulo     = "VENTANA SELECCION ARTICULOS "
	bus_datawindow = "dw_ayuda_articulos"
CASE "base2"
	valor_empresa = TRUE
	bus_titulo     = "VENTANA SELECCION ARTICULOS "
	bus_datawindow = "dw_ayuda_articulos"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key



end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "base"
	valor_empresa = TRUE
	bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
	bus_datawindow = "dw_ayuda_articulos"
CASE "base2"
	valor_empresa = TRUE
	bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
	bus_datawindow = "dw_ayuda_articulos"
	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;dw_obs_largas.enabled = true
end event

event dw_1::losefocus;integer v_tipo_version
if dw_1.rowcount() > 0 then
	if dw_1.object.tipo_version[dw_1.GetRow()] = 'P' then
		select count(*)
		into :v_tipo_version
		from art_versiones
		where empresa = :codigo_empresa
		and articulo = :articulo
		and tipo_version = 'P'
		and version <> :sle_valor.text;
		
		if v_tipo_version >= 1 then
			dw_1.object.tipo_version[dw_1.GetRow()] = 'A'
			messagebox ("Aviso","La versión principal debe ser única")
			dw_1.accepttext()
		end if
	end if
	
	if dw_1.object.tipo_version[dw_1.GetRow()] = '' then
		messagebox ("Aviso","El tipo de versión es obligatorio")
		dw_1.Setfocus()
	end if
end if	



end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_versiones_tencer
integer x = 50
integer y = 100
integer width = 274
string text = "Versión:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_versiones_tencer
integer x = 1883
integer y = 100
integer width = 334
fontcharset fontcharset = ansi!
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_versiones_tencer
integer x = 2222
integer y = 100
integer width = 334
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_versiones_tencer
integer x = 320
integer y = 100
integer width = 174
integer textsize = -9
fontcharset fontcharset = ansi!
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA VERSIONES ARTICULOS"
ue_datawindow = "dw_ayuda_art_versiones"
ue_filtro = "articulo = '"+articulo+"'"

//isle_campo = sle_valor
valor_empresa = TRUE

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_versiones_tencer
integer x = 2560
integer y = 100
integer width = 334
end type

event cb_salir::clicked;// Comprobaremos si el formato final de la ficha técnica coincide con el de la pestaña general

string formato_general
long orden_operacion


if dw_operaciones.Rowcount() > 0 then
//	articulo = dw_operaciones.object.art_ver_operaciones_articulo[orden_operacion]
	orden_operacion = dw_operaciones.Rowcount()
	
	select formato
	into :formato_general
	from articulos
	where empresa = :codigo_empresa
	and codigo = :articulo;
	
	if dw_operaciones.object.art_ver_operaciones_formato[orden_operacion] <> formato_general then
		messagebox("Aviso", "El formato general no coincide con el de la última operación") 
		return;
	end if

end if

CALL Super::clicked
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_versiones_tencer
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_versiones_tencer
integer x = 18
integer y = 0
boolean border = true
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_versiones_tencer
integer x = 329
integer width = 4073
integer height = 76
integer textsize = -9
end type

type st_descripcion_articulo from statictext within w_mant_versiones_tencer
integer x = 617
integer y = 100
integer width = 1152
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type pb_calculadora from u_calculadora within w_mant_versiones_tencer
integer x = 503
integer y = 96
integer taborder = 0
boolean bringtotop = true
end type

event clicked;Integer registros

IF cb_insertar.enabled THEN Return

Select count(*) 
Into   :registros
From   art_versiones
Where  art_versiones.empresa = :codigo_empresa 
and    art_versiones.articulo = :articulo;

IF registros = 0 THEN
	sle_valor.text="1"
ELSE
	Select max(convert(int,art_versiones.version)+1)
	Into   :sle_valor.text
	From   art_versiones
	Where  art_versiones.empresa = :codigo_empresa
	and    art_versiones.articulo = :articulo;
	
END IF
dw_1.triggerEvent("clicked")

 IF registros = 0 THEN
	dw_1.object.tipo_version[dw_1.GetRow()] = 'P'
	dw_1.accepttext()
	
ELSE
	dw_1.object.tipo_version[dw_1.GetRow()] = 'A'
	dw_1.accepttext()
END IF

end event

type cb_añadir from commandbutton within w_mant_versiones_tencer
integer x = 32
integer y = 1520
integer width = 942
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;long total_filas, fila_actual, nuevaoperacion, orden, indice

DW_operaciones.scrolltorow(DW_operaciones.InsertRow(0))
DW_operaciones.SetColumn(1)

fila_actual = dw_operaciones.Getrow()
total_filas = dw_operaciones.RowCount()

orden = 1
if total_filas > 0 then
	orden = total_filas
end if

nuevaoperacion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_operaciones.object.operacion[indice]) >= nuevaoperacion then
			nuevaoperacion = long(dw_operaciones.object.operacion[indice]) + 1
		end if
	next
end if

dw_operaciones.object.empresa[fila_actual] = codigo_empresa
dw_operaciones.object.articulo[fila_actual] = articulo
dw_operaciones.object.version[fila_actual] = sle_valor.text
dw_operaciones.object.operacion[fila_actual] = string(nuevaoperacion)
dw_operaciones.object.orden[fila_actual] = string(orden)


end event

type cb_eliminar from commandbutton within w_mant_versiones_tencer
integer x = 978
integer y = 1520
integer width = 942
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;boolean error_borrando
long fila_actual, total_filas, indice
string operacion, tipoaplicacion, contadoraplicacion

error_borrando = False

if dw_operaciones.Rowcount() > 0 then
	fila_actual = dw_operaciones.getrow()
	operacion = dw_operaciones.object.operacion[fila_Actual]
end if

fila_actual = dw_aplicaciones.getrow()
if dw_aplicaciones.Rowcount() > 0 then
	tipoaplicacion = dw_aplicaciones.object.tipoaplicacion[fila_Actual]
	contadoraplicacion = dw_aplicaciones.object.contadoraplicacion[fila_Actual]
end if

//Borramos las Aplicaciones
if not error_borrando then
	delete from art_ver_op_aplicaciones
	where empresa  = :codigo_empresa
	and	articulo = :articulo
	and	version  = :sle_valor.text
	and 	operacion = :operacion;
	
	if SQLCA.SQLCode = -1 then
		error_borrando = True
	end if
end if


// Borramos la operacion

if not error_borrando then
	fila_actual = dw_operaciones.DeleteRow(0)
	total_filas = dw_operaciones.Rowcount()
	
	for indice = fila_actual to total_filas
		dw_operaciones.object.orden[indice] = string(indice)
	next	
	if dw_operaciones.Update() = -1 then
		error_borrando = True
	end if
end if

if error_borrando then
	rollback;
end if

dw_operaciones.retrieve(codigo_empresa,articulo,sle_valor.text)


end event

type cb_intercalar from commandbutton within w_mant_versiones_tencer
integer x = 1925
integer y = 1520
integer width = 942
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Intercalar"
end type

event clicked;long total_filas, fila_actual, indice, orden, nuevaoperacion

fila_actual = dw_operaciones.Getrow()
total_filas = dw_operaciones.RowCount()

DW_operaciones.scrolltorow(DW_operaciones.InsertRow(fila_actual))
DW_operaciones.SetColumn(1)

total_filas = dw_operaciones.RowCount()

orden = fila_actual
for indice = fila_actual+1 to total_filas
 	 dw_operaciones.object.orden[indice] = string(indice)
next

nuevaoperacion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_operaciones.object.operacion[indice]) >= nuevaoperacion then
			nuevaoperacion = long(dw_operaciones.object.operacion[indice]) + 1
		end if
	next
end if

dw_operaciones.object.empresa[fila_actual] = codigo_empresa
dw_operaciones.object.articulo[fila_actual] = articulo
dw_operaciones.object.version[fila_actual] = sle_valor.text
dw_operaciones.object.operacion[fila_actual] = string(nuevaoperacion)
dw_operaciones.object.orden[fila_actual] = string(orden)



end event

type dw_operaciones from u_datawindow within w_mant_versiones_tencer
integer x = 23
integer y = 604
integer width = 2857
integer height = 908
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_art_ver_operaciones"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event key;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "tipo_operacion"
		bus_titulo     = "AYUDA SELECCION TIPOS DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_formato"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_juegopantallas"
		bus_titulo     = "AYUDA SELECCION DE JUEGOS DE PANTALLAS"
		bus_datawindow = "dw_ayuda_juegospantallas"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_coste"
		v_operacion = dw_operaciones.object.tipo_operacion[dw_operaciones.Getrow()]		
		bus_titulo     = "AYUDA SELECCION FACTOR MP POR OPERACION"
		bus_datawindow = "dw_ayuda_coste_mp_operacion"
		bus_filtro     = " operacion = '"+v_operacion+"' "	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event rbuttondown;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "tipo_operacion"
		bus_titulo     = "AYUDA SELECCION TIPOS DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_formato"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_juegopantallas"
		bus_titulo     = "AYUDA SELECCION DE JUEGOS DE PANTALLAS"
		bus_datawindow = "dw_ayuda_juegopantallas"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_coste"
		v_operacion = dw_operaciones.object.tipo_operacion[dw_operaciones.Getrow()]		
		bus_titulo     = "AYUDA SELECCION FACTOR MP POR OPERACION"
		bus_datawindow = "dw_ayuda_coste_mp_operacion"
		bus_filtro     = " operacion = '"+v_operacion+"' "	
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event clicked;str_parametros lstr_param
string pantalla


dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_tipooperacion"
			lstr_param.s_argumentos[1]  = "w_mant_art_ver_tipooperacion"
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_art_ver_tipooperacion, lstr_param)
		CASE "pb_formato"
			lstr_param.s_argumentos[1]  = "wi_mant_formatos"
    		lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_formatos, lstr_param)
		CASE "pb_pantallas"
			lstr_param.s_argumentos[1]  = "w_mant_juegospantallas"
			lstr_param.s_argumentos[2]  = dw_operaciones.object.art_ver_operaciones_juegopantallas[row] 
			select codigo_pantallas
			into :pantalla
			from articulos
			where empresa = :codigo_empresa
			and codigo = :articulo;
			lstr_param.s_argumentos[3]  = pantalla
			lstr_param.i_nargumentos    = 4
			
			OpenWithParm(w_mant_juegospantallas, lstr_param)
	END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

event rowfocuschanged;call super::rowfocuschanged;string operacion, aplicacion
if currentrow <> 0 then
	operacion = dw_operaciones.object.operacion[currentrow]
	dw_aplicaciones.retrieve(codigo_empresa, articulo, sle_valor.text, operacion)
	If dw_aplicaciones.GetRow() > 0 Then 
//	  dw_aplicaciones.SelectRow(0,FALSE)
//	  dw_aplicaciones.SelectRow(1,TRUE)
	  dw_aplicaciones.SetRow(1)
	end if
end if



end event

event retrieveend;if this.rowcount() >0 then
   This.event rowfocuschanged(1)
end if

end event

event itemchanged;string v_juegopantallas, v_factormp, operacion

IF dwo.Name = "tipo_operacion" THEN
	dw_operaciones.object.art_ver_tipooperacion_descripcion_abr[row] = f_buscar_tipooperacion (data)

END IF
IF dwo.Name = "art_ver_operaciones_formato" THEN
	dw_operaciones.object.formatos_descripcion[row] = f_nombre_formato (codigo_empresa,data)

END IF  
IF dwo.Name = "art_ver_operaciones_juegopantallas" THEN
	select descripcion
	into :v_juegopantallas
	from juegospantallas
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_operaciones.object.juegospantallas_descripcion[row] = v_juegopantallas

END IF  
IF dwo.Name = "art_ver_operaciones_coste" THEN
	operacion = dw_operaciones.object.tipo_operacion[row]
	select descripcion
	into :v_factormp
	from factormp
	where empresa = :codigo_empresa
	and operacion = :operacion
	and factor = :data;
	dw_operaciones.object.factormp_descripcion[row] = v_factormp  

END IF  

end event

type st_2 from statictext within w_mant_versiones_tencer
integer x = 23
integer y = 544
integer width = 2857
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Operaciones"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_aplicaciones from u_datawindow within w_mant_versiones_tencer
integer x = 18
integer y = 1692
integer width = 4375
integer height = 608
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_art_ver_op_aplicaciones"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

event clicked;str_parametros lstr_param

dw_1.enabled = false
dw_operaciones.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
//	Parent.TriggerEvent("ue_desactiva_claves")
end if
dw_1.enabled = True
dw_operaciones.enabled = True

If row=0 Then Return
IF ue_marca_linea = TRUE Then
//  This.SelectRow(0,FALSE)
//  This.SelectRow(row,TRUE)
  SetRow(row)
END IF

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_aplicacion"
			lstr_param.s_argumentos[1]  = "wi_mant_prodaplicaciones"
			lstr_param.s_argumentos[2]  = this.object.tipoaplicacion[this.getrow()]
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_prodaplicaciones, lstr_param)
		CASE "pb_formula"
			lstr_param.s_argumentos[1]  = "wi_mant_formulaciones"
			lstr_param.s_argumentos[2]  = this.object.formula[this.getrow()]
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_formulaciones, lstr_param)
		CASE "pb_pantalla"
			lstr_param.s_argumentos[1]  = "wi_mant_prodpantallas"
			lstr_param.s_argumentos[2]  = this.object.pantalla[this.getrow()]	
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_prodpantallas, lstr_param)
	END CHOOSE
end if


end event

event key;string juegopantallas
bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

juegopantallas = dw_operaciones.object.art_ver_operaciones_juegopantallas[dw_operaciones.getrow()]

CHOOSE CASE bus_campo
	CASE "cod_pantalla"
		bus_titulo     = "AYUDA SELECCION PANTALLAS"
		bus_datawindow = "dw_ayuda_prodpantallas"
		bus_filtro     = " juegopantallas = '"+juegopantallas+"'"
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULAS"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 	
	CASE "tipoaplicacion"
		bus_titulo     = "AYUDA SELECCION APLICACIONES"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key


end event

event rbuttondown;string juegopantallas

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

juegopantallas = dw_operaciones.object.art_ver_operaciones_juegopantallas[dw_operaciones.getrow()]


CHOOSE CASE bus_campo
	CASE "cod_pantalla"
		bus_titulo     = "AYUDA SELECCION PANTALLAS"
		bus_datawindow = "dw_ayuda_prodpantallas"
		bus_filtro     = " juegopantallas = '"+juegopantallas+"'"
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULAS"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 	
	CASE "tipoaplicacion"
		bus_titulo     = "AYUDA SELECCION APLICACIONES"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown

end event

event retrieveend;if this.rowcount() >0 then
   This.event rowfocuschanged(1)
end if

end event

event itemchanged;string v_descripcion
dec v_hilos

CHOOSE CASE dwo.Name 
	CASE "tipoaplicacion"
		dw_aplicaciones.object.prodaplicaciones_resumido[row] = f_nombre_aplicacion_Abr (codigo_empresa,data)
	CASE "formula"
		dw_aplicaciones.object.prodformula_descripcion_produccion[row] = f_nombre_formulacion_produccion (codigo_empresa,data)
	CASE "cod_pantalla"
		select numero_hilos, descripcion
		into :v_hilos, :v_Descripcion
		from prodpantallas
		where empresa = :codigo_empresa
		and codigo = :data;
		dw_aplicaciones.object.prodpantallas_descripcion[row] = v_descripcion //f_nombre_pantalla (codigo_empresa,data)
		dw_aplicaciones.object.prodpantallas_numero_hilos[row] = v_hilos  
END CHOOSE



end event

type st_3 from statictext within w_mant_versiones_tencer
integer x = 18
integer y = 1624
integer width = 4375
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Aplicaciones"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_añadir2 from commandbutton within w_mant_versiones_tencer
integer x = 32
integer y = 2312
integer width = 1445
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;long total_filas, fila_actual, nuevaaplicacion, orden, indice
string operacion 

operacion = dw_operaciones.object.operacion[dw_operaciones.getrow()]
dw_aplicaciones.scrolltorow(dw_aplicaciones.InsertRow(0))
dw_aplicaciones.SetColumn(1)

fila_actual = dw_aplicaciones.Getrow()
total_filas = dw_aplicaciones.RowCount()

orden = 1
if total_filas > 0 then
	orden = total_filas
end if

nuevaaplicacion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_aplicaciones.object.contadoraplicacion[indice]) >= nuevaaplicacion then
			nuevaaplicacion = long(dw_aplicaciones.object.contadoraplicacion[indice]) + 1
		end if
	next
end if

dw_aplicaciones.object.empresa[fila_actual] = codigo_empresa
dw_aplicaciones.object.articulo[fila_actual] = articulo
dw_aplicaciones.object.operacion[fila_actual] =operacion
dw_aplicaciones.object.version[fila_actual] = sle_valor.text
dw_aplicaciones.object.contadoraplicacion[fila_actual] = string(nuevaaplicacion)
dw_aplicaciones.object.orden[fila_actual] = string(orden)



end event

type cb_eliminar2 from commandbutton within w_mant_versiones_tencer
integer x = 1481
integer y = 2312
integer width = 1449
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;boolean error_borrando
long fila_actual, total_filas, indice
string operacion, tipoaplicacion, contadoraplicacion

error_borrando = False

if dw_operaciones.Rowcount() > 0 then
	fila_actual = dw_operaciones.getrow()
	operacion = dw_operaciones.object.operacion[fila_Actual]
end if

fila_actual = dw_aplicaciones.getrow()
if dw_aplicaciones.Rowcount() > 0 then
	tipoaplicacion = dw_aplicaciones.object.tipoaplicacion[fila_Actual]
	contadoraplicacion = dw_aplicaciones.object.contadoraplicacion[fila_Actual]
end if


// Borramos la aplicacion
if not error_borrando then
	fila_actual = dw_aplicaciones.DeleteRow(0)
	total_filas = dw_aplicaciones.Rowcount()
	
	for indice = fila_actual to total_filas
		dw_aplicaciones.object.orden[indice] = string(indice)
	next	
	if dw_aplicaciones.Update() = -1 then
		error_borrando = True
	end if
end if

if error_borrando then
	rollback;
end if

fila_actual = dw_operaciones.getrow()
operacion = dw_operaciones.object.operacion[fila_Actual]
dw_aplicaciones.retrieve (codigo_empresa,articulo,sle_valor.text,operacion)

total_filas = dw_aplicaciones.RowCount()

for indice = 1 to total_filas
	dw_aplicaciones.object.orden[indice] = string(indice)
next




















end event

type cb_intercalar2 from commandbutton within w_mant_versiones_tencer
integer x = 2935
integer y = 2312
integer width = 1449
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Intercalar"
end type

event clicked;long total_filas, fila_actual, indice, orden, nuevaaplicacion
string operacion

if dw_operaciones.RowCount() > 0 then
	operacion	= dw_operaciones.object.operacion[dw_operaciones.getrow()]
else
	return 0
end if

if dw_aplicaciones.RowCount() > 0 then
	fila_actual = dw_aplicaciones.Getrow()
	total_filas = dw_aplicaciones.RowCount()
end if
 
orden = fila_actual
// Incrementamos el orden de los registro en uno 
for indice = fila_actual to total_filas
 	 dw_aplicaciones.object.orden[indice] = string(indice+1)
next

nuevaaplicacion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_aplicaciones.object.contadoraplicacion[indice]) >= nuevaaplicacion then
			nuevaaplicacion = long(dw_aplicaciones.object.contadoraplicacion[indice]) + 1
		end if
	next
end if

dw_aplicaciones.scrolltorow(dw_aplicaciones.InsertRow(fila_actual))  
dw_aplicaciones.SetColumn(1)														


dw_aplicaciones.object.empresa[fila_actual] = codigo_empresa
dw_aplicaciones.object.articulo[fila_actual] = articulo
dw_aplicaciones.object.version[fila_actual] = sle_valor.text
dw_aplicaciones.object.operacion[fila_actual] = operacion
dw_aplicaciones.object.contadoraplicacion[fila_actual] = string(nuevaaplicacion)
dw_aplicaciones.object.orden[fila_actual] = string(orden)


/*

long total_filas, fila_actual, indice, orden, nuevaaplicacion
string operacion

if dw_operaciones.RowCount() > 0 then
	operacion	= dw_operaciones.object.operacion[dw_operaciones.getrow()]
else
	return 0
end if

if dw_aplicaciones.RowCount() > 0 then
	fila_actual = dw_aplicaciones.Getrow()
	total_filas = dw_aplicaciones.RowCount()
end if
 
dw_aplicaciones.scrolltorow(dw_aplicaciones.InsertRow(fila_actual))
dw_aplicaciones.SetColumn(1)

total_filas = dw_aplicaciones.RowCount()

for indice = fila_actual to total_filas
 	 dw_aplicaciones.object.contadoraplicacion[indice] = string(indice+1)    
next

orden = fila_actual
for indice = fila_actual+1 to total_filas
 	 dw_aplicaciones.object.orden[indice] = string(indice)
next

nuevaaplicacion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_aplicaciones.object.contadoraplicacion[indice]) >= nuevaaplicacion then
			nuevaaplicacion = long(dw_aplicaciones.object.contadoraplicacion[indice]) + 1
		end if
	next
end if


dw_aplicaciones.object.empresa[fila_actual] = codigo_empresa
dw_aplicaciones.object.articulo[fila_actual] = articulo
dw_aplicaciones.object.version[fila_actual] = sle_valor.text
dw_aplicaciones.object.operacion[fila_actual] = operacion
dw_aplicaciones.object.contadoraplicacion[fila_actual] = string(nuevaaplicacion)
dw_aplicaciones.object.orden[fila_actual] = string(orden)

*/
end event

type r_1 from rectangle within w_mant_versiones_tencer
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8388608
integer x = 23
integer y = 1508
integer width = 2857
integer height = 88
end type

type r_2 from rectangle within w_mant_versiones_tencer
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8388608
integer x = 14
integer y = 2292
integer width = 4379
integer height = 100
end type

type dw_escandallo from u_datawindow within w_mant_versiones_tencer
integer x = 2903
integer y = 604
integer width = 1495
integer height = 908
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_escandallo"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_tipooperacion"
			lstr_param.s_argumentos[1]  = "w_mant_art_ver_tipooperacion"
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_art_ver_tipooperacion, lstr_param)
	END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event itemchanged;string v_Articulo

IF dwo.Name = "art_escandallo_articulo_ant" THEN
	select descripcion
	into :v_Articulo
	from articulos
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_escandallo.object.articulos_descripcion[row] = v_articulo

END IF  
end event

event rbuttondown;
bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "art_escandallo_articulo_ant"
		bus_titulo     = "AYUDA SELECCION ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "" 	

	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "art_escandallo_articulo_ant"
		bus_titulo     = "AYUDA SELECCION ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type st_50 from statictext within w_mant_versiones_tencer
integer x = 2903
integer y = 544
integer width = 1495
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Escandallo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_añadir3 from commandbutton within w_mant_versiones_tencer
integer x = 2921
integer y = 1520
integer width = 731
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;long total_filas, fila_actual, nuevaoperacion, orden, indice


dw_escandallo.scrolltorow(dw_escandallo.InsertRow(0))
dw_escandallo.SetColumn(1)

fila_actual = dw_escandallo.Getrow()
total_filas = dw_escandallo.RowCount()

dw_escandallo.object.art_escandallo_empresa[fila_actual] = codigo_empresa
dw_escandallo.object.art_escandallo_articulo[fila_actual] = articulo
dw_escandallo.object.art_escandallo_version[fila_actual] = sle_valor.text


end event

type cb_eliminar3 from commandbutton within w_mant_versiones_tencer
integer x = 3657
integer y = 1520
integer width = 731
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;boolean error_borrando
long fila_actual, total_filas, indice
string registro, tipoaplicacion, contadoraplicacion

error_borrando = False

if dw_escandallo.Rowcount() > 0 then
	fila_actual = dw_escandallo.getrow()
//	registro = dw_escandallo.object.operacion[fila_Actual]
end if

// Borramos la operacion

if not error_borrando then
	dw_escandallo.DeleteRow(fila_actual)
	
//	if dw_escandallo.Update() = -1 then
//		error_borrando = True
//	end if
end if

if error_borrando then
	rollback;
end if

//dw_escandallo.retrieve(codigo_empresa,articulo, sle_valor.text)












end event

type uo_articulo from u_em_campo_2 within w_mant_versiones_tencer
event destroy ( )
integer x = 3250
integer y = 96
integer width = 1019
integer height = 88
integer taborder = 20
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type st_4 from statictext within w_mant_versiones_tencer
integer x = 3003
integer y = 116
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 134217857
string text = "Artículo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_duplicar from picturebutton within w_mant_versiones_tencer
integer x = 4283
integer y = 100
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = "Import5!"
alignment htextalign = right!
string powertiptext = "Importar ficha técnica"
end type

event clicked;datastore operaciones, aplicaciones
string v_base, v_descripcion, v_tipo_version, sel
string v_operacion, v_tipo_operacion, v_orden, v_formato, v_juegopantallas, v_coste
string v_contadoraplicacion, v_pantalla, v_formula, v_tipoaplicacion, v_ordenapl, v_boquilla, v_ciclo, v_temp_sup, v_temp_inf, v_cortes, v_discos 
string v_articulo_ant, v_observaciones
decimal v_factor_escandallo
decimal v_gramaje, v_densidad, v_viscosidad
long v_factor, v_numaplicaciones
boolean exito
long i, j

exito = true

if uo_articulo.em_campo.text = '' or isnull(uo_articulo.em_campo.text) then
	messagebox ("Aviso", "Debe indicar el artículo del cuál importarmos los datos")
else
	connect using SQLCA;
	//////////////////////////
	// Importar escandallo
	//////////////////////////
	
	delete 
	from art_escandallo
	where empresa = :codigo_empresa
	and articulo = :articulo
	and version = "1";
	
	if SQLCA.SQLCode = -1 then exito = false

	select articulo_ant, factor
	into :v_articulo_ant, :v_factor_escandallo
	from art_escandallo
	where empresa = :codigo_empresa
	and articulo = :uo_articulo.em_codigo.text
	and version = "1";

	if SQLCA.SQLCode = -1 then exito = false
	
	insert into art_escandallo
	(empresa, articulo, version, articulo_ant, factor)
	values (:codigo_empresa, :articulo, "1", :v_articulo_ant, :v_factor_escandallo);
	
	if SQLCA.SQLCode = -1 then exito = false
	
	//////////////////////////
	// Importar art_versiones
	//////////////////////////
	delete 
	from art_versiones 
	where empresa = :codigo_empresa
	and articulo = :articulo
	and version = :sle_valor.text;
	
	if SQLCA.SQLCode = -1 then exito = false
	
	select base, descripcion, tipo_version
	into :v_base, :v_descripcion,  :v_tipo_version
	from art_versiones
	where empresa = :codigo_empresa
	and articulo = :uo_articulo.em_codigo.text
	and version = '1';
	
	if SQLCA.SQLCode = -1 then exito = false

	v_observaciones = dw_obs_largas.object.observaciones[dw_obs_largas.GetRow()]
	insert into art_versiones (empresa, articulo, version, base, descripcion, tipo_version, observaciones) 
	values (:codigo_Empresa, :articulo, '1', :v_base, :v_descripcion, :v_tipo_version, :v_observaciones);
	
	if SQLCA.SQLCode = -1 then exito = false
	
	////////////////////////////////
	// Importar art_ver_operaciones
	////////////////////////////////
	
	delete 
	from art_ver_operaciones
	where empresa = :codigo_empresa
	and articulo = :articulo
	and version = :sle_valor.text;

	if SQLCA.SQLCode = -1 then exito = false

	sel = " select articulo, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste "+&
			" from art_ver_operaciones "+&
			" where empresa = "+codigo_empresa+&
			" and articulo = "+uo_articulo.em_codigo.text+&
			" and version = 1"
			
	f_cargar_cursor_nuevo (sel, operaciones)
	
	for i = 1 to operaciones.RowCount() 
		v_operacion = operaciones.object.operacion[i]
		v_tipo_operacion = operaciones.object.tipo_operacion[i]
		v_orden= operaciones.object.orden[i]
		v_formato = operaciones.object.formato[i]
		v_factor = operaciones.object.factor[i]
		v_juegopantallas = operaciones.object.juegopantallas[i]
		v_numaplicaciones = operaciones.object.numaplicaciones[i]
		v_coste = operaciones.object.coste[i]

		insert into art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, 
													formato, factor, juegopantallas, numaplicaciones, coste) 
		values (:codigo_Empresa, :articulo, '1', :v_operacion, :v_tipo_operacion, :v_orden, 
				:v_formato, :v_factor, :v_juegopantallas, :v_numaplicaciones, :v_coste);
		
		if SQLCA.SQLCode = -1 then exito = false	
		
		/////////////////////////////////////
		// Importar art_ver_op_aplicaciones
		/////////////////////////////////////
		
		sel = " select contadoraplicacion, pantalla, formula, gramaje, tipoaplicacion, orden, densidad, "+&
				" viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos "+&
				" from art_ver_op_aplicaciones "+&
				" where empresa = "+codigo_empresa+&
				" and articulo = "+uo_articulo.em_codigo.text+&
				" and version = 1 "+&
				" and operacion = "+v_operacion
				
		f_cargar_cursor_nuevo (sel, aplicaciones)
		
		delete from art_ver_op_aplicaciones
		where empresa = :codigo_empresa
		and articulo = :articulo
		and version = "1"
		and operacion = :v_operacion;
		
		if SQLCA.SQLCode = -1 then exito = false
	
		for j = 1 to aplicaciones.rowcount()
			v_contadoraplicacion = aplicaciones.object.contadoraplicacion[j]
			v_pantalla = aplicaciones.object.pantalla[j]
			v_formula = aplicaciones.object.formula[j]
			v_gramaje = aplicaciones.object.gramaje[j]
			v_tipoaplicacion = aplicaciones.object.tipoaplicacion[j]
			v_ordenapl = aplicaciones.object.orden[j]
			v_densidad = aplicaciones.object.densidad[j]
			v_viscosidad = aplicaciones.object.viscosidad[j]
			v_boquilla = aplicaciones.object.boquilla[j]
			v_ciclo = aplicaciones.object.ciclo[j]
			v_temp_sup = aplicaciones.object.temp_sup[j]
			v_temp_inf = aplicaciones.object.temp_inf[j]
			v_cortes = aplicaciones.object.cortes[j]
			v_discos = aplicaciones.object.discos[j]
			
			insert into art_ver_op_aplicaciones
			(empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, tipoaplicacion, 
			orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos)
			values (:codigo_empresa, :articulo, "1", :v_operacion, :v_contadoraplicacion, :v_pantalla, :v_formula, :v_gramaje, :v_tipoaplicacion,
			:v_ordenapl, :v_densidad, :v_viscosidad, :v_boquilla, :v_ciclo, :v_temp_sup, :v_temp_inf, :v_cortes, :v_discos);
			
			if SQLCA.SQLCode = -1 then exito = false	
		next
		f_mensaje_proceso ("Operación", i, operaciones.rowcount())
		
	next
	
	
	if exito = true then
		messagebox("Aviso", "El artículo se ha importado con éxito")
		commit using SQLCA;
		sle_valor.text = "1"
		parent.TriggerEvent("ue_recuperar")
		
	else
		messagebox("Error Duplicando Artículo", "No se llevó a cabo el duplicado del artículo")
		rollback using SQLCA;
	end if
	
end if
end event

type r_3 from rectangle within w_mant_versiones_tencer
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8421376
integer x = 2903
integer y = 1508
integer width = 1495
integer height = 88
end type

type r_4 from rectangle within w_mant_versiones_tencer
integer linethickness = 4
long fillcolor = 134217857
integer x = 2994
integer y = 88
integer width = 1399
integer height = 108
end type

type dw_obs_largas from datawindow within w_mant_versiones_tencer
integer x = 1723
integer y = 204
integer width = 2679
integer height = 328
integer taborder = 40
string dataobject = "dw_art_ver_obs_largas"
boolean livescroll = true
end type

event clicked;dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

end event

