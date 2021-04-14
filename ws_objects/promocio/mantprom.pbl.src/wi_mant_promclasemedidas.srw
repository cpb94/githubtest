$PBExportHeader$wi_mant_promclasemedidas.srw
$PBExportComments$€ Medidas de paneles por clases_panel
forward
global type wi_mant_promclasemedidas from wi_mvent_con_empresa
end type
type st_tipopanel from statictext within wi_mant_promclasemedidas
end type
type st_nombre_prommedidas from statictext within wi_mant_promclasemedidas
end type
type sle_clase_panel from u_em_campo within wi_mant_promclasemedidas
end type
type st_nombre_clase_panel from statictext within wi_mant_promclasemedidas
end type
type dw_detalle from datawindow within wi_mant_promclasemedidas
end type
end forward

global type wi_mant_promclasemedidas from wi_mvent_con_empresa
integer width = 2889
integer height = 1680
st_tipopanel st_tipopanel
st_nombre_prommedidas st_nombre_prommedidas
sle_clase_panel sle_clase_panel
st_nombre_clase_panel st_nombre_clase_panel
dw_detalle dw_detalle
end type
global wi_mant_promclasemedidas wi_mant_promclasemedidas

type variables

end variables

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)

longitud      =  len(trim(sle_clase_panel.text))
criterio[2]   =  trim(sle_clase_panel.text)+space(20-longitud)

longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)

seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "promclasemedidas"

dw_1.Retrieve(codigo_empresa,sle_clase_panel.text,sle_valor.Text)
dw_detalle.Retrieve(codigo_empresa,sle_clase_panel.text) 
CALL Super::ue_recuperar
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"clase_panel",sle_clase_panel.text)
dw_1.setitem(dw_1.getrow(),"tipo_medida",sle_valor.text)


end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Clases de paneles por Expositor"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransobject(SQLCA)

        
 IF istr_parametros.i_nargumentos>1 THEN
     sle_clase_panel.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(sle_clase_panel)
     sle_clase_panel.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0

	  IF Trim(sle_valor.text)<>"" and Trim(sle_clase_panel.text)<>"" THEN
			 f_activar_campo(sle_valor)
          This.TriggerEvent("ue_recuperar")
	  		 Return
    END IF
     
 END IF







end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_clase_panel.enabled=FALSE
dw_detalle.enabled = FALSE
end event

on wi_mant_promclasemedidas.create
int iCurrent
call super::create
this.st_tipopanel=create st_tipopanel
this.st_nombre_prommedidas=create st_nombre_prommedidas
this.sle_clase_panel=create sle_clase_panel
this.st_nombre_clase_panel=create st_nombre_clase_panel
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_tipopanel
this.Control[iCurrent+2]=this.st_nombre_prommedidas
this.Control[iCurrent+3]=this.sle_clase_panel
this.Control[iCurrent+4]=this.st_nombre_clase_panel
this.Control[iCurrent+5]=this.dw_detalle
end on

on wi_mant_promclasemedidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_tipopanel)
destroy(this.st_nombre_prommedidas)
destroy(this.sle_clase_panel)
destroy(this.st_nombre_clase_panel)
destroy(this.dw_detalle)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_clase_panel.enabled=TRUE
dw_detalle.enabled = TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promclasemedidas
integer x = 18
integer y = 392
integer width = 2377
integer height = 604
string dataobject = "dw_promclasemedidas"
end type

event dw_1::key; bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
end event

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promclasemedidas
integer x = 50
integer y = 284
integer width = 457
integer height = 80
string text = "Medidas panel:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promclasemedidas
integer x = 2446
integer y = 392
integer width = 352
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promclasemedidas
integer x = 2446
integer y = 504
integer width = 352
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promclasemedidas
integer x = 530
integer y = 276
integer width = 270
integer taborder = 30
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo       	= "AYUDA SELECCION DE MEDIDAS PANEL"
ue_datawindow   	= "dw_ayuda_prommedidas"
ue_filtro 		   = "" 
isle_campo        = sle_valor



end event

event sle_valor::modificado;call super::modificado;st_nombre_prommedidas.text=f_nombre_prommedidas(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_prommedidas.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
End if


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promclasemedidas
integer x = 2446
integer y = 616
integer width = 352
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promclasemedidas
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promclasemedidas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promclasemedidas
end type

type st_tipopanel from statictext within wi_mant_promclasemedidas
integer x = 137
integer y = 184
integer width = 375
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
string text = "Clase panel:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_prommedidas from statictext within wi_mant_promclasemedidas
integer x = 818
integer y = 288
integer width = 1467
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type sle_clase_panel from u_em_campo within wi_mant_promclasemedidas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 530
integer y = 180
integer width = 270
integer taborder = 10
end type

event getfocus;call super::getfocus;  	   ue_titulo     = "AYUDA SELECCION DE CLASE PANELES"
		ue_datawindow = "dw_ayuda_promclasepanel"
		ue_filtro     = ""
      isle_campo    = This
		
		sle_valor.text = ""
		st_nombre_prommedidas.text = ""
		
      dw_1.Retrieve(codigo_empresa,sle_clase_panel.text,sle_valor.Text) 
		dw_detalle.Retrieve(codigo_empresa,sle_clase_panel.text) 
		
		
      

end event

event modificado;call super::modificado;st_nombre_clase_panel.text=f_nombre_clasepanel(codigo_empresa,sle_clase_panel.text)
IF Trim(st_nombre_clase_panel.text)="" THEN 
 IF Trim(st_nombre_clase_panel.text)<>"" Then  f_activar_campo(sle_clase_panel)
 st_nombre_clase_panel.text = ""
END IF

dw_detalle.Retrieve(codigo_empresa,sle_clase_panel.text) 
end event

type st_nombre_clase_panel from statictext within wi_mant_promclasemedidas
integer x = 818
integer y = 184
integer width = 1467
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_detalle from datawindow within wi_mant_promclasemedidas
integer x = 18
integer y = 996
integer width = 2382
integer height = 424
boolean bringtotop = true
string dataobject = "dw_con_promclasemedidas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then 
 f_activar_campo(sle_valor)
 Return
END IF

sle_valor.text = This.GetItemString(Row,"tipo_medida")
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

