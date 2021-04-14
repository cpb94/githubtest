$PBExportHeader$wi_mant_telefonos.srw
forward
global type wi_mant_telefonos from wi_mvent_con_empresa
end type
type rb_tercero from radiobutton within wi_mant_telefonos
end type
type rb_cliente from radiobutton within wi_mant_telefonos
end type
type dw_2 from datawindow within wi_mant_telefonos
end type
type gb_1 from groupbox within wi_mant_telefonos
end type
type rb_proveedor from radiobutton within wi_mant_telefonos
end type
type pb_calculadora from u_calculadora within wi_mant_telefonos
end type
type st_nomcliente from statictext within wi_mant_telefonos
end type
type em_cliente from u_em_campo within wi_mant_telefonos
end type
end forward

global type wi_mant_telefonos from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2789
integer height = 1664
rb_tercero rb_tercero
rb_cliente rb_cliente
dw_2 dw_2
gb_1 gb_1
rb_proveedor rb_proveedor
pb_calculadora pb_calculadora
st_nomcliente st_nomcliente
em_cliente em_cliente
end type
global wi_mant_telefonos wi_mant_telefonos

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda

end variables

on open;call wi_mvent_con_empresa::open;dw_2.SetTransObject(SQLCA)
pb_calculadora.visible=FALSE

istr_parametros.s_titulo_ventana = "Teléfonos de Clientes/Proveedores"
istr_parametros.s_listado        = "report_telefonos"

This.title=istr_parametros.s_titulo_ventana

IF trim(ic_tipoter)="" THEN
   ic_tipoter = 'C'				// Damos el valor incial de tipo tercero
END IF

   
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;
		// Activamos los campos clave añadidos

rb_cliente.enabled   = TRUE
rb_proveedor.enabled = TRUE
rb_tercero.enabled   = TRUE
em_cliente.enabled   = TRUE
pb_calculadora.visible = TRUE
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)

 longitud     =  len(Trim(ic_tipoter))
 criterio[2]  =  trim(ic_tipoter)+space(20-longitud)

 longitud     =  len(Trim(em_cliente.text))
 criterio[3]  =  trim(em_cliente.text)+space(20-longitud)
 
 longitud     =  len(Trim(sle_valor.text))
 criterio[4]  =  trim(sle_valor.text)+space(20-longitud)

 seleccion    =  criterio[1]+criterio[2]+criterio[3]+criterio[4]

 tabla        = "telefonos"

 dw_1.Retrieve(codigo_empresa,ic_tipoter,em_cliente.text,sle_valor.text)
 CALL Super::ue_recuperar



end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;
		// Activamos los campos clave añadidos

rb_cliente.enabled   = FALSE
rb_proveedor.enabled = FALSE
rb_tercero.enabled   = FALSE
em_cliente.enabled   = FALSE
pb_calculadora.visible=FALSE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"tipoter",ic_tipoter)
dw_1.setitem(dw_1.getrow(),"codigo",em_cliente.text)
dw_1.setitem(dw_1.getrow(),"telefono",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"tipotelefono","T")


end on

on wi_mant_telefonos.create
int iCurrent
call super::create
this.rb_tercero=create rb_tercero
this.rb_cliente=create rb_cliente
this.dw_2=create dw_2
this.gb_1=create gb_1
this.rb_proveedor=create rb_proveedor
this.pb_calculadora=create pb_calculadora
this.st_nomcliente=create st_nomcliente
this.em_cliente=create em_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_tercero
this.Control[iCurrent+2]=this.rb_cliente
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.rb_proveedor
this.Control[iCurrent+6]=this.pb_calculadora
this.Control[iCurrent+7]=this.st_nomcliente
this.Control[iCurrent+8]=this.em_cliente
end on

on wi_mant_telefonos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_tercero)
destroy(this.rb_cliente)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.rb_proveedor)
destroy(this.pb_calculadora)
destroy(this.st_nomcliente)
destroy(this.em_cliente)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_telefonos
integer x = 23
integer y = 356
integer width = 2254
integer height = 708
string dataobject = "dw_telefonos"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_telefonos
integer x = 1198
integer y = 148
integer width = 279
integer height = 68
string text = "Cliente"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_telefonos
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

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_telefonos
integer x = 2309
integer y = 468
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_telefonos
integer x = 1541
integer y = 224
integer width = 201
integer taborder = 20
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;if Trim(em_cliente.text)="" or trim(st_nomcliente.text)="" or IsNull(em_cliente.text) &
    or IsNull(st_nomcliente.text) then
        f_activar_campo(em_cliente)	
        RETURN
end iF

dw_2.retrieve(codigo_empresa,ic_tipoter,em_cliente.text)
pb_calculadora.visible=TRUE


end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_telefonos
integer x = 2309
integer y = 608
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_telefonos
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_telefonos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_telefonos
integer width = 2679
end type

type rb_tercero from radiobutton within wi_mant_telefonos
integer x = 768
integer y = 220
integer width = 325
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Tercero"
end type

on clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF ic_tipoter <> 'T' THEN dw_1.Reset()

ic_tipoter = 'T'

sle_valor.text     = ""
em_cliente.text    = ""
st_nomcliente.text = ""

f_activar_campo(em_cliente)		// Despues de Activar pasar al campo clave.

end on

type rb_cliente from radiobutton within wi_mant_telefonos
integer x = 37
integer y = 224
integer width = 315
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Cliente"
boolean checked = true
end type

on clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF ic_tipoter <> 'C' THEN dw_1.Reset()

ic_tipoter = 'C'

sle_valor.text     = ""
em_cliente.text    = ""
st_nomcliente.text = ""

f_activar_campo(em_cliente)		// Despues de Activar pasar al campo clave.

end on

type dw_2 from datawindow within wi_mant_telefonos
integer x = 18
integer y = 1064
integer width = 2258
integer height = 376
string dataobject = "dw_list_telefonos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return


sle_valor.text  = This.GetItemString(Row,"telefono")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

type gb_1 from groupbox within wi_mant_telefonos
integer x = 18
integer y = 180
integer width = 1088
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_proveedor from radiobutton within wi_mant_telefonos
integer x = 347
integer y = 224
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Proveedor"
end type

on clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF ic_tipoter <> 'P' THEN dw_1.Reset()

ic_tipoter = 'P'

sle_valor.text     = ""
em_cliente.text    = ""
st_nomcliente.text = ""

f_activar_campo(em_cliente)		// Despues de Activar pasar al campo clave.
end on

type pb_calculadora from u_calculadora within wi_mant_telefonos
integer x = 1760
integer y = 216
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros

Select count(*) Into :registros From telefonos
Where  telefonos.empresa       = :codigo_empresa
and    telefonos.tipoter       = :ic_tipoter
and    telefonos.codigo        = :em_cliente.text;

IF registros=0 THEN
 sle_valor.text="1" 
ELSE
 Select max(convert(int,telefonos.telefono)+1)
 Into   :sle_valor.text
 From   telefonos
 Where  telefonos.empresa       = :codigo_empresa
 and    telefonos.tipoter       = :ic_tipoter
 and    telefonos.codigo        = :em_cliente.text;
END IF

dw_1.TriggerEvent("Clicked")
end on

type st_nomcliente from statictext within wi_mant_telefonos
integer x = 1893
integer y = 228
integer width = 837
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

type em_cliente from u_em_campo within wi_mant_telefonos
integer x = 1166
integer y = 224
integer width = 347
integer taborder = 10
end type

event getfocus;call super::getfocus;pb_calculadora.visible=FALSE

ue_titulo     = "AYUDA SELECCION TELEFONOS"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""
isle_campo    = this

IF istr_parametros.i_nargumentos>1 THEN
	  ic_tipoter=istr_parametros.s_argumentos[3]
     em_cliente.text=istr_parametros.s_argumentos[2]
  	  istr_parametros.i_nargumentos=0
     ue_filtro     = "tipoter = '" + ic_tipoter + "'"		
	  
	  CHOOSE case ic_tipoter
            case "C"
               rb_cliente.checked = TRUE
					rb_proveedor.checked = FALSE
					rb_tercero.checked = FALSE
				case "P"	 
               rb_cliente.checked = FALSE
					rb_proveedor.checked = TRUE
					rb_tercero.checked = FALSE
		      case "T"
               rb_cliente.checked = FALSE
					rb_proveedor.checked = FALSE
					rb_tercero.checked = TRUE
     End CHOOSE
     dw_2.retrieve(codigo_empresa,ic_tipoter,em_cliente.text)
	  IF TRIM(em_cliente.text)<>"" AND Not IsNull(em_cliente.text) THEN
		  This.TriggerEvent("modificado")
		  Parent.TriggerEvent("ue_recuperar")
        f_activar_campo(sle_valor)	  
        Return
     END IF     
END IF

dw_2.retrieve(codigo_empresa,ic_tipoter,em_cliente.text)
sle_valor.text = ""
end event

on modificado;call u_em_campo::modificado;st_nomcliente.text=f_nombre_cliente(codigo_empresa,ic_tipoter,em_cliente.text)	
IF Trim(st_nomcliente.text)="" THEN 
 IF Trim(st_nomcliente.text)<>"" Then f_activar_campo(em_cliente)
 em_cliente.text=""
END IF


end on

