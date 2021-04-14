$PBExportHeader$w_mant_ticket_inkcid.srw
forward
global type w_mant_ticket_inkcid from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_ticket_inkcid
end type
type cb_duplicar from commandbutton within w_mant_ticket_inkcid
end type
end forward

global type w_mant_ticket_inkcid from wi_mvent_con_empresa
integer width = 2318
integer height = 1528
pb_calculadora pb_calculadora
cb_duplicar cb_duplicar
end type
global w_mant_ticket_inkcid w_mant_ticket_inkcid

type variables
boolean volver_a_descripcion_abr
end variables

on w_mant_ticket_inkcid.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.cb_duplicar=create cb_duplicar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.cb_duplicar
end on

on w_mant_ticket_inkcid.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.cb_duplicar)
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_duplicar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana = "Mantenimiento tickets inkcid"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		This.TriggerEvent("ue_recuperar")
	END IF
END IF
f_activar_campo(sle_valor)

end event

event ue_inserta_fila;call super::ue_inserta_fila;datetime fecha

fecha = datetime(today())

dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"desticket_fecha",fecha)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "desticket"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;		
	pb_calculadora.visible = TRUE
	cb_duplicar.visible = true;
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
cb_duplicar.visible = false;
end event

event close;call super::close;
delete from uti_colisiones
where empresa = :codigo_empresa 
and tabla = "desticket"
and usuario = :nombre_usuario
using sqlca;

if sqlca.sqlcode <> 0 then
	rollback using sqlca;
	messagebox("Error","Error borrando colisiones")
else
	commit using sqlca;
end if

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_ticket_inkcid
integer x = 82
integer y = 236
integer width = 2112
integer height = 1092
string dataobject = "dw_mant_ticket_inkcid"
boolean border = true
end type

event dw_1::itemchanged;call super::itemchanged;string tecnico_lab

IF dwo.Name = "tecnico" THEN
	select descripcion
	into :tecnico_lab
	from tecnico_lab
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_1.object.tecnico_lab_descripcion[row] = tecnico_lab
	
END IF

if dwo.name = "esmalte" then
		dw_1.object.prodformula_descripcion_laboratorio[row] = f_nombre_formulacion_laboratorio (codigo_empresa,data)
end if
	
IF dwo.Name = "base" THEN
	dw_1.object.articulos_descripcion[row] = f_nombre_articulo (codigo_empresa,data)
END IF

IF dwo.Name = "desticket_tipo_maquina" THEN
	select descripcion
	into :tecnico_lab
	from tipomaquina_disenyo
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_1.object.tipomaquina_disenyo_descripcion[row] = tecnico_lab
	
END IF





end event

event dw_1::key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
CASE "tecnico"
	bus_titulo     = "VENTANA SELECCION TÉCNICOS "
	bus_datawindow = "dw_ayuda_tecnicos_lab"
	bus_filtro = ""

CASE "esmalte"
	bus_titulo     = "AYUDA SELECCION FORMULAS"
	bus_datawindow = "dw_ayuda_prodformulaciones"
	bus_filtro     = "" 	

CASE "desticket_tipo_maquina"
	bus_titulo     = "AYUDA SELECCION ARTÍCULOS"
	bus_datawindow = "dw_ayuda_articulos"
	bus_filtro     = "" 	
	
	consulta_busqueda =     "  SELECT tipomaquina_disenyo.codigo, tipomaquina_disenyo.descripcion "+&
									"  FROM   tipomaquina_disenyo   "+&
									"  WHERE  tipomaquina_disenyo.empresa = '"+codigo_empresa+"'"+&
									"  ORDER BY tipomaquina_disenyo.descripcion ASC  "
		
		
		busqueda.consulta = consulta_busqueda
		busqueda.titulos[1] = "Código"
		busqueda.titulos[2] = "Descripción"
		This.accepttext()
		bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
		if KeyDown(KeyTab!) then
			if not isnull(bus_cadena) and bus_cadena <> "" then
				busqueda.filtro = bus_cadena
				if Long(busqueda.filtro) = 0 then
					busqueda.filtro_es_codigo = false
				else
					busqueda.filtro_es_codigo = true
				end if
			end if
		end if
		
		IF KeyDown(KeyEnter!) or KeyDown(KeyTab!) THEN  
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado = -1 then
				MessageBox("Error en la creación de la búsqueda",resultado.error)
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(bus_cadena)
				AcceptText()
			elseif resultado.resultado > 0 then				
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(resultado.valores[1])
				AcceptText()
			else
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(bus_cadena)
				AcceptText()
			end if
		END IF
		Return
		
CASE "base"
	bus_titulo     = "AYUDA SELECCION ARTÍCULOS"
	bus_datawindow = "dw_ayuda_articulos"
	bus_filtro     = "" 	
	
	consulta_busqueda =     "  SELECT articulos.codigo, articulos.descripcion, formatos.abreviado, genter.razon "+&
									"  FROM   articulos,   "+&
									"			 genter,"+&
									"			 formatos "+&
									"   WHERE articulos.uso = '1' and "+&
									"         (articulos.empresa = '"+codigo_empresa+"') and "+&
									"			 (articulos.empresa *= formatos.empresa and articulos.formato *= formatos.codigo) and "+&
									"			 (articulos.empresa *= genter.empresa and articulos.cliente *= genter.codigo and genter.tipoter = 'C')"+&
									"   ORDER BY articulos.descripcion ASC  "
		
		
		busqueda.consulta = consulta_busqueda
		busqueda.titulos[1] = "Código"
		busqueda.titulos[2] = "Descripción"
		busqueda.titulos[3] = "Formato"
		busqueda.titulos[4] = "Cliente"
		This.accepttext()
		bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
		if KeyDown(KeyTab!) then
			if not isnull(bus_cadena) and bus_cadena <> "" then
				busqueda.filtro = bus_cadena
				if Long(busqueda.filtro) = 0 then
					busqueda.filtro_es_codigo = false
				else
					busqueda.filtro_es_codigo = true
				end if
			end if
		end if
		
		IF KeyDown(KeyEnter!) or KeyDown(KeyTab!) THEN  
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado = -1 then
				MessageBox("Error en la creación de la búsqueda",resultado.error)
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(bus_cadena)
				AcceptText()
			elseif resultado.resultado > 0 then				
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(resultado.valores[1])
				AcceptText()
			else
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(bus_cadena)
				AcceptText()
			end if
		END IF
		Return

CASE ELSE
		SetNull(bus_campo)	
END CHOOSE

CALL Super::Key


end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
CASE "tecnico"
	bus_titulo     = "VENTANA SELECCION TÉCNICOS "
	bus_datawindow = "dw_ayuda_tecnicos_lab"
	bus_filtro = ""

CASE "esmalte"
	bus_titulo     = "AYUDA SELECCION FORMULAS"
	bus_datawindow = "dw_ayuda_prodformulaciones"
	bus_filtro     = "" 	

CASE "base"
	bus_titulo     = "AYUDA SELECCION ARTÍCULOS"
	bus_datawindow = "dw_ayuda_articulos"
	bus_filtro     = "" 	
	
	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_ticket_inkcid
integer x = 41
integer y = 132
integer width = 288
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_ticket_inkcid
integer x = 1193
integer y = 128
integer width = 329
integer height = 88
end type

event cb_insertar::clicked;if dw_1.getrow() > 0 then
	if String(dw_1.object.base[dw_1.getrow()]) = "" then
		MessageBox("Error","Debe introducir la base")
		return
	end if
end if

CALL super::Clicked

if reg_insertado = true then
	delete from uti_colisiones
	where empresa = :codigo_empresa 
	and tabla = "desticket"
	and usuario = :nombre_usuario ;
	
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		messagebox("Error","Error borrando colisiones")
	else
		commit using sqlca;
	end if
	
end if
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_ticket_inkcid
integer x = 1527
integer y = 128
integer width = 329
integer height = 88
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_ticket_inkcid
integer x = 343
integer y = 128
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE TICKETS INKCID"
ue_datawindow = "dw_ayuda_ticked_inkcid"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_ticket_inkcid
integer x = 1861
integer y = 128
integer width = 329
integer height = 88
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_ticket_inkcid
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_ticket_inkcid
integer x = 2190
integer y = 1264
integer width = 101
integer height = 72
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_ticket_inkcid
integer width = 2350
end type

type pb_calculadora from u_calculadora within w_mant_ticket_inkcid
integer x = 613
integer y = 120
integer width = 114
integer height = 100
integer taborder = 11
boolean originalsize = false
end type

event clicked;long codigo

//codigo = f_colisiones( "desticket", "codigo", "")
//codigo = f_colisiones2(codigo_empresa, "desticket", "codigo", "",true)

codigo = f_colisiones2(codigo_empresa, "desticket", "codigo", "",true)

if codigo = 0  then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=string(codigo)
	dw_1.triggerEvent("clicked")
end if

this.TriggerEvent("ue_activa_claves")



end event

type cb_duplicar from commandbutton within w_mant_ticket_inkcid
integer x = 818
integer y = 128
integer width = 329
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Duplicar"
end type

event clicked;string tecnico, esmalte, base, pantallas, urgente, modo_impresion, observaciones, desticket_modelo, desticket_prueba, desticket_tipo_maquina
dec cantidad
datetime desticket_fecha

dw_1.accepttext()
if cb_insertar.enabled then
	cb_insertar.triggerevent (clicked!)
end if

if dw_1.rowcount() = 1 then
	tecnico = dw_1.object.tecnico[1]
	esmalte = dw_1.object.esmalte[1]
	base = dw_1.object.base[1]
	cantidad = dw_1.object.cantidad[1]
	desticket_fecha = datetime (today())
	pantallas = dw_1.object.pantallas[1]
	urgente = dw_1.object.urgente[1]
	modo_impresion = dw_1.object.modo_impresion[1]
	observaciones = dw_1.object.observaciones[1]
	desticket_modelo = dw_1.object.desticket_modelo[1]
	desticket_tipo_maquina = dw_1.object.desticket_tipo_maquina[1]
	desticket_prueba = dw_1.object.desticket_prueba[1]
	
	pb_calculadora.triggerevent (clicked!)
	
	dw_1.object.tecnico[1] = tecnico
	dw_1.object.esmalte[1] = esmalte
	dw_1.object.base[1] = base
	dw_1.object.cantidad[1] = cantidad
	dw_1.object.desticket_fecha[1] = desticket_fecha 
	dw_1.object.pantallas[1] = pantallas
	dw_1.object.urgente[1] = urgente
	dw_1.object.modo_impresion[1] = modo_impresion
	dw_1.object.observaciones[1] = observaciones
	dw_1.object.desticket_modelo[1] = desticket_modelo
	dw_1.object.desticket_tipo_maquina[1] = desticket_tipo_maquina
	dw_1.object.desticket_prueba[1] = desticket_prueba
	
end if





end event

