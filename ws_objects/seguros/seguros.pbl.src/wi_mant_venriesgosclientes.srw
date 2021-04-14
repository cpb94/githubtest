$PBExportHeader$wi_mant_venriesgosclientes.srw
forward
global type wi_mant_venriesgosclientes from wi_mvent_con_empresa
end type
type st_3 from statictext within wi_mant_venriesgosclientes
end type
type em_companyia from u_em_campo within wi_mant_venriesgosclientes
end type
type st_nombrecompanyia from statictext within wi_mant_venriesgosclientes
end type
type st_nombrecliente from statictext within wi_mant_venriesgosclientes
end type
type dw_detalle from datawindow within wi_mant_venriesgosclientes
end type
type cb_1 from commandbutton within wi_mant_venriesgosclientes
end type
type em_fecha_fra from u_em_campo within wi_mant_venriesgosclientes
end type
type st_2 from statictext within wi_mant_venriesgosclientes
end type
type cb_borrar_historico from commandbutton within wi_mant_venriesgosclientes
end type
type cb_2 from commandbutton within wi_mant_venriesgosclientes
end type
end forward

global type wi_mant_venriesgosclientes from wi_mvent_con_empresa
integer width = 3378
integer height = 1744
st_3 st_3
em_companyia em_companyia
st_nombrecompanyia st_nombrecompanyia
st_nombrecliente st_nombrecliente
dw_detalle dw_detalle
cb_1 cb_1
em_fecha_fra em_fecha_fra
st_2 st_2
cb_borrar_historico cb_borrar_historico
cb_2 cb_2
end type
global wi_mant_venriesgosclientes wi_mant_venriesgosclientes

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
string     ant_situacion
dec        ant_riesgo,ant_riesgo_solicitado
datetime ant_fecha_concedido,ant_fecha_solicitado
end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de riesgos por cliente"
istr_parametros.s_listado        = "report_riesgos_clientes"
This.title = istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_companyia.text = istr_parametros.s_argumentos[2]
	em_companyia.TriggerEvent("modificado")
	sle_valor.text    = istr_parametros.s_argumentos[3]
	sle_valor.TriggerEvent("modificado")
	IF len(sle_valor.text) <> 0  and len(em_companyia.text)<> 0  Then
		This.TriggerEvent("ue_recuperar")
		f_activar_campo(sle_valor)
	END IF
END IF

	
end event

event ue_activa_claves;call super::ue_activa_claves;em_companyia.enabled        = TRUE


end event

event ue_desactiva_claves;call super::ue_desactiva_claves;em_companyia.enabled     = FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"companyia",em_companyia.text)
dw_1.setitem(dw_1.getrow(),"concedido","E")
dw_1.setitem(dw_1.getrow(),"cuenta",f_cuenta_genter(codigo_empresa,"C",sle_valor.text))
dw_1.setitem(dw_1.getrow(),"cliente",sle_valor.text)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_companyia.text))
criterio[2]   =  trim(em_companyia.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         = "venriesgoclientes"

dw_1.Retrieve(codigo_empresa,em_companyia.text,sle_valor.Text)

if dw_1.rowcount() = 1 then
	ant_situacion         = dw_1.object.concedido[1]
	ant_riesgo            = dw_1.object.riesgo_concedido[1]
	ant_fecha_concedido   = dw_1.object.fecha_concedido[1]
	ant_riesgo_solicitado = dw_1.object.riesgo_solicitado[1]
	ant_fecha_solicitado  = dw_1.object.fecha_solicitado[1]
else
	ant_situacion         = ""
	ant_riesgo            = 0
	setnull(ant_fecha_concedido)
	ant_riesgo_solicitado = 0
	setnull(ant_fecha_solicitado)
end if

dw_detalle.Retrieve(codigo_empresa,em_companyia.text,sle_valor.text)
cb_borrar_historico.enabled = false

CALL Super::ue_recuperar

end event

on wi_mant_venriesgosclientes.create
int iCurrent
call super::create
this.st_3=create st_3
this.em_companyia=create em_companyia
this.st_nombrecompanyia=create st_nombrecompanyia
this.st_nombrecliente=create st_nombrecliente
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.em_fecha_fra=create em_fecha_fra
this.st_2=create st_2
this.cb_borrar_historico=create cb_borrar_historico
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.em_companyia
this.Control[iCurrent+3]=this.st_nombrecompanyia
this.Control[iCurrent+4]=this.st_nombrecliente
this.Control[iCurrent+5]=this.dw_detalle
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.em_fecha_fra
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_borrar_historico
this.Control[iCurrent+10]=this.cb_2
end on

on wi_mant_venriesgosclientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.em_companyia)
destroy(this.st_nombrecompanyia)
destroy(this.st_nombrecliente)
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.em_fecha_fra)
destroy(this.st_2)
destroy(this.cb_borrar_historico)
destroy(this.cb_2)
end on

event ue_actualiza_dw;long     orden
dec      riesgo,riesgo_solicitado
datetime fecha_concedido,fecha_solicitado
string   situacion,situacion_his,companyia,cliente
boolean  bien = true

companyia = em_companyia.text
cliente   = sle_valor.text

situacion         = dw_1.object.concedido[1]
riesgo            = dw_1.object.riesgo_concedido[1]
fecha_concedido   = dw_1.object.fecha_concedido[1]
riesgo_solicitado = dw_1.object.riesgo_solicitado[1]
fecha_solicitado  = dw_1.object.fecha_solicitado[1]

Select Max(orden) 
Into   :orden 
From   venriesgoclienteshis  
Where  empresa   = :codigo_empresa
And    companyia = :companyia
And    cliente   = :cliente;

IF IsNull(orden) Then orden = 0

if ant_riesgo_solicitado <> riesgo_solicitado or &
	fecha_solicitado <> ant_fecha_solicitado 	or &
	(not(isnull(fecha_solicitado)) and isnull(ant_fecha_solicitado)) then
	orden ++
	situacion_his = "Solicitado"
	
	INSERT INTO venriesgoclienteshis
		(empresa, 				companyia, 				cliente, 				orden, 
		 situacion, 			fecha, 					riesgo)
	VALUES
		(:codigo_empresa, 	:companyia, 			:cliente, 				:orden, 
		 :situacion_his, 		:fecha_solicitado, 	:riesgo_solicitado);
		 
	if sqlca.sqlcode <> 0 then
		rollback;
		bien = false
	end if
	
end if

if (ant_riesgo <> riesgo) or ((ant_situacion <> situacion) and situacion <> "E") or &
	(fecha_concedido <> ant_fecha_concedido) or &
	(not(isnull(fecha_concedido)) and isnull(ant_fecha_concedido)) then
	orden ++
	if situacion = "N" then
		situacion_his = "Denegado"
	else
		situacion_his = "Concedido"
	end if
	
	INSERT INTO venriesgoclienteshis
		(empresa, 				companyia, 				cliente, 				orden, 
		 situacion, 			fecha, 					riesgo)
	VALUES
		(:codigo_empresa, 	:companyia, 			:cliente, 				:orden, 
		 :situacion_his, 		:fecha_concedido, 	:riesgo);
		 
	if sqlca.sqlcode <> 0 then
		rollback;
		bien = false
	end if
	
end if

if bien then
	call super::ue_actualiza_dw	
else
	messagebox("Atención","Se ha producido un error al actualizar el historico.")
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venriesgosclientes
integer x = 14
integer y = 372
integer width = 1815
integer height = 528
string dataobject = "dw_venriesgoclientes"
end type

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cliente"
      bus_titulo     = "VENTANA SELECCION DE CLientes "
 		bus_datawindow = "dw_ayuda_clientes"

 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cliente"
      bus_titulo     = "VENTANA SELECCION DE CLientes "
 		bus_datawindow = "dw_ayuda_clientes"

 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 

end event

event dw_1::itemchanged;call super::itemchanged;
if dwo.name = "riesgo_concedido" then
	if dec(data) <> 0 then 
		this.object.concedido[row] = "S"
	end if
end if
	

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venriesgosclientes
integer x = 119
integer y = 280
integer width = 242
string text = "Cliente:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venriesgosclientes
integer x = 23
integer y = 920
end type

event cb_insertar::clicked;dec      riesgo,riesgo_solicitado
datetime fecha_concedido,fecha_solicitado
string   situacion,mensaje
boolean  bien = true

if this.enabled then
	situacion         = dw_1.object.concedido[1]
	riesgo            = dw_1.object.riesgo_concedido[1]
	fecha_concedido   = dw_1.object.fecha_concedido[1]
	riesgo_solicitado = dw_1.object.riesgo_solicitado[1]
	fecha_solicitado  = dw_1.object.fecha_solicitado[1]
	
	//Comprobamos los cambios en la ficha
	if situacion <> ant_situacion then
		if fecha_concedido = ant_fecha_concedido then
			mensaje = "Se ha cambiado la situación del cliente en la misma fecha que la situación anterior."
			mensaje = mensaje +"~n¿Desea validar el cambio?"
			if messagebox("Atención",mensaje,Question!,YesNo!,2) = 2 then
				bien = false
			end if		
		end if
	end if
	
	if bien then
		if riesgo <> ant_riesgo then
			if fecha_concedido = ant_fecha_concedido then
				mensaje = "Se ha cambiado el riesgo concedido del cliente en la misma fecha que la concesión anterior."
				mensaje = mensaje +"~n¿Desea validar el cambio?"
				if messagebox("Atención",mensaje,Question!,YesNo!,2) = 2 then
					bien = false
				end if					
			end if
		end if
	end if
	
	if bien then
		if riesgo_solicitado <> ant_riesgo_solicitado then
			if fecha_solicitado = ant_fecha_solicitado then
				mensaje = "Se ha cambiado el riesgo solicitado del cliente en la misma fecha que la solicitud anterior."
				mensaje = mensaje +"~n¿Desea validar el cambio?"
				if messagebox("Atención",mensaje,Question!,YesNo!,2) = 2 then
					bien = false
				end if					
			end if
		end if
	end if
end if

if bien then
	call super::clicked
end if

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venriesgosclientes
integer x = 443
integer y = 920
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venriesgosclientes
integer x = 389
integer y = 272
integer width = 512
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 	
isle_campo        = This

iF len(em_companyia.text) = 0 Then f_activar_campo(em_companyia)
dw_detalle.Retrieve(codigo_empresa,em_companyia.text,sle_valor.text)
end event

event sle_valor::modificado;call super::modificado;st_nombrecliente.text = f_nombre_cliente(codigo_empresa,"C",sle_valor.text)

IF Trim(st_nombrecliente.text) = "" THEN 
	IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
	sle_valor.text=""
END IF
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venriesgosclientes
integer x = 864
integer y = 920
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venriesgosclientes
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venriesgosclientes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venriesgosclientes
integer width = 3223
integer height = 76
end type

type st_3 from statictext within wi_mant_venriesgosclientes
integer x = 18
integer y = 172
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Compañia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_companyia from u_em_campo within wi_mant_venriesgosclientes
integer x = 389
integer y = 164
integer width = 384
integer taborder = 10
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_segcompanyias"
   ue_titulo         = "AYUDA SELECCION DE COMPAÑIAS"
   ue_filtro         = ""
   isle_campo        = This
end event

event modificado;call super::modificado;st_nombrecompanyia.text=f_nombre_segcompanyia(codigo_empresa,em_companyia.text)
IF Trim(st_nombrecompanyia.text)="" THEN 
 IF Trim(em_companyia.text)<>"" Then  f_activar_campo(em_companyia)
 em_companyia.text=""
END IF
end event

type st_nombrecompanyia from statictext within wi_mant_venriesgosclientes
integer x = 809
integer y = 164
integer width = 1202
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_nombrecliente from statictext within wi_mant_venriesgosclientes
integer x = 928
integer y = 276
integer width = 1065
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_detalle from datawindow within wi_mant_venriesgosclientes
integer x = 1829
integer y = 372
integer width = 1376
integer height = 1008
boolean bringtotop = true
boolean titlebar = true
string title = "Histórico"
string dataobject = "dw_hisriesgoclientes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;this.selectrow(0,false)

if row > 0 then
	this.selectrow(row,true)
	this.setrow(row)
	cb_borrar_historico.enabled = true
else
	cb_borrar_historico.enabled = false
end if
end event

type cb_1 from commandbutton within wi_mant_venriesgosclientes
integer x = 2779
integer y = 240
integer width = 425
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Comprobación"
end type

event clicked;string situacion

situacion = f_situacion_cliente_asegurado_fecha(codigo_empresa,em_companyia.text,sle_valor.text,datetime(date(em_fecha_fra.text)))

messagebox("Comprobación","Situación cliente a fecha "+em_fecha_fra.text+" : "+situacion)
end event

type em_fecha_fra from u_em_campo within wi_mant_venriesgosclientes
integer x = 2491
integer y = 240
integer width = 279
integer taborder = 50
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_2 from statictext within wi_mant_venriesgosclientes
integer x = 2149
integer y = 248
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha Fra :"
boolean focusrectangle = false
end type

type cb_borrar_historico from commandbutton within wi_mant_venriesgosclientes
integer x = 2944
integer y = 380
integer width = 247
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\Mano.cur"
boolean enabled = false
string text = "Borrar"
end type

event clicked;string companyia,cliente
long   orden,donde

donde = dw_detalle.getrow()
if donde > 0 then
	if messagebox("Confirmación","¿Desea borrar la linea del histórico seleccionada?",Question!,YesNo!,2) = 1 then
		companyia = dw_detalle.object.companyia[donde]
		cliente   = dw_detalle.object.cliente[donde]
		orden     = dw_detalle.object.orden[donde]
		
		delete venriesgoclienteshis
		where  empresa   = :codigo_empresa
		and    companyia = :companyia
		and    cliente   = :cliente
		and    orden     = :orden;
		
		if sqlca.sqlcode <> 0 then
			rollback;
			messagebox("Atención","Se ha producido un error al borrar la linea del histórico.")
		else
			commit;
			dw_detalle.deleterow(donde)
			this.enabled = false
		end if
	end if
end if
end event

type cb_2 from commandbutton within wi_mant_venriesgosclientes
integer x = 32
integer y = 1192
integer width = 1239
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar facuras aseguradas del cliente"
end type

event clicked;if MessageBox("Atención", "Se marcarán como aseguradas aquellas facturas del cliente "+st_nombrecliente.text+" que tengan fecha mayor o igual a la fecha de concesión (concedido = SI, riesgo > 0, valor vigente NO historico). El resto de facturas no se modificarán.", Question!, YesNo!, 2) = 2 then
	return
end if


UPDATE venfac SET asegurado = 'S' 
WHERE 
cliente = :sle_valor.text
AND EXISTS (
SELECT * FROM venriesgoclientes 
WHERE venfac.ffactura >= fecha_concedido 
AND cliente = venfac.cliente 
AND concedido = 'S' 
AND riesgo_concedido > 0);
end event

