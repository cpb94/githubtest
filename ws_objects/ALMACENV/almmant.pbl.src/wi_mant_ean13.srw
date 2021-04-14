$PBExportHeader$wi_mant_ean13.srw
$PBExportComments$Mantenimiento EAN 13
forward
global type wi_mant_ean13 from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_ean13
end type
type st_nombre_formato from statictext within wi_mant_ean13
end type
type st_pallet_nombre from statictext within wi_mant_ean13
end type
type sle_cliente from u_em_campo within wi_mant_ean13
end type
type sle_articulo from u_em_campo within wi_mant_ean13
end type
type st_cliente from statictext within wi_mant_ean13
end type
type st_alt from statictext within wi_mant_ean13
end type
end forward

global type wi_mant_ean13 from wi_mvent_con_empresa
integer width = 2373
integer height = 1692
st_almacen st_almacen
st_nombre_formato st_nombre_formato
st_pallet_nombre st_pallet_nombre
sle_cliente sle_cliente
sle_articulo sle_articulo
st_cliente st_cliente
st_alt st_alt
end type
global wi_mant_ean13 wi_mant_ean13

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,sle_articulo.text,sle_cliente.Text,dec(sle_valor.Text))


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de EAN 13"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)



end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"articulo",sle_articulo.text)
dw_1.setitem(dw_1.getrow(),"cliente",sle_cliente.text)
dw_1.setitem(dw_1.getrow(),"orden",dec(sle_valor.text))
dw_1.setitem(dw_1.getrow(),"cajas_caja",0)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_articulo.text))
criterio[2]   =  trim(sle_articulo.text)+space(20-longitud)
longitud      =  len(trim(sle_cliente.text))
criterio[3]   =  trim(sle_cliente.text)+space(20-longitud)
longitud      =  len(trim(sle_cliente.text))
criterio[4]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]
tabla         =  "almean13"

f_control()
CALL Super::ue_recuperar
end event

on wi_mant_ean13.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_formato=create st_nombre_formato
this.st_pallet_nombre=create st_pallet_nombre
this.sle_cliente=create sle_cliente
this.sle_articulo=create sle_articulo
this.st_cliente=create st_cliente
this.st_alt=create st_alt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_formato
this.Control[iCurrent+3]=this.st_pallet_nombre
this.Control[iCurrent+4]=this.sle_cliente
this.Control[iCurrent+5]=this.sle_articulo
this.Control[iCurrent+6]=this.st_cliente
this.Control[iCurrent+7]=this.st_alt
end on

on wi_mant_ean13.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_formato)
destroy(this.st_pallet_nombre)
destroy(this.sle_cliente)
destroy(this.sle_articulo)
destroy(this.st_cliente)
destroy(this.st_alt)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_articulo.enabled=FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;sle_articulo.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_ean13
integer x = 119
integer y = 532
integer width = 1568
integer height = 888
string dataobject = "dw_ean13"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_ean13
integer x = 128
integer y = 412
integer width = 343
integer height = 80
string text = "Idioma:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_ean13
integer x = 1733
integer y = 532
end type

event cb_insertar::clicked;IF dw_1.rowcount() <> 0 then
	IF not f_ean_13_correcto(dw_1.getitemstring(1,"ean13")) then
		messagebox("Error","EAN 13 no valido")
		return
	end if
end if


CALL Super:: clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_ean13
integer x = 1733
integer y = 648
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_ean13
integer x = 503
integer y = 412
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = TRUE
ue_titulo     = "Ayuda seleccion de descripciones alternativas"
ue_datawindow = "dw_ayuda_almcliartdesc"
ue_filtro     = "cliente = '"+sle_cliente.text+"' and codigo = '"+sle_articulo.text+"'"

end event

event sle_valor::modificado;if sle_valor.text = "0" then
	st_alt.text="SIN DESCRIPCIÓN ALTERNATIVA"	
else
	st_alt.text=f_descripcion_almcliartdesc2(codigo_empresa,sle_cliente.text,sle_articulo.text,dec(sle_valor.text))
end if
IF Trim(st_alt.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_ean13
integer x = 1733
integer y = 768
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_ean13
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_ean13
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_ean13
end type

type st_almacen from statictext within wi_mant_ean13
integer x = 128
integer y = 292
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_formato from statictext within wi_mant_ean13
integer x = 777
integer y = 172
integer width = 1198
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

type st_pallet_nombre from statictext within wi_mant_ean13
integer x = 777
integer y = 296
integer width = 1198
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

type sle_cliente from u_em_campo within wi_mant_ean13
integer x = 503
integer y = 292
integer taborder = 20
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""
isle_campo    = This

IF trim(sle_articulo.text)= "" THEN
	f_activar_campo(sle_cliente)
	REturn	 
End if	
f_control()





end event

event modificado;call super::modificado;Long total_desc

st_pallet_nombre.text=f_razon_genter(codigo_empresa,"C",sle_cliente.text)
IF Trim(st_pallet_nombre.text)="" THEN 
 IF Trim(sle_cliente.text)<>"" Then  f_activar_campo(sle_cliente)
 sle_cliente.text=""
ELSE
		select count(descripcion)
		into :total_desc
		from almcliartdesc
		where empresa=:codigo_empresa and
				cliente=:sle_cliente.text and
				articulo=:sle_articulo.text
		group by empresa,cliente,articulo;
		
		if isnull(total_desc) then total_desc = 0
		
		if total_desc >= 1 then
			if total_desc = 1 then
				sle_valor.text = "1"
				sle_valor.TriggerEvent("modificado")
				Parent.TriggerEvent("ue_recuperar")
			else
				sle_valor.text = ""
			end if
		end if
		if total_desc = 0 then
			sle_valor.text = "0"
			sle_valor.TriggerEvent("modificado")
			Parent.TriggerEvent("ue_recuperar")
		end if
		
	END IF

end event

type sle_articulo from u_em_campo within wi_mant_ean13
integer x = 503
integer y = 172
integer taborder = 10
end type

event getfocus;call super::getfocus;  ue_titulo     = "AYUDA SELECCION DE ARTICULOS"
  ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
  ue_filtro     = ""
  isle_campo    = This
  sle_valor.Text = ""
  
  f_control()
        
  







end event

event modificado;call super::modificado;st_nombre_formato.text=f_nombre_articulo(codigo_empresa,sle_articulo.text)
IF Trim(st_nombre_formato.text)="" THEN 
 IF Trim(sle_articulo.text)<>"" Then  f_activar_campo(sle_articulo)
 sle_articulo.text=""
END IF
end event

event busqueda;str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
param.s_titulo_ayuda    = ue_titulo
param.s_nom_datawindow  = ue_datawindow
param.s_filtro          = ue_filtro
param.b_empresa         = valor_empresa
This.text = ue_valor
f_buscar_largo(This,param)
This.TriggerEvent("modificado")
ue_ante_valor = This.text
This.SelectText(1,Len(This.Text))
end event

type st_cliente from statictext within wi_mant_ean13
integer x = 128
integer y = 180
integer width = 343
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Articulo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_alt from statictext within wi_mant_ean13
integer x = 777
integer y = 412
integer width = 1198
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

