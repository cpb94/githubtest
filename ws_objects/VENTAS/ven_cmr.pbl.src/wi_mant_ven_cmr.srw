$PBExportHeader$wi_mant_ven_cmr.srw
forward
global type wi_mant_ven_cmr from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_ven_cmr
end type
type dw_albaranes from datawindow within wi_mant_ven_cmr
end type
type sle_anyo from u_em_campo within wi_mant_ven_cmr
end type
type st_almacen from statictext within wi_mant_ven_cmr
end type
type dw_listado_cmr from datawindow within wi_mant_ven_cmr
end type
type pb_imprimir from picturebutton within wi_mant_ven_cmr
end type
type gb_1 from groupbox within wi_mant_ven_cmr
end type
end forward

global type wi_mant_ven_cmr from wi_mvent_con_empresa
integer width = 2331
integer height = 2020
pb_calculadora pb_calculadora
dw_albaranes dw_albaranes
sle_anyo sle_anyo
st_almacen st_almacen
dw_listado_cmr dw_listado_cmr
pb_imprimir pb_imprimir
gb_1 gb_1
end type
global wi_mant_ven_cmr wi_mant_ven_cmr

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"ejercicio",dec(sle_anyo.text))
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

dw_1.object.cliente[1] = ''   
dw_1.object.fecha[1] = datetime(today())  
dw_1.object.direccion_envio[1] = ''
dw_1.object.transportista[1] = ''
dw_1.object.matricula[1] = ''
dw_1.object.remolque[1] = ''
dw_1.object.cond_entrega[1] = ''
dw_1.object.peso_bruto[1] = 0
dw_1.object.bultos[1] = 0
dw_1.object.peso_bruto_muestras[1] = 0
dw_1.object.bultos_muestras[1] = 0
dw_1.object.albaranes[1] = 0
dw_1.object.albaranes_muestras[1] = 0
dw_1.object.venconductores_codigo[1] = '' 
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
string ls_cliente
datetime ldt_fecha

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "venpartidas"


dw_albaranes.Reset()
IF dw_1.Retrieve(codigo_empresa,dec(sle_anyo.text),sle_valor.Text) <> 0 Then
	ls_cliente = dw_1.object.cliente[1]
	ldt_fecha  = dw_1.object.fecha[1]
	dw_albaranes.Retrieve(codigo_empresa,ls_cliente,dec(sle_anyo.text),sle_valor.Text,ldt_fecha)
END IF
CALL Super::ue_recuperar
end event

event open;call super::open;integer li_anyo

istr_parametros.s_titulo_ventana = "Mantenimiento de CMRS"
istr_parametros.s_listado        = ""
This.title = istr_parametros.s_titulo_ventana
dw_listado_cmr.SetTransObject(SQLCA)
dw_albaranes.SetTransObject(SQLCA)

li_anyo = year(today())
sle_anyo.text = string(li_anyo)
	
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_anyo.text  = istr_parametros.s_argumentos[2]
	sle_valor.text = istr_parametros.s_argumentos[3]
	istr_parametros.i_nargumentos=0
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		This.TriggerEvent("ue_recuperar")
	END IF
END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_ven_cmr.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_albaranes=create dw_albaranes
this.sle_anyo=create sle_anyo
this.st_almacen=create st_almacen
this.dw_listado_cmr=create dw_listado_cmr
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_albaranes
this.Control[iCurrent+3]=this.sle_anyo
this.Control[iCurrent+4]=this.st_almacen
this.Control[iCurrent+5]=this.dw_listado_cmr
this.Control[iCurrent+6]=this.pb_imprimir
this.Control[iCurrent+7]=this.gb_1
end on

on wi_mant_ven_cmr.destroy
call super::destroy
destroy(this.pb_calculadora)
destroy(this.dw_albaranes)
destroy(this.sle_anyo)
destroy(this.st_almacen)
destroy(this.dw_listado_cmr)
destroy(this.pb_imprimir)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_borra_fila;Integer anyo
string  ls_cmr

anyo = Dec(sle_anyo.text)
ls_cmr = sle_valor.text

Delete from  ven_cmr_lineas
Where  empresa   = :codigo_empresa
And    ejercicio = :anyo
And    codigo    = :ls_cmr;

call super::ue_borra_fila
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_ven_cmr
integer x = 23
integer y = 228
integer width = 2281
integer height = 1084
string dataobject = "dw_mant_ven_cmr1"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;//String par
//		IF GetRow() = 0 Then Return
//		par = GetItemString(GetRow(),"valor2")
//		IF IsNUll(par) Then par = ""
//		
//		AccepTText()
//		IF Trim(par)= "" Then
//			SetItem(GetRow(),"valor2",GetItemString(GetRow(),"valor1"))
//		END IF
//
end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	valor_empresa = TRUE	
	bus_filtro=""
	bus_titulo=""
	bus_campo = This.GetColumnName()
	
	CHOOSE CASE bus_campo
		CASE "cliente"
			bus_datawindow = "dw_ayuda_clientes"
			bus_filtro     = ""
			bus_titulo = "VENTANA SELECCION DE CLIENTES"	
		CASE "subcliente"
			bus_filtro     = " crm_tercero_codigo = 'C"+this.object.cliente[this.getrow()]+"'"
			bus_datawindow = "dw_ayuda_contactos_crm"
			bus_titulo     = "VENTANA SELECCION DE CONTACTOS"						
		CASE "cond_entrega"
			bus_datawindow = "dw_ayuda_vencondentrega"
			bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"			
		CASE "direccion_envio"
			bus_datawindow = "dw_ayuda_venenvio"
			bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
			bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		CASE "transportista"
			bus_datawindow = "dw_ayuda_ventransportistas"
			bus_titulo = "VENTANA SELECCION TRANSPORTISTAS"
			bus_filtro = ""		
		case "venconductores_codigo"	
			bus_titulo     = "AYUDA SELECCION CONDUCTORES"
			bus_datawindow = "dw_ayuda_venconductores"
			bus_filtro     = " transportista = '" +this.object.transportista[this.getrow()] + "'"				  
		CASE ELSE
			SetNull(bus_campo)
	END CHOOSE
	
	CALL Super::Key

END IF

end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = dwo.name
 valor_empresa = TRUE
 
CHOOSE CASE bus_campo
	CASE "cliente"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"	
	CASE "subcliente"
		bus_filtro     = " crm_tercero_codigo = 'C"+this.object.cliente[this.getrow()]+"'"
		bus_datawindow = "dw_ayuda_contactos_crm"
		bus_titulo     = "VENTANA SELECCION DE CONTACTOS"					
	CASE "cond_entrega"
		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"			
	CASE "direccion_envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "transportista"
		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION TRANSPORTISTAS"
		bus_filtro = ""		
	case "venconductores_codigo"	
		bus_titulo     = "AYUDA SELECCION CONDUCTORES"
		bus_datawindow = "dw_ayuda_venconductores"
		bus_filtro     = " transportista = '" +this.object.transportista[this.getrow()] + "'"				  
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
 
 CALL Super::rbuttondown
end event

event dw_1::itemchanged;call super::itemchanged;string cliente,ls_direccion_envio,ls_cond_entrega,ls_codigo
long   ll_ejercicio,ll_lineas
boolean control_itemchanged = true				
if control_itemchanged then	
	choose case dwo.name
		case "cliente"	
			cliente = data
			ll_ejercicio = dec(sle_anyo.text)
			ls_codigo    = sle_valor.text
			
			select isnull(count(*),0)
			into   :ll_lineas
			from   ven_cmr_lineas
			where  empresa   = :codigo_empresa
			and    ejercicio = :ll_ejercicio
			and    codigo    = :ls_codigo;
			
			if ll_lineas > 0 then
				return 2
			else
				
				if isnull(cliente) then cliente = ""
				
				if trim(cliente) <> "" then
					select envio,		cod_entrega
					into   :ls_direccion_envio,	:ls_cond_entrega
					from   venclientes
					where  empresa = :codigo_empresa
					and    codigo  = :cliente;
					
					if sqlca.sqlcode <> 0 then
						messagebox("Atención","Error en la selección del cliente ~n"+sqlca.sqlerrtext,StopSign!)
						return 2
					else
	
						if isnull(ls_direccion_envio) then ls_direccion_envio = ""
						if isnull(ls_cond_entrega) then ls_cond_entrega = ""
	
						
						this.object.direccion_envio[row] = ls_direccion_envio
						this.object.cond_entrega[row]    = ls_cond_entrega
					end if			    			
				end if
			end if
	end choose	
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_ven_cmr
integer x = 434
integer y = 132
integer width = 201
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_ven_cmr
integer x = 1266
integer y = 120
integer width = 343
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_ven_cmr
integer x = 1609
integer y = 120
integer width = 343
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_ven_cmr
integer x = 635
integer y = 128
integer width = 238
integer height = 80
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_ven_cmr_cabecera"
ue_titulo     =  "AYUDA SELECCION CMRS"
ue_filtro     =  "ejercicio = "+sle_anyo.text
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_ven_cmr
integer x = 1957
integer y = 120
integer width = 329
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_ven_cmr
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_ven_cmr
integer width = 2053
end type

type pb_calculadora from u_calculadora within wi_mant_ven_cmr
integer x = 882
integer y = 116
integer taborder = 0
end type

event clicked;call super::clicked;Integer li_anyo
string  ls_cmr

IF cb_insertar.enabled=TRUE THEN Return
 
li_anyo = dec(sle_anyo.text) 
if li_anyo = 0 then
	li_anyo = year(today())
	sle_anyo.text = string(li_anyo)
end if
ls_cmr = f_nuevo_cmr(codigo_empresa,li_anyo)
sle_valor.text = ls_cmr
dw_1.TriggerEvent("Clicked")
end event

type dw_albaranes from datawindow within wi_mant_ven_cmr
integer x = 23
integer y = 1316
integer width = 2281
integer height = 612
boolean bringtotop = true
string dataobject = "dw_mant_ven_cmr2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//String partida,familia
//IF row = 0 Then Return
//partida = sle_valor.text
//familia = GetItemString(row,"codigo")
//IF  f_venpartidas_familia(codigo_empresa,partida,familia) then
//	delete from venpartidasfamilias
//	where empresa = :codigo_empresa
//	And   partida = :partida
//	And   familia = :familia;
//	COMMIT;
//ELSE
//	INSERT INTo venpartidasfamilias VALUES (:codigo_empresa,:partida,:familia);
//	COMMIT;
//END IF
//dw_albaranes.SetItem(row,"empresa",codigo_empresa)
end event

event itemchanged;long   ll_anyo,ll_albaran,ll_albaran_en_otro_cmr
string ls_ventaspromocion

if dwo.name = 'marcado' then
	if data = 'S' then
		if cb_insertar.enabled then
			cb_insertar.event clicked()
		end if
				
		ll_anyo            = this.object.anyo[row]
		ll_albaran         = this.object.albaran[row]
		ls_ventaspromocion = this.object.ventaspromocion[row]		
		
		ll_albaran_en_otro_cmr = 0
		
		select isnull(count(*),0)
		into   :ll_albaran_en_otro_cmr
		from   ven_cmr_lineas
		where  empresa           = :codigo_empresa
		and    ejercicio_albaran = :ll_anyo
		and    albaran           = :ll_albaran
		and    ventaspromocion   = :ls_ventaspromocion;
		
		if ll_albaran_en_otro_cmr = 0 then			
			f_anyade_albaran_a_cmr(codigo_empresa,dec(sle_anyo.text),sle_valor.text,ls_ventaspromocion,ll_anyo,ll_albaran)		
		else
			messagebox("¡Atención!","El albarán que esta marcando ya pertenece a otro cmr.")
			return 2
		end if
	else
		if cb_insertar.enabled then
			cb_insertar.event clicked()
		end if
		
		ll_anyo            = this.object.anyo[row]
		ll_albaran         = this.object.albaran[row]
		ls_ventaspromocion = this.object.ventaspromocion[row]
		
		f_elimina_albaran_de_cmr(codigo_empresa,dec(sle_anyo.text),sle_valor.text,ls_ventaspromocion,ll_anyo,ll_albaran)
	end if	
	
	dw_1.Retrieve(codigo_empresa,dec(sle_anyo.text),sle_valor.Text)
end if
end event

type sle_anyo from u_em_campo within wi_mant_ven_cmr
integer x = 165
integer y = 128
integer width = 242
integer height = 80
integer taborder = 20
boolean bringtotop = true
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event getfocus;call super::getfocus;sle_valor.text = ""

end event

type st_almacen from statictext within wi_mant_ven_cmr
integer x = 27
integer y = 132
integer width = 123
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_listado_cmr from datawindow within wi_mant_ven_cmr
boolean visible = false
integer y = 12
integer width = 457
integer height = 88
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_list_cmr"
boolean border = false
boolean livescroll = true
end type

type pb_imprimir from picturebutton within wi_mant_ven_cmr
integer x = 997
integer y = 116
integer width = 114
integer height = 96
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\imp32.bmp"
alignment htextalign = left!
end type

event clicked;f_imprimir_cmr_previsualizacion(codigo_empresa,dec(sle_anyo.text),sle_valor.text,dw_listado_cmr)
end event

type gb_1 from groupbox within wi_mant_ven_cmr
integer x = 1253
integer y = 84
integer width = 1047
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

