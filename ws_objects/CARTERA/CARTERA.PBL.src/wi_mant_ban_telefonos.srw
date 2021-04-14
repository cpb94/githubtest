$PBExportHeader$wi_mant_ban_telefonos.srw
forward
global type wi_mant_ban_telefonos from wi_mvent_con_empresa
end type
type dw_2 from datawindow within wi_mant_ban_telefonos
end type
type pb_calculadora from u_calculadora within wi_mant_ban_telefonos
end type
type st_ntelefonos from statictext within wi_mant_ban_telefonos
end type
type st_nombanco from statictext within wi_mant_ban_telefonos
end type
type em_banco from u_em_campo within wi_mant_ban_telefonos
end type
end forward

global type wi_mant_ban_telefonos from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2770
integer height = 1640
dw_2 dw_2
pb_calculadora pb_calculadora
st_ntelefonos st_ntelefonos
st_nombanco st_nombanco
em_banco em_banco
end type
global wi_mant_ban_telefonos wi_mant_ban_telefonos

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda

end variables

event open;call super::open;dw_2.SetTransObject(SQLCA)
pb_calculadora.visible=FALSE

istr_parametros.s_titulo_ventana = "Teléfonos de Bancos"
istr_parametros.s_listado        = "report_telefonos"

This.title=istr_parametros.s_titulo_ventana

  
end event

event ue_activa_claves;call super::ue_activa_claves;
		// Activamos los campos clave añadidos

em_banco.enabled   = TRUE
pb_calculadora.visible = TRUE
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)

 longitud     =  len(Trim(em_banco.text))
 criterio[2]  =  trim(em_banco.text)+space(20-longitud)
 
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)

 seleccion    =  criterio[1]+criterio[2]+criterio[3]

 tabla        = "carbantelefonos"

 dw_1.Retrieve(codigo_empresa,em_banco.text,sle_valor.text)
 CALL Super::ue_recuperar



end event

event ue_desactiva_claves;call super::ue_desactiva_claves;
		// Activamos los campos clave añadidos

em_banco.enabled   = FALSE
pb_calculadora.visible=FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",em_banco.text)
dw_1.setitem(dw_1.getrow(),"telefono",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"tipotelefono","T")


end event

on wi_mant_ban_telefonos.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.pb_calculadora=create pb_calculadora
this.st_ntelefonos=create st_ntelefonos
this.st_nombanco=create st_nombanco
this.em_banco=create em_banco
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.st_ntelefonos
this.Control[iCurrent+4]=this.st_nombanco
this.Control[iCurrent+5]=this.em_banco
end on

on wi_mant_ban_telefonos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.pb_calculadora)
destroy(this.st_ntelefonos)
destroy(this.st_nombanco)
destroy(this.em_banco)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_ban_telefonos
integer x = 27
integer y = 356
integer width = 2254
integer height = 684
string dataobject = "dw_ban_telefonos"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_ban_telefonos
integer x = 133
integer y = 160
integer width = 279
integer height = 68
string text = "Banco"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_ban_telefonos
integer x = 2309
integer y = 348
end type

on cb_insertar::clicked;iF cb_insertar.enabled =TRUE THEN 

	dw_1.AcceptText()
   string var_numero, campo, campo_text

   var_numero    = dw_1.GetItemString(dw_1.GetRow(),'numero')

   IF IsNull(var_numero) or Trim(String(var_numero))="" THEN 
           campo_text ="Número teléfono"
           campo="numero"
	end if

   IF Trim(campo)<>"" THEN
      MessageBox(campo_text+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
      dw_1.SetColumn(campo)
      dw_1.setRow(dw_1.getRow())
      dw_1.setfocus()
      Return
   END IF

END IF

call super::clicked


end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_ban_telefonos
integer x = 2309
integer y = 468
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_ban_telefonos
integer x = 475
integer y = 236
integer width = 201
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;if Trim(em_banco.text)="" or trim(st_nombanco.text)="" or IsNull(em_banco.text) &
    or IsNull(st_nombanco.text) then
        f_activar_campo(em_banco)	
        RETURN
end iF

dw_2.retrieve(codigo_empresa,em_banco.text)
pb_calculadora.visible=TRUE


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_ban_telefonos
integer x = 2309
integer y = 608
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_ban_telefonos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_ban_telefonos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_ban_telefonos
integer width = 2679
end type

type dw_2 from datawindow within wi_mant_ban_telefonos
integer x = 23
integer y = 1060
integer width = 2263
integer height = 360
string dataobject = "dw_list_ban_telefonos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then 
 f_activar_campo(em_banco)
 Return
END IF

sle_valor.text = (This.GetItemString(row,"telefono"))
Parent.TriggerEvent("ue_recuperar")

f_activar_campo(sle_valor)
end event

type pb_calculadora from u_calculadora within wi_mant_ban_telefonos
integer x = 695
integer y = 228
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros

Select count(*) Into :registros From carbantelefonos
Where  carbantelefonos.empresa       = :codigo_empresa
and    carbantelefonos.codigo        = :em_banco.text;

IF registros=0 THEN
 sle_valor.text="1" 
ELSE
 Select max(convert(int,carbantelefonos.telefono)+1)
 Into   :sle_valor.text
 From   carbantelefonos
 Where  carbantelefonos.empresa       = :codigo_empresa
 and    carbantelefonos.codigo        = :em_banco.text;
END IF

dw_1.TriggerEvent("Clicked")
end event

type st_ntelefonos from statictext within wi_mant_ban_telefonos
integer x = 448
integer y = 164
integer width = 279
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
string text = "Nº Tl."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nombanco from statictext within wi_mant_ban_telefonos
integer x = 809
integer y = 236
integer width = 1143
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_banco from u_em_campo within wi_mant_ban_telefonos
integer x = 101
integer y = 236
integer width = 347
integer taborder = 10
end type

event getfocus;call super::getfocus;pb_calculadora.visible=FALSE

ue_titulo     = "AYUDA SELECCION BANCOS"
ue_datawindow = "dw_ayuda_carbancos"
ue_filtro     = ""		
isle_campo    = this

IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
 	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			dw_1.retrieve(codigo_empresa,sle_valor.text)         	
			f_activar_campo(sle_valor)     
     END IF     
	  istr_parametros.i_nargumentos=0
END IF

dw_2.retrieve(codigo_empresa,em_banco.text)
sle_valor.text = ""
end event

event modificado;call super::modificado;st_nombanco.text=f_nombre_banco(codigo_empresa,em_banco.text)	
IF Trim(st_nombanco.text)="" THEN 
 IF Trim(st_nombanco.text)<>"" Then f_activar_campo(em_banco)
 em_banco.text=""
END IF


end event

