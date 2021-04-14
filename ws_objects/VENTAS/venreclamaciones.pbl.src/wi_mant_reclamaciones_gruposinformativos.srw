$PBExportHeader$wi_mant_reclamaciones_gruposinformativos.srw
forward
global type wi_mant_reclamaciones_gruposinformativos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_reclamaciones_gruposinformativos
end type
type dw_usuarios from datawindow within wi_mant_reclamaciones_gruposinformativos
end type
end forward

global type wi_mant_reclamaciones_gruposinformativos from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2821
integer height = 1748
pb_calculadora pb_calculadora
dw_usuarios dw_usuarios
end type
global wi_mant_reclamaciones_gruposinformativos wi_mant_reclamaciones_gruposinformativos

type variables

end variables

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
dw_usuarios.enabled = true
end event

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Grupos a Informar de las Reclamaciones"

This.title = istr_parametros.s_titulo_ventana

dw_usuarios.settransobject(sqlca)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_usuarios.Retrieve(codigo_empresa)
	END IF
END IF

	
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE

//if insercion = "S" then
//	dw_usuarios.enabled = false
//end if
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo_grupo",sle_valor.text)

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "ven_reclamaciones_grupos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_usuarios.Retrieve(codigo_empresa)


CALL Super::ue_recuperar
end event

on wi_mant_reclamaciones_gruposinformativos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_usuarios=create dw_usuarios
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_usuarios
end on

on wi_mant_reclamaciones_gruposinformativos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_usuarios)
end on

event ue_borra_fila;call super::ue_borra_fila;//string tipoparte
//
//tipoparte = sle_valor.text
//
//delete from ven_reclamaciones_grupos
//where  empresa   = :codigo_empresa
//and   codigo_grupo = :tipoparte
//using sqlca;
//if sqlca.sqlcode = 0 then
//	call super::ue_borra_fila
//else
//	rollback;
//	messagebox("Error al borrar los puestos de trabajo!!",sqlca.sqlerrtext)
//end if
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;//if dw_2.update() = -1 then	
//	rollback;
//	messagebox("Atención","Se ha producido un error al actualizar los trabajos")
//else
//	call super::ue_actualiza_dw
//end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_reclamaciones_gruposinformativos
integer x = 18
integer y = 208
integer width = 2757
integer height = 172
string dataobject = "dw_mant_ven_reclamaciones_grupos"
end type

event dw_1::rbuttondown;bus_filtro    = ""
valor_empresa = TRUE	
bus_titulo    = ""
bus_campo     = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "unidad_entrada"
		if this.object.entrada_en_unidad_articulo[this.getrow()] = "N" then
			bus_datawindow = "dw_ayuda_prodpartes_unidades"
			bus_titulo     = "AYUDA SELECCION DE UNIDADES DE PARTES DE PRODUCCIÓN"
		end if
	CASE "unidad_salida"
		if this.object.salida_en_unidad_articulo[this.getrow()] = "N" then
			bus_datawindow = "dw_ayuda_prodpartes_unidades"
			bus_titulo     = "AYUDA SELECCION DE UNIDADES DE PARTES DE PRODUCCIÓN"
		end if
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::RbuttonDown
end event

event dw_1::key;bus_filtro    = ""
valor_empresa = TRUE	
bus_titulo    = ""
bus_campo     = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "unidad_entrada"
		if this.object.entrada_en_unidad_articulo[this.getrow()] = "N" then
			bus_datawindow = "dw_ayuda_prodpartes_unidades"
			bus_titulo     = "AYUDA SELECCION DE UNIDADES DE PARTES DE PRODUCCIÓN"
		end if
	CASE "unidad_salida"
		if this.object.salida_en_unidad_articulo[this.getrow()] = "N" then
			bus_datawindow = "dw_ayuda_prodpartes_unidades"
			bus_titulo     = "AYUDA SELECCION DE UNIDADES DE PARTES DE PRODUCCIÓN"
		end if
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event dw_1::itemchanged;
choose case dwo.name 
	case "genera_entrada_almacen"
		if data = "S" then		
			this.object.pedir_caja[row]        = "S"
			this.object.pedir_tipo_pallet[row] = "S"
			this.object.pedir_tono[row]        = "S"
			this.object.pedir_calibre[row]     = "S"
			this.object.pedir_calidad[row]     = "S"
		end if
	case "entrada_en_unidad_articulo"
		if data = "S" then		
			this.object.unidad_entrada[row]    = ""
		end if
	case "salida_en_unidad_articulo"
		if data = "S" then		
			this.object.unidad_salida[row]    = ""
		end if		
end choose
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_reclamaciones_gruposinformativos
integer x = 5
integer y = 112
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_reclamaciones_gruposinformativos
integer x = 727
integer y = 108
end type

event cb_insertar::clicked;String descrip

dw_1.accepttext()



Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_reclamaciones_gruposinformativos
integer x = 1143
integer y = 108
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_reclamaciones_gruposinformativos
integer x = 306
integer y = 108
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_ven_reclamaciones_grupos"
ue_titulo      = "AYUDA SELECCION DE GRUPOS INFORMATIVOS"
ue_filtro      =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_reclamaciones_gruposinformativos
integer x = 1563
integer y = 108
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_reclamaciones_gruposinformativos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_reclamaciones_gruposinformativos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_reclamaciones_gruposinformativos
integer width = 2437
end type

type pb_calculadora from u_calculadora within wi_mant_reclamaciones_gruposinformativos
integer x = 571
integer y = 104
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select   count(*) 
 Into     :registros
 From     ven_reclamaciones_grupos
 Where   ven_reclamaciones_grupos.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int, ven_reclamaciones_grupos.codigo_grupo)+1)
  Into   :registros
  From   ven_reclamaciones_grupos
  Where  ven_reclamaciones_grupos.empresa = :codigo_empresa;
  
  sle_valor.text=string(registros)
END IF
dw_1.triggerEvent("clicked")
  
end event

type dw_usuarios from datawindow within wi_mant_reclamaciones_gruposinformativos
integer y = 376
integer width = 2770
integer height = 1256
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_mant_ven_reclamaciones_grupos_usua_1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;string    sel,codigo_grupo,ls_usuario
long      indice,total,donde
datastore ds_grupos

if rowcount > 0 then
	codigo_grupo = sle_valor.text
	
	sel = "select ven_reclamaciones_grupos_usua.usuario "+&
			"from   ven_reclamaciones_grupos_usua "+&
			"where  empresa   = '"+codigo_empresa+"'" + &
			" and   codigo_grupo = '" + codigo_grupo + "'"
			
			
	ds_grupos = f_cargar_cursor(sel)		
	
	total = ds_grupos.rowcount()
	
	for indice = 1 to total
		ls_usuario = ds_grupos.object.usuario[indice]
		sel            = "v_usuario = '"+ls_usuario+"'"
		donde          = this.find(sel,1,rowcount)
		if donde > 0 then
			this.object.seleccionado[donde] = "S"
		end if
	next
end if

destroy ds_grupos
end event

event itemchanged;string seleccionado,ls_codigo_grupo,ls_usuario

choose case dwo.name
	case "seleccionado_1"
		seleccionado   = data
		ls_usuario = this.object.v_usuario_1[row]		
	case "seleccionado_2"
		seleccionado   = data
		ls_usuario = this.object.v_usuario_2[row]				
	case "seleccionado_3"
		seleccionado   = data
		ls_usuario = this.object.v_usuario_3[row]				
end choose

ls_codigo_grupo = sle_valor.text

if seleccionado = "N" then
	delete from ven_reclamaciones_grupos_usua
	where  empresa        = :codigo_empresa
	and    codigo_grupo      = :ls_codigo_grupo
	and    usuario = :ls_usuario;
else
	insert into ven_reclamaciones_grupos_usua
		(empresa,			codigo_grupo,		usuario)
	values
		(:codigo_empresa,	:ls_codigo_grupo,		:ls_usuario);
end if

if sqlca.sqlcode <> 0 then
	rollback;
	messagebox("Error al actualizar!!",sqlca.sqlerrtext)
else
	commit;
end if
end event

