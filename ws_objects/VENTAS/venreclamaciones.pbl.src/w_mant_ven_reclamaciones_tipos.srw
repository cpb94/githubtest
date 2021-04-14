$PBExportHeader$w_mant_ven_reclamaciones_tipos.srw
forward
global type w_mant_ven_reclamaciones_tipos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_ven_reclamaciones_tipos
end type
type dw_rutas_fase from u_datawindow within w_mant_ven_reclamaciones_tipos
end type
type dw_fases from u_datawindow within w_mant_ven_reclamaciones_tipos
end type
type dw_causas from u_datawindow within w_mant_ven_reclamaciones_tipos
end type
end forward

global type w_mant_ven_reclamaciones_tipos from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 4608
integer height = 2604
string icon = "Window!"
pb_calculadora pb_calculadora
dw_rutas_fase dw_rutas_fase
dw_fases dw_fases
dw_causas dw_causas
end type
global w_mant_ven_reclamaciones_tipos w_mant_ven_reclamaciones_tipos

type variables

end variables

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
dw_rutas_fase.enabled = true
end event

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Motivos de Reclamación"

This.title = istr_parametros.s_titulo_ventana

dw_rutas_fase.settransobject(sqlca)
dw_fases.settransobject(sqlca)
dw_causas.settransobject(sqlca)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_rutas_fase.Retrieve(codigo_empresa,sle_valor.Text )
		dw_1.triggerevent(clicked!)
	END IF
END IF

	
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE

if insercion = "S" then
	dw_rutas_fase.enabled = false
end if
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "ven_reclamaciones_tipos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_rutas_fase.Retrieve(codigo_empresa,sle_valor.Text)
dw_fases.Retrieve(codigo_empresa,sle_valor.Text)
dw_causas.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on w_mant_ven_reclamaciones_tipos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_rutas_fase=create dw_rutas_fase
this.dw_fases=create dw_fases
this.dw_causas=create dw_causas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_rutas_fase
this.Control[iCurrent+3]=this.dw_fases
this.Control[iCurrent+4]=this.dw_causas
end on

on w_mant_ven_reclamaciones_tipos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_rutas_fase)
destroy(this.dw_fases)
destroy(this.dw_causas)
end on

event ue_borra_fila;string tipoparte

tipoparte = sle_valor.text

delete from prodtipopartes_puestos_trabajo
where  empresa   = :codigo_empresa
and    tipoparte = :tipoparte;

if sqlca.sqlcode = 0 then
	call super::ue_borra_fila
else
	rollback;
	messagebox("Error al borrar los puestos de trabajo!!",sqlca.sqlerrtext)
end if
end event

event ue_actualiza_dw;if dw_causas.update() = -1 then
	rollback;
	messagebox("Atención","Se ha producido un error al actualizar las causas")	
else
	dw_fases.setfilter('')
	dw_fases.filter()	
	if dw_fases.update() = -1 then	
		rollback;
		messagebox("Atención","Se ha producido un error al actualizar las fases")
	else
		dw_rutas_fase.setfilter('')
		dw_rutas_fase.filter()
		if dw_rutas_fase.update() = -1 then	
			rollback;
			messagebox("Atención","Se ha producido un error al actualizar las rutas")
		else
			call super::ue_actualiza_dw
		end if
	end if
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_ven_reclamaciones_tipos
integer x = 0
integer y = 196
integer width = 2011
integer height = 672
boolean titlebar = true
string title = "DATOS GENERALES"
string dataobject = "dw_mant_ven_reclamaciones_tipos"
end type

event dw_1::rbuttondown;bus_filtro    = ""
valor_empresa = TRUE	
bus_titulo    = ""
bus_campo     = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "fase_inicial"
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
		bus_filtro     = ""
		CASE "codigo_grupo"
		bus_datawindow = "dw_ayuda_ven_reclamaciones_grupos_usua"
		bus_titulo     = "AYUDA SELECCION DE GRUPOS INFORMATIVOS"
		bus_filtro     = ""
		valor_empresa = false
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
	CASE "fase_inicial"
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
		bus_filtro     = ""
		CASE "codigo_grupo"
		bus_datawindow = "dw_ayuda_ven_reclamaciones_grupos_usua"
		bus_titulo     = "AYUDA SELECCION DE GRUPOS INFORMATIVOS"
		bus_filtro     = ""
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

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_ven_reclamaciones_tipos
integer x = 5
integer y = 88
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_ven_reclamaciones_tipos
integer x = 727
integer y = 84
end type

event cb_insertar::clicked;String descrip

dw_1.accepttext()



Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_ven_reclamaciones_tipos
integer x = 1143
integer y = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_ven_reclamaciones_tipos
integer x = 306
integer y = 84
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_ven_reclamaciones_tipos"
ue_titulo      = "AYUDA SELECCION MOTIVOS DE RECLAMACIONES"
ue_filtro      =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_ven_reclamaciones_tipos
integer x = 1563
integer y = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_ven_reclamaciones_tipos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_ven_reclamaciones_tipos
integer y = 96
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_ven_reclamaciones_tipos
integer width = 2437
end type

type pb_calculadora from u_calculadora within w_mant_ven_reclamaciones_tipos
integer x = 571
integer y = 80
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select   count(*) 
 Into     :registros
 From     ven_reclamaciones_tipos
 Where   empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,codigo)+1)
  Into   :registros
  From   ven_reclamaciones_tipos
  Where  empresa = :codigo_empresa;
  
  sle_valor.text=string(registros)
END IF
dw_1.triggerEvent("clicked")
  
end event

type dw_rutas_fase from u_datawindow within w_mant_ven_reclamaciones_tipos
integer x = 1120
integer y = 880
integer width = 3470
integer height = 1564
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "RUTAS"
string dataobject = "dw_mant_ven_reclamaciones_rutas_fases_ti"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long donde
choose case f_objeto_datawindow(this)
	case "anyadir"
		if cb_insertar.enabled then	
			if dw_causas.getrow() > 0 then
				if dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()] <> "" then			
					if dw_fases.getrow() > 0 then				
						donde = this.insertrow(this.rowcount() +1)
						this.object.empresa[donde]          = codigo_empresa
						this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
						this.object.codigo_ven_reclamaciones_causa[donde] = dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()]
						this.object.fase[donde]             = dw_fases.object.fase[dw_fases.getrow()]
						this.object.situacion[donde]           = ""
						this.object.fase_siguiente[donde]      = ""
						this.object.situacion_siguiente[donde] = ""
						this.object.cierra_reclamacion[donde]  = "N"
						this.setrow(donde)
						this.scrolltorow(donde)
						this.setcolumn("orden")
					end if
				end if
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if		
	case "insertar"
		if cb_insertar.enabled then	
			if dw_causas.getrow() > 0 then
				if dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()] <> "" then			
					if dw_fases.getrow() > 0 then
						donde = this.insertrow(this.getrow())
						this.object.empresa[donde]          = codigo_empresa
						this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
						this.object.codigo_ven_reclamaciones_causa[donde] = dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()]
						this.object.fase[donde]             = dw_fases.object.fase[dw_fases.getrow()]
						this.object.situacion[donde]           = ""
						this.object.fase_siguiente[donde]      = ""
						this.object.situacion_siguiente[donde] = ""
						this.object.cierra_reclamacion[donde]  = "N"						
						this.setrow(donde)
						this.scrolltorow(donde)
						this.setcolumn("orden")
					end if
				end if
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if
	case "borrar"
		if cb_insertar.enabled then		
			if this.getrow() > 0 then
				this.deleterow(this.getrow())
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)
			end if			
		end if
	case else
		if not(cb_insertar.enabled) then
			dw_1.triggerevent(clicked!)
		end if
end choose
end event

event key;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "situacion"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo     = "AYUDA SELECCION DE SITUACIONES"
	CASE "fase_siguiente"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
	CASE "situacion_siguiente"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo     = "AYUDA SELECCION DE SITUACIONES"		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::key
end event

event rbuttondown;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "situacion"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo     = "AYUDA SELECCION DE SITUACIONES"
	CASE "fase_siguiente"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
	CASE "situacion_siguiente"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo     = "AYUDA SELECCION DE SITUACIONES"		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

type dw_fases from u_datawindow within w_mant_ven_reclamaciones_tipos
integer x = 9
integer y = 880
integer width = 1102
integer height = 1564
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "FASES"
string dataobject = "dw_mant_ven_reclamaciones_fases_tipos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;long donde
choose case f_objeto_datawindow(this)
	case "anyadir"
		if cb_insertar.enabled then					
			if dw_causas.getrow() > 0 then
				if dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()] <> "" then
					donde = this.insertrow(this.rowcount() +1)
					this.object.empresa[donde]          = codigo_empresa
					this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
					this.object.codigo_ven_reclamaciones_causa[donde] = dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()]
					this.object.fase[donde]             = ""
					this.setrow(donde)
					this.scrolltorow(donde)
					this.setcolumn("orden")
				end if
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if		
	case "insertar"
		if cb_insertar.enabled then		
			if dw_causas.getrow() > 0 then
				if dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()] <> "" then			
					donde = this.insertrow(this.getrow())
					this.object.empresa[donde]          = codigo_empresa
					this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
					this.object.codigo_ven_reclamaciones_causa[donde] = dw_causas.object.codigo_ven_reclamaciones_causa[dw_causas.getrow()]
					this.object.fase[donde]             = ""
					this.setrow(donde)
					this.scrolltorow(donde)
					this.setcolumn("orden")
				end if
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if
	case "borrar"
		if cb_insertar.enabled then		
			if this.getrow() > 0 then
				this.deleterow(this.getrow())
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)
			end if			
		end if
	case else
		if not(cb_insertar.enabled) then
			dw_1.triggerevent(clicked!)
		end if
end choose
end event

event itemchanged;string   mensaje_error
boolean  no_valido = false

if dwo.name = "fase" then
	//Aqui chequearemos la integridad
end if

if no_valido then
	messagebox("Atención",mensaje_error)		
	return 2
else
	return 0
end if
end event

event rbuttondown;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE
CHOOSE CASE bus_campo
	CASE "fase"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event retrieveend;//long indice,total
//string trabajo
//total = this.rowcount()
//
//if rowcount > 0 then
//	this.event rowfocuschanged(1)
//end if
end event

event key;long donde

IF  KeyDown(KeyEscape!) Then Parent.TriggerEvent("ue_esc")
IF  KeyDown(KeyF5!)Then Parent.TriggerEvent("ue_f5")
IF  KeyDown(KeyF2!)Then Parent.TriggerEvent("ue_f2")
IF  KeyDown(KeyF3!)Then Parent.TriggerEvent("ue_f3")

IF  KeyDown(KeyInsert!) THEN
	donde = this.insertrow(this.getrow())
	this.object.empresa[donde]   = codigo_empresa
	this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
	this.setrow(donde)
	this.scrolltorow(donde)
	this.setcolumn("fase")
END IF

bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "fase"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::key
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_filtro_rutas,ls_fase,ls_causa

if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	ls_causa = this.object.codigo_ven_reclamaciones_causa[currentrow]
	if isnull(ls_causa) then ls_causa = ''
	ls_fase = this.object.fase[currentrow]
	if isnull(ls_fase) then ls_fase = ''
	ls_filtro_rutas = "codigo_ven_reclamaciones_causa = '"+ls_causa+"' and fase = '"+ls_fase+"'"
	
	dw_rutas_fase.setredraw(false)
	dw_rutas_fase.setfilter(ls_filtro_rutas)
	dw_rutas_fase.filter()
	dw_rutas_fase.sort()
	dw_rutas_fase.setredraw(true)
end if
end event

type dw_causas from u_datawindow within w_mant_ven_reclamaciones_tipos
integer x = 2016
integer y = 196
integer width = 2565
integer height = 672
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "CAUSAS"
string dataobject = "dw_mant_ven_reclamaciones_causas_tipos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;long donde
choose case f_objeto_datawindow(this)
	case "anyadir"
		if cb_insertar.enabled then					
			donde = this.insertrow(this.rowcount() +1)
			this.object.empresa[donde]          = codigo_empresa
			this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
			this.object.fase_inicial[donde]       = ""
			this.object.situacion_inicial[donde]  = ""
			this.setrow(donde)
			this.scrolltorow(donde)
			this.setcolumn("fase_inicial")
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if		
	case "insertar"
		if cb_insertar.enabled then					
			donde = this.insertrow(this.getrow())
			this.object.empresa[donde]          = codigo_empresa
			this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
			this.object.fase_inicial[donde]       = ""
			this.object.situacion_inicial[donde]  = ""
			this.setrow(donde)
			this.scrolltorow(donde)
			this.setcolumn("fase_inicial")
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if
	case "borrar"
		if cb_insertar.enabled then		
			if this.getrow() > 0 then
				this.deleterow(this.getrow())
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)
			end if			
		end if
	case else
		if not(cb_insertar.enabled) then
			dw_1.triggerevent(clicked!)
		end if
end choose
end event

event itemchanged;string   mensaje_error
boolean  no_valido = false

if dwo.name = "codigo_ven_reclamaciones_causa" then
	//SI ya teniamos fases asignadas no dejaremos cambiar la causa
	if dw_fases.rowcount() > 0 then
		no_valido = true
	end if
	//Aqui chequearemos la integridad
end if

if no_valido then
	messagebox("Atención",mensaje_error)		
	return 2
else
	return 0
end if
end event

event rbuttondown;bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE
CHOOSE CASE bus_campo
	CASE "codigo_ven_reclamaciones_causa"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_causas"
		bus_titulo     = "AYUDA SELECCION DE CAUSAS"
	CASE "fase_inicial"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
	CASE "situacion_inicial"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo     = "AYUDA SELECCION DE SITUACIONES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event retrieveend;long indice,total
string trabajo
total = this.rowcount()

if rowcount > 0 then
	this.event rowfocuschanged(1)
end if
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_filtro_fases,ls_causa

if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	ls_causa = this.object.codigo_ven_reclamaciones_causa[currentrow]
	if isnull(ls_causa) then ls_causa = ''
	ls_filtro_fases = "codigo_ven_reclamaciones_causa = '"+ls_causa+"'"
	
	dw_fases.setredraw(false)
	dw_fases.setfilter(ls_filtro_fases)
	dw_fases.filter()
	dw_fases.sort()
	if dw_fases.rowcount() > 0 then
		dw_fases.event rowfocuschanged(1)
	else
		dw_rutas_fase.setfilter('0 = 1')
		dw_rutas_fase.filter()
	end if
	dw_fases.setredraw(true)
end if
end event

event key;long donde

IF  KeyDown(KeyEscape!) Then Parent.TriggerEvent("ue_esc")
IF  KeyDown(KeyF5!)Then Parent.TriggerEvent("ue_f5")
IF  KeyDown(KeyF2!)Then Parent.TriggerEvent("ue_f2")
IF  KeyDown(KeyF3!)Then Parent.TriggerEvent("ue_f3")

IF  KeyDown(KeyInsert!) THEN
	donde = this.insertrow(this.getrow())
	this.object.empresa[donde]   = codigo_empresa
	this.object.codigo_ven_reclamaciones_tipos[donde] = sle_valor.text
	this.setrow(donde)
	this.scrolltorow(donde)
	this.setcolumn("fase")
END IF

bus_filtro     = ""
bus_titulo     = ""
bus_datawindow = ""
bus_campo      = This.GetColumnName()
valor_empresa  = TRUE

CHOOSE CASE bus_campo
	CASE "codigo_ven_reclamaciones_causa"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_causas"
		bus_titulo     = "AYUDA SELECCION DE CAUSAS"
	CASE "fase_inicial"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		bus_titulo     = "AYUDA SELECCION DE FASES"
	CASE "situacion_inicial"		
		bus_filtro     = ""
		bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo     = "AYUDA SELECCION DE SITUACIONES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::key
end event

