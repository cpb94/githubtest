$PBExportHeader$wi_mant_venconductores.srw
forward
global type wi_mant_venconductores from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_venconductores
end type
type st_ntelefonos from statictext within wi_mant_venconductores
end type
type st_nomcliente from statictext within wi_mant_venconductores
end type
type em_cliente from u_em_campo within wi_mant_venconductores
end type
end forward

global type wi_mant_venconductores from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2715
integer height = 1204
boolean maxbox = false
windowtype windowtype = response!
pb_calculadora pb_calculadora
st_ntelefonos st_ntelefonos
st_nomcliente st_nomcliente
em_cliente em_cliente
end type
global wi_mant_venconductores wi_mant_venconductores

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda

end variables

event type long ue_recuperar(unsignedlong wparam, long lparam);// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(em_cliente.text))
 criterio[2]  =  trim(em_cliente.text)+space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "venconductores"

 dw_1.Retrieve(codigo_empresa,em_cliente.text,sle_valor.text)

 CALL Super::ue_recuperar
 
RETURN 0


end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"transportista",em_cliente.text)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)






end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled   = FALSE
em_cliente.enabled   = FALSE
pb_calculadora.visible=FALSE
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Conductores"
istr_parametros.s_listado        = ""

This.title = istr_parametros.s_titulo_ventana

IF istr_parametros.i_nargumentos > 1 THEN
	em_cliente.text 	 = istr_parametros.s_argumentos[2]
	st_nomcliente.text = f_nombre_ventransportista(codigo_empresa,em_cliente.text)
	sle_valor.text 	 = istr_parametros.s_argumentos[3]
	IF Trim(sle_valor.text) <> "" and Not IsNull(sle_valor.text) Then
		This.TriggerEvent("ue_recuperar")
	ELSE
		f_activar_campo(sle_valor)
	END IF
ELSE
	f_activar_campo(em_cliente)
END IF
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled = TRUE
em_cliente.enabled   = TRUE
pb_calculadora.visible = TRUE
end on

on wi_mant_venconductores.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.st_ntelefonos=create st_ntelefonos
this.st_nomcliente=create st_nomcliente
this.em_cliente=create em_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.st_ntelefonos
this.Control[iCurrent+3]=this.st_nomcliente
this.Control[iCurrent+4]=this.em_cliente
end on

on wi_mant_venconductores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.st_ntelefonos)
destroy(this.st_nomcliente)
destroy(this.em_cliente)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venconductores
integer x = 23
integer y = 332
integer width = 2153
integer height = 652
string dataobject = "dw_venconductores"
end type

event dw_1::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
//---------------------------------------------//
//---------------------------------------------//
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venconductores
integer x = 73
integer y = 228
integer width = 389
integer height = 68
string text = "Transportista"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venconductores
integer x = 2217
integer y = 332
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venconductores
integer x = 2217
integer y = 448
integer height = 84
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venconductores
integer x = 850
integer width = 311
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CONDUCTORES"
ue_datawindow = "dw_ayuda_venconductores"
ue_filtro     = " transportista = '" + em_cliente.text + "'"
isle_campo    = this

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venconductores
integer x = 2217
integer y = 564
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venconductores
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venconductores
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venconductores
integer y = 44
integer width = 2578
end type

type pb_calculadora from u_calculadora within wi_mant_venconductores
integer x = 1179
integer y = 208
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros

Select count(*) Into :registros From venconductores
Where  venconductores.empresa       = :codigo_empresa
and    venconductores.transportista = :em_cliente.text;

IF registros=0 THEN
 sle_valor.text="1" 
ELSE
 Select max(convert(int,venconductores.codigo)+1)
 Into   :sle_valor.text
 From   venconductores
 Where  venconductores.empresa       = :codigo_empresa
 and    venconductores.transportista = :em_cliente.text;
END IF

Parent.TriggerEvent("ue_recuperar")
end event

type st_ntelefonos from statictext within wi_mant_venconductores
integer x = 809
integer y = 148
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Código"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nomcliente from statictext within wi_mant_venconductores
integer x = 1312
integer y = 220
integer width = 1230
integer height = 72
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

type em_cliente from u_em_campo within wi_mant_venconductores
integer x = 475
integer y = 212
integer width = 347
integer height = 88
integer taborder = 10
string facename = "Courier"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE TRANSPORTISTAS"
ue_datawindow = "dw_ayuda_ventransportistas"
ue_filtro     = ""
isle_campo    = this

Return 0


end event

event modificado;call super::modificado;st_nomcliente.text=f_nombre_ventransportista(codigo_empresa,em_cliente.text)
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF


end event

