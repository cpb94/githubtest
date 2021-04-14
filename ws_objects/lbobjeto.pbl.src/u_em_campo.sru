$PBExportHeader$u_em_campo.sru
$PBExportComments$Campo de introduccion con o sin busquedas.
forward
global type u_em_campo from editmask
end type
end forward

global type u_em_campo from editmask
integer width = 251
integer height = 84
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
event key pbm_keydown
event busqueda pbm_custom01
event modificado pbm_custom02
event tecla_enter pbm_custom03
event tecla_tabulador pbm_custom04
end type
global u_em_campo u_em_campo

type variables
String  ue_datawindow,ue_titulo,ue_filtro
Editmask ue_campo
String  ue_ante_valor,ue_valor

end variables

event key;IF KeyDown(KeyEnter!) THEN  This.TriggerEvent("tecla_enter")
IF KeyDown(KeyF12!) THEN  This.TriggerEvent(rbuttonDown!)


end event

event busqueda;str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
param.s_titulo_ayuda    = ue_titulo
param.s_nom_datawindow  = ue_datawindow
param.s_filtro          = ue_filtro
param.b_empresa         = valor_empresa
This.text = ue_valor
f_buscar(This,param)
This.TriggerEvent("modificado")
ue_ante_valor = This.text
This.SelectText(1,Len(This.Text))

end event

event modificado;IF This.MaskdataType= DateTimemask! or This.MaskdataType= DateMask!Then  
IF Not f_verifica_fecha(DateTime(Date(This.text))) Then
	This.text = ""
	f_activar_campo(ue_campo)
	Return
end if	
END IF	
end event

event tecla_enter;IF len(ue_datawindow) <> 0 Then
	ue_campo.text = ""
	ue_valor = ""
	This.TriggerEvent("busqueda")
END IF

end event

event tecla_tabulador;IF Len(This.text)=0  Then 
     This.TriggerEvent("busqueda")
END IF
     


end event

event losefocus;This.BackColor= RGB(192,192,192)
ue_valor = This.text
IF ue_valor <> ue_ante_valor   Then
	This.TriggerEvent("modificado")
	IF KeyDown(KeyTab!) THEN  
		This.TriggerEvent("tecla_tabulador")
	END IF
END IF
end event

event getfocus;This.BackColor= RGB(255,255,255)
ue_datawindow  = "" // Valor Datawindow por defecto
ue_campo       =  This
ue_ante_valor = This.text
This.SelectText(1,Len(This.Text))
valor_empresa = TRUE  // Por defecto busquedas con empresa

// ue_datawindow -> datawindow de ayuda
// ue_titulo -> titulo datawindow de ayuda
// ue_filtro  -> posibles filtros de ayuda
// valor_empresa -> "FALSE" si la busqueda no filtra por empresa


end event

event rbuttondown;This.TriggerEvent(Getfocus!)
f_activar_campo(ue_campo)
ue_campo.text = ""
ue_valor = ""
This.TriggerEvent("busqueda")


end event

event constructor;ue_ante_valor= ""
ue_valor= ""
end event

on u_em_campo.create
end on

on u_em_campo.destroy
end on

