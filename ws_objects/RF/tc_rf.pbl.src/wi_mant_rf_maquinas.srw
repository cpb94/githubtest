$PBExportHeader$wi_mant_rf_maquinas.srw
forward
global type wi_mant_rf_maquinas from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_rf_maquinas
end type
type p_1 from picture within wi_mant_rf_maquinas
end type
end forward

global type wi_mant_rf_maquinas from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 3447
integer height = 560
pb_calculadora pb_calculadora
p_1 p_1
end type
global wi_mant_rf_maquinas wi_mant_rf_maquinas

type variables

end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Parametros de Ventanas RF [ "+f_nombre_empresa(codigo_empresa)+" ]"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

tipo_mantenimiento = 'N'

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
		dw_1.Retrieve(codigo_empresa,sle_valor.text)
	END IF
END IF
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_inserta_fila;call super::ue_inserta_fila;
//dw_1.object.id[1] = long(sle_valor.text))
dw_1.object.empresa[1] = codigo_empresa
dw_1.object.descripcion[1] = ""

//Parametros generales
dw_1.object.texto_ventana[1] = ""
dw_1.object.tipo_ventana[1] = ""
dw_1.object.ayuda_ventana[1] = ""
dw_1.object.texto_paso1[1] = ""
dw_1.object.texto_paso2[1] = ""
dw_1.object.texto_paso3[1] = ""
dw_1.object.ayuda_paso1[1] = ""
dw_1.object.ayuda_paso2[1] = ""
dw_1.object.ayuda_paso3[1] = ""

//Parametros Entrada
dw_1.object.tipo_movimiento_entrada[1] = ""
dw_1.object.sugerir_ubicacion_entrada[1] = ""
dw_1.object.entrada_ubicacion_fija[1] = ""
dw_1.object.almacen_entrada[1] = ""
dw_1.object.zona_entrada[1] = ""
dw_1.object.fila_entrada[1] = 0
dw_1.object.altura_entrada[1] = 0

//Parametros Salida
dw_1.object.tipo_movimiento_salida[1] = ""
dw_1.object.salida_ubicacion_fija[1] = ""
dw_1.object.almacen_salida[1] = ""
dw_1.object.zona_salida[1] = ""
dw_1.object.fila_salida[1] = 0
dw_1.object.altura_salida[1] = 0
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo       =  This.title
longitud     =  len(Trim(sle_valor.text))
if dec(sle_valor.text) > 0 then
	criterio[1]  = trim(sle_valor.text)+space(20-longitud)
else
	criterio[1]  = string(now())//trim(sle_valor.text)+space(20-longitud)
end if
seleccion    =  criterio[1]
tabla        = "rf_maquinas"

if dw_1.Retrieve(codigo_empresa,long(sle_valor.Text)) = 0 then
	
end if

CALL Super::ue_recuperar



end event

on wi_mant_rf_maquinas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.p_1
end on

on wi_mant_rf_maquinas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.p_1)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_actualiza_dw;call super::ue_actualiza_dw;if dw_1.rowcount() = 1 then
	sle_valor.text = string(dw_1.object.id[1])
end if
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_rf_maquinas
integer x = 32
integer y = 132
integer width = 3387
integer height = 260
string title = "Cabecera Orden"
string dataobject = "dw_mant_rf_maquinas"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::itemchanged;call super::itemchanged;/*string ls_descripcion
string ls_almacen,ls_zona
int	 li_fila,li_altura
long   ll_existe,ll_copiar_de,ll_id
str_rf_maquinas lstr_rf_maquinas

CHOOSE CASE dwo.name
	CASE "copiar_de"
		ll_copiar_de = dec(data)
		
		ll_id        = this.object.id[row]
		
		if isnull(ll_id) then ll_id = 0
		
		if ll_copiar_de <> 0 and ll_copiar_de <> ll_id then
			if f_cargar_str_rf_maquinas(ll_copiar_de,lstr_rf_maquinas) then		
				f_inicializar_str_rf_maquinas(lstr_rf_maquinas)
				/*
				this.object.id[row]                              = lstr_rf_maquinas.id
				this.object.empresa[row]                         = lstr_rf_maquinas.empresa
				*/
				if this.object.descripcion[row] = "" or isnull(this.object.descripcion[row]) then
					this.object.descripcion[row]                  = lstr_rf_maquinas.descripcion
				end if
				this.object.texto_ventana[row]                   = lstr_rf_maquinas.texto_ventana
				this.object.tipo_ventana[row]                    = lstr_rf_maquinas.tipo_ventana
				this.object.ayuda_ventana[row]                   = lstr_rf_maquinas.ayuda_ventana
				this.object.texto_paso1[row]                     = lstr_rf_maquinas.texto_paso1
				this.object.texto_paso2[row]                     = lstr_rf_maquinas.texto_paso2
				this.object.texto_paso3[row]                     = lstr_rf_maquinas.texto_paso3
				this.object.ayuda_paso1[row]                     = lstr_rf_maquinas.ayuda_paso1
				this.object.ayuda_paso2[row]                     = lstr_rf_maquinas.ayuda_paso2
				this.object.ayuda_paso3[row]                     = lstr_rf_maquinas.ayuda_paso3
				this.object.tipo_movimiento_entrada[row]         = lstr_rf_maquinas.tipo_movimiento_entrada
				this.object.sugerir_ubicacion_entrada[row]       = lstr_rf_maquinas.sugerir_ubicacion_entrada
				this.object.entrada_ubicacion_fija[row]          = lstr_rf_maquinas.entrada_ubicacion_fija
				this.object.almacen_entrada[row]                 = lstr_rf_maquinas.almacen_entrada
				this.object.zona_entrada[row]                    = lstr_rf_maquinas.zona_entrada
				this.object.fila_entrada[row]                    = lstr_rf_maquinas.fila_entrada
				this.object.altura_entrada[row]                  = lstr_rf_maquinas.altura_entrada
				this.object.tipo_movimiento_salida[row]          = lstr_rf_maquinas.tipo_movimiento_salida
				this.object.salida_ubicacion_fija[row]           = lstr_rf_maquinas.salida_ubicacion_fija
				this.object.almacen_salida[row]                  = lstr_rf_maquinas.almacen_salida
				this.object.zona_salida[row]                     = lstr_rf_maquinas.zona_salida
				this.object.fila_salida[row]                     = lstr_rf_maquinas.fila_salida
				this.object.altura_salida[row]                   = lstr_rf_maquinas.altura_salida
				this.object.permitir_en_bulto_con_lineas[row]    = lstr_rf_maquinas.permitir_en_bulto_con_lineas
				this.object.tipologia_articulo[row]              = lstr_rf_maquinas.tipologia_articulo
				this.object.permitir_en_bulto_de_ubicacion[row]  = lstr_rf_maquinas.permitir_en_bulto_de_ubicacion
				this.object.mostrar_contenido_bulto_entrada[row] = lstr_rf_maquinas.mostrar_contenido_bulto_entrada
				this.object.entrada_consume_cajas[row]           = lstr_rf_maquinas.entrada_consume_cajas
			else
				return 2
			end if
		else
			return 2
		end if
	CASE "id"
		
	CASE "empresa"
		
	CASE "descripcion"
		
	CASE "texto_ventana"
		
	CASE "tipo_ventana"
		choose case data
			case ""		
				
			case ""
				
			case ""
				
		end choose
		
	CASE "ayuda_ventana"
		
	CASE "texto_paso1"
		
	CASE "texto_paso2"
		
	CASE "texto_paso3"
		
	CASE "ayuda_paso1"
		
	CASE "ayuda_paso2"
		
	CASE "ayuda_paso3"
		
	CASE "tipo_movimiento_entrada"
		
		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almtipomov
		WHERE  almtipomov.empresa     = :codigo_empresa
		AND    almtipomov.tipomov     = :data
		AND    almtipomov.codigo_real = 'E';
		
		if ll_existe > 0 then					

		else
			return 2			
		end if								
		
	CASE "sugerir_ubicacion_entrada"
		
	CASE "entrada_ubicacion_fija"
		if data = 'N' then
			this.object.almacen_entrada[row] = ""
			this.object.zona_entrada[row]    = ""
			this.object.fila_entrada[row]    = 0
			this.object.altura_entrada[row]  = 0
		end if
	CASE "almacen_entrada"

		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :data;
			
		if ll_existe > 0 then					
			this.object.zona_entrada[row]   = ""
			this.object.fila_entrada[row]   = 0
			this.object.altura_entrada[row] = 0
		else
			this.object.zona_entrada[row]   = ""
			this.object.fila_entrada[row]   = 0
			this.object.altura_entrada[row] = 0
			return 2			
		end if						
	CASE "zona_entrada"
		ls_almacen = this.object.almacen_entrada[row]

		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :ls_almacen
		AND    almubimapa_codbar.zona    = :data;
			
		if ll_existe > 0 then					
			this.object.fila_entrada[row]   = 0
			this.object.altura_entrada[row] = 0
		else
			this.object.fila_entrada[row]   = 0
			this.object.altura_entrada[row] = 0
			return 2			
		end if				
	CASE "fila_entrada"
		ls_almacen = this.object.almacen_entrada[row]
		ls_zona    = this.object.zona_entrada[row]
		li_fila    = integer(data)
		
		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :ls_almacen
		AND    almubimapa_codbar.zona    = :ls_zona
		AND    almubimapa_codbar.fila    = :li_fila;
			
		if ll_existe > 0 then					
			this.object.altura_entrada[row] = 0
		else
			this.object.altura_entrada[row] = 0
			return 2			
		end if								
	CASE "altura_entrada"
		ls_almacen = this.object.almacen_entrada[row]
		ls_zona    = this.object.zona_entrada[row]
		li_fila    = this.object.fila_entrada[row]
		li_altura  = integer(data)
		
		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :ls_almacen
		AND    almubimapa_codbar.zona    = :ls_zona
		AND    almubimapa_codbar.fila    = :li_fila
		AND    almubimapa_codbar.altura  = :li_altura;
			
		if ll_existe > 0 then					

		else
			return 2			
		end if								
	CASE "tipo_movimiento_salida"
		
		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almtipomov
		WHERE  almtipomov.empresa     = :codigo_empresa
		AND    almtipomov.tipomov     = :data
		AND    almtipomov.codigo_real = 'S';
		
		if ll_existe > 0 then					

		else
			return 2			
		end if								
				
	CASE "salida_ubicacion_fija"
		if data = 'N' then
			this.object.almacen_salida[row] = ""
			this.object.zona_salida[row]    = ""
			this.object.fila_salida[row]    = 0
			this.object.altura_salida[row]  = 0
		end if		
	CASE "almacen_salida"

		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :data;
			
		if ll_existe > 0 then					
			this.object.zona_salida[row]   = ""
			this.object.fila_salida[row]   = 0
			this.object.altura_salida[row] = 0
		else
			this.object.zona_salida[row]   = ""
			this.object.fila_salida[row]   = 0
			this.object.altura_salida[row] = 0
			return 2			
		end if						
	CASE "zona_salida"
		ls_almacen = this.object.almacen_salida[row]

		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :ls_almacen
		AND    almubimapa_codbar.zona    = :data;
			
		if ll_existe > 0 then					
			this.object.fila_salida[row]   = 0
			this.object.altura_salida[row] = 0
		else
			this.object.fila_salida[row]   = 0
			this.object.altura_salida[row] = 0
			return 2			
		end if				
	CASE "fila_salida"
		ls_almacen = this.object.almacen_salida[row]
		ls_zona    = this.object.zona_salida[row]
		li_fila    = integer(data)
		
		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :ls_almacen
		AND    almubimapa_codbar.zona    = :ls_zona
		AND    almubimapa_codbar.fila    = :li_fila;
			
		if ll_existe > 0 then					
			this.object.altura_salida[row] = 0
		else
			this.object.altura_salida[row] = 0
			return 2			
		end if						
	CASE "altura_salida"
		ls_almacen = this.object.almacen_salida[row]
		ls_zona    = this.object.zona_salida[row]
		li_fila    = this.object.fila_salida[row]
		li_altura  = integer(data)
		
		SELECT isnull(count(*),0)
		INTO   :ll_existe
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :codigo_empresa
		AND    almubimapa_codbar.almacen = :ls_almacen
		AND    almubimapa_codbar.zona    = :ls_zona
		AND    almubimapa_codbar.fila    = :li_fila
		AND    almubimapa_codbar.altura  = :li_altura;
			
		if ll_existe > 0 then					

		else
			return 2			
		end if						
END CHOOSE
*/
/*

		SELECT almubimapa_codbar.id 
		FROM   almubimapa_codbar
		WHERE  almubimapa_codbar.empresa = :
		AND    almubimapa_codbar.almacen = :
		AND    almubimapa_codbar.zona    = :
		AND    almubimapa_codbar.fila    = :
		AND    almubimapa_codbar.altura  = : 
		AND    almubimapa_codbar.activo  = :;


CASE "id"
CASE "empresa"
CASE "descripcion"
CASE "texto_ventana"
CASE "tipo_ventana"
CASE "ayuda_ventana"
CASE "texto_paso1"
CASE "texto_paso2"
CASE "texto_paso3"
CASE "ayuda_paso1"
CASE "ayuda_paso2"
CASE "ayuda_paso3"
CASE "tipo_movimiento_entrada"
CASE "sugerir_ubicacion_entrada"
CASE "entrada_ubicacion_fija"
CASE "almacen_entrada"
CASE "zona_entrada"
CASE "fila_entrada"
CASE "altura_entrada"
CASE "tipo_movimiento_salida"
CASE "salida_ubicacion_fija"
CASE "almacen_salida"
CASE "zona_salida"
CASE "fila_salida"
CASE "altura_salida"
*/
end event

event dw_1::key;bus_filtro    = ""
bus_titulo    = ""
valor_empresa = TRUE
bus_campo     = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "copiar_de"
		bus_titulo     = "AYUDA SELECCION PARAMETROS RF"
		bus_datawindow = "dw_ayuda_rf_maquinas"
		bus_filtro     =  ""
	CASE "tipo_movimiento_entrada"	
		bus_datawindow = "dw_ayuda_almtipomov_entradas"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE MOVIMIENTOS"
	CASE "almacen_entrada"
		bus_datawindow = "dw_ayuda_almacenes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE ALMACENES"
	CASE "zona_entrada"
		bus_datawindow = "dw_ayuda_almubizonas"	
		bus_filtro     = "almacen ='"+This.GetItemString(This.GetRow(),"almacen_entrada")+"'"
		bus_titulo     = "VENTANA SELECCION DE ZONAS"
	CASE "tipo_movimiento_salida"
 		bus_datawindow = "dw_ayuda_almtipomov_salidas"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE MOVIMIENTOS"			
	CASE "almacen_salida"	
		bus_datawindow = "dw_ayuda_almacenes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE ALMACENES"			
	CASE "zona_salida"
		bus_datawindow = "dw_ayuda_almubizonas"	
		bus_filtro     = "almacen ='"+This.GetItemString(This.GetRow(),"almacen_salida")+"'"
		bus_titulo     = "VENTANA SELECCION DE ZONAS"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = dwo.name
 valor_empresa = TRUE
 
CHOOSE CASE bus_campo
	CASE "copiar_de"
		bus_titulo     = "AYUDA SELECCION PARAMETROS RF"
		bus_datawindow = "dw_ayuda_rf_maquinas"
		bus_filtro     =  ""		
	CASE "tipo_movimiento_entrada"	
		bus_datawindow = "dw_ayuda_almtipomov_entradas"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE MOVIMIENTOS"
	CASE "almacen_entrada"
		bus_datawindow = "dw_ayuda_almacenes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE ALMACENES"
	CASE "zona_entrada"
		bus_datawindow = "dw_ayuda_almubizonas"	
		bus_filtro     = "almacen ='"+This.GetItemString(This.GetRow(),"almacen_entrada")+"'"
		bus_titulo     = "VENTANA SELECCION DE ZONAS"
	CASE "tipo_movimiento_salida"
 		bus_datawindow = "dw_ayuda_almtipomov_salidas"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE MOVIMIENTOS"			
	CASE "almacen_salida"	
		bus_datawindow = "dw_ayuda_almacenes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE ALMACENES"			
	CASE "zona_salida"
		bus_datawindow = "dw_ayuda_almubizonas"	
		bus_filtro     = "almacen ='"+This.GetItemString(This.GetRow(),"almacen_salida")+"'"
		bus_titulo     = "VENTANA SELECCION DE ZONAS"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
 
 CALL Super::rbuttondown
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_rf_maquinas
integer x = 23
integer y = 24
integer width = 123
string text = "ID"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_rf_maquinas
integer x = 2080
integer y = 20
end type

event cb_insertar::clicked;call super::clicked;//if isnull(dw_1.object.fecha[1]) then
//	messagebox("Campo Obligatorio","Debe indicar la fecha de carga.")
//	return false
//else
//	return true
//end if

end event

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_rf_maquinas
integer x = 2482
integer y = 20
end type

event cb_borrar::clicked;
call super::clicked

end event

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_rf_maquinas
integer x = 146
integer y = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION MAQUINAS RF"
ue_datawindow     = "dw_ayuda_rf_maquinas"
ue_filtro         =  ""
valor_empresa     = true
isle_campo        = This

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_rf_maquinas
integer x = 2885
integer y = 20
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_rf_maquinas
end type

type pb_calculadora from u_calculadora within wi_mant_rf_maquinas
integer x = 425
integer y = 16
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled = TRUE THEN Return

//long ll_id
//
//ll_id = 0//f_contador_ordenes_carga("contador_ordenes_carga",1)
//
//sle_valor.text = string(ll_id,"####0")
//
//dw_1.event clicked(0,0,0,dw_1.object.empresa)
//
sle_valor.text = "0"
dw_1.reset()

//dw_1.event clicked(0,0,0,dw_1.object.empresa)
//cb_insertar.event clicked()
cb_insertar.enabled   = TRUE
cb_borrar.enabled     = FALSE
Parent.TriggerEvent("ue_desactiva_claves")
control_tabulador.enabled = FALSE
		
parent.event ue_inserta_fila(0,0)
end event

type p_1 from picture within wi_mant_rf_maquinas
integer x = 3314
integer y = 20
integer width = 101
integer height = 88
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\Print_24x24.png"
boolean border = true
boolean focusrectangle = false
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = "ID "+sle_valor.text
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

//Con esto forzamos a que el reporte se ajuste al tamaño del papel
//dw_1.Object.DataWindow.Zoom = 100//75

u_imp.event ue_imprimir(dw_1)

destroy u_imp

//dw_1.Object.DataWindow.Zoom = 133//100

end event

